<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
	<meta charset="utf-8">
    <title>后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%=basePath%>">
    <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">
    
	<link rel="stylesheet" type="text/css" href="/forumboot/admin/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/forumboot/admin/stylesheets/theme.css">
    <link rel="stylesheet" href="/forumboot/admin/lib/font-awesome/css/font-awesome.css">

    <script src="/forumboot/admin/lib/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/forumboot/layer/layer.js"></script>

    <!-- Demo page code -->

    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .brand { font-family: georgia, serif; }
        .brand .first {
            color: #ccc;
            font-style: italic;
        }
        .brand .second {
            color: #fff;
            font-weight: bold;
        }
    </style>

      <link rel="stylesheet" href="../themes/default/default.css" />
      <link rel="stylesheet" href="../plugins/code/prettify.css" />
      <script charset="utf-8" src="../plugins/code/prettify.js"></script>
      <script charset="utf-8" src="/forumboot/kindeditor/kindeditor-all.js"></script>
      <script charset="utf-8" src="/forumboot/kindeditor/lang/zh-CN.js"></script>
      <script>
          KindEditor.ready(function(K) {
              window.editor = K.create('#editor_id');
          });
      </script>
      <script>
          KindEditor.ready(function(K) {
              K.create('textarea[name="content"]', {
                  uploadJson : '/forumboot/kindeditor/jsp/upload_json.jsp',
                  fileManagerJson : '/forumboot/kindeditor/jsp/file_manager_json.jsp',
                  allowFileManager : true,
                  allowImageUpload : true,
                  autoHeightMode : true,
                  afterCreate : function() {this.loadPlugin('autoheight');},
                  afterBlur : function(){ this.sync(); }  //Kindeditor下获取文本框信息
              });
          });
      </script>
  </head>
  
  <body class="">
	<jsp:include page="/admin/top.jsp"></jsp:include>
    
    <jsp:include page="/admin/left.jsp"></jsp:include>
    

    
       <div class="content">
        
        <div class="header">
            
            <h1 class="page-title">站内资讯编辑</h1>
        </div>
        
                <ul class="breadcrumb">
            <li><a href="admin/index.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">站内资讯编辑</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">

<div class="well">
    <div id="myTabContent" class="tab-content">
      <div class="tab-pane active in" id="home">
		    <form id="form" action="<%=path %>/admin/newsEdit" method="post">
		    <input type="hidden" name="id" value="${news.id}"/>
		        <label>标题</label>
		        <input type="text" id="title" name="title" class="input-xlarge span12"  value="${news.title}" required>
		        <label>图片</label>
		        <input name='filename' type='text' class="input-xlarge" id='url' value="${news.filename}" />
		        <label></label>
		        <input type='button' value='上传' onClick="up('url')" style="width: 60px;height: 30px;"/>
		        <label></label>
		        <label></label>
		        <label>内容</label>
		        <textarea id="content" name="content" style="width:1000px;height:400px;" >${news.content}</textarea>
		        <button class="btn btn-primary"><i class="icon-save"></i> Save</button>
		    </form>
      </div>
  </div>

</div>

<div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Delete Confirmation</h3>
  </div>
  <div class="modal-body">
    
    <p class="error-text"><i class="icon-warning-sign modal-icon"></i>Are you sure you want to delete the user?</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
    <button class="btn btn-danger" data-dismiss="modal">Delete</button>
  </div>
</div>
            </div>
        </div>
    </div>

    <script src="/forumboot/admin/lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });

    	function up(tt)
    	{
    			    layer.open({
    			      type: 2,
    			      title: '上传文件',
    			      shadeClose: true,
    			      shade: false,
    			      maxmin: true, //开启最大化最小化按钮
    			      area: ['450px', '200px'],
    			      content: '/forumboot/upload.jsp?Result='+tt
    			    });
    	}
    </script>
  </body>
</html>
