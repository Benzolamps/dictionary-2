<#-- @ftlvariable name="page" type="com.benzolamps.dict.dao.core.Page<com.benzolamps.dict.bean.Group>" -->
<@data_list
  id='word-groups'
  name='单词分组'
  fields=[
    {'type': 'numbers'},
    {'type': 'checkbox'},
    {'field': 'name', 'title': '名称', 'sort': true},
    {'field': 'description', 'title': '描述', 'sort': true},
    {'field': 'status', 'title': '状态', 'sort': true},
    {'field': 'studentsOriented', 'title': '学生数', 'sort': true},
    {'field': 'studentsScored', 'title': '已评分的学生数', 'sort': true},
    {'field': 'words', 'title': '单词数', 'sort': true}
  ]
  page=page
  add='${base_url}/word_group/add.html'
  edit='${base_url}/word_group/edit.html'
  delete='${base_url}/word_group/delete.json'
  page_enabled=true
  search=[
    {
      'name': 'name',
      'display': '名称',
      'type': 'string'
    },
    {
      'name': 'description',
      'display': '描述',
      'type': 'string'
    },
    {
      'name': 'status',
      'display': '状态',
      'type': 'string'
    }
  ]
/>
