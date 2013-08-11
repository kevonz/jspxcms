<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<ul id="nav_menu">
  <li><a href="nav_homepage.do" target="left" class="nav_menu_select"><s:message code="navigation.homepage"/></a></li>
	<shiro:hasPermission name="core:info:left">
  <li class="sep"></li>
  <li><a href="core/info/left.do" target="left"><s:message code="info.management"/></a></li>
  </shiro:hasPermission>
	<shiro:hasPermission name="core:node:left">
  <li class="sep"></li>
  <li><a href="core/node/left.do?noSelect=true" target="left"><s:message code="node.management"/></a></li>
  </shiro:hasPermission>
	<shiro:hasPermission name="core:web_file:left">
  <li class="sep"></li>
  <li><a href="core/web_file/left.do?noSelect=true" target="left"><s:message code="webFile.management"/></a></li>
  </shiro:hasPermission>
	<shiro:hasPermission name="nav_info_related">
  <li class="sep"></li>
  <li><a href="nav_info_related.do" target="left"><s:message code="navigation.infoRelated"/></a></li>
  </shiro:hasPermission>
	<shiro:hasPermission name="nav_user">
  <li class="sep"></li>
  <li><a href="nav_user.do" target="left"><s:message code="navigation.user"/></a></li>
  </shiro:hasPermission>
	<shiro:hasPermission name="nav_config">
  <li class="sep"></li>
  <li><a href="nav_config.do" target="left"><s:message code="navigation.config"/></a></li>
  </shiro:hasPermission>
</ul>