<#-- @ftlvariable name="page" type="com.benzolamps.dict.dao.core.Page<com.benzolamps.dict.bean.Student>" -->
<#-- @ftlvariable name="clazzes" type="java.util.Collection<com.benzolamps.dict.bean.Clazz>" -->
<@nothing><script type="text/javascript"></@nothing>
<#assign search>
  [
    {
      'name': 'number',
      'display': '学号',
      'type': 'integer'
    },
    {
      'name': 'name',
      'display': '姓名',
      'type': 'string'
    },
    {
      'name': 'description',
      'display': '描述',
      'type': 'string'
    },
    {
      'name': 'clazz',
      'display': '班级',
      'type': 'string',
      'options': [
        <#list clazzes as clazz>
          {'id': ${clazz.id}, 'value': '${clazz.name}'}<#sep>,
        </#list>
      ]
    }
  ]
</#assign>
<@nothing></script></@nothing>

<@data_list
  id='students'
  name='学生'
  fields=[
    {'type': 'numbers'},
    {'type': 'checkbox'},
    {'field': 'number', 'title': '学号', 'sort': true, 'width': 120},
    {'field': 'name', 'title': '姓名', 'sort': true, 'width': 120},
    {'field': 'description', 'title': '描述', 'sort': true, 'width': 120},
    {'field': 'clazz', 'title': '班级', 'sort': true, 'width': 120},
    {'field': 'masteredWords', 'title': '已掌握的单词', 'sort': true, 'width': 150},
    {'field': 'masteredPhrases', 'title': '已掌握的短语', 'sort': true, 'width': 150},
    {'field': 'failedWords', 'title': '未掌握的单词', 'sort': true, 'width': 150},
    {'field': 'failedPhrases', 'title': '未掌握的短语', 'sort': true, 'width': 150}
  ]
  page=page
  add='${base_url}/student/add.html'
  edit='${base_url}/student/edit.html'
  delete='${base_url}/student/delete.json'
  page_enabled=true
  search=search?eval
/>