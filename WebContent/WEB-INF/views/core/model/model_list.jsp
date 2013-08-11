<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
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
	$("#pagedTable tbody tr").dblclick(function(eventObj) {
		var nodeName = eventObj.target.nodeName.toLowerCase();
		if(nodeName!="input"&&nodeName!="select"&&nodeName!="textarea") {
			location.href=$("#edit_opt_"+$(this).attr("beanid")).attr('href');
		}
	});
});
function confirmDelete() {
	return confirm("<s:message code='confirmDelete'/>");
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
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="model.management"/> - <s:message code="list"/></span>
	<span class="c_total">(<s:message code="totalElements" arguments="${fn:length(list)}"/>)</span>
</div>
<form action="list.do" method="get">
	<fieldset class="c_fieldset">
    <legend><s:message code="search"/></legend>
	  <label class="c_lab">
	  	<s:message code="model.type"/>:
	  	<select name="search_EQ_type">
	  		<option value=""><s:message code="allSelect"/></option>
	  		<f:option value="1" selected="${search_EQ_type[0]}"><s:message code="model.type.1"/></f:option>
	  		<f:option value="2" selected="${search_EQ_type[0]}"><s:message code="model.type.2"/></f:option>
	  		<f:option value="3" selected="${search_EQ_type[0]}"><s:message code="model.type.3"/></f:option>
	  		<f:option value="4" selected="${search_EQ_type[0]}"><s:message code="model.type.4"/></f:option>
	  	</select>
	  </label>
	  <label class="c_lab"><s:message code="model.name"/>: <input type="text" name="search_CONTAIN_name" value="${search_CONTAIN_name[0]}"/></label>
	  <label class="c_lab"><input type="submit" value="<s:message code="search"/>"/></label>
  </fieldset>
</form>
<form action="batch_update.do" method="post">
<tags:search_params/>
<div class="ls_bc_opt">
	<div class="ls_btn"><input type="button" value="<s:message code="create"/>" onclick="location.href='create.do?${searchstring}';"/></div>
	<div class="ls_btn"></div>
	<div class="ls_btn"><input type="submit" value="<s:message code="save"/>"/></div>
	<div class="ls_btn"></div>
	<div class="ls_btn"><input type="button" value="<s:message code="model.fieldList"/>" onclick="return optSingle('#fields_opt_');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="copy"/>" onclick="return optSingle('#copy_opt_');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="edit"/>" onclick="return optSingle('#edit_opt_');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="delete"/>" onclick="return optDelete(this.form);"/></div>
	<div class="ls_btn"></div>
  <div class="ls_btn"><input type="button" value="<s:message code='moveTop'/>" onclick="Cms.moveTop('ids');"/></div>
  <div class="ls_btn"><input type="button" value="<s:message code='moveUp'/>" onclick="Cms.moveUp('ids');"/></div>
  <div class="ls_btn"><input type="button" value="<s:message code='moveDown'/>" onclick="Cms.moveDown('ids');"/></div>
  <div class="ls_btn"><input type="button" value="<s:message code='moveBottom'/>" onclick="Cms.moveBottom('ids');"/></div>
	<div style="clear:both"></div>
</div>
<table id="pagedTable" border="0" cellpadding="0" cellspacing="0" class="ls_tb">
  <thead id="sortHead" pagesort="<c:out value='${page_sort[0]}' />" pagedir="${page_sort_dir[0]}" pageurl="list.do?page_sort={0}&page_sort_dir={1}&${searchstringnosort}">
  <tr class="ls_table_th">
    <th width="25"><input type="checkbox" onclick="Cms.check('ids',this.checked);"/></th>
    <th width="170"><s:message code="operate"/></th>
    <th width="30" class="ls_th_sort"><span class="ls_sort" pagesort="id">ID</span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="type"><s:message code="model.type"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="name"><s:message code="model.name"/></span></th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="bean" varStatus="status" items="${list}">
  <tr beanid="${bean.id}">
    <td><input type="checkbox" name="ids" value="${bean.id}"/></td>
    <td align="center">
      <a id="fields_opt_${bean.id}" href="../model_field/list.do?modelId=${bean.id}&${searchstring}" class="ls_opt"><s:message code="model.fieldList"/></a>
      <a id="copy_opt_${bean.id}" href="create.do?id=${bean.id}&${searchstring}" class="ls_opt"><s:message code="copy"/></a>
      <a id="edit_opt_${bean.id}" href="edit.do?id=${bean.id}&position=${pagedList.number*pagedList.size+status.index}&${searchstring}" class="ls_opt"><s:message code="edit"/></a>
      <a href="delete.do?ids=${bean.id}&${searchstring}" onclick="return confirmDelete();" class="ls_opt"><s:message code="delete"/></a>
     </td>
    <td><c:out value="${bean.id}"/><f:hidden name="id" value="${bean.id}"/></td>
    <td align="center"><s:message code="model.type.${bean.type}"/></td>
    <td align="center"><f:text name="name" value="${bean.name}" style="width:150px;"/></td>
  </tr>
  </c:forEach>
  </tbody>
</table>
<c:if test="${fn:length(list) le 0}"> 
<div class="ls_norecord"><s:message code="recordNotFound"/></div>
</c:if>
</form>
</body>
</html>