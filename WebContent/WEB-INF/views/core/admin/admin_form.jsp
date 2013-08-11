<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	$("input[name='name']").focus();
});
function confirmDelete() {
	return confirm("<s:message code='confirmDelete'/>");
}
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="admin.management"/> - <s:message code="${oprt=='edit'?'edit':'create'}"/></span>
</div>
<form id="validForm" action="${oprt=='edit'?'update':'save'}.do" method="post">
<tags:search_params/>
<f:hidden name="oid" value="${bean.id}"/>
<f:hidden name="position" value="${position}"/>
<input type="hidden" id="redirect" name="redirect" value="edit"/>
<table border="0" cellpadding="0" cellspacing="0" class="in_tb">
  <tr>
    <td colspan="4" class="in_opt">
			<div class="in_btn"><input type="button" value="<s:message code="create"/>" onclick="location.href='create.do?${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="copy"/>" onclick="location.href='create.do?id=${bean.id}&${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="delete"/>" onclick="if(confirmDelete()){location.href='delete.do?ids=${bean.id}&${searchstring}';}"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="prev"/>" onclick="location.href='edit.do?id=${side.prev.id}&position=${position-1}&${searchstring}';"<c:if test="${empty side.prev}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="next"/>" onclick="location.href='edit.do?id=${side.next.id}&position=${position+1}&${searchstring}';"<c:if test="${empty side.next}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="return"/>" onclick="location.href='list.do?${searchstring}';"/></div>
      <div style="clear:both;"></div>
    </td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="user.username"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="username" value="${oprt=='edit'?bean.username:''}" class="{required:true,remote:{url:'check_username.do',type:'post',data:{original:'${oprt=='edit'?bean.username:''}'}}}" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="user.realName"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="realName" maxlength="100" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="user.password"/>:</td>
    <td class="in_ctt" width="35%"><input id="rawPassword" type="password" name="rawPassword" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="user.pwdAgain"/>:</td>
    <td class="in_ctt" width="35%"><input type="password" class="{equalTo:'#rawPassword'}" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="user.status"/>:</td>
    <td class="in_ctt" width="35%">
    	<select name="status">
    		<f:option value="0" selected="${bean.status}" default="0"><s:message code='user.status.0'/></f:option>
    		<f:option value="1" selected="${bean.status}" default="0"><s:message code='user.status.1'/></f:option>
    	</select>
   	</td>
    <td class="in_lab" width="15%"><s:message code="user.rank"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="rank" value="${bean.rank}" disabled="disabled" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="user.email"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="email" value="${bean.email}" class="email" maxlength="100" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="user.mobile"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="mobile" value="${bean.mobile}" maxlength="100" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="admin.roles"/>:</td>
    <td class="in_ctt" width="85%" colspan="3"><f:checkboxes name="roleIds" items="${roleList}" checked="${bean.roles}" itemLabel="name" itemValue="id"/></td>
  </tr>
  <tr>
    <td colspan="4" class="in_opt">
      <div class="in_btn"><input type="submit" value="<s:message code="save"/>"/></div>
      <div class="in_btn"><input type="submit" value="<s:message code="saveAndReturn"/>" onclick="$('#redirect').val('list');"/></div>
      <c:if test="${oprt=='create'}">
      <div class="in_btn"><input type="submit" value="<s:message code="saveAndCreate"/>" onclick="$('#redirect').val('create');"/></div>
      </c:if>
      <div style="clear:both;"></div>
    </td>
  </tr>
</table>
</form>
</body>
</html>