package com.benzolamps.dict.dao.core;

import com.benzolamps.dict.util.DictMath;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.Min;
import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import static com.benzolamps.dict.util.Constant.EMPTY_SET;

/**
 * 分页信息
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-7-1 18:27:13
 */
@SuppressWarnings("unchecked")
@NoArgsConstructor
public class Pageable implements Serializable {

	private static final long serialVersionUID = -3487429338961715997L;

	/** 默认页码 */
	private static final int DEFAULT_PAGE_NUMBER = 1;

	/** 默认每页记录数 */
	private static final int DEFAULT_PAGE_SIZE = 20;

	/** 最小每页记录数 */
	private static final int MIN_PAGE_SIZE = 1;

	/** 最大每页记录数 */
	private static final int MAX_PAGE_SIZE = 1000;

	/** 是否禁用分页 */
	@Getter
	@Setter
	private Boolean pageDisabled = false;

	/** 页码 */
	@Getter
	@Min(DEFAULT_PAGE_NUMBER)
	private int pageNumber = DEFAULT_PAGE_NUMBER;

	/** 每页记录数 */
	@Getter
	@Range(min = MIN_PAGE_SIZE, max = MAX_PAGE_SIZE)
	private int pageSize = DEFAULT_PAGE_SIZE;

	/** 排序 */
	@Getter
	@Setter
	private List<Order> orders = new LinkedList<>();

	/** 搜索 */
	@Getter
	@Setter
	private Set<Search> searches = EMPTY_SET;

	/** 筛选 */
	@Getter
	@JsonIgnore
	private Filter filter = new Filter();

	/**
	 * 构造方法
	 * @param pageNumber 页码
	 * @param pageSize 每页记录数
	 */
	@SuppressWarnings("unused")
	public Pageable(Integer pageNumber, Integer pageSize) {
		Optional.ofNullable(pageNumber).ifPresent(this::setPageNumber);
		Optional.ofNullable(pageSize).ifPresent(this::setPageSize);
	}

	/**
	 * 设置页码
	 * @param pageNumber 页码
	 */
	public void setPageNumber(int pageNumber) {
		this.pageNumber = DictMath.limit(pageNumber, DEFAULT_PAGE_NUMBER, Integer.MAX_VALUE);
	}

	/**
	 * 设置每页记录数
	 * @param pageSize 每页记录数
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = DictMath.limit(pageSize, MIN_PAGE_SIZE, MAX_PAGE_SIZE);
	}
}