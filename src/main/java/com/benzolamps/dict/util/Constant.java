package com.benzolamps.dict.util;

import org.springframework.cglib.proxy.Enhancer;
import org.springframework.cglib.proxy.MethodInterceptor;
import org.yaml.snakeyaml.Yaml;

import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.function.Supplier;

/**
 * 常量
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-8-23 19:10:34
 */
@SuppressWarnings({"unchecked", "unused", "rawtypes"})
public interface Constant {

    /** 日期格式 */
    String DATE_FORMAT = "yyyy-MM-dd";

    /** 时间格式 */
    String TIME_FORMAT = "HH:mm:ss";

    /** SimpleDateFormat */
    DateFormat SIMPLE_DATE_FORMAT = new SimpleDateFormat(DATE_FORMAT + " " + TIME_FORMAT);

    /** 标识符正则表达式 */
    // language=RegExp
    String IDENTIFIER_PATTERN = "^[$_a-zA-Z][$_a-zA-Z0-9]*$";

    /** 中文正则表达式 */
    // language=RegExp
    String CHINESE_PATTERN = "^[\\u4e00-\\u9fa5\\ufe30-\\uffa0]$";

    /** 中文、字母、数字、下划线2到20位 */
    // language=RegExp
    String CHINESE_TITLE_PATTERN = "^[_a-zA-Z0-9\\u4e00-\\u9fa5\\ufe30-\\uffa0]{2,20}$";

    /** 大陆手机号 */
    // language=RegExp
    String MOBILE_PATTERN = "^1[3-9][0-9]{9}$";

    /** 空的Object数组 */
    Object[] EMPTY_OBJECT_ARRAY = new Object[0];

    /** 空的String数组 */
    String[] EMPTY_STRING_ARRAY = new String[0];

    /** 空的Method数组 */
    Method[] EMPTY_METHOD_ARRAY = new Method[0];

    /** 空的Class数组 */
    Class[] EMPTY_CLASS_ARRAY = new Class[0];

    /** 文本文件格式 */
    String[] TEXT_FILES = {
        ".txt", ".java", ".html", ".css", ".js", ".yml", ".xml", ".json", ".less", ".svg", ".scss", ".md", ".ftl", ".ini", ".vbs", ".sql"
    };

    /** 空的List */
    List EMPTY_LIST = Collections.EMPTY_LIST;

    /** 空的Set */
    Set EMPTY_SET = Collections.EMPTY_SET;

    /** 空的Collection */
    Collection EMPTY_COLLECTION = Collections.EMPTY_LIST;

    /** 空的Map */
    Map EMPTY_MAP = Collections.EMPTY_MAP;

    /** Yaml */
    Yaml YAML = new Yaml();

    /** 空的Properties */
    Properties EMPTY_PROPERTIES = ((Supplier<Properties>) () -> {
        Enhancer enhancer = new Enhancer();
        enhancer.setSuperclass(Properties.class);
        enhancer.setCallback((MethodInterceptor) (obj, method, args, methodProxy) ->
            method.getDeclaringClass().isInstance(EMPTY_MAP) ? methodProxy.invoke(EMPTY_MAP, args) : methodProxy.invokeSuper(obj, args));
        return (Properties) enhancer.create();
    }).get();

    /** 半角字符与全角字符映射 */
    List<KeyValuePairs<Character, Character>> HALF_WIDTH_FULL_WIDTH_MAPPING = ((Supplier<List>) () -> {
        List<KeyValuePairs<Character, Character>> mapping = new ArrayList<>();
        mapping.add(new KeyValuePairs<>(',', '，'));
        mapping.add(new KeyValuePairs<>('\'', '’'));
        mapping.add(new KeyValuePairs<>('\'', '‘'));
        mapping.add(new KeyValuePairs<>('"', '”'));
        mapping.add(new KeyValuePairs<>('"', '“'));
        mapping.add(new KeyValuePairs<>(';', '；'));
        mapping.add(new KeyValuePairs<>(':', '：'));
        mapping.add(new KeyValuePairs<>('/', '／'));
        mapping.add(new KeyValuePairs<>('\\', '＼'));
        mapping.add(new KeyValuePairs<>('!', '！'));
        mapping.add(new KeyValuePairs<>('?', '？'));
        mapping.add(new KeyValuePairs<>('&', '＆'));
        mapping.add(new KeyValuePairs<>('|', '｜'));
        mapping.add(new KeyValuePairs<>('(', '（'));
        mapping.add(new KeyValuePairs<>(')', '）'));
        mapping.add(new KeyValuePairs<>('[', '［'));
        mapping.add(new KeyValuePairs<>(']', '］'));
        mapping.add(new KeyValuePairs<>('<', '＜'));
        mapping.add(new KeyValuePairs<>('>', '＞'));
        mapping.add(new KeyValuePairs<>('{', '｛'));
        mapping.add(new KeyValuePairs<>('}', '｝'));
        mapping.add(new KeyValuePairs<>('~', '～'));
        mapping.add(new KeyValuePairs<>('@', '＠'));
        mapping.add(new KeyValuePairs<>('#', '＃'));
        mapping.add(new KeyValuePairs<>('_', '＿'));
        mapping.add(new KeyValuePairs<>('-', '－'));
        mapping.add(new KeyValuePairs<>('¯', '￣'));
        mapping.add(new KeyValuePairs<>('`', 'ˋ'));
        mapping.add(new KeyValuePairs<>('+', '＋'));
        mapping.add(new KeyValuePairs<>('*', '＊'));
        mapping.add(new KeyValuePairs<>('%', '％'));
        mapping.add(new KeyValuePairs<>('$', '＄'));
        mapping.add(new KeyValuePairs<>('¥', '￥'));
        return mapping;
    }).get();
}
