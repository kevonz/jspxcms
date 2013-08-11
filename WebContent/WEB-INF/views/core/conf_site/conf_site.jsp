<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fnx" uri="http://java.sun.com/jsp/jstl/functionsx"%>
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
  <span class="c_position"><s:message code="site.configuration"/> - <s:message code="edit"/></span>
</div>
<form id="validForm" action="update.do" method="post">
<table border="0" cellpadding="0" cellspacing="0" class="in_tb">
<!-- 
  <tr>
    <td colspan="4" class="in_opt">
			<input type="button" value="<s:message code="return"/>" onclick="location.href='list.do?${searchstring}';"/>
    </td>
  </tr>
 -->
  <tr>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="site.name"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="name" value="${bean.name}" class="required" maxlength="100" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="site.fullName"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="fullName" value="${bean.fullName}" class="" maxlength="100" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="site.domain"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="domain" value="${bean.domain}" class="required" maxlength="100" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="site.htmlPath"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="htmlPath" value="${bean.htmlPath}" class="" maxlength="100" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="site.templateTheme"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="templateTheme" value="${bean.templateTheme}" class="required" maxlength="100" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="site.withDomain"/>:</td>
    <td class="in_ctt" width="35%">
    	<label><f:radio name="withDomain" value="true" checked="${bean.withDomain}" class="required" /><s:message code="yes"/></label>
    	<label><f:radio name="withDomain" value="false" checked="${bean.withDomain}" default="false" class="required" /><s:message code="no"/></label>
  	</td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="site.noPicture"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:text name="noPicture" value="${bean.noPicture}" class="required" maxlength="255" style="width:180px;"/></td>

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