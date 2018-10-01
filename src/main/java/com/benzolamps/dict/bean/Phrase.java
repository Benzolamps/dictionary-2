package com.benzolamps.dict.bean;

import com.benzolamps.dict.component.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Set;

/**
 * 短语实体类
 * @author Benzolamps
 * @version 1.1.1
 * @datetime 2018-6-5 21:10:34
 */
@Entity
@Table(name = "dict_phrase", uniqueConstraints = @UniqueConstraint(name = "uk_phrase", columnNames = {"library", "prototype"}))
@Getter
@Setter
@NoArgsConstructor
public class Phrase extends BaseElement {

    private static final long serialVersionUID = 5771542562398020839L;

    /** 已掌握该短语的学生 */
    @ManyToMany(mappedBy = "masteredPhrases")
    private Set<Student> masteredStudents;

    /** 未掌握该短语的学生 */
    @ManyToMany(mappedBy = "failedPhrases")
    private Set<Student> failedStudents;

    /** 已掌握该短语的学生数 */
    @Transient
    @Size("masteredStudents")
    private Integer masteredStudentsCount;

    /** 未掌握该短语的学生数 */
    @Transient
    @Size("failedStudents")
    private Integer failedStudentsCount;
}
