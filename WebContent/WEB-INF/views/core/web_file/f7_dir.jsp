<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fnx" uri="http://java.sun.com/jsp/jstl/functionsx"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<style type="text/css">
.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
.ztree li ul.level0 {padding:0; background:none;}
</style>
<script type="text/javascript">
function __f7DirList(url) {
	url += "&d="+new Date()*1;
	$("#__f7Dir").load(url,function(){
		$("#__pagedTable").tableHighlight();		
	});
}
$(function(){
	$("#__pagedTable").tableHighlight();
});
</script>
<div id="__f7Dir">
<div>${parentId}</div>
<table id="__pagedTable" border="0" cellpadding="0" cellspacing="0" class="ls_tb">
  <thead>
  <tr class="ls_table_th">
    <th width="30">#</th>
    <th><s:message code="webFile.directory"/></th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="bean" varStatus="status" items="${list}">
  <c:url value="/cmscp/core/web_file/f7_dir_list.do" var="url">
		<c:param name="parentId" value="${bean.id}"/>
	</c:url>
	<c:forEach var="id" items="${ids}">
		<c:set var="url">${url}&ids=${fnx:urlEncode(id)}</c:set>
	</c:forEach>
  <tr>
  	<td align="center"><input type="radio" name="moveTodir" value="${bean.id}"<c:if test="${bean.parent}"> disabled="disabled"</c:if>/></td>
    <td onclick="javascript:__f7DirList('${url}');" style="cursor:pointer;"><c:out value="${bean.name}"/></td>
  </tr>
  </c:forEach>
  </tbody>
</table>
</div>