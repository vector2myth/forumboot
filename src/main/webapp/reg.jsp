<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

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
  	<script type="text/javascript" src="/forumboot/layer/layer.js"></script>
  </head>
  
  <body>
	    <jsp:include page="top.jsp"></jsp:include>
		
		<div class="layui-container fly-marginTop">
		  <div class="fly-panel fly-panel-user" pad20>
		    <div class="layui-tab layui-tab-brief" lay-filter="user">
		      <ul class="layui-tab-title">
		        <li><a href="login.jsp">登入</a></li>
		        <li class="layui-this">注册</li>
		      </ul>
		      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
		        <div class="layui-tab-item layui-show">
		          <div class="layui-form layui-form-pane">
		            <form id="form" method="post" action="memberReg">
		              <div class="layui-form-item">
		                <label for="uname" class="layui-form-label">用户名</label>
		                <div class="layui-input-inline">
		                  <input type="text" id="uname" name="uname" required oninvalid="setCustomValidity('用户名不能为空')" oninput="setCustomValidity('');" autocomplete="off" class="layui-input" onblur="validatorloginName()" >
		                </div>
		                <div class="layui-form-mid layui-word-aux">将会成为您唯一的登入名</div>
		              </div>
		              <div class="layui-form-item">
		                <label for="tname" class="layui-form-label">昵称</label>
		                <div class="layui-input-inline">
		                  <input type="text" id="tname" name="tname" required oninvalid="setCustomValidity('昵称不能为空')" oninput="setCustomValidity('');" autocomplete="off" class="layui-input" >
		                </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="upass" class="layui-form-label">密码</label>
		                <div class="layui-input-inline">
		                  <input type="password" id="upass" name="upass" required oninvalid="setCustomValidity('密码不能为空')" oninput="setCustomValidity('');" autocomplete="off" class="layui-input" >
		                </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="upass1" class="layui-form-label">确认密码</label>
		                <div class="layui-input-inline">
		                  <input type="password" id="upass1" name="upass1" required oninvalid="setCustomValidity('确认密码不能为空')" oninput="setCustomValidity('');" autocomplete="off" class="layui-input"  onblur="validatorpwd()">
		                </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="L_username" class="layui-form-label">性别</label>
		                <div class="layui-input-block">
					      <input type="radio" id="L_username" name="sex" value="男" title="男" checked="">
					      <input type="radio" name="sex" value="女" title="女">
					    </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="L_username" class="layui-form-label">头像</label>
		              	<div class="layui-upload">
						  <input name='filename' type='text' class="yanse" id='url'  required class="layui-input" style="width: 190px;height: 38px;border-color: 1px solid #FBFBFB"/>&nbsp;<input type='button' value='上传' onClick="up('url')" style="width: 60px;height: 37px;"/>
						</div>
					 </div>
		              <div class="layui-form-item">
		                <label for="L_username" class="layui-form-label">电子邮箱</label>
		                <div class="layui-input-inline">
		                  <input type="email" id="email" name="email" required  autocomplete="off" class="layui-input">
		                </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="L_username" class="layui-form-label">QQ</label>
		                <div class="layui-input-inline">
		                  <input type="text" id="qq" name="qq" required oninvalid="setCustomValidity('QQ不能为空')" oninput="setCustomValidity('');" autocomplete="off" class="layui-input">
		                </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="L_username" class="layui-form-label">电话</label>
		                <div class="layui-input-inline">
		                  <input type="text" id="tel" name="tel" required oninvalid="setCustomValidity('电话不能为空')" oninput="setCustomValidity('');" autocomplete="off" class="layui-input">
		                </div>
		              </div>
		              <div class="layui-form-item">
		                <label for="L_username" class="layui-form-label">地址</label>
		                <div class="layui-input-inline">
		                  <input type="text" id="addr" name="addr" required oninvalid="setCustomValidity('地址不能为空')" oninput="setCustomValidity('');" autocomplete="off" class="layui-input">
		                </div>
		              </div>
		              
		              <div class="layui-form-item">
		                <button class="layui-btn" >立即注册</button>
		              </div>
		            </form>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
		
		</div>

		<jsp:include page="foot.jsp"></jsp:include>
		<script src="/forumboot/res/layui/layui.js"></script>
		<script src="/forumboot/js/jquery.min.js"></script>
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
		
	
	function validatorloginName(){     
		 var uname=form.uname.value;  
		 $.ajax({  
		        type: "POST",      
		        url: "checkUname", //servlet的名字
		        data: "uname="+uname, 
		        success: function(data){  
				    if(data==0){     
				    	//layer.msg('用户名可用');
				    }else{    
				    	layer.msg('用户名不可用');
				     	form.uname.value = "";
				    }     
		 		}     
		});     
	}  
	
	function validatorpwd(){
		if(form.upass.value!=form.upass1.value){
			layer.msg('两次密码不一致');
			return false;
		}
	}


	function up(tt)
	{
			    layer.open({
			      type: 2,
			      title: '上传文件',
			      shadeClose: true,
			      shade: false,
			      maxmin: true, //开启最大化最小化按钮
			      area: ['450px', '200px'],
			      content: '/forumboot/upload.jsp?Result='+tt
			    });
	}	
		</script>
		
		

  </body>
</html>
