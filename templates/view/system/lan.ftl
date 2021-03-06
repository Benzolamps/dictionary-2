<blockquote class="layui-elem-quote" style="margin-top: 10px;">
  <button id="open_firewall" class="layui-btn layui-btn-normal layui-btn-sm">开启防火墙</button>
  <button id="add_rule" class="layui-btn layui-btn-warm layui-btn-sm">添加入站规则</button>
</blockquote>
<div class="layui-row">
  <div class="layui-card" style="width: 800px;">
    <div class="layui-card-body">
      <table id="url-table" class="layui-table">
        <thead>
          <tr>
            <td colspan="2">可用的局域网链接</td>
          </tr>
        </thead>
        <tbody>
          <#list host_address as address>
            <tr>
              <td class="selectable" width="700">
                <#assign url='http://${address}:${port}${base_url}/index.html'/>
                <input type="text" title="${url}" readonly value="${url}" style="
                  border: none; width: 100%; height: 100%; background-color: transparent; color: #666"/>
              </td>
              <td width="100">
                <button style="margin-bottom: 5px" class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add" type="button">
                  <i class="fa fa-copy" style="font-size: 20px;"></i> &nbsp; 复制
                </button>
              </td>
            </tr>
          </#list>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script type="text/javascript">
  $('#open_firewall').click(function () {
    parent.layer.confirm('确定要开启防火墙？', {icon: 3, title: '提示'}, function (index) {
      parent.layer.close(index);
      dict.loadText({
        url: '${base_url}/lan/open_firewall.json',
        type: 'get',
        async: 'true',
        success: function (result, status, request) {
          parent.layer.alert('操作成功！', {icon: 1});
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

  $('#add_rule').click(function () {
    parent.layer.confirm('确定要添加入站规则？', {icon: 3, title: '提示'}, function (index) {
      parent.layer.close(index);
      dict.loadText({
        url: '${base_url}/lan/add_rule.json',
        type: 'get',
        async: 'true',
        success: function (result, status, request) {
          parent.layer.alert('操作成功！', {icon: 1});
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

  $('#url-table button').click(function () {
    var $content = $(this).parent().parent().find('input');
    $content[0].select();
    document.execCommand("Copy");
    layer.tips('已复制！', $(this).parent()[0], {anim: 0});
  });
</script>