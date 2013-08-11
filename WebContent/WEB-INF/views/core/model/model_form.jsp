<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
var count = 3;
$(function() {
	$("#validForm").validate();
	$("#model_type").change(function() {
		typeChange(this.selectedIndex);
	});
	typeChange(${bean.type});
});
function typeChange(index) {
	for(var i=1;i<=count;i++) {
		$(".type_custom_"+i).hide();
		$(".type_custom_"+i+" input").prop("disabled",true);
	}
	$(".type_custom_"+index).show();
	$(".type_custom_"+index+" input").removeProp("disabled");
}
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="model.management"/> - <s:message code="${oprt=='edit'?'edit':'create'}"/></span>
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
			<div class="in_btn"><input type="button" value="<s:message code="model.fieldList"/>" onclick="location.href='../model_field/list.do?modelId=${bean.id}&${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
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
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="model.name"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="name" value="${oprt=='edit'?bean.name:''}" class="required" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="model.type"/>:</td>
    <td class="in_ctt" width="35%">
      <select id="model_type" name="type" class="required">
        <option value=""><s:message code="pleaseSelect"/></option>
        <f:option value="1" selected="${bean.type}"><s:message code="model.type.1"/></f:option>
        <f:option value="2" selected="${bean.type}"><s:message code="model.type.2"/></f:option>
        <f:option value="3" selected="${bean.type}"><s:message code="model.type.3"/></f:option>
      </select>
    </td>
  </tr>
  <tr class="type_custom_1 type_custom_3"<c:if test="${bean.type != 1&&bean.type != 3}"> style="display:none;"</c:if>>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="model.template"/>:</td>
    <td class="in_ctt" colspan="3"><f:text name="customs_template" value="${bean.customs['template']}" class="required" maxlength="255" style="width:180px;"/></td>
  </tr>
  <tr class="type_custom_2"<c:if test="${bean.type != 2}"> style="display:none;"</c:if>>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="model.coverTemplate"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="customs_coverTemplate" value="${bean.customs['coverTemplate']}" class="required" maxlength="255" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="model.listTemplate"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="customs_listTemplate" value="${bean.customs['listTemplate']}" maxlength="255" style="width:180px;"/></td>
  </tr>
  <tr class="type_custom_1 type_custom_2"<c:if test="${bean.type != 1&&bean.type != 2}"> style="display:none;"</c:if>>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="node.generateNode"/>:</td>
    <td class="in_ctt" colspan="3">
	  	<select name="customs_generateNode">
	      <f:option value="true" selected="${bean.generateNode}"><s:message code="on"/></f:option>
	      <f:option value="false" selected="${bean.generateNode}" default="false"><s:message code="off"/></f:option>
	  	</select> &nbsp;
	    <f:text name="customs_nodePath" value="${bean.nodePath}" style="text-align:right;width:300px;"/>
	    <select name="customs_nodeExtension">
	      <f:options items="${fn:split('.html,.htm,.shtml,.shtm',',')}" selected="${bean.nodeExtension}"/>
	      <option value=""></option>
	    </select> &nbsp;
	    <label><f:checkbox name="customs_defPage" value="${bean.defPage}" default="true"/><s:message code="node.defPage"/></label>
    </td>
  </tr>
  <tr class="type_custom_1 type_custom_2"<c:if test="${bean.type != 1&&bean.type != 2}"> style="display:none;"</c:if>>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="node.generateInfo"/>:</td>
    <td class="in_ctt" colspan="3">
	  	<select name="customs_generateInfo">
	      <f:option value="true" selected="${bean.generateInfo}"><s:message code="on"/></f:option>
	      <f:option value="false" selected="${bean.generateInfo}" default="false"><s:message code="off"/></f:option>
	  	</select> &nbsp;
	    <f:text name="customs_infoPath" value="${bean.infoPath}" style="text-align:right;width:300px;"/>
	    <select name="customs_infoExtension">
	      <f:options items="${fn:split('.html,.htm,.shtml,.shtm',',')}" selected="${bean.infoExtension}"/>
	      <option value=""></option>
	    </select>
    </td>
  </tr>
  <tr class="type_custom_1 type_custom_2"<c:if test="${bean.type != 1&&bean.type != 2}"> style="display:none;"</c:if>>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="node.staticMethod"/>:</td>
    <td class="in_ctt" width="35%">
    <select name="customs_staticMethod" class="required">
      <f:option value="0" selected="${bean.staticMethod}"><s:message code="node.staticMethod.0"/></f:option>
      <f:option value="1" selected="${bean.staticMethod}"><s:message code="node.staticMethod.1"/></f:option>
      <f:option value="2" selected="${bean.staticMethod}"><s:message code="node.staticMethod.2"/></f:option>
      <f:option value="3" selected="${bean.staticMethod}" default="3"><s:message code="node.staticMethod.3"/></f:option>
    </select>
    </td>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="node.staticPage"/>:</td>
    <td class="in_ctt" width="35%">
    	<f:text name="customs_staticPage" value="${bean.staticPage}" default="1" class="required digits" style="width:180px;"/>
    </td>
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