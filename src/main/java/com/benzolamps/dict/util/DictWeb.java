package com.benzolamps.dict.util;

import org.springframework.util.Assert;

import static com.benzolamps.dict.controller.util.Constant.*;

/**
 * Web工具类
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-7-8 00:19:37
 */
public interface DictWeb {

    /**
     * 将URL后缀转换为content type
     * @param extension 后缀
     * @return content type
     */
    static String convertContentType(String extension) {
        Assert.hasText(extension, "extension不能为null或空");
        switch (extension.toLowerCase()) {
            case "css":
                return CSS;
            case "js":
                return JS;
            case "json":
                return JSON;
            case "html":
            case "htm":
                return HTML;
            case "txt":
                return TXT;
            case "xml":
            case "dtd":
            case "xsd":
                return XML;
            case "doc":
            case "docx":
                return DOC;
            case "xls":
            case "xlsx":
                return XLS;
            case "zip":
            case "jar":
            case "war":
                return ZIP;
            default:
                return TXT;
        }
    }
}
