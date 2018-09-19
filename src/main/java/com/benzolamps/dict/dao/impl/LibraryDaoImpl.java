package com.benzolamps.dict.dao.impl;

import com.benzolamps.dict.bean.Library;
import com.benzolamps.dict.dao.base.LibraryDao;
import com.benzolamps.dict.dao.core.*;
import org.springframework.stereotype.Repository;

/**
 * 词库Dao接口实现类
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-7-1 22:16:40
 */
@Repository("libraryDao")
public class LibraryDaoImpl extends BaseDaoImpl<Library> implements LibraryDao {

    @Override
    public Page<Library> findPage(Pageable pageable) {
        DictQuery<Library> dictQuery = new GeneratedDictQuery<Library>(Library.class) {
            @Override
            public void applyOrder(Order order) {
                if (order.getField().equals("wordsCount")) {
                    order = new Order("words.size", order.getDirection());
                } else if (order.getField().equals("phrasesCount")) {
                    order = new Order("phrases.size", order.getDirection());
                }
                super.applyOrder(order);
            }
        };
        return super.findPage(dictQuery, pageable);
    }
}
