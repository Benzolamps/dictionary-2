package com.benzolamps.dict.controller;

import com.benzolamps.dict.controller.interceptor.NavigationView;
import com.benzolamps.dict.controller.vo.BaseVo;
import com.benzolamps.dict.service.base.BackupService;
import com.benzolamps.dict.service.base.MiscellaneousService;
import com.benzolamps.dict.util.lambda.Action;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static com.benzolamps.dict.util.DictSpring.$;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * 系统管理Controller
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-7-4 19:21:16
 */
@RestController
@Slf4j
@RequestMapping("system")
public class SystemController extends BaseController {

    @Resource
    private MiscellaneousService miscellaneousService;

    @Resource
    private BackupService backupService;

    /**
     * 系统信息界面
     * @return ModelAndView
     */
    @NavigationView
    @GetMapping("info.html")
    protected ModelAndView info() {
        return new ModelAndView("view/system/info");
    }

    /**
     * 关于我们界面
     * @return ModelAndView
     */
    @NavigationView
    @GetMapping("about.html")
    protected ModelAndView about() {
        return new ModelAndView("view/system/about");
    }

    /**
     * 系统设置界面
     * @return ModelAndView
     */
    @NavigationView
    @GetMapping("settings.html")
    protected ModelAndView settings() {
        return new ModelAndView("view/system/settings");
    }

    /**
     * 清理缓存界面
     * @return ModelAndView
     */
    @RequestMapping(value = "clean.html", method = {GET, POST})
    protected ModelAndView clean() {
        ModelAndView mv = new ModelAndView("view/system/clean");
        mv.addObject("size", miscellaneousService.databaseFileSize());
        return mv;
    }

    /**
     * clean
     * @return ModelAndView
     */
    @ResponseBody
    @GetMapping("clean.json")
    protected BaseVo cleanProcess() {
        miscellaneousService.clean();
        return SUCCESS_VO;
    }

    /**
     * 数据库备份界面
     * @return ModelAndView
     */
    @RequestMapping(value = "backup.html", method = {GET, POST})
    protected ModelAndView backup() {
        return new ModelAndView("view/system/backup");
    }

    /**
     * 备份数据库过程
     */
    @SuppressWarnings("SpellCheckingInspection")
    @RequestMapping("backup.sql")
    protected void backupProcess(HttpServletResponse response) throws IOException {
        response.setHeader("Content-disposition", "attachment;filename*=utf-8'zh_cn'backup" +
            new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".sql");
        backupService.backup(response.getOutputStream());
    }

    /**
     * 恢复数据库过程
     */
    @PostMapping("restore.json")
    protected BaseVo restoreProcess(MultipartFile file) throws IOException {
        backupService.restore(file.getInputStream());
        return SUCCESS_VO;
    }

    /**
     * 关闭系统服务界面
     * @return ModelAndView
     */
    @RequestMapping(value = "shutdown.html", method = {GET, POST})
    protected ModelAndView shutdown() {
        return new ModelAndView("view/system/shutdown");
    }

    /**
     * 关闭系统服务
     * @return 关闭成功
     */
    @ResponseBody
    @PostMapping("shutdown.json")
    protected BaseVo shutdownProcess() {
        new Thread((Action) () -> {
            Thread.sleep(100);
            logger.info($("#{'**${dict.system.title} - ${dict.system.version} - 已退出！'}"));
            System.exit(0);
        }).start();
        return SUCCESS_VO;
    }

    /**
     * 局域网操作界面界面
     * @return ModelAndView
     */
    @RequestMapping(value = "lan.html", method = {GET, POST})
    protected ModelAndView lan() {
        return new ModelAndView("view/system/lan");
    }

    /**
     * 执行SQL脚本界面
     * @return ModelAndView
     */
    @RequestMapping(value = "sql.html", method = {GET, POST})
    protected ModelAndView sql() {
        return new ModelAndView("view/system/sql");
    }

    /**
     * 执行SQL脚本
     * @return 操作成功
     */
    @PostMapping(value = "sql.json", params = "type=sql")
    protected BaseVo sqlProcess(String sql) {
        miscellaneousService.executeSqlScript(sql);
        return SUCCESS_VO;
    }

    /**
     * 执行SQL脚本
     * @return 操作成功
     */
    @PostMapping(value = "sql.json", params = "type!=sql")
    protected BaseVo sqlProcess(MultipartFile file) throws IOException {
        miscellaneousService.executeSqlScript(file.getInputStream());
        return SUCCESS_VO;
    }
}
