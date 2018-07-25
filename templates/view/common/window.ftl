<#--
  -- layout界面
  -- author: Benzolamps
  -- version: 2.1.1
  -- datetime: 2018-7-11 19:25:14
  -->

<#-- @ftlvariable name="title" type="java.lang.String" -->
<#-- @ftlvariable name="content_path" type="java.lang.String" -->
<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
  <link rel="stylesheet" type="text/css" href="${base_url}/layui/css/layui.css"/>
  <link rel="stylesheet" type="text/css" href="${base_url}/layui/css/modules/layer/default/layer.css"/>
  <link rel="stylesheet" type="text/css" href="${base_url}/font-awesome/css/font-awesome.min.css"/>
  <link rel="stylesheet" type="text/css" href="${base_url}/res/css/common.css"/>
  <script type="text/javascript" src="${base_url}/js/jquery-3.3.1.js"></script>
  <script type="text/javascript" src="${base_url}/js/jquery.cookie.js"></script>
  <script type="text/javascript" src="${base_url}/layui/layui.js"></script>
  <script type="text/javascript" src="${base_url}/layui/lay/modules/layer.js"></script>
  <script type="text/javascript" src="${base_url}/res/js/common.js"></script>
</head>
<body>
  <#include '/${content_path}.ftl'/>
</body>
</html>