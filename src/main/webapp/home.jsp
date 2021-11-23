<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
  </head>
  
  <body>
    <jsp:include page="top.jsp"></jsp:include>

	<div class="fly-home fly-panel" style="background-image: url();">
  <img src="<%=path %>/upload/${member.filename}" alt="${member.tname }">
  <i class="iconfont icon-renzheng" title="身份认证"></i>
  <h1>
    ${member.tname }
    <c:choose>
      <c:when test="${member.sex eq '男'}"><i class="iconfont icon-nan"></i></c:when>
      <c:otherwise><i class="iconfont icon-nv"></i></c:otherwise>
    </c:choose>
    <!--
    <span style="color:#c00;">（管理员）</span>
    <span style="color:#5FB878;">（社区之光）</span>-->
    <c:if test="${member.isfh eq 'yes'}"><span>（该号已被封）</span></c:if>
  </h1>


  <p class="fly-home-info">
    <i class="iconfont icon-kiss" title="粉丝"></i><span style="color: #FF7200;">${fn:length(fanslist)} 粉丝</span>
    <i class="iconfont icon-shijian"></i><span>${member.savetime}加入</span>
    <i class="iconfont icon-chengshi"></i><span>来自${member.addr}</span>
  </p>
<!--  
  <p class="fly-home-sign">（人生仿若一场修行）</p>
-->
  <div class="fly-sns" data-user="">
    <!-- <a href="javascript:;" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">加为好友</a>-->
        <c:if test="${sessionScope.member ne null&&fn:length(sglist)==0&& sessionScope.member.id eq member.id}">
        <a href="javascript:qd('${sessionScope.member.id}')" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">签到</a>
        </c:if>
        <c:if test="${sessionScope.member ne null&&fn:length(sglist)==1&& sessionScope.member.id eq member.id}">
        <a class="layui-btn layui-btn-normal fly-imActive" data-type="chat" href="javascript:void(0)">已签到</a>
        </c:if>
        <c:if test="${sessionScope.member ne null  && sessionScope.member.id ne member.id }">
        <c:if test="${sessionScope.member ne null &&(member.id ne sessionScope.member.id)&&(isgz eq '0')}">
    	<a href="javascript:gz('${sessionScope.member.id}','${member.id}')" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">关注</a>
    	</c:if>
    	<c:if test="${sessionScope.member ne null &&(member.id ne sessionScope.member.id)&&(isgz ne '0')}">
    	<a class="layui-btn layui-btn-normal fly-imActive" data-type="chat" href="javascript:qxgz('${sessionScope.member.id}','${member.id}')">已关注</a>
    	</c:if>
    	
    	<c:if test="${sessionScope.member ne null &&(member.id ne sessionScope.member.id)&&(ispb eq '0')}">
    	<a href="javascript:pb('${sessionScope.member.id}','${member.id}')" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">屏蔽</a>
    	</c:if>
    	<c:if test="${sessionScope.member ne null &&(member.id ne sessionScope.member.id)&&(ispb ne '0')}">
    	<a class="layui-btn layui-btn-normal fly-imActive" data-type="chat" href="javascript:qxpb('${sessionScope.member.id}','${member.id}')">已屏蔽</a>
    	</c:if>
    	<a class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend" href="javascript:jb('${member.id}')">举报</a>
    	<a class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend" href="javascript:sx('${sessionScope.member.id}','${member.id}')">私信</a>
    	</c:if>
  </div>

</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md12 fly-home-jie">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${member.tname}最近的帖子</h3>
        <ul class="jie-row">
        <c:forEach items="${pageInfo.list}" var="tzinfo">
          <li>
            <c:if test="${tzinfo.isjh eq 'yes'}">
            <span class="fly-jing">精</span>
            </c:if>
            <c:if test="${tzinfo.istop eq 'yes'}">
            <span class="fly-jing">顶</span>
            </c:if>
            <a href="tzDetail?id=${tzinfo.id}" class="jie-title">${tzinfo.title}</a>
            <i>${tzinfo.savetime}</i>
            <em class="layui-hide-xs">${tzinfo.looknum }阅/${fn:length(tzinfo.allhtlist)}答</em>
          </li>
        </c:forEach>
          <!-- <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何求解</i></div> -->
        </ul>
      </div>
    </div>
    
    <!-- 
    <div class="layui-col-md6 fly-home-da">
      <div class="fly-panel">
        <h3 class="fly-panel-title">贤心 最近的回答</h3>
        <ul class="home-jieda">
          <li>
          <p>
          <span>1分钟前</span>
          在<a href="" target="_blank">tips能同时渲染多个吗?</a>中回答：
          </p>
          <div class="home-dacontent">
            尝试给layer.photos加上这个属性试试：
<pre>
full: true         
</pre>
            文档没有提及
          </div>
        </li>
        <li>
          <p>
          <span>5分钟前</span>
          在<a href="" target="_blank">在Fly社区用的是什么系统啊?</a>中回答：
          </p>
          <div class="home-dacontent">
            Fly社区采用的是NodeJS。分享出来的只是前端模版
          </div>
        </li>
        
        </ul>
      </div>
    </div>
     -->
    
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

//签到
function qd(memberid){
	var index = layer.load(1, {
	  shade: [0.1,'#fff'] //0.1透明度的白色背景
	});

	
	$.ajax({  
        type: "POST",      
        url: "signinAdd", //servlet的名字
        data: "memberid="+memberid, 
        success: function(data){   
        	if(data==0){
        		//layer.msg('关注成功!');
        		location.href="Home?memberid="+memberid;
        	}else{
        		layer.msg('你已关注过此人!');
        	}
        	
 		}     
	});

	
}


function gz(memberid,gzmemberid){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "fansAdd", //servlet的名字
				        data: "memberid="+memberid+"&gzmemberid="+gzmemberid, 
				        success: function(data){   
				        	if(data==0){
				        		layer.msg('关注成功!');
				        		location.href="Home?memberid="+gzmemberid;
				        	}else{
				        		layer.msg('你已关注过此人!');
				        	}
				        	
				 		}     
					});
}

function qxgz(memberid,gzmemberid){
	var index = layer.load(1, {
	  shade: [0.1,'#fff'] //0.1透明度的白色背景
	});
	$.ajax({  
        type: "POST",      
        url: "fansDel", //servlet的名字
        data: "memberid="+memberid+"&gzmemberid="+gzmemberid, 
        success: function(data){   
        	if(data==0){
        		layer.msg('关注成功!');
        		location.href="Home?memberid="+gzmemberid;
        	}else{
        		layer.msg('你已关注过此人!');
        	}
        	
 		}     
	});
}



function pb(memberid,pbmemberid){
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({  
				        type: "POST",      
				        url: "pbinfoAdd", //servlet的名字
				        data: "memberid="+memberid+"&pbmemberid="+pbmemberid, 
				        success: function(data){   
				        	layer.closeAll();
				        	if(data=='0'){
				        		layer.msg('屏蔽成功!');
				        		location.href="Home?memberid="+pbmemberid;
				        	}else{
				        		layer.msg('你已关注过此人!');
				        	}
				        	
				 		}     
					});
}

function qxpb(memberid,pbmemberid){
	var index = layer.load(1, {
	  shade: [0.1,'#fff'] //0.1透明度的白色背景
	});
	$.ajax({  
        type: "POST",      
        url: "pbinfoDel", //servlet的名字
        data: "memberid="+memberid+"&pbmemberid="+pbmemberid, 
        success: function(data){   
        	layer.closeAll();
        	if(data=='0'){
        		layer.msg('屏蔽成功!');
        		location.href="Home?memberid="+pbmemberid;
        	}else{
        		layer.msg('你已关注过此人!');
        	}
        	
 		}     
	});
}

function jb(jbmemberid){
	location.href="jbShow?jbmemberid="+jbmemberid;
}
function sx(memberid,sxmemberid){
	location.href="sxShow?memberid="+memberid+"&sxmemberid="+sxmemberid;
}
</script>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>

  </body>
</html>
