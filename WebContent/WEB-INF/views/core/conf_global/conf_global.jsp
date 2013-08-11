<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Jspxcms管理平台 - Powered by Jspxcms</title>
<jsp:include page="/WEB-INF/views/commons/head.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	$("#validForm").validate();
});
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="global.configuration"/> - <s:message code="edit"/></span>
</div>
<form id="validForm" action="update.do" method="post">
<table border="0" cellpadding="0" cellspacing="0" class="in_tb">
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.contextPath"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="contextPath" value="${bean.contextPath}" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="global.port"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="port" value="${bean.port}" class="{'range':[0,65535]}" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.linkAllowedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_linkAllowedExtensions" value="${bean.customs['sys_linkAllowedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.linkDeniedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_linkDeniedExtensions" value="${bean.customs['sys_linkDeniedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.imageAllowedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_imageAllowedExtensions" value="${bean.customs['sys_imageAllowedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.imageDeniedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_imageDeniedExtensions" value="${bean.customs['sys_imageDeniedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.flashAllowedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_flashAllowedExtensions" value="${bean.customs['sys_flashAllowedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.flashDeniedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_flashDeniedExtensions" value="${bean.customs['sys_flashDeniedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.videoAllowedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_videoAllowedExtensions" value="${bean.customs['sys_videoAllowedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="global.videoDeniedExtensions"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="sys_videoDeniedExtensions" value="${bean.customs['sys_videoDeniedExtensions']}" style="width:500px;"/></td>
  </tr>
  <tr>
    <td colspan="4" class="in_opt">
      <div class="in_btn"><input type="submit" value="<s:message code="save"/>"/></div>
    </td>
  </tr>
</table>
</form>
</body>
</html>