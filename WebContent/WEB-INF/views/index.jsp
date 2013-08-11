<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Jspxcms管理平台 - Powered by Jspxcms</title>
<jsp:include page="/WEB-INF/views/commons/head.jsp"></jsp:include>
<style type="text/css">
html,body{height:100%;margin:0;padding:0;overflow:auto;}

a:link,a:visited,a:hover,a:active{font-size:14px;color:#fff;text-decoration:none;outline-style:none;}

#top{height:76px;width:100%;top:0;left:0;position:absolute;}
#header{height:46px;background:url('${ctx}/back/images/bg.png');padding:0 5px;}
#logo{float:left;height:100%;width:50%;background:url('${ctx}/back/images/admin_logo.png') no-repeat 5px center;}
#logout{float:right;width:50px;height:100%;display:block;background:url('${ctx}/back/images/logout.png') no-repeat center center;}
#homepage{float:right;width:50px;height:100%;display:block;background:url('${ctx}/back/images/home.png') no-repeat center center;}
#welcome{float:right;height:100%;line-height:46px;padding:0 10px 0 20px;background:url('${ctx}/back/images/user.png') no-repeat 0 center;}

#nav_menu{height:30px;padding-left:15px;overflow:hidden;background:url("${ctx}/back/images/top_menu_bg.png");}
#nav_menu li{font-weight:bold;height:30px;line-height:30px;float:left;}
#nav_menu li a{display:block;padding:0 15px;}
#nav_menu li.sep{width:2px;background:url("${ctx}/back/images/sep.png") no-repeat;}
.nav_menu_hover{background-color:#718fe4;}
.nav_menu_select{background-color:#637dc7;}

#container{position:absolute;width:100%;top:76px;bottom:0;}

/*for ie6 start*/
* html{padding-top:76px;}
* html #top{height:76px;position:absolute;top:0;width:100%;}
* html #container{height:100%;}
/*for ie6 end*/
</style>
<script type="text/javascript">
$(function(){
	$("#nav_menu a").each(function(){
		$(this).click(function() {
			$(this).blur();
			$("#nav_menu a").each(function() {
				$(this).removeClass("nav_menu_select");				
			});
			$(this).addClass("nav_menu_select");
		});
		$(this).hover(function () {
		  $(this).addClass("nav_menu_hover");
    }, function () {
      $(this).removeClass("nav_menu_hover");
    });
	});		
});
function keepSession() {
	$.ajax("${ctx}/keep_session.servlet",{cache:false});
}
setInterval("keepSession()",600000);
</script>
</head>
<body>
<div id="top">
	<div id="header">
	  <div id="logo"></div>
	  <a id="logout" href="logout.do" title="退出系统"></a>
	  <a id="homepage" href="${ctx}/" target="_blank" title="网站首页"></a>
	  <div id="welcome">欢迎 <b>${user.username}</b></div>
	  <div style="clear:both;"></div>
	</div>
	<jsp:include page="/WEB-INF/views/navigations/navigation.jsp"></jsp:include>
</div>
<div id="container">
  <iframe name="container" style="position:absolute;width:100%;height:100%;" frameborder="0" src="container.do"></iframe>
</div>
</body>
</html>