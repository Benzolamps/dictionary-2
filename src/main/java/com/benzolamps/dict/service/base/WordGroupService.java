package com.benzolamps.dict.service.base;

import com.benzolamps.dict.bean.Group;
import com.benzolamps.dict.bean.Student;
import com.benzolamps.dict.bean.Word;
import com.benzolamps.dict.controller.vo.ProcessImportVo;

import java.util.List;

/**
 * 单词短语分组Service接口
 * @author Benzolamps
 * @version 2.1.4
 * @datetime 2018-9-21 22:09:20
 */
public interface WordGroupService extends GroupService {

    /**
     * 添加单词
     * @param wordGroup 单词分组
     * @param words 单词
     */
    void addWords(Group wordGroup, Word... words);

    /**
     *
     * @param wordGroup 单词分组
     * @param words 单词
     */
    void removeWords(Group wordGroup, Word... words);

    /**
     * 评分
     * @param wordGroup 单词分组
     * @param student 学生
     * @param words 已掌握的单词
     */
    void scoreWords(Group wordGroup, Student student, Word... words);

    /**
     * 导入学习进度
     * @param processImportVos ProcessImportVo
     */
    void importWords(ProcessImportVo... processImportVos);

    /**
     * 添加词频分组 (TXT)
     * @param wordGroup 分组
     * @param bytes byte[]
     * @param extraWords 词库中不存在的单词
     */
    Group persistFrequencyGroupTxt(Group wordGroup, byte[] bytes, List<String> extraWords);

    /**
     * 添加词频分组 (DOC)
     * @param wordGroup 分组
     * @param bytes byte[]
     */
    Group persistFrequencyGroupDoc(Group wordGroup, byte[] bytes, List<String> extraWords);
}
