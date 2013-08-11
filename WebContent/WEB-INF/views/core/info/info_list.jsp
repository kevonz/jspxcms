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
  <span class="c_position"><s:message code="info.management"/> - <s:message code="list"/></span>
	<span class="c_total">(<s:message code="totalElements" arguments="${pagedList.totalElements}"/>)</span>
</div>
<form action="list.do" method="get">
	<fieldset class="c_fieldset">
    <legend><s:message code="search"/></legend>
	  <label class="c_lab"><s:message code="info.title"/>: <input type="text" name="search_CONTAIN_detail.title" value="${requestScope['search_CONTAIN_detail.title'][0]}" style="width:150px;"/></label>
	  <label class="c_lab"><s:message code="info.tagKeywords"/>: <input type="text" name="search_CONTAIN_Jtags.name" value="${requestScope['search_CONTAIN_Jtags.name'][0]}" style="width:100px;"/></label>
	  <label class="c_lab"><s:message code="startTime"/>: <f:text name="search_GTE_publishDate_Date" value="${search_GTE_publishDate_Date[0]}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" style="width:80px;"/></label>
	  <label class="c_lab"><s:message code="endTime"/>: <f:text name="search_LTE_publishDate_Date" value="${search_LTE_publishDate_Date[0]}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" style="width:80px;"/></label>
	  <label class="c_lab">
	  	<select name="search_EQ_priority">
	  		<option value="">--<s:message code="info.priority"/>--</option>
	  		<c:forEach var="i" begin="0" end="9">
	  		<c:set var="istr">${i}</c:set>
	  		<option<c:if test="${istr eq search_EQ_priority[0]}"> selected="selected"</c:if>>${i}</option>
	  		</c:forEach>
  		</select>
	  </label>
	  <label class="c_lab">
	  	<select name="search_EQ_JinfoAttrs.Jattribute.id">
	  		<option value="">--<s:message code="info.attributes"/>--</option>
	  		<c:forEach var="attr" items="${attributeList}">
	  		<c:set var="idstr">${attr.id}</c:set>
	  		<option value="${attr.id}"<c:if test="${idstr eq requestScope['search_EQ_JinfoAttrs.Jattribute.id'][0]}"> selected="selected"</c:if>>${attr.name}</option>
	  		</c:forEach>
  		</select>
	  </label>
	  <label class="c_lab"><input type="submit" value="<s:message code="search"/>"/></label>
		<f:hidden name="queryNodeId" value="${queryNodeId}"/>
		<f:hidden name="queryNodeType" value="${queryNodeType}"/>
  </fieldset>
</form>
<form method="post">
<tags:search_params/>
<f:hidden name="queryNodeId" value="${queryNodeId}"/>
<f:hidden name="queryNodeType" value="${queryNodeType}"/>
<div class="ls_bc_opt">
	<div class="ls_btn"><input type="button" value="<s:message code="create"/>" onclick="location.href='create.do?queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstring}';"/></div>
	<div class="ls_btn"></div>
	<div class="ls_btn"><input type="button" value="<s:message code="copy"/>" onclick="return optSingle('#copy_opt_');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="edit"/>" onclick="return optSingle('#edit_opt_');"/></div>
	<div class="ls_btn"><input type="button" value="<s:message code="delete"/>" onclick="return optDelete(this.form);"/></div>
	<div style="clear:both"></div>
</div>
<table id="pagedTable" border="0" cellpadding="0" cellspacing="0" class="ls_tb">
  <thead id="sortHead" pagesort="<c:out value='${page_sort[0]}' />" pagedir="${page_sort_dir[0]}" pageurl="list.do?page_sort={0}&page_sort_dir={1}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstringnosort}">
  <tr class="ls_table_th">
    <th width="25"><input type="checkbox" onclick="Cms.check('ids',this.checked);"/></th>
    <th width="110"><s:message code="operate"/></th>
    <th width="30" class="ls_th_sort"><span class="ls_sort" pagesort="id">ID</span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="detail.title"><s:message code="info.title"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="publishDate"><s:message code="info.publishDate"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="priority"><s:message code="info.priority"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="views"><s:message code="info.views"/></span></th>
    <th class="ls_th_sort"><span class="ls_sort" pagesort="status"><s:message code="info.status"/></span></th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="bean" varStatus="status" items="${pagedList.content}">
  <tr ondblclick="location.href=$('#edit_opt_${bean.id}').attr('href');">
    <td><input type="checkbox" name="ids" value="${bean.id}"/></td>
    <td align="center">
      <a id="copy_opt_${bean.id}" href="create.do?id=${bean.id}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstring}" class="ls_opt"><s:message code="copy"/></a>
      <a id="edit_opt_${bean.id}" href="edit.do?id=${bean.id}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&position=${pagedList.number*pagedList.size+status.index}&${searchstring}" class="ls_opt"><s:message code="edit"/></a>
      <a href="delete.do?ids=${bean.id}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstring}" onclick="return confirmDelete();" class="ls_opt"><s:message code="delete"/></a>
     </td>
    <td><c:out value="${bean.id}"/></td>
    <td>
    	<div><a href="${bean.url}" target="_blank" title="<c:out value='${bean.title}'/>"><c:out value="${fnx:substringx_sis(bean.title,30,'...')}"/></a></div>
    	<div>[<span style="color:blue;"><c:out value="${bean.node.fullName}"/></span>]
    		<c:if test="${fn:length(bean.infoAttrs) gt 0}">&nbsp;[<span style="color:red;"><c:forEach var="ia" items="${bean.infoAttrs}" varStatus="status">${ia.attribute.name}<c:if test="${!status.last}"> </c:if></c:forEach></span>]</c:if>
    	</div>
    </td>
    <td>
    	<div><fmt:formatDate value="${bean.publishDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
    	<div><span style="color:blue;"><c:out value="${bean.creator.username}"/></span></div>
    </td>
    <td align="right"><c:out value="${bean.priority}"/></td>
    <td align="right"><c:out value="${bean.views}"/></td>
    <td align="center"><s:message code="info.status.${bean.status}"/></td>
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
	<f:hidden name="queryNodeId" value="${queryNodeId}"/>
	<f:hidden name="queryNodeType" value="${queryNodeType}"/>
  <tags:pagination pagedList="${pagedList}"/>
</form>
</body>
</html>