package com.benzolamps.dict.dao.core;

import com.benzolamps.dict.bean.BaseEntity;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

/**
 * 自定义查询, 可以指定搜索和排序
 * @param <B> 实体类型
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-7-25 19:18:04
 */
public interface DictQuery<B extends BaseEntity> {

    /**
     * 应用排序
     * @param orders 排序
     */
    void applyOrders(Order... orders);

    /**
     * 应用搜索
     * @param search 搜索
     */
    void applySearch(Search search);

    /**
     * 获取结果集查询
     * @param entityManager EntityManager
     * @return 结果集查询
     */
    TypedQuery<B> getTypedQuery(EntityManager entityManager);

    /**
     * 获取总条数查询
     * @param entityManager EntityManager
     * @return 总条数查询
     */
    TypedQuery<Long> getCountQuery(EntityManager entityManager);
}
