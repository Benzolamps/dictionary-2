package com.benzolamps.dict.service.impl;

import com.benzolamps.dict.exception.DictException;
import com.benzolamps.dict.service.base.LocalAreaNetworkService;
import com.benzolamps.dict.util.lambda.Action2;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StreamUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.function.UnaryOperator;

import static com.benzolamps.dict.util.Constant.GBK_CHARSET;

/**
 * 局域网操作Service接口实现类
 * @author Benzolamps
 * @version 2.2.1
 * @datetime 2018-10-9 10:49:54
 */
@Slf4j
@SuppressWarnings("SpellCheckingInspection")
@Service("localAreaNetworkService")
public class LocalAreaNetworkServiceImpl implements LocalAreaNetworkService {

    @Value("net start mpssvc")
    private String openFireWallCmd;

    @Value("netsh advfirewall firewall add rule name=#{dictProperties.name} dir=in action=allow protocol=tcp localport=#{serverProperties.port}")
    private String addRuleCmd;

    @Value("netsh advfirewall firewall delete rule name=#{dictProperties.name}")
    private String deleteRuleCmd;

    @Resource
    private UnaryOperator<String> compress;

    @Override
    public void openFireWall() {
        exec(openFireWallCmd, (istr, estr) -> {
            if (StringUtils.hasText(istr)) {
                logger.info(istr);
            }
            if (StringUtils.hasText(estr)) {
                // logger.error(estr);
                throw new DictException(estr);
            }
        });
    }

    @Override
    public void addRule() {
        exec(deleteRuleCmd, (istr, estr) -> {
            if (StringUtils.hasText(istr)) {
                logger.info(istr);
            }
            if (StringUtils.hasText(estr)) {
                // logger.error(estr);
                throw new DictException(estr);
            }
        });

        exec(addRuleCmd, (istr, estr) -> {
            if (StringUtils.hasText(istr)) {
                logger.info(istr);
            }
            if (StringUtils.hasText(estr)) {
                // logger.error(estr);
                throw new DictException(estr);
            }
        });
    }

    @Override
    @SneakyThrows(SocketException.class)
    public List<String> getIpv4() {
        List<String> ipv4s = new ArrayList<>();
        Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
        while (networkInterfaces.hasMoreElements()) {
            NetworkInterface networkInterface = networkInterfaces.nextElement();
            if (!networkInterface.isVirtual() && !networkInterface.isLoopback() && networkInterface.isUp()) {
                Enumeration<InetAddress> addresses = networkInterface.getInetAddresses();
                while (addresses.hasMoreElements()) {
                    InetAddress address = addresses.nextElement();
                    byte[] bs = address.getAddress();
                    if (bs.length == 4) {
                        ipv4s.add(address.getHostAddress());
                    }
                }
            }
        }
        // logger.info(ipv4s.toString());
        return ipv4s;
    }

    @SneakyThrows(IOException.class)
    private void exec(String cmd, Action2<String, String> action) {
        Runtime runtime = Runtime.getRuntime();
        Process process = runtime.exec(cmd);
        try (InputStream is = process.getInputStream(); InputStream es = process.getErrorStream()) {
            String istr = StreamUtils.copyToString(is, GBK_CHARSET);
            String estr = StreamUtils.copyToString(es, GBK_CHARSET);
            istr = compress.apply(istr);
            estr = compress.apply(estr);
            action.accept(istr, estr);
        }
    }
}
