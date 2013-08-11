<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>jspxcms</title>
<jsp:include page="/WEB-INF/views/commons/head.jsp"></jsp:include>
<style type="text/css">
html{height:100%;}
</style>
<script type="text/javascript">
$(function() {
	$(".left_menu a").each(function(index) {
		if(index==0) {
			parent.frames["center"].location.href=$(this).attr("href");
			$(this).addClass("left_menu_selected");
		}
		$(this).click(function() {
			$(this).blur();
			$(".left_menu a").each(function() {
				$(this).removeClass("left_menu_selected");				
			});
			$(this).addClass("left_menu_selected");
		});
		$(this).hover(function () {
		  $(this).addClass("left_menu_hover");
    }, function () {
      $(this).removeClass("left_menu_hover");
    });

	});
});
</script>
</head>
<body class="left_body">
<ul class="left_menu">
  <li><a href="core/homepage/welcome.do" target="center" class="left_fun"><s:message code="homepage.welcome"/></a></li>
	<shiro:hasPermission name="core:homepage:environment">
  <li><a href="core/homepage/environment.do" target="center" class="left_fun"><s:message code="homepage.environment"/></a></li>
  </shiro:hasPermission>
	<shiro:hasPermission name="core:homepage:personal:edit">
  <li><a href="core/homepage/personal_edit.do" target="center" class="left_fun"><s:message code="homepage.personal"/></a></li>
	</shiro:hasPermission>
</ul>
</body>
</html>