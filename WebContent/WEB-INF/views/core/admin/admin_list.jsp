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
	$("#pagedTable").tableHighlight();
	$("#sortHead").headSort();
});
function confirmDelete() {
	return confirm("<s:message code='confirmDelete'/>");
}
function confirmDeletePassword() {
	return confirm("<s:message code='user.confirmDeletePassword'/>");
}
function optSingle(opt) {
	if(Cms.checkeds("ids")==0) {
		alert("<s:message code='pleaseSelectRecord'/>");
		return false;
	}
	if(Cms.checkeds("ids")>1) {
		alert("<s:message code='pleaseSelectOne'/>");
		return false;
	}
	var id = $("input[name='ids']:checkbox:checked").val();
	location.href=$(opt+id).attr("href");
}
function optMulti(form, action, msg) {
	if(Cms.checkeds("ids")==0) {
		alert("<s:message code='pleaseSelectRecord'/>");
		return false;
	}
	if(msg && !confirm(msg)) {
		return false;
	}
	form.action=action;
	form.submit();
	return true;
}
function optDelete(form) {
	if(Cms.checkeds("ids")==0) {
		alert("<s:message code='pleaseSelectRecord'/>");
		return false;
	}
	if(!confirmDelete()) {
		return false;
	}
	form.action='delete.do';
	form.submit();
	return true;
}
function optDeletePassword(form) {
	if(Cms.checkeds("ids")==0) {
		alert("<s:message code='pleaseSelectRecord'/>");
		return false;
	}
	if(!confirmDeletePassword()) {
		return false;
	}
	form.action='delete_password.do';
	form.submit();
	return true;
}
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="admin.management"/> - <s:message code="list"/></span>
	<span class="c_total">(<s:message code="totalElements" arguments="${pagedList.totalElements}"/>)</span>
</div>
<form action="list.do" method="get">
	<fieldset class="c_fieldset">
    <legend><s:message code="search"/></legend>
	  <label class="c_lab"><s:message code="user.username"/>: <input type="text" name="search_CONTAIN_user.username" value="${search_CONTAIN_user.username[0]}"/></label>
	  <label class="c_lab"><input type="submit" value="<s:message code="search"/>"/></label>
  </fieldset>
</form>
<form method="post">
<tags:search_params/>
<div class="ls_bc_opt">
	<div class="ls_btn"><input type="button" value="<s:message code="create"/>" onclick="location.href='create.do?${searchstring}';"/></div>
	<div class="ls_btn"></div>
	<div class="ls_btn"><input type="button" value="<s:message code="copy"/>" onclick="return optSingle('#copy_opt_');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="edit"/>" onclick="return optSingle('#edit_opt_');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="user.disable"/>" onclick="return optMulti(this.form,'disable.do');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="user.undisable"/>" onclick="return optMulti(this.form,'undisable.do');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="user.deletePassword"/>" onclick="return optDeletePassword(this.form);"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="delete"/>" onclick="return optDelete(this.form);"/></div>
	<div style="clear:both"></div>
</div>
<table id="pagedTable" border="0" cellpadding="0" cellspacing="0" class="ls_tb">
  <thead id="sortHead" pagesort="<c:out value='${page_sort[0]}' />" pagedir="${page_sort_dir[0]}" pageurl="list.do?page_sort={0}&page_sort_dir={1}&${searchstringnosort}">
  <tr class="ls_table_th">
    <th width="25"><input type="checkbox" onclick="Cms.check('ids',this.checked);"/></th>
    <th width="130"><s:message code="operate"/></th>
    <th width="30" class="ls_th_sort"><span class="ls_sort" pagesort="id">ID</span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="user.username"><s:message code="user.username"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="user.status"><s:message code="user.status"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="user.logins"><s:message code="user.logins"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="user.creationDate"><s:message code="user.creationDate"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="user.lastLoginDate"><s:message code="user.lastLoginDate"/></span></th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="bean" varStatus="status" items="${pagedList.content}">
  <tr ondblclick="location.href=$('#edit_opt_${bean.id}').attr('href');">
    <td><input type="checkbox" name="ids" value="${bean.id}"/></td>
    <td align="center">
      <a id="copy_opt_${bean.id}" href="create.do?id=${bean.id}&${searchstring}" class="ls_opt" style="display:none;"><s:message code="copy"/></a>
      <a id="edit_opt_${bean.id}" href="edit.do?id=${bean.id}&position=${pagedList.number*pagedList.size+status.index}&${searchstring}" class="ls_opt"><s:message code="edit"/></a>
      <a href="delete_password.do?ids=${bean.id}&${searchstring}" onclick="return confirmDeletePassword();" class="ls_opt"><s:message code="user.deletePassword"/></a>
      <a href="delete.do?ids=${bean.id}&${searchstring}" onclick="return confirmDelete();" class="ls_opt"><s:message code="delete"/></a>
     </td>
    <td>${bean.id}</td>
    <td>${bean.username}</td>
    <td><c:if test="${bean.status!=0}"><strong></c:if><s:message code="user.status.${bean.status}"/><c:if test="${bean.status!=0}"></strong></c:if></td>
    <td>${bean.logins}</td>
    <td>
    	<div><fmt:formatDate value="${bean.creationDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/></div>
    	<div>${bean.creationIp}</div>
    </td>
    <td>
    	<div><fmt:formatDate value="${bean.lastLoginDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/></div>
    	<div>${bean.lastLoginIp}</div>
    </td>
  </tr>
  </c:forEach>
  </tbody>
</table>
<c:if test="${fn:length(pagedList.content) le 0}"> 
<div class="ls_norecord"><s:message code="recordNotFound"/></div>
</c:if>
</form>
<form action="list.do" method="get" class="ls_page">
	<tags:search_params excludePage="true"/>
  <tags:pagination pagedList="${pagedList}"/>
</form>
</body>
</html>