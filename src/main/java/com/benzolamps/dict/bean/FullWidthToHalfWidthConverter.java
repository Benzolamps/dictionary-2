package com.benzolamps.dict.bean;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.util.concurrent.atomic.AtomicReference;

import static com.benzolamps.dict.util.Constant.HALF_WIDTH_FULL_WIDTH_MAPPING;

/**
 * 全角字符转半角字符
 * @author Benzolamps
 * @version 2.1.6
 * @datetime 2018-10-4 11:08:54
 */
@Converter
public class FullWidthToHalfWidthConverter implements AttributeConverter<String, String> {
    @Override
    public String convertToDatabaseColumn(String value) {
        AtomicReference<String> aa = new AtomicReference<>(value);
        HALF_WIDTH_FULL_WIDTH_MAPPING.forEach(p -> aa.set(aa.get().replace(p.getValue(), p.getKey())));
        return aa.get();
    }

    @Override
    public String convertToEntityAttribute(String value) {
        AtomicReference<String> aa = new AtomicReference<>(value);
        HALF_WIDTH_FULL_WIDTH_MAPPING.forEach(p -> aa.set(aa.get().replace(p.getValue(), p.getKey())));
        return aa.get();
    }
}
