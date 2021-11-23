<%--
  Created by IntelliJ IDEA.
  User: ding
  Date: 2020/12/10
  Time: 22:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/forumboot/res/layui/css/layui.css">

</head>
<body>
<div style="padding: 30px;">
    <form class="layui-form" action="">
        <% String htid = request.getParameter("htid");%>
        <input type="hidden" name="hiddenhtid" id="hiddenhtid" value="<%=htid%>">
         <div class="layui-form-item layui-form-text">
                <textarea name="content" id="content" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
        <div class="layui-form-item">
                <a class="layui-btn" lay-submit lay-filter="formDemo" onclick="add()">立即提交</a>
        </div>
    </form>
</div>
</body>
<script type="text/javascript" src="layer/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="layer/layer.js"></script>
<script type="text/javascript">
function add(){
    var content =$("#content").val();
    var hiddenhtid =$("#hiddenhtid").val();
if($("#content").val()==""){
layer.msg("回复内容不能为空",{icon:5})
    return false;
}
$.ajax({
    url:"hthfAdd",
    type:"post",
    data:{
        content:content,
        htid:hiddenhtid,
    },
    success:function(msg){
        if(msg.data==400){
            layer.alert("操作失败,请先登录",{icon:5},function(){
                parent.location.reload(true)
                parent.layer.closeAll();
            })
        }else{
            layer.alert("操作成功",{icon:6},function(){
                parent.location.reload(true)
                parent.layer.closeAll();
            })
        }
    }
})
}
</script>
</html>
