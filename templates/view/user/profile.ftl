<@data_edit
  id='shuffle_solution'
  title='修改个人资料'
  fields=get_dict_property('com.benzolamps.dict.bean.User')
  values=current_user()
  messages={
  'nickname': {'pattern': '昵称中存在非法字符'}
  }
/>
