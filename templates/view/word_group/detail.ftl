<#-- @ftlvariable name="group" type="com.benzolamps.dict.bean.Group" -->
<#-- @ftlvariable name="students" type="java.util.List<com.benzolamps.dict.controller.vo.ClazzStudentTreeVo>" -->
<#assign title>单词分组详情</#assign>
<blockquote class="layui-elem-quote" style="margin-top: 10px;">
  ${group.name}&nbsp;&nbsp;&nbsp;&nbsp;
  <button class="layui-btn layui-btn-normal layui-btn-sm" onclick="history.back();">
    <i class="fa fa-arrow-circle-left" style="font-size: 20px;"></i> &nbsp; 返回
  </button>
  <button class="layui-btn layui-btn-warm layui-btn-sm" onclick="location.reload(true);">
    <i class="fa fa-refresh" style="font-size: 20px;"></i> &nbsp; 刷新
  </button>
  <button id="export" class="layui-btn layui-btn-primary layui-btn-sm">
    <i class="fa fa-upload" style="font-size: 20px;"></i> &nbsp; 导出单词
  </button>
  <button id="import" class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status == 'COMPLETED'> style="display: none"</#if>>
    <i class="fa fa-download" style="font-size: 20px;"></i> &nbsp; 导入单词学习进度
  </button>
  <button id="edit-frequency-group" class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status == 'SCORING' || !group.frequencyGenerated> style="display: none"</#if>>
    更新单词词频分组
  </button>
  <button id="score" class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status == 'COMPLETED'> style="display: none"</#if>>
    去评分
  </button>
  <button id="finish" class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status != 'SCORING'> style="display: none"</#if>>
    结束评分
  </button>
  <button id="complete" class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status != 'COMPLETED'> style="display: none"</#if>>
    完成评分
  </button>
</blockquote>
<div class="layui-row">
  <div class="layui-col-xs6">
    <div class="layui-card">
      <div class="layui-card-body">
        <table class="layui-table">
          <colgroup>
            <col width="30">
            <col width="70">
          </colgroup>
          <thead></thead>
          <tbody>
            <tr>
              <th title="状态">状态</th>
              <td>${group.status.getName()}</td>
            </tr>
            <tr>
              <th title="单词数">单词数</th>
              <td>${group.wordsCount}</td>
            </tr>
            <tr>
              <th title="已考核次数">已考核次数</th>
              <td>${group.scoreCount}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <div class="layui-col-xs6">
    <div class="layui-card">
      <div class="layui-card-body">
        <table class="layui-table">
          <thead></thead>
          <tbody>
            <tr>
              <th title="描述">描述</th>
              <td>${group.description!''}</td>
            </tr>
            <tr>
              <th title="学生数">学生数</th>
              <td>${group.studentsOrientedCount}</td>
            </tr>
            <tr>
              <th title="已考核学生数">已评分学生数</th>
              <td>${group.studentsScoredCount}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<div class="layui-row" style="margin-top: 20px">
  <div class="layui-col-xs3">
    <div class="layui-card" style="height: 500px;">
      <div class="layui-card-body">
        <#if group.status == 'NORMAL' || group.status == 'COMPLETED'>
          <button class="layui-btn layui-btn-primary layui-btn-xs select-all">全选</button>
          <button class="layui-btn layui-btn-primary layui-btn-xs select-none">全不选</button>
          <button class="layui-btn layui-btn-primary layui-btn-xs select-reverse">反选</button>
          <button class="layui-btn layui-btn-danger layui-btn-xs delete">删除</button>
        </#if>
        <div class="ztree" id="words-tree" style="height: 400px; overflow-x: hidden; overflow-y: auto; margin-top: 5px; background-color: #FFE6B0"></div>
      </div>
    </div>
  </div>
  <div class="layui-col-xs6">
    <div class="layui-card" style="height: 500px;">
      <div class="layui-card-body">
        <#if group.status != 'COMPLETED'>
          <blockquote class="layui-elem-quote" style="margin-top: 10px;">
            结束评分后可查看该分组单词的考核情况！
          </blockquote>
        <#else>
          <div style="text-align: center">
            <button class="layui-btn layui-btn-warm layui-btn-sm extract-derive-group">创建派生单词分组</button>
            <button class="layui-btn layui-btn-warm layui-btn-sm extract-personal-group">创建专属单词分组</button>
          </div>
          <div id="rate" style="width: 100%; height: 430px"></div>
        </#if>
      </div>
    </div>
  </div>
  <div class="layui-col-xs3">
    <div class="layui-card" style="height: 500px;">
      <div class="layui-card-body">
        <#if group.status == 'NORMAL' || group.status == 'COMPLETED'>
          <button class="layui-btn layui-btn-primary layui-btn-xs select-all">全选</button>
          <button class="layui-btn layui-btn-primary layui-btn-xs select-none">全不选</button>
          <button class="layui-btn layui-btn-primary layui-btn-xs select-reverse">反选</button>
          <button class="layui-btn layui-btn-danger layui-btn-xs delete">删除</button>
          <#if group.status == 'COMPLETED'>
            <button class="layui-btn layui-btn-warm layui-btn-xs view">查看</button>
          </#if>
        </#if>
        <div class="ztree" id="students-tree" style="height: 400px; overflow-x: hidden; overflow-y: auto; margin-top: 5px; background-color: #FFE6B0"></div>
      </div>
    </div>
  </div>
</div>
<link rel="stylesheet" type="text/css" href="${base_url}/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
<script type="text/javascript" src="${base_url}/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${base_url}/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${base_url}/js/echarts.min.js"></script>
<script>
  <#escape x as x?js_string>
    var $wordsTree = $('#words-tree'), $studentsTree = $('#students-tree');

    var setting = {
      <#if group.status == 'NORMAL' || group.status == 'COMPLETED'>
        check: {
          enable: true,
          chkStyle: 'checkbox'
        },
      </#if>
      callback: {
        beforeClick: dict.nothing
      }
    };

    var wordsNode = [
      {
        treeId: 'words',
        name: '单词',
        open: 'true',
        children: [
          <#if group.status != 'COMPLETED'>
            <#list group.frequencySortedWords as word>
            {id: '${word.id}', name: '${word.prototype}（${word.definition}）（词频：${group.frequencyGenerated?string(word.groupFrequency + '／', '') + word.frequency}）'},
            </#list>
          <#else>
            <#list group.groupLog.words as word>
            {id: '${word.id}', name: '${word.prototype}（${word.definition}）（掌握人数：${word.masteredStudentsCount}）'},
            </#list>
          </#if>
        ]
      }
    ];

    var studentsNode = [
      {
        name: '学生',
        open: 'true',
        children: [
          <#list students as clazz>
            {
              id: '${clazz.id}',
              name: '${clazz.name}<#if clazz.description??>（${clazz.description}）</#if>',
              children: [
                <#list clazz.students as student>
                  {
                    id: '#{student.id}',
                    name: '${student.name} (${student.number})' +
                      '<#if student.description??>（${student.description}）</#if>' +
                      '<#if group.status == 'COMPLETED'>（掌握单词数：${student.masteredWordsCount!'未参与评分'}）</#if>'
                  },
                </#list>
              ]
            },
          </#list>
        ]
      }
    ];

    var wordsTree, studentsTree;

    <@data_tree id='words-tree' setting='setting' value='wordsNode' variable='wordsTree'/>

    <@data_tree id='students-tree' setting='setting' value='studentsNode' variable='studentsTree'/>

    $('#export').click(function () {
      <#if group.wordsCount lte 0>
        parent.layer.alert('还没有单词呢！导出个毛线啊！', {
          icon: 2,
          title: '提示'
        });
      <#elseif group.studentsOrientedCount lte 0>
        parent.layer.alert('还没有学生呢！无法导出专属文档！', {
          icon: 2,
          title: '提示'
        });
      <#else>
       parent.layer.open({
         type: 2,
         title: '导出单词',
         content: '${base_url}/word/export.html',
         area: ['800px', '600px'],
         cancel: function () {
           delete parent.exportData;
         },
         end: function () {
           if (!parent.exportData) return false;
           var data = {};
           data.groupIds = [${group.id}];
           data.title = parent.exportData.title;
           data.docSolutionId = parent.exportData.docSolution;
           data.shuffleSolutionId = parent.exportData.shuffleSolution;
           dict.loadText({
             url: '${base_url}/word/export_save.json',
             type: 'post',
             data: data,
             dataType: 'json',
             requestBody: true,
             success: function (result, status, request) {
               parent.layer.alert('导出成功！', {
                 icon: 1,
                 end: function () {
                   dict.postHref('${base_url}/doc/download', {
                     fileName: data.title,
                     token: result.data
                   });
                 }
               });
             },
             error: function (result, status, request) {
               parent.layer.alert(result.message, {
                 icon: 2,
                 title: result.status
               });
             }
           });
         }
       });
      </#if>
    });

    <#if group.status != 'COMPLETED'>
      $('#score').click(function () {
        <#if group.wordsCount lte 0>
          parent.layer.alert('还没有单词呢！怎么评分？', {
            icon: 2,
            title: '提示'
          });
        <#elseif group.studentsOrientedCount lte 0>
          parent.layer.alert('还没有学生呢！不能评分！', {
            icon: 2,
            title: '提示'
          });
        <#else>
          parent.layer.open({
            type: 2,
            title: '单词分组评分',
            content: '${base_url}/word_group/score.html?id=${group.id}',
            area: ['800px', '600px']
          });
        </#if>
      });

      $('#import').click(function () {
        <#if group.wordsCount lte 0>
          parent.layer.alert('加点单词再来吧！', {
            icon: 2,
            title: '提示'
          });
        <#elseif group.studentsOrientedCount lte 0>
          parent.layer.alert('还没有学生呢！', {
            icon: 2,
            title: '提示'
          });
        <#else>
          dict.uploadFile({
            action: 'import.json',
            data: {
              groupId: ${group.id}
            },
            multiple: true,
            accept: 'image/*',
            success: function (data, delta) {
              location.reload(true);
              parent.layer.alert('导入单词学习进度成功！<br>用时 ' + delta + ' 秒！', {icon: 1});
            }
          });
        </#if>
      });
    </#if>

    <#if group.status == 'SCORING'>
      $('#finish').click(function () {
      parent.layer.confirm('确定要结束当前评分吗？', {icon: 3, title: '提示'}, function (index) {
        parent.layer.close(index);
        dict.loadText({
          url: 'finish.json',
          type: 'post',
          data: {
            id: ${group.id}
          },
          dataType: 'json',
          success: function (result, status, request) {
            parent.layer.alert('操作成功！', {
              icon: 1,
              end: function () {
                parent.$('iframe')[0].contentWindow.dict.reload(true);
                var layerIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(layerIndex);
              }
            });
          },
          error: function (result, status, request) {
            parent.layer.alert(result.message, {
              icon: 2,
              title: result.status
            });
          }
        });
      });
    });
    </#if>

    <#if group.status == 'COMPLETED'>
      var data = <@json_dump obj=group.groupLog.students/>;
      data = data.filter(function (item) {
        return item.masteredWordsCount != null
      });
      data.sort(function (a, b) {
        return b.masteredWordsCount - a.masteredWordsCount;
      });

      data = data.slice(0, 10);
      echarts.init($('#rate')[0]).setOption({
        color: ['#3398DB'],
        tooltip : {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [
          {
            type: 'category',
            data: data.map(function (item) {
              return item.name;
            }),
            axisTick: {
              alignWithLabel: true
            }
          }
        ],
        yAxis: [
          {
            type: 'value',
            max: ${group.wordsCount}
          }
        ],
        series: [
          {
            name: '掌握单词数',
            type: 'bar',
            barWidth: '60%',
            data: data.map(function (item) {
              return item.masteredWordsCount;
            })
          }
        ]
      });
    </#if>

    <#if group.status == 'COMPLETED'>
      $('#complete').click(function () {
        parent.layer.confirm('确定要开始新一轮的评分吗？', {icon: 3, title: '提示'}, function (index) {
          parent.layer.close(index);
          dict.loadText({
            url: 'complete.json',
            type: 'post',
            data: {
              id: ${group.id}
            },
            dataType: 'json',
            success: function (result, status, request) {
              parent.layer.alert('操作成功！', {
                icon: 1,
                end: function () {
                  parent.$('iframe')[0].contentWindow.dict.reload(true);
                  var layerIndex = parent.layer.getFrameIndex(window.name);
                  parent.layer.close(layerIndex);
                }
              });
            },
            error: function (result, status, request) {
              parent.layer.alert(result.message, {
                icon: 2,
                title: result.status
              });
            }
          });
        });
      });
    </#if>

    <#if group.status == 'NORMAL' || group.status == 'COMPLETED'>
      $studentsTree.parent().find('.delete').click(function () {
        var nodes = studentsTree.getCheckedNodes().filter(function (node) {
          return !node.isParent;
        });
        if (nodes.length <= 0) {
          parent.layer.alert('请选中要删除的学生！', {
            icon: 2,
            title: '提示'
          });
        } else {
          parent.layer.confirm('确定要删除选中的记录吗？', {icon: 3, title: '提示'}, function (index) {
            parent.layer.close(index);
            dict.loadText({
              url: 'remove_students.json',
              type: 'post',
              data: {
                groupId: ${group.id},
                studentId: nodes.map(function (item) {
                  return item.id;
                })
              },
              dataType: 'json',
              success: function (result, status, request) {
                parent.layer.alert('操作成功！', {
                  icon: 1,
                  end: function () {
                    parent.$('iframe')[0].contentWindow.dict.reload(true);
                    var layerIndex = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(layerIndex);
                  }
                });
              },
              error: function (result, status, request) {
                parent.layer.alert(result.message, {
                  icon: 2,
                  title: result.status
                });
              }
            });
          });
        }
      });

      $wordsTree.parent().find('.delete').click(function () {
        var nodes = wordsTree.getCheckedNodes().filter(function (node) {
          return !node.isParent;
        });
        if (nodes.length <= 0) {
          parent.layer.alert('请选中要删除的单词！', {
            icon: 2,
            title: '提示'
          });
        } else {
          parent.layer.confirm('确定要删除选中的记录吗？', {icon: 3, title: '提示'}, function (index) {
            parent.layer.close(index);
            dict.loadText({
              url: 'remove_words.json',
              type: 'post',
              data: {
                groupId: ${group.id},
                wordId: nodes.map(function (item) {
                  return item.id;
                })
              },
              dataType: 'json',
              success: function (result, status, request) {
                parent.layer.alert('操作成功！', {
                  icon: 1,
                  end: function () {
                    parent.$('iframe')[0].contentWindow.dict.reload(true);
                    var layerIndex = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(layerIndex);
                  }
                });
              },
              error: function (result, status, request) {
                parent.layer.alert(result.message, {
                  icon: 2,
                  title: result.status
                });
              }
            });
          });
        }
      });
    </#if>

    <#if group.status == 'COMPLETED'>
      $studentsTree.parent().find('.view').click(function () {
        var nodes = studentsTree.getCheckedNodes().filter(function (node) {
          return !node.isParent;
        });
        if (nodes.length != 1) {
          parent.layer.alert('请选中一个要查看信息的学生！', {
            icon: 2,
            title: '提示'
          });
        } else {
          parent.layer.open({
            type: 2,
            title: '查看学生信息',
            content: '${base_url}/word_group/score.html?id=${group.id}&studentId=' + nodes[0].id,
            area: ['800px', '600px']
          });
        }
      });

      $('.extract-derive-group').click(function () {
        var studentNodes = studentsTree.getCheckedNodes().filter(function (node) {
          return !node.isParent;
        });
        var wordNodes = wordsTree.getCheckedNodes().filter(function (node) {
          return !node.isParent;
        });
        if (studentNodes.length <= 0 && wordNodes.length <= 0) {
          parent.layer.alert('没有单词，也没有学生，臣妾做不到啊！', {
            icon: 2,
            title: '提示'
          });
        } else {
          parent.layer.open({
            type: 2,
            title: '创建派生单词分组',
            content: (function () {
              var baseUrl = '${base_url}/word_group/extract_derive_group.html?';
              $.each(studentNodes, function (index, item) {
                baseUrl += 'studentId=' + item.id + '&';
              });
              $.each(wordNodes, function (index, item) {
                baseUrl += 'wordId=' + item.id + '&';
              });
              baseUrl += 'groupId=${group.id}';
              return baseUrl;
            })(),
            area: ['400px', '400px']
          });
        }
      });

      $('.extract-personal-group').click(function () {
        var studentNodes = studentsTree.getCheckedNodes().filter(function (node) {
          return !node.isParent;
        });

        if (studentNodes.length <= 0) {
          parent.layer.alert('没有学生，不能创建专属单词分组！', {
            icon: 2,
            title: '提示'
          });
        } else {
          parent.layer.open({
            type: 2,
            title: '创建专属单词分组',
            content: (function () {
              var baseUrl = '${base_url}/word_group/extract_personal_group.html?';
              $.each(studentNodes, function (index, item) {
                baseUrl += 'studentId=' + item.id + '&';
              });
              baseUrl += 'groupId=${group.id}';
              return baseUrl;
            })(),
            area: ['400px', '400px']
          });
        }
      });
    </#if>

    <#if group.status != 'SCORING' && group.frequencyGenerated>
      $('#edit-frequency-group').click(function () {
        parent.layer.open({type: 2, title: '更新短语词频分组', content: '${base_url}/word_group/edit_frequency_group.html?id=${group.id}', area: ['400px', '400px']});
      });
    </#if>
  </#escape>
</script>