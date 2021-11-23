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
    
    
    <title>My JSP 'right.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <body>
    <div class="layui-col-md4">

      <div class="fly-panel">
        <h3 class="fly-panel-title">周排行</h3>
        <ul class="fly-panel-main fly-list-static">
        <c:forEach items="${weeklist}" var="lookrecord" begin="0" end="9">
          <li style="list-style: none;">
            <a href="javascript:;" onclick="tzdetails('${lookrecord.tzinfo.id}')"  style="color:#333333">${lookrecord.tzinfo.title}</a>
          </li>
        </c:forEach>
        </ul>
      </div>


        <div class="fly-panel">
            <h3 class="fly-panel-title">月排行</h3>
            <ul class="fly-panel-main fly-list-static">
                <c:forEach items="${monthlist}" var="lookre" begin="0" end="9">
                    <li style="list-style: none;">
                        <a href="javascript:;" onclick="tzdetails('${lookre.tzinfo.id}')"   style="color:#333333">${lookre.tzinfo.title}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>


        <div class="fly-panel">
            <h3 class="fly-panel-title">总榜</h3>
            <ul class="fly-panel-main fly-list-static">
                <c:forEach items="${phlist}" var="tzo" begin="0" end="9">
                    <li style="list-style: none;">
                        <a href="javascript:;" onclick="tzdetails('${tzo.id}')"   style="color:#333333">${tzo.title}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
      



      
      

    </div>
  <script type="text/javascript">
          function tzdetails(id) {
              $.ajax({
                  url: "recordList",
                  type: "post",
                  data: {
                      tzid: id,
                  },
                  success: function (res) {
                      if (res.data == 400) {
                          location.replace("login.jsp")
                      } else if (res.data == 300) {

                          layer.confirm('是否购买？', {
                              btn: ['是', '否'] //按钮
                          }, function () {
                              //layer.msg('的确很重要', {icon: 1});

                              //购买文章
                              $.ajax({
                                  url: "recordAdd",
                                  type: "post",
                                  data: {
                                      tzid: id,
                                  },
                                  success: function (res) {
                                      if (res.data == 330) {
                                          layer.msg("金钱不足，操作失败", {icon: 5})
                                      } else if (res.data == 300) {
                                          layer.msg("等级不够，操作失败", {icon: 5})
                                      } else if (res.data == 400) {
                                          location.replace("login.jsp")
                                      } else {
                                          layer.msg("购买成功", {icon: 6})
                                      }
                                  }
                              })

                          }, function () {
                              // layer.msg('也可以这样', {
                              //     time: 20000, //20s后自动关闭
                              //     btn: ['明白了', '知道了']
                              // });
                          });


                      } else {
                          location.replace("tzDetail?id=" + id)
                      }
                  }
              })
          }
  </script>
  </body>

</html>
