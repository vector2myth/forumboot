<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
      <link rel="stylesheet" href="css/page.css">
  </head>
  
  <body>
    <jsp:include page="top.jsp"></jsp:include>
<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <a href="search.jsp?q=${key}" class="layui-this">搜索结果</a>
          <span class="fly-mid"></span>
        </div>
        <ul class="fly-list">  
		<c:forEach items="${pageInfo.list}" var="tzinfo">
          <li>
            <a href="Home?memberid=${tzinfo.member.tname}" class="fly-avatar">
              <img src="<%=path %>/upload/${tzinfo.member.filename}" alt="${tzinfo.member.tname}">
            </a>
            <h2>
              <a class="layui-badge">${tzinfo.stype.typename}</a>
              <a href="tzDetail?id=${tzinfo.id}">${tzinfo.title}</a>
            </h2>
            <div class="fly-list-info">
              <a href="Home?memberid=${tzinfo.member.id}" link>
                <cite>${tzinfo.member.tname}</cite>
                <!--
                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                <i class="layui-badge fly-badge-vip">VIP3</i>
                -->
              </a>
              <span>${tzinfo.savetime}</span>
              
              <!--<span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> 60</span>
              <span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>-->
              <span class="fly-list-nums"> 
                <i class="iconfont icon-pinglun1" title="跟帖"></i> ${fn:length(tzinfo.allhtlist)}
              </span>
            </div>
            <div class="fly-list-badge">
            <c:if test="${tzinfo.isjh eq 'yes'}">
              <span class="layui-badge layui-bg-red">精帖</span>
            </c:if>
            </div>
          </li>
          </c:forEach>    
        </ul>
        <div style="text-align: center">
	        <div >
	        	<div id="LAY_page">${page.info }</div>
	        </div>
        </div>
        <!-- <div style="text-align: center">
          <div class="laypage-main">
            <a href="jie/index.html" class="laypage-next">更多求解</a>
          </div>
        </div> -->

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
</script>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>

  </body>
</html>
