package com.benzolamps.dict.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import java.util.Date;

/**
 * 学生学习记录实体类
 * @author Benzolamps
 * @version 2.1.3
 * @datetime 2018-9-17 20:10:21
 */
@SuppressWarnings("unused")
@Entity
@Table(name = "dict_study_log")
@Getter
@Setter
@JsonIgnoreProperties({"createDate", "modifyDate", "version", "remark"})
public class StudyLog extends BaseEntity {

    private static final long serialVersionUID = -2554704023637347137L;

    /** 学生 */
    @ManyToOne
    @JoinColumn(name = "student", nullable = false, updatable = false)
    @NotNull
    @JsonIgnore
    private Student student;

    /** 记录时间 */
    @Column(nullable = false, updatable = false)
    @Past
    @JsonFormat(pattern = "yyyy年MM月dd日 H:mm:ss")
    private Date logDate;

    /** 分组名称 */
    @Column(nullable = false, updatable = false)
    @NotEmpty
    private String groupName;

    /** 分组类型 */
    @Column(nullable = false, updatable = false)
    @NotNull
    private Group.Type groupType;

    /** 分组创建时间 */
    @Column(nullable = false, updatable = false)
    @Past
    @JsonFormat(pattern = "yyyy年MM月dd日 H:mm:ss")
    private Date groupCreateDate;

    /** 词库名称 */
    @Column(nullable = false, updatable = false)
    @NotEmpty
    private String libraryName;

    /** 分组单词数 */
    @Column(updatable = false)
    private Integer wordsCount;

    /** 分组短语数 */
    @Column(updatable = false)
    private Integer phrasesCount;

    /** 分组中学会的单词数 */
    @Column(updatable = false)
    private Integer masteredWordsCount;

    /** 分组中学会的短语数 */
    @Column(updatable = false)
    private Integer masteredPhrasesCount;
}
