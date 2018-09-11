package com.benzolamps.dict.bean;

import com.benzolamps.dict.util.DictIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

/**
 * 实体类的基类
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-6-30 22:58:35
 */
@MappedSuperclass
@EntityListeners(DictEntityListener.class)
@Getter
@Setter
public abstract class BaseEntity implements Serializable {

    private static final long serialVersionUID = -1589883392937692838L;

    /** 主键 */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Integer id;

    /** 版本 */
    @Version
    @Column(nullable = false)
    @DictIgnore
    @JsonIgnore
    protected Integer version;

    /** 创建时间 */
    @Column(nullable = false, updatable = false)
    @DictIgnore
    @JsonIgnore
    protected Date createDate;

    /** 修改时间 */
    @Column(nullable = false)
    @DictIgnore
    @JsonIgnore
    protected Date modifyDate;

    /** 备注 */
    @Column
    @Length(max = 255)
    @DictIgnore
    @JsonIgnore
    protected String remark;

    /** @return 判断是否为新建对象 */
    @Transient
    @JsonIgnore
    public boolean isNew() {
        return getId() == null;
    }

    @Override
    public String toString() {
        return String.format("Entity of type %s with id: %s", getClass().getSimpleName(), getId());
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        if (!getClass().isAssignableFrom(obj.getClass())) {
            return false;
        }
        return Objects.equals(getId(), ((BaseEntity) obj).getId());
    }
}
