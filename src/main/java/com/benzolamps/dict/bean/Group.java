package com.benzolamps.dict.bean;

import com.benzolamps.dict.component.*;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Formula;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import static com.benzolamps.dict.bean.Group.Type.WORD;

/**
 * 单词短语分组
 * @author Benzolamps
 * @version 2.1.1
 * @datetime 2018-9-15 14:29:16
 */
@SuppressWarnings("SqlResolve")
@Getter
@Setter
@Entity
@Table(name = "dict_group")
@Alias("groups")
@JsonIgnoreProperties({"modifyDate", "version", "remark"})
public class Group extends BaseEntity {

    private static final long serialVersionUID = -756587292984332161L;

    /** 名称 */
    @NotEmpty
    @Length(max = 20)
    @Column(nullable = false, unique = true)
    @DictRemote("/word_group/name_not_exists.json")
    @DictPropertyInfo(display = "名称")
    private String name;

    /** 描述 */
    @Length(max = 50)
    @Column
    @DictPropertyInfo(display = "描述")
    @DictTextArea
    private String description;

    /** 词库 */
    @ManyToOne
    @JoinColumn(name = "library", updatable = false, nullable = false)
    @DictIgnore
    @JsonIgnore
    private Library library;

    /** 状态 */
    @AllArgsConstructor
    public enum Status {
        /** 正常状态, 此状态可以导出单词, 可以删除, 可以给学生评分, 若已有评分, 则自动进入SCORING状态 */
        NORMAL("正常"),

        /**
         * 评分状态, 此状态可以导出单词, 但不可删除, 可以终止评分, 进入COMPLETED状态
         * 终止后未评分的学生的单词将不会做改动, 已评分才会做改动,
         * 评分过的学生评分记录会被保留, 不能再次评分
         * 所有学生全部评分完毕后, 自动进入COMPLETED状态
         */
        SCORING("评分中"),

        /**
         * 已完成状态, 可以导出, 可以查看单词与学生掌握情况
         * 可以转换为正常状态, 所有学生都可以重新评分
         */
        COMPLETED("已完成");

        private String name;

        @JsonValue
        public String getName() {
            return name;
        }
    }

    /** 状态 */
    @DictIgnore
    @Column(nullable = false)
    private Status status;

    /** 类型 */
    public enum Type {
        /** 单词 */
        WORD,

        /** 短语 */
        PHRASE
    }

    /** 类型 */
    @Column(nullable = false, updatable = false)
    @DictIgnore
    @JsonIgnore
    private Type type;

    /** 分组中的的学生 */
    @ManyToMany
    @JoinTable(name = "dict_gs", joinColumns = @JoinColumn(name = "groups"), inverseJoinColumns = @JoinColumn(name = "student"))
    @DictIgnore
    @JsonIgnore
    private Set<Student> studentsOriented;

    /** 已评分的学生 */
    @ManyToMany
    @JoinTable(name = "dict_gss", joinColumns = @JoinColumn(name = "groups"), inverseJoinColumns = @JoinColumn(name = "student"))
    @DictIgnore
    @JsonIgnore
    private Set<Student> studentsScored;

    /** 分组中的单词 */
    @ManyToMany
    @JoinTable(name = "dict_gw", joinColumns = @JoinColumn(name = "groups"), inverseJoinColumns = @JoinColumn(name = "word"))
    @DictIgnore
    @JsonIgnore
    @OrderBy("index")
    private Set<Word> words;

    /** 分组中的短语 */
    @ManyToMany
    @JoinTable(name = "dict_gp", joinColumns = @JoinColumn(name = "groups"), inverseJoinColumns = @JoinColumn(name = "phrase"))
    @DictIgnore
    @JsonIgnore
    @OrderBy("index")
    private Set<Phrase> phrases;

    /** 分组日志 */
    @Convert(converter = GroupLog.GroupLogConverter.class)
    @Basic(fetch = FetchType.LAZY)
    @Column(insertable = false, columnDefinition = "longtext")
    @DictIgnore
    @JsonIgnore
    private GroupLog groupLog;

    /** 评分次数 */
    @Column(nullable = false)
    @DictIgnore
    private Integer scoreCount;

    /** 是否是词频分组 */
    @DictIgnore
    @Column(nullable = false, updatable = false)
    @ColumnDefault("false")
    private Boolean frequencyGenerated;

    /** 分组中的学生数 */
    @Formula("(select count(1) from dict_gs as gs where gs.groups = id)")
    @DictIgnore
    @JsonProperty("studentsOriented")
    private Integer studentsOrientedCount;

    /** 已评分的学生数 */
    @Formula("(select count(1) from dict_gss as gss where gss.groups = id)")
    @DictIgnore
    @JsonProperty("studentsScored")
    private Integer studentsScoredCount;

    /** 分组中的单词数 */
    @Formula("(select count(1) from dict_gw as gw where gw.groups = id)")
    @DictIgnore
    @JsonProperty("words")
    private Integer wordsCount;

    /** 分组中的短语数 */
    @Formula("(select count(1) from dict_gp as gp where gp.groups = id)")
    @DictIgnore
    @JsonProperty("phrases")
    private Integer phrasesCount;

    /**
     * 获取排序过的单词
     * @return 排序过的单词
     */
    @JsonIgnore
    public Collection<Word> getFrequencySortedWords() {
        return getFrequencySortedWords(this.getWords(), this);
    }

    /**
     * 获取排序过的短语
     * @return 排序过的短语
     */
    @JsonIgnore
    public Collection<Phrase> getFrequencySortedPhrases() {
        return getFrequencySortedPhrases(this.getPhrases(), this);
    }

    /**
     * 获取元素
     * @return 元素
     */
    @JsonIgnore
    @SuppressWarnings("unchecked")
    public <T extends BaseElement> Collection<T> getElements() {
        return (Collection<T>) (WORD.equals(getType()) ? getWords() : getPhrases());
    }

    /**
     * 获取排序过的元素
     * @return 元素
     */
    @JsonIgnore
    public Collection<? extends BaseElement> getFrequencySortedElements() {
        return WORD.equals(getType()) ? getFrequencySortedWords() : getFrequencySortedPhrases();
    }

    /**
     * 获取排序过的短语
     * @return 排序过的短语
     */
    public static Collection<Phrase> getFrequencySortedPhrases(Collection<Phrase> phrases, Group phraseGroup) {
        Assert.notNull(phraseGroup, "phrase group不能为空");
        if (!CollectionUtils.isEmpty(phrases) && phraseGroup.getFrequencyGenerated()) {
            phrases = phrases.stream().sorted((p1, p2) -> compare(p2, p1, phraseGroup)).collect(Collectors.toList());
        }
        return phrases;
    }

    /**
     * 获取排序过的短语
     * @return 排序过的短语
     */
    public static Collection<Word> getFrequencySortedWords(Collection<Word> words, Group wordGroup) {
        Assert.notNull(wordGroup, "word group不能为空");
        if (!CollectionUtils.isEmpty(words) && wordGroup.getFrequencyGenerated()) {
            words = words.stream().sorted((w1, w2) -> compare(w2, w1, wordGroup)).collect(Collectors.toList());
        }
        return words;
    }

    @SuppressWarnings("ConstantConditions")
    private static <E extends BaseElement> int compare(E e1, E e2, Group g) {
        Integer frequency1, frequency2;
        try {
            if (null == (frequency1 = e1.getFrequencyInfo().stream().filter(info -> info.getGroupId().equals(g.getId())).findFirst().get().getFrequency())) {
                frequency1 = 0;
            }
        } catch (Throwable e) {
            frequency1 = 0;
        }
        e1.setGroupFrequency(frequency1);
        try {
            if (null == (frequency2 = e2.getFrequencyInfo().stream().filter(info -> info.getGroupId().equals(g.getId())).findFirst().get().getFrequency())) {
                frequency2 = 0;
            }
        } catch (Throwable e) {
            frequency2 = 0;
        }
        e2.setGroupFrequency(frequency2);
        return frequency1.compareTo(frequency2);
    }

    @PostLoad
    private void postLoad() {
        if (Objects.equals(getStudentsScoredCount(), getStudentsOrientedCount()) && getStatus() == Status.SCORING) {
            setStatus(Status.COMPLETED);
        }
    }
}
