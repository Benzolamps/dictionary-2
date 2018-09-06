package com.benzolamps.dict.dao.impl;

import com.benzolamps.dict.bean.BaseElement;
import com.benzolamps.dict.bean.Library;
import com.benzolamps.dict.dao.base.BaseElementDao;
import org.springframework.core.ResolvableType;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@SuppressWarnings("unchecked")
public class BaseElementDaoImpl<T extends BaseElement> extends BaseDaoImpl<T> implements BaseElementDao<T> {

    /** 实体类类型 */
    private Class<T> entityClass;


    /** 构造方法 */
    public BaseElementDaoImpl() {
        ResolvableType resolvableType = ResolvableType.forClass(getClass());
        entityClass = (Class<T>) resolvableType.getSuperType().getGeneric().resolve();
    }

    @Override
    public Set<String> findPrototypes(Library library) {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<String> criteriaQuery = criteriaBuilder.createQuery(String.class);
        Root<T> root = criteriaQuery.from(entityClass);
        Predicate restrictions = criteriaBuilder.conjunction();
        criteriaQuery.where(restrictions, criteriaBuilder.equal(root.get("library"), library));
        criteriaQuery.select(root.get("prototype"));
        List<String> existsPrototypes = entityManager.createQuery(criteriaQuery).getResultList();
        return new HashSet<>(existsPrototypes);
    }
}
