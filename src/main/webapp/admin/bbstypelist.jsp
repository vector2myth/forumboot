<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
  <head>
	<meta charset="utf-8">
    <title>后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%=basePath%>">
    <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">
    
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/admin/stylesheets/theme.css">
    <link rel="stylesheet" href="<%=path %>/admin/lib/font-awesome/css/font-awesome.css">

    <script src="<%=path %>/admin/lib/jquery-1.7.2.min.js" type="text/javascript"></script>
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
            
            <h1 class="page-title">版块分类</h1>
        </div>
        
                <ul class="breadcrumb">
            <li><a href="admin/index.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">版块分类</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
				<div class="btn-toolbar">
					<div class="search-well">
						<form action="admin/bbstypeList" method="post" class="form-inline">
							<input class="input-xlarge" placeholder="类别名称..." id="key" name="key" type="text" value="${key}">
		                    <button class="btn" type="submit"><i class="icon-search"></i> Go</button>
						    <button class="btn btn-primary" onclick="protypeadd(0)" type="button"><i class="icon-plus"></i> 大类</button>
						</form>	
					</div>  	
				</div>
			
<div class="well">
    <table class="table" border=0>
      <thead>
        <tr>
          <th>大类名称</th>
          <th>版主</th>
          <th>小类</th>
        </tr>
      </thead>
      <tbody>
      <c:forEach items="${pageInfo.list}" var="bbstype">
        <tr>
          <td>${bbstype.typename}
          [<a href="<%=path %>/admin/bbstypeShow?id=${bbstype.id}"><i class="icon-pencil"></i></a>
		    &nbsp;
		    <a href="<%=path %>/admin/bbstypeDel?id=${bbstype.id}" ><i class="icon-remove"></i></a>
		    ]
          </td>
          <td>
          <c:if test="${bbstype.banzhu ne null}">
          ${bbstype.banzhu.tname}[<a href="javascript:cxbz('${bbstype.banzhu.id}','${bbstype.id}')">撤销</a>]&nbsp;&nbsp;
          </c:if>
          <c:if test="${bbstype.banzhu eq null}">
          暂无版主
          </c:if>
          </td>
          <td>
            <a href="admin/bbstypeadd.jsp?fatherid=${bbstype.id}&type=child"><i class="icon-plus"></i></a>
		    &nbsp;&nbsp;
            <c:forEach items="${bbstype.childlist}" var="childbbstype">
            ${childbbstype.typename}
		    [<a href="admin/bbstypeShow?id=${childbbstype.id}"><i class="icon-pencil"></i></a>
		    &nbsp;
		    <a href="admin/bbstypeDel?id=${childbbstype.id}" ><i class="icon-remove"></i></a>
		    ]
		    &nbsp;&nbsp;&nbsp;
		    </c:forEach>
          </td>
        </tr>
       </c:forEach>
       <tr>
           <td style="font-weight: bold;font-family:楷体;font-weight: bold; color:blue;text-align: right;" colspan="9">
               <c:if test="${fn:length(pageInfo.list) gt 0}">
                   <div id="pagediv" style="border:0px solid red;">
                       <ul>
                           <li>
                               <a href="admin/bbstypeList?pageNum=${pageInfo.hasPreviousPage==false?1:pageInfo.prePage}&key=${key}">上一页</a>
                           </li>
                           <c:forEach begin="1" end="${pageInfo.pages}"
                                      varStatus="status">
                               <li class="pagesz ${status.count eq pageInfo.pageNum ?"acvtive":""}">
                                   <a href="admin/bbstypeList?pageNum=${status.count}&key=${key}">${status.count}</a>
                               </li>
                           </c:forEach>
                           <li>
                               <a href="admin/bbstypeList?pageNum=${pageInfo.hasNextPage==false? pageInfo.pages : pageInfo.nextPage}&key=${key}">下一页</a>
                           </li>
                       </ul>
                   </div>
               </c:if>
           </td>
       </tr>
      </tbody>
    </table>
</div>
<div class="pagination">
    ${page.info }
</div>

    <script src="/forumboot/admin/lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
    	function protypeadd(fatherid){
			location.href="admin/bbstypeadd.jsp?fatherid=0";
        }
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
        
                function cxbz(memberid,fid){
					$.ajax({  
				        type: "POST",      
				        url: "admin/bzDel", //servlet的名字
				        data: "memberid="+memberid+"&fid="+fid, 
				        success: function(data){   
				        	alert('操作成功!');
						    location.href="admin/bbstypeList";
				 		}     
					});
				}
    </script>
  </body>
</html>
