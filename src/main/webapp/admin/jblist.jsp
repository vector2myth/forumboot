<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
      <link rel="stylesheet" href="./css/page.css">
	
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

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">

	
  </head>
  
  <body class="">
	<jsp:include page="/admin/top.jsp"></jsp:include>
    <jsp:include page="/admin/left.jsp"></jsp:include>
       <div class="content">
        <div class="header">
            <h1 class="page-title">举报信息</h1>
        </div>
                <ul class="breadcrumb">
            <li><a href="admin/index.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">举报信息</li>
        </ul>
        <div class="container-fluid">
            <div class="row-fluid">
				<div class="btn-toolbar">
					<div class="search-well">
						<form action="admin/jbList" method="post" class="form-inline">
							<input class="input-xlarge" placeholder="内容..." id="key" name="key" type="text" value="">
		                    <button class="btn" type="submit"><i class="icon-search"></i> Go</button>
						</form>	
					</div>  	
				</div>
			
<div class="well">
    <table class="table">
      <thead>
        <tr>
          <th>被举报人</th>
          <th>举报人</th>
          <th>举报原因</th>
          <th style="width: 26px;"></th>
        </tr>
      </thead>
      <tbody>
      <c:forEach items="${pageInfo.list}" var="jbrecord">
        <tr>
          <td>${jbrecord.jbmember.uname}/${jbrecord.jbmember.tname }</td>
          <td>${jbrecord.member.uname}/${jbrecord.member.tname }</td>
          <td>${jbrecord.note}</td>
          <td>
              <a href="admin/jbDel?id=${jbrecord.id}" ><i class="icon-remove"></i></a>
          </td>
        </tr>
      </c:forEach>
      <tr>
          <td style="font-weight: bold;font-family:楷体;font-weight: bold; color:blue;text-align: right;" colspan="9">
              <c:if test="${fn:length(pageInfo.list) gt 0}">
                  <div id="pagediv" style="border:0px solid red;">
                      <ul>
                          <li>
                              <a href="admin/jbList?pageNum=${pageInfo.hasPreviousPage==false?1:pageInfo.prePage}&key=${key}">上一页</a>
                          </li>
                          <c:forEach begin="1" end="${pageInfo.pages}"
                                     varStatus="status">
                              <li class="pagesz ${status.count eq pageInfo.pageNum ?"acvtive":""}">
                                  <a href="admin/jbList?pageNum=${status.count}&key=${key}">${status.count}</a>
                              </li>
                          </c:forEach>
                          <li>
                              <a href="admin/jbList?pageNum=${pageInfo.hasNextPage==false? pageInfo.pages : pageInfo.nextPage}&key=${key}">下一页</a>
                          </li>
                      </ul>
                  </div>
              </c:if>
          </td>
        </tr>
      </tbody>
    </table>
</div>
</div>
</div>
</div>
    <script src="/forumboot/admin/lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
    	function newsadd(){
			location.href="admin/newsadd.jsp";
        }
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
  </body>
</html>
