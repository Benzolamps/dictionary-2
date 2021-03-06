package com.benzolamps.dict.controller;

import com.benzolamps.dict.controller.vo.BaseVo;
import com.benzolamps.dict.controller.vo.DataVo;
import com.benzolamps.dict.util.DictWeb;
import org.springframework.beans.factory.annotation.Value;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller基类
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-7-4 20:51:17
 */
public class BaseController {

    protected static final BaseVo SUCCESS_VO = BaseVo.SUCCESS_VO;

    @Value("#{servletContext.contextPath}")
    protected String baseUrl;

    /**
     * 转换数据
     * @param data 数据
     * @return DataVo
     */
    protected DataVo wrapperData(Object data) {
        return new DataVo(data);
    }

    /**
     * 转换提示信息
     * @param message 提示信息
     * @return DataVo
     */
    @SuppressWarnings("SameParameterValue")
    protected BaseVo wrapperMsg(String message) {
        return new BaseVo(200, message);
    }

    /**
     * 获取request
     * @return HttpServletRequest
     */
    protected HttpServletRequest getRequest() {
        return DictWeb.getRequest();
    }

    /**
     * 获取response
     * @return HttpServletResponse
     */
    protected HttpServletResponse getResponse() {
        return DictWeb.getResponse();
    }

    /**
     * 下载文件
     * @param fileName 文件名
     */
    protected void download(String fileName) {
        DictWeb.download(fileName);
    }
}
