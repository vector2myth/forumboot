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
                afterBlur : function(){ this.sync(); }  //Kindeditor下获取文本框信息
            });
        });
    </script>


</head>

<body>
<jsp:include page="top.jsp"></jsp:include>
<input type="hidden" id="hiddenmember" value="${sessionScope.member}">


<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8 content detail">
            <div class="fly-panel detail-box">
                <h1>${tzinfo.title}</h1>






                <div class="fly-detail-info">

                    <c:if test="${tzinfo.istop eq 'yes'}">
                        <span class="layui-badge layui-bg-black">置顶</span>
                    </c:if>
                    <c:if test="${tzinfo.isjh eq 'yes'}">
                        <span class="layui-badge layui-bg-red">精帖</span>
                    </c:if>

                    <div class="fly-admin-box" data-id="123">
                        <c:if test="${isbz eq 'isbz'}">
                            <span class="layui-btn layui-btn-xs jie-admin" type="del" onclick="delTzinfo('${tzinfo.id}')">删除</span>
                            <c:if test="${tzinfo.istop eq 'no'}">
                                <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1" onclick="tzzd('${tzinfo.id}')">置顶</span>
                            </c:if>
                            <!-- <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span> -->
                            <c:if test="${tzinfo.istop eq 'yes'}">
                                <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1" onclick="tzzdqx('${tzinfo.id}')">取消置顶</span>
                            </c:if>
                            <c:if test="${tzinfo.isjh eq 'no'}">
                                <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1" onclick="tzjj('${tzinfo.id}')">加精</span>
                            </c:if>
                            <!-- <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span> -->
                            <c:if test="${tzinfo.isjh eq 'yes'}">
                                <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1" onclick="tzjjqx('${tzinfo.id}')">取消加精</span>
                            </c:if>
                        </c:if>
                        <c:if test="${sessionScope.member ne null}">
                            <c:choose>
                                <c:when test="${fn:length(fvlist)==0}">
                                    <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1" onclick="addfav('${tzinfo.id}','${sessionScope.member.id}')">收藏此帖</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1" onclick="scfav('${tzinfo.id}','${sessionScope.member.id}')">取消收藏</span>
                                </c:otherwise>
                            </c:choose>
                            <span >&nbsp;</span>
                        </c:if>
                        <!-- 分享 -->
                        <!-- 分享 -->
                    </div>
                    <span class="fly-list-nums">
            <i class="iconfont" title="跟帖">&#xe60c;</i> ${fn:length(tzhtlist) }
            <i class="iconfont" title="人气">&#xe60b;</i> ${tzinfo.looknum }
                        <a href="javascript:;" onclick="dz('${tzinfo.id}')"><i class="layui-icon" title="点赞">&#xe6c6;</i></a> <span id="dznum">${tzinfo.dznum}</span>
          </span>
                </div>
                <div class="detail-about" style="margin-top: 20px;">
                    <a class="fly-avatar" href="Home?memberid=${tzinfo.member.id}">
                        <img src="<%=path %>/upload/${tzinfo.member.filename}" alt="${tzinfo.member.tname}">
                    </a>
                    <div class="fly-detail-user">
                        <a href="Home?memberid=${tzinfo.member.id}" class="fly-link">
                            <cite>${tzinfo.member.tname}</cite>
                            <i class="iconfont icon-renzheng" title="实名认证"></i>
                        </a>
                        <span>${tzinfo.savetime }</span>
                    </div>
                    <div class="detail-hits" id="LAY_jieAdmin" data-id="123">
                        <c:if test="${tzinfo.member.id eq sessionScope.member.id}">
                            <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a href="tzinfoShow?id=${tzinfo.id }">编辑此贴</a></span>
                        </c:if>
                        <span  type="edit">&nbsp;</span>
                    </div>
                </div>
                <div class="detail-body photos">
                    <c:if test="${tzinfo.filename ne null and tzinfo.filename ne ''}">
                        <div><img src="upload/${tzinfo.filename}" style="width: 100%"> </div>
                    </c:if>
                    <p>${tzinfo.note}</p>
                </div>

                <div class="fly-panel detail-box" id="flyReply">
                    <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
                        <c:choose>
                            <c:when test="${tzinfo.canht eq 'yes'}">
                                <legend>回帖</legend>
                            </c:when>
                            <c:otherwise>
                                <legend>此帖已设置不能回帖</legend>
                            </c:otherwise>
                        </c:choose>
                    </fieldset>


                    <c:if test="${tzinfo.canht ne 'no'}">
                        <ul class="jieda" id="jieda">
                            <c:forEach items="${tzhtlist}" var="tzhtinfo">
                                <li data-id="111" class="jieda-daan">
                                    <a name="item-1111111111"></a>
                                    <div class="detail-about detail-about-reply">
                                        <a class="fly-avatar" href="">
                                            <img src="<%=path %>/upload/${tzhtinfo.htmember.filename}" alt=" ">
                                        </a>
                                        <div class="fly-detail-user">
                                            <a href="Home?memberid=${tzhtinfo.htmember.id}" class="fly-link">
                                                <cite>${tzhtinfo.htmember.tname}</cite>
                                                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                                            </a>
                                            <span>${tzhtinfo.author eq tzinfo.id ?'(楼主)':''}</span>
                                            <c:if test="${tzhtinfo.htmember.isjy eq 'yes'}">
                                                <span style="color:#999">（该号已被禁言）</span>
                                            </c:if>
                                        </div>
                                            <div class="detail-hits">
                                                <span>${tzhtinfo.savetime }&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                            </div>
                                    </div>
                                    <div class="detail-body jieda-body photos">
                                        <p>${tzhtinfo.note}</p>
                                    </div>


                                    <!-- 跟帖-->
                                    <c:forEach items="${tzhtinfo.hthflist}" var="hthf">

                                    <div style="padding-left: 50px;">
                                        <div class="detail-about detail-about-reply">
                                            <a class="fly-avatar" href="">
                                                <img src="<%=path %>/upload/${hthf.member.filename}" alt=" ">
                                            </a>
                                            <div class="fly-detail-user">
                                                <a href="Home?memberid=${hthf.member.id}" class="fly-link">
                                                    <cite>${hthf.member.tname}</cite>
                                                    <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                                                </a>
                                                <c:if test="${hthf.member.isjy eq 'yes'}">
                                                    <span style="color:#999">（该号已被禁言）</span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="detail-body jieda-body photos">
                                            <p>${hthf.content}</p>
                                        </div>
                                    </div>
                                    </c:forEach>
                                    <!-- 跟帖-->


                                    <div class="jieda-reply">
                                          <span class="jieda-zan zanok" type="zan">
                                          </span>
                                        <!--
                                       <span type="reply">
                                        <i class="iconfont icon-svgmoban53"></i>
                                        3
                                      </span>
                                      -->
                                        <div class="jieda-admin">
                                            <a href="javascript:;" onclick="pinlunhf('${tzhtinfo.id}')"><span class="layui-badge layui-bg-orange" style="padding-left: 20px;">回复</span></a>
                                            <c:if test="${isbz eq 'isbz'}">
                                                <span type="del" onclick="delht('${tzinfo.id}','${tzhtinfo.id}')"><span class="layui-badge" style="padding-left: 20px;color:white;">删除</span></span>
                                            </c:if>
                                            <!-- <span class="jieda-accept" type="accept">采纳</span> -->
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>

                            <!-- 无数据时 -->
                            <!-- <li class="fly-none">消灭零回复</li> -->
                        </ul>
                        <div id="LAY_page">${page.info }</div>
                        <div class="layui-form layui-form-pane">
                            <div class="layui-form-item layui-form-text">
                                <a name="comment"></a>
                                <div class="layui-input-block">
                                    <textarea id="editor_id" name="note"  class="layui-textarea "  style="height: 150px;" ></textarea>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <input type="hidden" id="tzid" name="tzid" value="${tzinfo.id }">
                                <button class="layui-btn" onclick="checksub()">提交回复</button>
                            </div>
                        </div>
                    </c:if>

                </div>

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
</script>

<script>


    function checksub(){
        var tzid = document.getElementById("tzid").value;
        editor.sync();
        var note = $('#editor_id').val();
        location.replace("tzhtinfoAdd?tzid="+tzid+"&note="+note);
    }

    function dz(tzid){
        $.ajax({
            type: "POST",
            url: "voteAdd", //servlet的名字
            data:{
                tzid:tzid,
            },
            success: function(res){
                if(res.data==500){
                    location.replace("login.jsp")
                }else if(res.data==300){
                    layer.msg("不能点赞自己的文章",{icon:5,offset: ['200px', '550px']})
                }else if(res.data==400){
                    layer.msg("已赞过了",{icon:5,offset: ['200px', '550px']})
                }else{
                    layer.msg("点赞加1",{icon:6,offset: ['200px', '550px']})
                    $("#dznum").text(res.dznum)
                }
            }
        });
    }

    function del(id,ppid){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "tzdel.action", //servlet的名字
            data: "id="+id,
            success: function(data){
                layer.closeAll();
                location.href="tzlist.jsp?ppid="+ppid;
            }
        });
    }
    function tzzd(id){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "tzzd", //servlet的名字
            data: "id="+id,
            success: function(data){
                layer.msg('置顶成功!');
                location.href="tzDetail?id="+id;
            }
        });
    }

    function tzjj(id){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "tzjj", //servlet的名字
            data: "id="+id,
            success: function(data){
                location.href="tzDetail?id="+id;
            }
        });
    }

    function tzzdqx(id){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "tzzd", //servlet的名字
            data: "id="+id,
            success: function(data){
                layer.msg('取消置顶成功!');
                location.href="tzDetail?id="+id;
            }
        });
    }

    function tzjjqx(id){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "tzjj", //servlet的名字
            data: "id="+id,
            success: function(data){
                layer.msg('取消加精成功!');
                location.href="tzDetail?id="+id;
            }
        });
    }

    function delht(id,htid){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "delHt", //servlet的名字
            data: "id="+htid,
            success: function(data){
                layer.closeAll();
                layer.msg('删除成功!');
                location.href="tzDetail?id="+id;
            }
        });
    }
    function addfav(id,memberid){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "favAdd", //servlet的名字
            data: "tzid="+id+"&memberid="+memberid,
            success: function(data){
                layer.closeAll();
                if(data=='1'){
                    layer.msg('收藏成功!');
                    location.href="tzDetail?id="+id;
                }else{
                    layer.msg('此帖已经被你收藏过!');
                    location.href="tzDetail?id="+id;
                }

            }
        });
    }
    function scfav(id,memberid){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type: "POST",
            url: "favSc", //servlet的名字
            data: "tzid="+id+"&memberid="+memberid,
            success: function(data){
                layer.closeAll();
                location.href="tzDetail?id="+id;
            }
        });
    }

    function delTzinfo(id){
        $.ajax({
            type: "POST",
            url: "admin/tzinfoDel", //servlet的名字
            data: "id="+id,
            success: function(data){
                layer.closeAll();
                alert("删除成功");
                location.href="index";
            }
        });
    }


    function pinlunhf(htid){
        var index = layer.open({
            title:"回复",
            type:2,
            area:['600px','400px'],
            maxmin:true,
            offset: ['200px', '450px'],
            content:"tzhthf.jsp?htid="+htid,

        })
    }


    function downloadfile(filename){
        var hiddenmember = $("#hiddenmember").val()
        if(hiddenmember==""){
            location.replace("login.jsp")
        }else{
            location.replace("upload?filename="+filename)
        }

    }

</script>
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>

</body>
</html>
