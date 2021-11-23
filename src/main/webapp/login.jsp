<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.removeAttribute("member");
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
	<style>
		/*验证码*/
		
		.upload-awrp {
			overflow: hidden;
			margin: 120px 0;
		}
		
		.code {
			font-family: Arial;
			font-style: italic;
			font-size: 30px;
			border: 0;
			padding: 2px 3px;
			letter-spacing: 3px;
			font-weight: bolder;
			float: left;
			cursor: pointer;
			width: 150px;
			height: 31px;
			line-height: 30px;
			text-align: center;
			vertical-align: middle;
			border: 1px solid #6D6D72;
		}
	</style>

	<link rel="stylesheet" href="/forumboot/res/layui/css/layui.css">
  	<link rel="stylesheet" href="/forumboot/res/css/global.css">
  </head>
  
  <body>
	    <jsp:include page="top.jsp"></jsp:include>
		
		<div class="layui-container fly-marginTop">
		  <div class="fly-panel fly-panel-user" pad20>
		    <div class="layui-tab layui-tab-brief" lay-filter="user">
		      <ul class="layui-tab-title">
		        <li class="layui-this">登入</li>
		        <li><a href="reg.jsp">注册</a></li>
		      </ul>
		      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
		        <div class="layui-tab-item layui-show">
		          <div class="layui-form layui-form-pane">
		              <div class="layui-form-item">
		                <label for="uname" class="layui-form-label">用户名</label>
		                <div class="layui-input-inline">
		                  <input type="text" id="uname" name="uname" required lay-verify="required" autocomplete="off" class="layui-input">
		                </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="upass" class="layui-form-label">密码</label>
		                <div class="layui-input-inline">
		                  <input type="password" id="upass" name="upass" required lay-verify="required" autocomplete="off" class="layui-input">
		                </div>
		              </div>
		              
		              <div class="layui-form-item">
		                <label for="yzm" class="layui-form-label">验证码</label>
		                <div class="layui-input-inline">
		                  	<input type="text" id="yzm" name="yzm" required lay-verify="required" autocomplete="off" class="layui-input">
		                	<!--随机验证码-->

		                </div>
		                <div class="layui-inline">
					      	<div id="check-code" style="overflow: hidden;">
								<div class="code" id="data_code"></div>
							</div>
					    </div>
		              </div>
		              
		              <div class="layui-form-item">
		                <button class="layui-btn" onclick="login()">立即登录</button>
		              </div>
		              
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
		<jsp:include page="foot.jsp"></jsp:include>
		<script src="/forumboot/res/layui/layui.js"></script>
		<script src="/forumboot/js/jquery-2.1.0.min.js"></script>
		<script>
		layui.cache.page = 'user';
		layui.cache.user = {
		  username: '游客'
		  ,uid: -1
		  ,avatar: '/forumboot/res/images/avatar/00.jpg'
		  ,experience: 83
		  ,sex: '男'
		};
		layui.config({
		  version: "3.0.0"
		  ,base: '/forumboot/res/mods/'
		}).extend({
		  fly: 'index'
		}).use('fly');
		
			function login(){     
				 var uname=document.getElementById("uname").value;  
				 var upass=document.getElementById("upass").value; 
				 var yzm=document.getElementById("yzm").value; 
				 var data_code = document.getElementById("data_code").innerHTML;
				 if(uname==""){
				 	layer.msg('请输入用户名 ');
				 	return false;
				 }
				 if(upass==""){
				 	layer.msg('请输入密码 ');
				 	return false;
				 }
				 if(yzm==""){
				 	layer.msg('请输入验证码 ');
				 	return false;
				 }
				 if(yzm!=data_code.toLowerCase()){
				 	layer.msg('验证码不正确 ');
				 	return false;
				 }
				 $.ajax({  
				        type: "POST",      
				        url: "memberLogin", //servlet的名字
				        data: "uname="+uname+"&upass="+upass, 
				        success: function(data){   
						    if(data==1){     
						    	location.href="index";
						    }else if(data==0){    
						    	layer.msg('用户名或密码错误 ');
						    }else if(data==2){
						    	layer.msg('帐号被查封');
							    }else{
							    	layer.msg('帐号异常');
								    }
				 		}     
				});     
			}  
		</script>
		<script type="text/javascript">
	/**
	 * 验证码
	 * @param {Object} o 验证码长度
	 */
	$.fn.code_Obj = function(o) {
		var _this = $(this);
		var options = {
			code_l: o.codeLength,//验证码长度
			codeChars: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
			],
			codeColors: ['#f44336', '#009688', '#cddc39', '#03a9f4', '#9c27b0', '#5e4444', '#9ebf9f', '#ffc8c4', '#2b4754', '#b4ced9', '#835f53', '#aa677e'],
			code_Init: function() {
				var code = "";
				var codeColor = "";
				var checkCode = _this.find("#data_code");
				for(var i = 0; i < this.code_l; i++) {
					var charNum = Math.floor(Math.random() * 52);
					code += this.codeChars[charNum];
				}
				for(var i = 0; i < this.codeColors.length; i++) {
					var charNum = Math.floor(Math.random() * 12);
					codeColor = this.codeColors[charNum];
				}
				console.log(code);
				if(checkCode) {
					checkCode.css('color', codeColor);
					checkCode.className = "code";
					checkCode.text(code);
					checkCode.attr('data-value', code);
				}
			}
		};

		options.code_Init();//初始化验证码
		_this.find("#data_code").bind('click', function() {
			options.code_Init();
		});
	};
</script>
<script type="text/javascript">
	/**
	 * 验证码
	 * codeLength:验证码长度
	 */
	$('#check-code').code_Obj({
		codeLength: 5
	});
</script>
  </body>
</html>
