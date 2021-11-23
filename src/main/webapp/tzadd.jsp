<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>信息交流论坛</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="/forumboot/res/layui/css/layui.css">
  	<link rel="stylesheet" href="/forumboot/res/css/global.css">



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
  <body>
    <jsp:include page="top.jsp"></jsp:include>

	
	<div class="layui-container fly-marginTop">
  <div class="fly-panel" pad20 style="padding-top: 5px;">
    <!--<div class="fly-none">没有权限</div>-->
    <div class="layui-form layui-form-pane">
      <div class="layui-tab layui-tab-brief" lay-filter="user">
        <ul class="layui-tab-title">
          <li class="layui-this">发表新帖<!-- 编辑帖子 --></li>
        </ul>
        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
          <div class="layui-tab-item layui-show">
            <form action="tzinfoAdd" method="post">
            <input type="hidden" id="author" name="author" value="${member.id}" >
              <div class="layui-row layui-col-space15 layui-form-item">
                <div class="layui-col-md4">
				      <label class="layui-form-label">所在版块</label>
				      <div class="layui-input-inline">
				        <select id="sid" name="sid" lay-verify="required" required>
				          <option value="">请选择版块</option>
				          <c:forEach items="${ctlist}" var="fathertype">
				          <optgroup label="${fathertype.typename}">
				            <c:forEach items="${fathertype.childlist}" var="childtype">
				            <option value="${childtype.id}">${childtype.typename}</option>
				            </c:forEach>
				          </optgroup>
				        </c:forEach>
				        </select>
				      </div>
				</div>
                  <div class="layui-col-md4">
                      <label class="layui-form-label">是否发布</label>
                      <div class="layui-input-inline">
                          <select id="isfb" name="isfb" lay-verify="required"  required>
                              <option value="是">是</option>
                              <option value="否">否</option>
                          </select>
                      </div>
                  </div>
                <div class="layui-col-md4">
                	<label for="L_title" class="layui-form-label">允许回帖</label>
                  	<input type="radio" name="canht" value="yes" title="是" checked="">
				  	<input type="radio" name="canht" value="no" title="否">
                </div>
                
                <div class="layui-col-md9">
                  <label for="L_title" class="layui-form-label">标题</label>
                  <div class="layui-input-block">
                    <input type="text" id="L_title" name="title" required lay-verify="required" autocomplete="off" class="layui-input">
                    <!-- <input type="hidden" name="id" value="{{d.edit.id}}"> -->
                  </div>
                </div>

                  <div class="layui-col-md9">
                      <label for="L_title" class="layui-form-label">图片</label>
                      <div class="layui-input-block">
                          <input type="text" id="url" name="filename"    autocomplete="off" class="layui-input">
                          &nbsp;<input type='button' value='上传' onClick="up('url')" style="width: 60px;height: 37px;"/>
                      </div>
                  </div>
                
              </div>
              
              <div class="layui-form-item layui-form-text">
                <div class="layui-input-block">
                  <textarea id="editor_id" name="note"  class="layui-textarea "  style="height: 260px;" ></textarea>
                </div>
              </div>
              <c:choose>
                 <c:when test="${member.isjy eq 'no'}">
	              <div class="layui-form-item">
	                <button class="layui-btn" lay-submit lay-filter="formDemo">立即发布</button>
	              </div>
	             </c:when>
	             <c:otherwise>
              	<div class="layui-form-item">
	                <a class="layui-btn">对不起,你已被禁言</a> 
	             </div>
	             </c:otherwise>
	          </c:choose>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
      

<jsp:include page="foot.jsp"></jsp:include>
 
<script src="/forumboot/res/layui/layui.js"></script>
<script>
layui.cache.page = '';
layui.cache.user = {
  username: '游客'
  ,uid: -1
  ,avatar: '/forumboot/res/images/avatar/00.jpg'
  ,experience: 83
  ,sex: '男'
};
layui.config({
  version: "3.0.0"
  ,base: '/forumboot/res/mods/' //这里实际使用时，建议改成绝对路径
}).extend({
  fly: 'index'
}).use('fly');
layui.use('form', function() {
    var form = layui.form;
})


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
