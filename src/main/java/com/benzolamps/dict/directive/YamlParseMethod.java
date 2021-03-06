package com.benzolamps.dict.directive;

import freemarker.template.TemplateMethodModelEx;
import lombok.Cleanup;
import lombok.Setter;
import lombok.SneakyThrows;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.UrlResource;
import org.springframework.util.Assert;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import static com.benzolamps.dict.directive.ResourceType.STRING;
import static com.benzolamps.dict.util.Constant.YAML;

/**
 * 将YAML资源转换为对象的Freemarker方法
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-7-11 18:40:54
 */
public class YamlParseMethod implements TemplateMethodModelEx {

    /** 资源类型 */
    @Setter
    private ResourceType resourceType;

    public YamlParseMethod() {
        this.resourceType = STRING;
    }

    @Override
    public Object exec(@SuppressWarnings("rawtypes") List arguments) {
        Assert.notNull(resourceType, "resource type不能为null");
        Assert.notEmpty(arguments, "arguments不能为空");
        String str = arguments.get(0).toString();
        Assert.notNull(str, "str不能为null");
        return execInternal(str);
    }

    @SuppressWarnings({"unused", "UnusedAssignment"})
    @SneakyThrows(IOException.class)
    private Object execInternal(String str) {
        @Cleanup InputStream inputStream = null;
        switch (resourceType) {
            case STRING:
                return YAML.load(str);
            case URL:
                return YAML.load(inputStream = new UrlResource(str).getInputStream());
            case CLASS_PATH:
                return YAML.load(inputStream = new ClassPathResource(str).getInputStream());
            case FILE_SYSTEM:
                return YAML.load(inputStream = new FileSystemResource(str).getInputStream());
            default:
                return null;
        }
    }
}