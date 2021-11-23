<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
            
            <h1 class="page-title">帖子管理</h1>
        </div>
        
                <ul class="breadcrumb">
            <li><a href="admin/index.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">帖子管理</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
				<div class="btn-toolbar">
					<div class="search-well">
						<form action="admin/searchTzinfo" method="post" class="form-inline">
							<input class="input-xlarge" placeholder="标题或内容..." id="key" name="key" value="${key }" type="text" value="">
		                    <select id="key1" name="key1" onChange="Change_Select()" class="input-xlarge">
							<option value="">请选择大类</option>
							<c:forEach items="${flist}" var="ftype">
					    	<option value="${ftype.id}" ${ftype.id eq key1?'selected':'' }>${ftype.typename}</option>
					    	</c:forEach>
							</select>
							<select id="key2" name="key2" class="input-xlarge">
							<option value="" >请选择</option>
						    </select>
		                    <button class="btn" type="submit"><i class="icon-search"></i> Go</button>
						</form>	
					</div>  	
				</div>
			
<div class="well">
    <table class="table">
      <thead>
        <tr>
          <th>版块</th>
          <th>标题</th>
          <th>精华</th>
          <th>置顶</th>
          <th>作者</th>
          <th>日期</th>
          <th>浏览数</th>
          <th>回帖数</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
      <c:forEach items="${list}" var="tzinfo">
     
        <tr>
          <td>${tzinfo.ftype.typename}&nbsp;/&nbsp;${tzinfo.stype.typename}</td>
          <td><a href="tzDetail?id=${tzinfo.id}" target="_blank">${tzinfo.title}</a></td>
          <td>${tzinfo.isjh}</td>
          <td>${tzinfo.istop}</td>
          <td>${tzinfo.author}</td>
          <td>${tzinfo.savetime}</td>
          <td>${tzinfo.looknum}</td>
          <td>${fn:length(tzinfo.allhtlist) }</td>
          <td>
              <a href="admin/tzmove.jsp?id=${tzinfo.id}">迁移</a>
              <c:choose>
              <c:when test="${tzinfo.isjh eq 'no'}">
              <a href="javascript:tzjj('${tzinfo.id}')">精华</a>
              </c:when>
              <c:otherwise>
              <a href="javascript:tzjjqx('${tzinfo.id}')">取消精华</a>
              </c:otherwise>
              </c:choose>
              
              <c:choose>
              <c:when test="${tzinfo.istop eq 'no'}">
              <a href="javascript:tzzd('${tzinfo.id}')">置顶</a>
              </c:when>
              <c:otherwise>
              <a href="javascript:tzzdqx('${tzinfo.id}')">取消置顶</a>
              </c:otherwise>
              </c:choose>
              <a href="javascript:tzdel('${tzinfo.id}')" ><i class="icon-remove"></i></a>
          </td>
        </tr>
        </c:forEach>
      </tbody>
    </table>
</div>
</div>
</div>
</div>
    <script src="/forumboot/admin/lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
    	function ppinfoadd(){
			location.href="admin/ppinfoadd.jsp";
        }
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
        $(function(){
        	  var key2 = $("#key2");
        	  //var opt = $("#key2 option");
        	  $('#key1').change(function(){
	        	  $.ajax({
		        	  url:"admin/searchBbstype?fid="+$('#key1').val(),
		        	  type:"post",
		        	  date:"",
		        	  success:function(msg){
			        	  key2.empty();
			        	  //key2.append("<option value=\"\">请选择</option>");
			        	  key2.append(msg);
        	  		  }
        	  		});
        		});
        	});
        
        function tzdel(id){
					
					$.ajax({  
				        type: "POST",      
				        url: "admin/tzinfoDel", //servlet的名字
				        data: "id="+id, 
				        success: function(data){   
				        	if(data==0){
				        		alert('删除成功!');
				        		location.href="admin/tzinfoList";
				        	}
				        	
				 		}     
					});
		}
		
		function tzzd(id){
					$.ajax({  
				        type: "POST",      
				        url: "admin/topTzinfo", //servlet的名字
				        data: "id="+id, 
				        success: function(data){   
				        	alert('置顶成功!');
						    location.href="admin/tzinfoList";
				 		}     
					});
}

function tzjj(id){
					$.ajax({  
				        type: "POST",      
				        url: "admin/jingHua", //servlet的名字
				        data: "id="+id, 
				        success: function(data){   
				        	alert('加精成功!');
						    location.href="admin/tzinfoList";
				 		}     
					});
}

function tzzdqx(id){
					$.ajax({  
				        type: "POST",      
				        url: "admin/notopTzinfo", //servlet的名字
				        data: "id="+id, 
				        success: function(data){   
				        	alert('取消置顶成功!');
						    location.href="admin/tzinfoList";
				 		}     
					});
}

function tzjjqx(id){
					$.ajax({  
				        type: "POST",      
				        url: "admin/noJinghua", //servlet的名字
				        data: "id="+id, 
				        success: function(data){   
				        	alert('取消加精成功!');
						    location.href="admin/tzinfoList";
				 		}     
					});
}
    </script>
  </body>
</html>
