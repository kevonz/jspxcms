<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Jspxcms管理平台 - Powered by Jspxcms</title>
<jsp:include page="/WEB-INF/views/commons/head.jsp"></jsp:include>
<style type="text/css">
html,body{height:100%;overflow:hidden;}
</style>
<script type="text/javascript">
$(function() {
	$("#resize_btn").toggle(function() {
		$("#left").width(0);
		$("#right").attr("width","100%");
		$("#resize_btn").addClass("resize_btn_close").removeClass("resize_btn_open");
		isClose = true;
	},function() {
		$("#left").width(248);
		$("#right").removeAttr("width");
		$("#resize_btn").addClass("resize_btn_open").removeClass("resize_btn_close");
		isClose = false;
	});
});
</script>
</head>
<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td id="left" width="248px" height="100%">
      <iframe name="left" width="100%" height="100%" frameborder="0" scrolling="auto" src="nav_homepage.do"></iframe>
    </td>
    <td id="right" height="100%">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
      	<tr>
			    <td width="7px" height="100%" valign="middle" class="resize">
			      <div id="resize_btn" class="resize_btn resize_btn_open"></div>
			    </td>
			    <td height="100%">
			      <iframe name="center" width="100%" height="100%" frameborder="0" scrolling="auto" src="about:blank"></iframe>
			    </td>
		    </tr>
		  </table>
    </td>
  </tr>
</table>
</body>
</html>