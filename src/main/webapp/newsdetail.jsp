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
  	<script charset="utf-8" src="/forumboot/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/forumboot/kindeditor/lang/zh-CN.js"></script>

	
	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="note"]', {
				afterBlur: function () { this.sync(); },
				cssPath : '/forumboot/kindeditor/plugins/code/prettify.css',
				uploadJson : '/forumboot/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : '/forumboot/kindeditor/jsp/file_manager_json.jsp',
				allowFileManager : true,
				
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
					});
				}
			});
			prettyPrint();
		});

</script>
  </head>
  <body>
    <jsp:include page="top.jsp"></jsp:include>
<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1>${news.title}</h1>
        <div class="fly-detail-info">

        
          <div class="fly-admin-box" data-id="123">
          <cite>${news.savetime}</cite>
          	<span >&nbsp;</span>
          </div>
          
          <span class="fly-list-nums"> 
          
          </span>
        </div>
        <div class="detail-body photos">
        <c:if test="${news.filename ne ''}">
          <img alt="" src="<%=path %>/upload/${news.filename}" width="500%" height="300px"><br/>
        </c:if>
          ${news.content }
          <!--  
          <embed src="http://localhost:8088/forumboot/kindeditor/plugins/ckplayer/ckplayer.swf" flashvars="video=/forumboot/attached/media/20180320/20180320174122_252.mp4" type="application/x-shockwave-flash" width="550" height="400" autostart="false" loop="true" />
-->
        </div>
      </div>

      
    </div>
    <jsp:include page="right.jsp"></jsp:include>
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

function checksub(){
	var tzid = document.getElementById("tzid").value;
	var author = document.getElementById("author").value;
	var note = $('#note').val();
					$.ajax({  
				        type: "POST",      
				        url: "tzhtinfoadd.action", //servlet的名字     
				        data: "tzid="+tzid+"&author="+author+"&note="+note, 
				        success: function(data){   
						    if(data==0){     
						    	location.href="tzdetail.jsp?id="+tzid;
						    }else{
						    	layer.msg('回帖内容不能为空');
						    } 
				 		}     
					});   
}

function dz(id){
					$.ajax({  
				        type: "POST",      
				        url: "tzhtdz.action", //servlet的名字     
				        data: "id="+id, 
				        success: function(data){   
				        	layer.msg('点赞+1');
						    document.getElementById("emid"+id).innerText=data;
				 		}     
					});
}

function del(id,ppid){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "tzdel.action", //servlet的名字     
				        data: "id="+id, 
				        success: function(data){   
				        	layer.closeAll();
						    location.href="tzlist.jsp?ppid="+ppid;
				 		}     
					});
}
function tzzd(id){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "tzzd.action", //servlet的名字     
				        data: "id="+id, 
				        success: function(data){   
				        	layer.closeAll();
				        	layer.msg('置顶成功!');
						    location.href="tzdetail.jsp?id="+id;
				 		}     
					});
}

function tzjj(id){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "tzjj.action", //servlet的名字     
				        data: "id="+id, 
				        success: function(data){   
				        	layer.closeAll();
				        	layer.msg('加精成功!');
						    location.href="tzdetail.jsp?id="+id;
				 		}     
					});
}

function tzzdqx(id){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "tzzdqx.action", //servlet的名字     
				        data: "id="+id, 
				        success: function(data){   
				        	layer.closeAll();
				        	layer.msg('置顶成功!');
						    location.href="tzdetail.jsp?id="+id;
				 		}     
					});
}

function tzjjqx(id){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "tzjjqx.action", //servlet的名字     
				        data: "id="+id, 
				        success: function(data){   
				        	layer.closeAll();
				        	layer.msg('加精成功!');
						    location.href="tzdetail.jsp?id="+id;
				 		}     
					});
}

function delht(id,htid){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "delht.action", //servlet的名字     
				        data: "id="+htid, 
				        success: function(data){   
				        	layer.closeAll();
				        	layer.msg('删除成功!');
						    location.href="tzdetail.jsp?id="+id;
				 		}     
					});
}
function addfav(id,memberid){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "addfav.action", //servlet的名字     
				        data: "tzid="+id+"&memberid="+memberid, 
				        success: function(data){   
				        	layer.closeAll();
				        	if(data=='0'){
				        		layer.msg('收藏成功!');
				        	}else{
				        		layer.msg('此帖已经被你收藏过!');
				        	}
				        	
				 		}     
					});
}

</script>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>

  </body>
</html>
