<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">

    <title>后台管理系统</title>

    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" type="text/css" href="<%=path %>/admin/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/admin/stylesheets/theme.css">
    <link rel="stylesheet" href="<%=path %>/admin/lib/font-awesome/css/font-awesome.css">

    <script src="<%=path %>/admin/lib/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="<%=path %>/admin/lib/echarts.js" type="text/javascript"></script>


    <!-- Demo page code -->

    <style type="text/css">
        #line-chart {
            height: 300px;
            width: 800px;
            margin: 0px auto;
            margin-top: 1em;
        }

        .brand {
            font-family: georgia, serif;
        }

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
        <h1 class="page-title">Home</h1>
    </div>

    <ul class="breadcrumb">
        <li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
        <li class="active">Dashboard</li>
    </ul>
    <div class="copyrights">Collect from <a href="http://www.cssmoban.com/" title=" "> </a></div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="row-fluid">
                <div class="block">
                    <a href="#page-stats" class="block-heading" data-toggle="collapse"></a>
                    <div id="page-stats" class="block-body collapse in">
                        <div class="stat-widget-container">
                            <div class="stat-widget">
                                <div class="stat-button">
                                    <p class="title">欢迎使用!</p>
                                    <p class="detail"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
            <div id="main" style="width: 600px;height:400px;"></div>
            <script type="text/javascript">
                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'));

                myChart.setOption({
                    series : [
                        {
                            name: '访问来源',
                            type: 'pie',    // 设置图表类型为饼图
                            radius: '55%',  // 饼图的半径，外半径为可视区尺寸（容器高宽中较小一项）的 55% 长度。
                            data:[          // 数据数组，name 为数据项名称，value 为数据项值
                                {value:235, name:'视频广告'},
                                {value:274, name:'联盟广告'},
                                {value:310, name:'邮件营销'},
                                {value:335, name:'直接访问'},
                                {value:400, name:'搜索引擎'}
                            ]
                        }
                    ]
                })
            </script>
        </div>
    </div>
</div>
<script src="/forumboot/admin/lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
    $("[rel=tooltip]").tooltip();
    $(function () {
        $('.demo-cancel-click').click(function () {
            return false;
        });
    });
</script>
</body>
</html>
