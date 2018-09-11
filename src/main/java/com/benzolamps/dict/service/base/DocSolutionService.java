package com.benzolamps.dict.service.base;

import com.benzolamps.dict.bean.DocSolution;
import com.benzolamps.dict.bean.ShuffleSolution;
import com.benzolamps.dict.component.IShuffleStrategySetup;
import com.benzolamps.dict.controller.vo.DictPropertyInfoVo;
import com.benzolamps.dict.dao.core.Page;
import com.benzolamps.dict.dao.core.Pageable;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Word文档方案Service接口
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-9-11 21:23:42
 */
public interface DocSolutionService {

    /** @return 获取全部乱序方案 */
    List<DocSolution> findAll();

    /**
     * 根据id寻找乱序方案
     * @param id id
     * @return 乱序方案
     */
    DocSolution find(Integer id);

    /**
     * 使用
     */
    void use(Integer id);

    /** 获取基础属性 */
    Map<String, Object> getBaseProperties();
}