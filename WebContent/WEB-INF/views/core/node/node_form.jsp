<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jspxcms.core.domain.*,java.util.*"%>
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
<style type="text/css">
* html{overflow-y: scroll;}
</style>
<script type="text/javascript">
$(function() {
	$("#validForm").validate();
	$("input[name='name']").focus();
	//setTimeout(function() {
	//	$("#color").colorPicker();
	//},0);
	
});
function uploadImg(name,button) {
	if($("#f_"+name).val()=="") {alert("<s:message code='pleaseSelectTheFile'/>");return;}
	Cms.uploadImg("../upload_image.do",name,button);
}
function imgCrop(name) {
	if($("#"+name).val()=="") {alert("<s:message code='noImageToCrop'/>");return;}
	Cms.imgCrop("../../commons/img_area_select.do",name);
}
function confirmDelete() {
	return confirm("<s:message code='confirmDelete'/>");
}
<c:if test="${!empty refreshLeft}">
parent.frames['left'].location.href="left.do";
</c:if>
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="node.management"/> - <s:message code="${oprt=='edit'?'edit':'create'}"/></span>
</div>
<form id="validForm" action="${oprt=='edit'?'update':'save'}.do" method="post">
<tags:search_params/>
<f:hidden name="cid" value="${oprt=='create'?cid:''}"/>
<f:hidden name="oid" value="${bean.id}"/>
<f:hidden name="queryParentId" value="${queryParentId}"/>
<f:hidden name="showDescendants" value="${showDescendants}"/>
<f:hidden name="position" value="${position}"/>
<input type="hidden" id="redirect" name="redirect" value="edit"/>
<table border="0" cellpadding="0" cellspacing="0" class="in_tb">
  <tr>
    <td colspan="4" class="in_opt">
			<div class="in_btn"><input type="button" value="<s:message code="create"/>" onclick="location.href='create.do?parentId=${parent.id}&queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';"<c:if test="${oprt=='create'||parent==null}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="node.createChild"/>" onclick="location.href='create.do?parentId=${bean.id}&queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="copy"/>" onclick="location.href='create.do?cid=${bean.id}&parentId=${parent.id}&queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';"<c:if test="${oprt=='create'||parent==null}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="delete"/>" onclick="if(confirmDelete()){location.href='delete.do?ids=${bean.id}&queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';}"<c:if test="${oprt=='create'||parent==null}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="node.deletePage"/>" onclick="location.href='delete_page.do?id=${bean.id}&queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="prev"/>" onclick="location.href='edit.do?id=${side.prev.id}&position=${position-1}&queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';"<c:if test="${empty side.prev}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="next"/>" onclick="location.href='edit.do?id=${side.next.id}&position=${position+1}&queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';"<c:if test="${empty side.next}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="return"/>" onclick="location.href='list.do?queryParentId=${queryParentId}&showDescendants=${showDescendants}&${searchstring}';"/></div>
      <div style="clear:both;"></div>
    </td>
  </tr>
  <%
  Model model = (Model) request.getAttribute("model");
  Set<String> names = model.getPredefinedNames();
  int colCount=0;
  %>
  <c:forEach var="field" items="${model.fields}">
  <%ModelField field = (ModelField) pageContext.getAttribute("field");%>
  <%if(colCount%2==0||!field.getDblColumn()){%><tr><%}%>  
  <td class="in_lab" width="15%"><c:if test="${field.required}"><em class="required">*</em></c:if><c:out value="${field.label}"/>:</td>
  <td<c:if test="${field.type!=50}"> class="in_ctt"</c:if><c:choose><c:when test="${field.dblColumn}"> width="35%"</c:when><c:otherwise> width="85%" colspan="3"</c:otherwise></c:choose>>
  <%if(field.isCustom()) {%>
  
  <%} else {%>
  <%String name=field.getName();%>
  <%if(name.equals("parent")) {%>
    <f:hidden id="parentId" name="parentId" value="${parent.id}"/>
    <f:hidden id="parentIdNumber" value="${parent.id}"/>
    <f:hidden id="parentIdName" value="${parent.fullName}"/>
    <f:text id="parentIdNameDisplay" value="${parent.fullName}" readonly="readonly" style="width:160px;"/><input id="parentIdButton" type="button" value="F7"/>
    <script type="text/javascript">
    $(function(){
    	Cms.f7.node("${ctx}","parentId",{
    		"title": "<s:message code='node.f7.selectNode'/>",
    		"params": {
    			"excludeChildrenId":"${oprt=='edit'?bean.id:''}"
    		}
    	});
    });
    </script>
  <%}else if(name.equals("name")) {%>
    <f:text name="name" value="${oprt=='edit'?bean.name:''}" class="required" style="width:180px;"/>
  <%}else if(name.equals("number")) {%>
    <f:text name="number" value="${bean.number}" style="width:180px;"/>
  <%}else if(name.equals("linkUrl")) {%>
    <f:text name="linkUrl" value="${bean.linkUrl}" style="width:180px;"/>
  <%}else if(name.equals("newWindow")) {%>
  	<select name="newWindow">
  		<option value=""><s:message code="defaultSelect"/></option>
      <f:option value="true" selected="${bean.newWindow}"><s:message code="yes"/></f:option>
      <f:option value="false" selected="${bean.newWindow}"><s:message code="no"/></f:option>
  	</select>
  <%}else if(name.equals("metaKeywords")) {%>
    <f:text name="metaKeywords" value="${bean.metaKeywords}" style="width:500px;"/>
  <%}else if(name.equals("metaDescription")) {%>
    <f:textarea name="metaDescription" value="${bean.metaDescription}" class="{maxlength:255}" style="width:500px;height:80px;"/>
  <%}else if(name.equals("nodeModel")) {%>
    <select name="nodeModelId" onchange="location.href='${oprt=='edit'?'edit':'create'}.do?id=${bean.id}&parentId=${parent.id}&modelId='+$(this).val()+'&${searchstring}';">
      <f:options items="${nodeModelList}" itemLabel="name" itemValue="id" selected="${model}" default="${bean.nodeModel.id}"/>
    </select>
  <%}else if(name.equals("infoModel")) {%>
    <select name="infoModelId">
      <option value=""></option>
      <f:options items="${infoModelList}" itemLabel="name" itemValue="id" selected="${oprt=='edit'?(bean.infoModel.id):(infoModelDef.id)}"/>
    </select>
  <%}else if(name.equals("nodeTemplate")) {%>
    <f:text name="nodeTemplate" value="${bean.nodeTemplate}" style="width:180px;"/>
  <%}else if(name.equals("infoTemplate")) {%>
    <f:text name="infoTemplate" value="${bean.infoTemplate}" style="width:180px;"/>
  <%}else if(name.equals("staticMethod")) {%>
    <select name="staticMethod">
      <option value=""><s:message code="defaultSelect"/></option>
      <f:option value="0" selected="${bean.staticMethod}"><s:message code="node.staticMethod.0"/></f:option>
      <f:option value="1" selected="${bean.staticMethod}"><s:message code="node.staticMethod.1"/></f:option>
      <f:option value="2" selected="${bean.staticMethod}"><s:message code="node.staticMethod.2"/></f:option>
      <f:option value="3" selected="${bean.staticMethod}"><s:message code="node.staticMethod.3"/></f:option>
    </select>
  <%}else if(name.equals("staticPage")) {%>
    <f:text name="staticPage" value="${bean.staticPage}" class="digits" style="width:180px;"/>
  <%}else if(name.equals("generateNode")) {%>
  	<select name="generateNode">
      <option value=""><s:message code="defaultSelect"/></option>
      <f:option value="true" selected="${bean.generateNode}"><s:message code="on"/></f:option>
      <f:option value="false" selected="${bean.generateNode}"><s:message code="off"/></f:option>
  	</select> &nbsp;
    <f:text name="nodePath" value="${bean.nodePath}" style="text-align:right;width:300px;"/>
    <select name="nodeExtension">
      <option value=""><s:message code="defaultSelect"/></option>
      <f:options items="${fn:split('.html,.htm,.shtml,.shtm',',')}" selected="${bean.nodeExtension}"/>
    </select> &nbsp;
    <select name="defPage">
      <option value="">---<s:message code="node.defPage"/>---</option>
      <f:option value="true" selected="${bean.defPage}"><s:message code="yes"/></f:option>
      <f:option value="false" selected="${bean.defPage}"><s:message code="no"/></f:option>
    </select>
  <%}else if(name.equals("generateInfo")) {%>  
  	<select name="generateInfo">
      <option value=""><s:message code="defaultSelect"/></option>
      <f:option value="true" selected="${bean.generateInfo}"><s:message code="on"/></f:option>
      <f:option value="false" selected="${bean.generateInfo}"><s:message code="off"/></f:option>
  	</select> &nbsp;
    <f:text name="infoPath" value="${bean.infoPath}" style="text-align:right;width:300px;"/>
    <select name="infoExtension">
      <option value=""><s:message code="defaultSelect"/></option>
      <f:options items="${fn:split('.html,.htm,.shtml,.shtm',',')}" selected="${bean.infoExtension}"/>
    </select>
  <%}else if(name.equals("smallImage")) {%>
      <tags:image_upload name="smallImage" value="${bean.smallImage}" width="<%=field.getCustoms().get(\"imageWidth\")%>" height="<%=field.getCustoms().get(\"imageHeight\")%>" watermark="<%=field.getCustoms().get(\"imageWatermark\")%>" scale="<%=field.getCustoms().get(\"imageScale\")%>"/>
  <%}else if(name.equals("largeImage")) {%>
      <tags:image_upload name="largeImage" value="${bean.largeImage}"/>
  <%}else if(name.equals("text")) {%>
    <f:textarea id="clobs_text" name="clobs_text" value="${bean.text}"/>
    <script type="text/javascript">
      CKEDITOR.replace("clobs_text",{
        toolbar:'Cms',
        filebrowserUploadUrl : '../upload.do?type=Files',
        filebrowserImageUploadUrl : '../upload.do?type=Images',
        filebrowserFlashUploadUrl : '../upload.do?type=Flash'
      });
    </script>
  <%}else {%>
    System field not found: '<%=name%>'
  <%}%>
  <%}%>
  </td><%if(colCount%2==1||!field.getDblColumn()){%></tr><%}%>
  <%if(field.getDblColumn()){colCount++;}%>
  </c:forEach>
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