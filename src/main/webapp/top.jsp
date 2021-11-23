<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'top.jsp' starting page</title>
    
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
  </head>
  
  <body>
	    <div class="fly-header layui-bg-black">
	  <div class="layui-container">
	    <a class="fly-logo" href="index">
		    <h2><font color="white">信息交流论坛</font></h2>
	    </a>
	    
	    
	    
	    <ul class="layui-nav fly-nav-user">
	      <!-- 未登入的状态 -->
	      <c:if test="${sessionScope.member == null}">
	      <li class="layui-nav-item">
	        <a class="iconfont icon-touxiang layui-hide-xs" href="login.jsp"></a>
	      </li>
	      <li class="layui-nav-item">
	        <a href="login.jsp">登入</a>
	      </li>
	      <li class="layui-nav-item">
	        <a href="reg.jsp">注册</a>
	      </li>
	      </c:if>
	      <!-- 登入后的状态 -->
	      <c:if test="${sessionScope.member !=null}">
	      <li class="layui-nav-item">
	        <a class="fly-nav-avatar" href="javascript:;">
	          <cite class="layui-hide-xs">${sessionScope.member.tname}</cite>
	          <i class="iconfont icon-renzheng layui-hide-xs" title="实名认证"></i>
	          <!--<i class="layui-badge fly-badge-vip layui-hide-xs">VIP3</i>-->
	          <img src="<%=path %>/upload/${sessionScope.member.filename}">
	        </a>
	        <dl class="layui-nav-child">
	          <dd><a href="memberCenter"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>用户中心</a></dd>
	          <dd><a href="memberSet"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
	          <!--  <dd><a href="../user/message.html"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
	          <dd><a href="../user/home.html"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>-->
	          <hr style="margin: 5px 0;">
	          <dd><a href="javascript:logout()" style="text-align: center;">安全退出</a></dd>
	        </dl>
	      </li>
	      </c:if>
	      
	      
	    </ul>
	  </div>
	</div>
	
	<div class="fly-panel fly-column">
	  <div class="layui-container">
	    <ul class="layui-clear ">
	      <li class="layui-hide-xs layui-this"><a href="index">首页</a></li>
	      
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li> 
	      <!-- 用户登入后显示 -->
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="memberCenter">我发表的帖</a></li>
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="chatList">意见建议</a></li>
	    </ul> 
	    
	    <div class="fly-column-right layui-hide-xs"> 
	      <span class="fly-search"><i class="layui-icon">&#xe615;</i></span>
	      <a href="tzShowmember" class="layui-btn">发表新帖</a>
	    </div> 
	    <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;"> 
	      <a href="tzShowmember" class="layui-btn">发表新帖</a>
	    </div>


	  </div>
	</div>
	<script src="/forumboot/res/layui/layui.js"></script>
	<script src="/forumboot/js/jquery-2.1.0.min.js"></script>
	<script>
		layui.cache.page = 'user';
		layui.cache.user = {
		  username: '游客'
		  ,uid: -1
		  ,avatar: '/forumboot/res/images/avatar/00.jpg'
		  ,experience: 83
		  ,sex: '男'
		};

		
		function logout(){
				$.ajax({  
				        type: "POST",      
				        url: "memberExit", //servlet的名字
				        data: "a=1", 
				        success: function(msg){  
						    if(msg==0){     
						    	location.href="index";
						    }    
				 		}     
				}); 
		}
</script>
  </body>
</html>
