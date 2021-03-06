<#-- @ftlvariable name="title" type="java.lang.String" -->
<#-- @ftlvariable name="content_path" type="java.lang.String" -->
<@compress>
  <!doctype html>
  <html lang="zh-CN">
    <head>
      <meta charset="utf-8"/>
      <link rel="stylesheet" type="text/css" href="${base_url}/layui/css/layui.css"/>
      <link rel="stylesheet" type="text/css" href="${base_url}/font-awesome/css/font-awesome.min.css"/>
      <link rel="stylesheet" type="text/css" href="${base_url}/res/css/common.css"/>
      <link rel="icon" type="image/x-icon" href="${base_url}/favicon.ico"/>
      <script type="text/javascript" src="${base_url}/js/jquery-3.3.1.js"></script>
      <script type="text/javascript" src="${base_url}/js/jquery.form.js"></script>
      <script type="text/javascript" src="${base_url}/jquery-validation-1.17.0/jquery.validate.js"></script>
      <script type="text/javascript" src="${base_url}/jquery-validation-1.17.0/additional-methods.js"></script>
      <script type="text/javascript" src="${base_url}/jquery-validation-1.17.0/localization/messages_zh.js"></script>
      <script type="text/javascript" src="${base_url}/layui/layui.all.js"></script>
      <script type="text/javascript" src="${base_url}/res/js/common.js"></script>
      <script>
        parent.dict.updateSocket.initCallback();
      </script>
    </head>
    <body>
      <div class="overflow">
        <#include '/${content_path}.ftl'/>
      </div>
      <script type="text/javascript">
        $(function () {
          /* 请求栏目JSON */
          var columns = dict.loadText({
            type: "get",
            loading: false,
            async: false,
            url: '${base_url}/res/json/columns.json',
            cache: true,
            dataType: 'json'
          });

          /* 将当前页面地址与JSON中逐个比对 */
          var href = location.href, column = -1, child = -1, title = '${title!}';
          for (var i = 0; i < columns.length; i++) {
            var children = columns[i].children;
            for (var j = 0; j < children.length; j++) {
              if (href.indexOf(children[j].href) > -1) {
                column = i;
                child = j;
                title || title.trim().length > 0 || (title = children[j].title);
                /* 将找到的栏目设为选中 */
                if (column >= 0 && child >= 0) {
                  var $li = parent.$('ul.dict-nav-tree>li').eq(column);
                  $li.parent().find('.layui-nav-itemed').removeClass('layui-nav-itemed');
                  $li.addClass('layui-nav-itemed');
                  /* language=JQuery-CSS */
                  var $dd = $li.find('dl.layui-nav-child>dd').eq(child);
                  $dd.parent().find('.layui-this').removeClass('layui-this');
                  $dd.addClass('layui-this');
                  localStorage.setItem('column', column);
                  localStorage.setItem('child', child);
                }
                break;
              }
            }
          }

          document.title = title;
          parent.document.title = title + ' - ${system_title} - ${system_version}';
        });
      </script>
    </body>
  </html>
</@compress>