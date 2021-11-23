<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
  	<script type="text/javascript" src="/forumboot/layer/jquery-2.0.3.min.js"></script>
  	<script type="text/javascript" src="/forumboot/layer/layer.js"></script>
  </head>
  
  <body>
    <jsp:include page="top.jsp"></jsp:include>

	<div class="layui-container fly-marginTop fly-user-main">
	  
	  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
	    <li class="layui-nav-item">
	      <a href="Home?memberid=${sessionScope.member.id}">
	        <i class="layui-icon">&#xe609;</i>
	        我的主页
	      </a>
	    </li>
	    <li class="layui-nav-item">
	      <a href="memberCenter">
	        <i class="layui-icon">&#xe612;</i>
	        用户中心
	      </a>
	    </li>
	    <li class="layui-nav-item">
	      <a href="memberSet">
	        <i class="layui-icon">&#xe620;</i>
	        基本设置
	      </a>
	    </li>
	    <li class="layui-nav-item  layui-this">
	      <a href="bzApply">
	        <i class="layui-icon">&#xe857;</i>
	       版主申请
	      </a>
	    </li>
	    <li class="layui-nav-item">
	      <a href="myFollow">
	        <i class="layui-icon">&#xe658;</i>
	        我的关注
	      </a>
	    </li>
	    <li class="layui-nav-item">
	      <a href="myPingbi">
	        <i class="layui-icon">&#x1006;</i>
	        屏蔽用户
	      </a>
	    </li>
	    <li class="layui-nav-item">
	      <a href="mysendSx">
	        <i class="layui-icon">&#xe63a;</i>
	        我的私信
	      </a>
	    </li>
          <li class="layui-nav-item">
              <a href="favMsg">
                  <i class="layui-icon">&#xe63a;</i>
                  我的收藏
              </a>
          </li>
	  </ul>
	
	  <div class="site-tree-mobile layui-hide">
	    <i class="layui-icon">&#xe602;</i>
	  </div>
	  <div class="site-mobile-shade"></div>
	  
	  <div class="site-tree-mobile layui-hide">
	    <i class="layui-icon">&#xe602;</i>
	  </div>
	  <div class="site-mobile-shade"></div>
	  
	  
	  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li><a href="bzapply.jsp">我的申请</a></li>
	    <li data-type="mine-jie" lay-id="index" class="layui-this">版主申请</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
            			<div class="layui-form-item">
		                <label for="fid" class="layui-form-label">申请版块</label>
		                <div class="layui-input-inline">
					        <select id="fid" name="fid" lay-verify="required" lay-search="">
					          <option value="">直接选择或搜索选择</option>
        					  <c:forEach items="${ctlist}" var="ftype">
					          <option value="${ftype.id}">${ftype.typename}</option>
					          </c:forEach>
					        </select>
					      </div>
		              </div>
		              <input type="hidden" name="memberid" id="memberid" value="${member.id}"/>
		              <div class="layui-form-item layui-form-text">
					    <label class="layui-form-label">申请原因</label>
					    <div class="layui-input-block">
					      <textarea id="note" name="note" placeholder="请输入内容" class="layui-textarea"></textarea>
					    </div>
					  </div>
				
		            <div class="layui-form-item">
		              <button class="layui-btn" onclick="sub()">提交</button>
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

	function sub(){
		var memberid = document.getElementById("memberid").value;
		var fid = document.getElementById("fid").value;
		var note = document.getElementById("note").value;
		if(fid==""){
			layer.msg('请选择版块');
			return false;
		}
		if(note==""){
			layer.msg('请填写申请原因');
			return false;
		}
					$.ajax({  
				        type: "POST",      
				        url: "applyAdd", //servlet的名字
				        data: "memberid="+memberid+"&fid="+fid+"&note="+note, 
				        success: function(data){   
						    if(data==0){     
						    	location.href="bzApply";
						    }else if(data==1){
						    	layer.msg('已经提交申请');
						    }else if(data==2){
						    	layer.msg('已经是该版块版主');
						    } 
				 		}     
					});
	}
</script>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>

  </body>
</html>
