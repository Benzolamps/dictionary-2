<#-- @ftlvariable name="group" type="com.benzolamps.dict.bean.Group" -->
<#-- @ftlvariable name="students" type="java.util.List<com.benzolamps.dict.controller.vo.ClazzStudentTreeVo>" -->
<#assign title>短语分组详情</#assign>
<blockquote class="layui-elem-quote" style="margin-top: 10px;">
  ${group.name}&nbsp;&nbsp;&nbsp;&nbsp;
  <button class="layui-btn layui-btn-normal layui-btn-sm" onclick="history.back();">
    <i class="fa fa-arrow-circle-left" style="font-size: 20px;"></i> &nbsp; 返回
  </button>
  <button class="layui-btn layui-btn-warm layui-btn-sm" onclick="location.reload(true);">
    <i class="fa fa-refresh" style="font-size: 20px;"></i> &nbsp; 刷新
  </button>
  <button id="export" class="layui-btn layui-btn-primary layui-btn-sm">
    <i class="fa fa-upload" style="font-size: 20px;"></i> &nbsp; 导出短语
  </button>
  <button id="import" class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status == 'COMPLETED'> style="display: none"</#if>>
    <i class="fa fa-download" style="font-size: 20px;"></i> &nbsp; 导入学习进度
  </button>
  <button id="score" class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status == 'COMPLETED'> style="display: none"</#if>>
    去评分
  </button>
  <button id="finish"  class="layui-btn layui-btn-primary layui-btn-sm"<#if group.status != 'SCORING'> style="display: none"</#if>>
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
              <th title="短语数">短语数</th>
              <td>${group.phrasesCount}</td>
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
        <div class="ztree" id="phrases-tree" style="height: 400px; overflow-x: hidden; overflow-y: auto; margin-top: 5px; background-color: #FFE6B0"></div>
      </div>
    </div>
  </div>
  <div class="layui-col-xs6">
    <div class="layui-card" style="height: 500px;">
      <div class="layui-card-body">
        <#if group.status != 'COMPLETED'>
          <blockquote class="layui-elem-quote" style="margin-top: 10px;">
            结束评分后可查看该分组短语的考核情况！
          </blockquote>
        <#else>
          <div id="rate" style="width: 100%; height: 450px"></div>
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
    var $phraseTree = $('#phrases-tree'), $studentsTree = $('#students-tree');

    var setting = {
      <#if group.status == 'NORMAL' || group.status == 'COMPLETED'>
        check: {
          enable: true,
          chkStyle: "checkbox"
        },
      </#if>
      callback: {
        beforeClick: dict.nothing
      }
    };

    var phrasesNode = [
      {
        treeId: 'phrases',
        name: '短语',
        open: 'true',
        children: [
          <#if group.status != 'COMPLETED'>
            <#list group.phrases as phrase>
              {id: '${phrase.id}', name: '${phrase.prototype} (${phrase.definition})'},
            </#list>
          <#else>
            <#list group.groupLog.phrases as phrase>
              {id: '${phrase.id}', name: '${phrase.prototype} (${phrase.definition}) (掌握人数：${phrase.masteredStudentsCount})'},
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
              name: '${clazz.name}<#if clazz.description??> (${clazz.description})</#if>',
              children: [
                <#list clazz.students as student>
                  {
                    id: '#{student.id}',
                    name: '${student.name} (${student.number})' +
                      '<#if student.description??> (${student.description})</#if>' +
                      '<#if group.status == 'COMPLETED'> (掌握短语数：${student.masteredPhrasesCount!'未参与评分'})</#if>'
                  },
                </#list>
              ]
            },
          </#list>
        ]
      }
    ];

    var phrasesTree, studentsTree;

    <@data_tree id='phrases-tree' setting='setting' value='phrasesNode' variable='phrasesTree'/>

    <@data_tree id='students-tree' setting='setting' value='studentsNode' variable='studentsTree'/>

    $('#export').click(function () {
      <#if group.phrasesCount gt 0>
        parent.layer.open({
          type: 2,
          title: '导出短语',
          content: '${base_url}/phrase/export.html',
          area: ['800px', '600px'],
          cancel: function () {
            delete parent.exportData;
          },
          end: function () {
            if (!parent.exportData) return false;
            var data = {};
            data.groupId = ${group.id};
            data.title = parent.exportData.title;
            data.docSolutionId = parent.exportData.docSolution;
            data.shuffleSolutionId = parent.exportData.shuffleSolution;
            dict.loadText({
              url: '${base_url}/phrase/export_save.json',
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
      <#else>
        parent.layer.alert('还没有短语呢！导出个毛线啊！', {
          icon: 2,
          title: '提示'
        });
      </#if>
    });

    <#if group.status != 'COMPLETED'>
      $('#score').click(function () {
        <#if group.phrasesCount lte 0>
          parent.layer.alert('还没有短语呢！怎么评分？', {
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
            title: '短语分组评分',
            content: '${base_url}/phrase_group/score.html?id=${group.id}',
            area: ['800px', '600px']
          });
        </#if>
      });

      $('#import').click(function () {
        <#if group.phrasesCount lte 0>
          parent.layer.alert('加点短语再来吧！', {
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
            success: function (delta) {
              location.reload(true);
              parent.layer.alert('导入短语学习进度成功！<br>用时 ' + delta + ' 秒！', {icon: 1});
            }
          });
        </#if>
      });
    </#if>

    <#if group.status == 'SCORING'>
      $('#finish').click(function () {
      parent.layer.confirm('确定要结束当前评分吗？', {icon: 3, title: '提示'}, function (index) {
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
        return item.masteredPhrasesCount != null
      });
      data.sort(function (a, b) {
        return b.masteredPhrasesCount - a.masteredPhrasesCount;
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
            max: ${group.phrasesCount}
          }
        ],
        series: [
          {
            name: '掌握短语数',
            type: 'bar',
            barWidth: '60%',
            data: data.map(function (item) {
              return item.masteredPhrasesCount;
            })
          }
        ]
      });
    </#if>

    <#if group.status == 'COMPLETED'>
      $('#complete').click(function () {
        parent.layer.confirm('确定要开始新一轮的评分吗？', {icon: 3, title: '提示'}, function (index) {
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
        console.log(nodes);
        if (nodes.length <= 0) {
          parent.layer.alert('请选中要删除的学生！', {
            icon: 2,
            title: '提示'
          });
        } else {
          parent.layer.confirm('确定要删除选中的记录吗？', {icon: 3, title: '提示'}, function (index) {
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

      $phraseTree.parent().find('.delete').click(function () {
        var nodes = phrasesTree.getCheckedNodes().filter(function (node) {
          return !node.isParent;
        });
        console.log(nodes);
        if (nodes.length <= 0) {
          parent.layer.alert('请选中要删除的短语！', {
            icon: 2,
            title: '提示'
          });
        } else {
          parent.layer.confirm('确定要删除选中的记录吗？', {icon: 3, title: '提示'}, function (index) {
            dict.loadText({
              url: 'remove_phrases.json',
              type: 'post',
              data: {
                groupId: ${group.id},
                phraseId: nodes.map(function (item) {
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
  </#escape>
</script>