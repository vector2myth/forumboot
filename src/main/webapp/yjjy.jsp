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
                  afterBlur : function(){ this.sync();}//Kindeditor下获取文本框信息
              });
          });
      </script>
  </head>
  <body>
    <jsp:include page="top.jsp"></jsp:include>
<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box" id="flyReply">
       <c:forEach items="${pageInfo.list}" var="chat">
          <li data-id="111" class="jieda-daan">
            <a name="item-1111111111"></a>
            <div class="detail-about detail-about-reply">
              <a class="fly-avatar" href="">
                <img src="<%=path %>/upload/${chat.member.filename}" alt=" ">
              </a>
              <div class="fly-detail-user">
                <a href="Home?memberid=${chat.member.id}" class="fly-link">
                  <cite>${chat.member.tname}</cite>
                  <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                </a>
                
                <!--
                <span style="color:#5FB878">(管理员)</span>
                <span style="color:#FF9E3F">（社区之光）</span>
                <span style="color:#999">（该号已被封）</span>
                -->
              </div>
              <div class="detail-hits">
                <span>${chat.savetime}</span>
              </div>
            </div>
            <div class="detail-body jieda-body photos">
              <p>${chat.msg}</p>
            </div>
            <c:if test="${chat.hfmsg ne ''}">
            <div class="jieda-reply">
              <p>管理员回复：${chat.hfmsg}</p>
            </div>
            </c:if>
          </li>
          </c:forEach>
          
          
          <!-- 无数据时 -->
          <!-- <li class="fly-none">消灭零回复</li> -->
        <c:if test="${fn:length(list)!=0}">
            <c:if test="${fn:length(pageInfo.list) gt 0}">
                <div id="pagediv" style="border:0px solid red;">
                    <ul>
                        <li>
                            <a href="chatList?pageNum=${pageInfo.hasPreviousPage==false?1:pageInfo.prePage}&key=${key}">上一页</a>
                        </li>
                        <c:forEach begin="1" end="${pageInfo.pages}"
                                   varStatus="status">
                            <li class="pagesz ${status.count eq pageInfo.pageNum ?"acvtive":""}">
                                <a href="chatList?pageNum=${status.count}&key=${key}">${status.count}</a>
                            </li>
                        </c:forEach>
                        <li>
                            <a href="chatList?pageNum=${pageInfo.hasNextPage==false? pageInfo.pages : pageInfo.nextPage}&key=${key}">下一页</a>
                        </li>
                    </ul>
                </div>
            </c:if>
        </c:if>
        <c:if test="${sessionScope.member ne null}">
        <input type="hidden" id="memberid" name="memberid" value="${sessionScope.member.id}"/>
        <div style="margin-top: 20px;"></div>
        <div class="layui-form layui-form-pane">
            <div class="layui-form-item layui-form-text">
              <a name="comment"></a>
              <div class="layui-input-block">
                <textarea id="editor_id" name="note"  class="layui-textarea "  style="height: 250px;" ></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <button class="layui-btn" onclick="checksub()">提交回复</button>
            </div>
        </div>
        </c:if>
        
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
					var index = layer.load(1, {
					  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
        editor.sync();
					var memberid = document.getElementById("memberid").value;
					var note = document.getElementById('editor_id').value;
					$.ajax({
				        type: "POST",      
				        url: "chatAdd", //servlet的名字
				        data: "memberid="+memberid+"&msg="+note, 
				        success: function(data){  
				        	layer.closeAll(); 
						    if(data==0){
						        alert("操作成功");
						    	location.href="chatList";
						    }else{
						    	layer.msg("内容不能为空");
						    }
				 		}     
					});   
}



</script>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>

  </body>
</html>
