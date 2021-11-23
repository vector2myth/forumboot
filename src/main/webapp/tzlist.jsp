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

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel">
        <div class="fly-panel-title fly-filter">
          <a>置顶</a>
          <a href="#signin" class="layui-hide-sm layui-show-xs-block fly-right" id="LAY_goSignin" style="color: #FF5722;">去签到</a>
        </div>
        <ul class="fly-list">
			
			<c:forEach items="${toplist}" var="toptzinfo">
          <li>
            <a href="Home?memberid=${toptzinfo.member.id}" class="fly-avatar">
              <img src="<%=path %>/upload/${toptzinfo.member.filename}" alt="${toptzinfo.member.tname}">
            </a>
            <h2>
              <a class="layui-badge">${toptzinfo.stype.typename}</a>
              <a href="tzDetail?id=${toptzinfo.id}">${toptzinfo.title}</a>
            </h2>
            <div class="fly-list-info">
              <a href="Home?memberid=${toptzinfo.member.id }" link>
                <cite>${toptzinfo.member.tname}</cite>
                <i class="iconfont icon-renzheng" title="实名认证"></i>
                <!--  <i class="layui-badge fly-badge-vip">VIP3</i>-->
              </a>
              <span>${toptzinfo.savetime }</span>
              
              <span class="fly-list-nums"> 
              
                <i class="iconfont icon-pinglun1" title="跟帖"></i>${fn:length(toptzinfo.tophtlist)}
              </span>
            </div>
            <div class="fly-list-badge">
              <c:if test="${toptzinfo.istop eq 'yes'}">
              <span class="layui-badge layui-bg-black">置顶</span>
              </c:if>
              <c:if test="${toptzinfo.isjh eq 'yes'}">
              <span class="layui-badge layui-bg-red">精帖</span>
              </c:if>
            </div>
          </li>
          </c:forEach>
          
        </ul>
      </div>

      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <a href="tzList?fid=${fid}" >全部</a>
          <c:forEach items="${childlist}" var="stype">
          <span class="fly-mid"></span>
          <a href="tzList?fid=${fid}&sid=${stype.id}" class="layui-this">${stype.typename}</a>
          </c:forEach>
        </div>

        <ul class="fly-list">  
        
		<c:forEach items="${pageInfo.list}" var="pttzinfo">
          <li>
            <a href="Home?memberid=${pttzinfo.member.id}" class="fly-avatar">
              <img src="<%=path %>/upload/${pttzinfo.member.filename}" alt="${pttzinfo.member.tname}">
            </a>
            <h2>
              <a class="layui-badge">${pttzinfo.stype.typename }</a>
              <a href="tzDetail?id=${pttzinfo.id }">${pttzinfo.title }</a>
            </h2>
            <div class="fly-list-info">
              <a href="Home?memberid=${pttzinfo.member.id}" link>
                <cite>${pttzinfo.member.tname}</cite>
                <i class="iconfont icon-renzheng" title="实名认证"></i>
                <!--
                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                <i class="layui-badge fly-badge-vip">VIP3</i>
                -->
              </a>
              <span>${pttzinfo.savetime}</span>
              
              <!--<span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> 60</span>
              <span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>-->
              <span class="fly-list-nums"> 
                <i class="iconfont icon-pinglun1" title="跟帖"></i>${fn:length(pttzinfo.pthtlist)}
              </span>
            </div>
            <div class="fly-list-badge">
            <c:if test="${pttzinfo.isjh eq 'yes'}">
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
    
    <jsp:include page="rightph.jsp"></jsp:include>
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
