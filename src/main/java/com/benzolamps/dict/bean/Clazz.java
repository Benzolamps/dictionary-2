package com.benzolamps.dict.bean;

import com.benzolamps.dict.component.DictPropertyInfo;
import com.benzolamps.dict.component.Size;
import com.benzolamps.dict.util.DictIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import java.util.Set;

/**
 * 班级实体类
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-9-15 14:47:54
 */
@Entity
@Table(name = "dict_class")
@Getter
@Setter
public class Clazz extends BaseEntity {

    private static final long serialVersionUID = 5117865263073835548L;

    /** 名称 */
    @Column(nullable = false)
    @NotEmpty
    @Pattern(regexp = "^[0-9a-zA-Z\\u4e00-\\u9fa5]+$")
    @Length(max = 20)
    @DictPropertyInfo(display = "名称")
    private String name;

    /** 描述 */
    @Column
    @Length(max = 50)
    @DictPropertyInfo(display = "描述")
    private String description;

    /** 学生 */
    @OneToMany(mappedBy = "clazz", fetch = FetchType.LAZY)
    @DictIgnore
    @JsonIgnore
    private Set<Student> students;

    /** 学生数 */
    @Size("students")
    @DictIgnore
    @Transient
    @JsonProperty("students")
    private Integer studentsCount;
}
