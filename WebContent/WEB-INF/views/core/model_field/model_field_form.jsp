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
	$("#input_type").change(function() {
		var index = $(this).val();
		if(index=="") {
			$("#input_type_body tr").hide();
			$("#input_type_body input,#input_type_body select,#input_type_body textarea").attr("disabled","disabled");
		} else {
			$("#input_type_body tr").hide();
			$("#input_type_body input,#input_type_body select,#input_type_body textarea").attr("disabled","disabled");
			$(".input_type_"+index).show();
			$(".input_type_"+index+" input,.input_type_"+index+" select,.input_type_"+index+" textarea").removeAttr("disabled");
		}
	});
});
function confirmDelete() {
	return confirm("<s:message code='confirmDelete'/>");
}
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="model.management"/> - <s:message code="model.type.${model.type}"/> - <s:message code="modelField.${oprt=='edit'?'editField':'addField'}"/></span>
</div>
<form id="validForm" action="${oprt=='edit'?'update':'save'}.do" method="post">
<tags:search_params/>
<f:hidden name="modelId" value="${model.id }"/>
<f:hidden name="oid" value="${bean.id}"/>
<f:hidden name="position" value="${position}"/>
<input type="hidden" id="redirect" name="redirect" value="edit"/>
<table border="0" cellpadding="0" cellspacing="0" class="in_tb">
  <tr>
    <td colspan="4" class="in_opt">
			<div class="in_btn"><input type="button" value="<s:message code="create"/>" onclick="location.href='create.do?modelId=${model.id}&${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="delete"/>" onclick="if(confirmDelete()){location.href='delete.do?ids=${bean.id}&modelId=${model.id}&${searchstring}';}"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="prev"/>" onclick="location.href='edit.do?id=${side.prev.id}&position=${position-1}&${searchstring}';"<c:if test="${empty side.prev}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="next"/>" onclick="location.href='edit.do?id=${side.next.id}&position=${position+1}&${searchstring}';"<c:if test="${empty side.next}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="return"/>" onclick="location.href='list.do?modelId=${model.id}&${searchstring}';"/></div>
      <div style="clear:both;"></div>
    </td>
  </tr>
  <td class="in_lab" width="15%"><em class="required">*</em><s:message code="modelField.type"/>:</td>
    <td class="in_ctt" colspan="3">
      <c:choose>
      <c:when test="${oprt=='create'||bean.custom}">
      <select id="input_type" name="type" class="required">
        <option value=""><s:message code="pleaseSelect"/></option>
        <option value="1"<c:if test="${bean.type==1}"> selected="selected"</c:if>><s:message code="modelField.type.1"/></option>
        <option value="2"<c:if test="${bean.type==2}"> selected="selected"</c:if>><s:message code="modelField.type.2"/></option>
        <option value="3"<c:if test="${bean.type==3}"> selected="selected"</c:if>><s:message code="modelField.type.3"/></option>
        <option value="4"<c:if test="${bean.type==4}"> selected="selected"</c:if>><s:message code="modelField.type.4"/></option>
        <option value="5"<c:if test="${bean.type==5}"> selected="selected"</c:if>><s:message code="modelField.type.5"/></option>
        <option value="6"<c:if test="${bean.type==6}"> selected="selected"</c:if>><s:message code="modelField.type.6"/></option>
        <option value="6"<c:if test="${bean.type==50}"> selected="selected"</c:if>><s:message code="modelField.type.50"/></option>
        <option value="7"<c:if test="${bean.type==7}"> selected="selected"</c:if>><s:message code="modelField.type.7"/></option>
        <option value="8"<c:if test="${bean.type==8}"> selected="selected"</c:if>><s:message code="modelField.type.8"/></option>
        <option value="9"<c:if test="${bean.type==9}"> selected="selected"</c:if>><s:message code="modelField.type.9"/></option>
      </select> &nbsp;
      <label><f:checkbox name="clob" value="${bean.clob}"/><s:message code="modelField.clob"/></label>
      </c:when>
      <c:when test="${bean.innerType==3}">
      <select id="input_type" name="type" class="required">
        <option value=""><s:message code="pleaseSelect"/></option>
        <option value="100"<c:if test="${bean.type==100}"> selected="selected"</c:if>><s:message code="modelField.type.100"/></option>
        <option value="101"<c:if test="${bean.type==101}"> selected="selected"</c:if>><s:message code="modelField.type.101"/></option>
        <option value="102"<c:if test="${bean.type==102}"> selected="selected"</c:if>><s:message code="modelField.type.102"/></option>
      </select>
      </c:when>
      <c:otherwise><s:message code="modelField.type.${bean.type}"/></c:otherwise>
      </c:choose>
    </td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="modelField.name"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="name" value="<c:out value='${bean.name}'/>" class="required${bean.predefined?' readonly':''}"<c:if test="${bean.predefined}"> readonly="readonly"</c:if> maxlength="50" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="modelField.label"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="label" value="<c:out value='${bean.label}'/>" class="required" maxlength="50" style="width:180px;"/></td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="modelField.required"/>:</td>
    <td class="in_ctt" width="35%">
      <label><input type="radio" name="required" value="true"<c:if test="${bean.required}"> checked="checked"</c:if>/><s:message code="yes"/></label> &nbsp;
      <label><input type="radio" name="required" value="false"<c:if test="${empty bean.required || !bean.required}"> checked="checked"</c:if>/><s:message code="no"/></label>
    </td>  
    <td class="in_lab" width="15%"><em class="required">*</em><s:message code="modelField.dblColumn"/>:</td>
    <td class="in_ctt" width="35%">
      <label><input type="radio" name="dblColumn" value="true"<c:if test="${bean.dblColumn}"> checked="checked"</c:if>/><s:message code="yes"/></label> &nbsp;
      <label><input type="radio" name="dblColumn" value="false"<c:if test="${empty bean.dblColumn || !bean.dblColumn}"> checked="checked"</c:if>/><s:message code="no"/></label>
    </td>
  </tr>
  <tr>
    <td class="in_lab" width="15%"><s:message code="modelField.defValue"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="defValue" value="<c:out value='${bean.defValue}'/>" maxlength="255" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="modelField.prompt"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="prompt" value="<c:out value='${bean.prompt}'/>" maxlength="255" style="width:180px;"/></td>
  </tr>
  <tbody id="input_type_body">
  <tr class="input_type_1" style="<c:if test='${bean.type!=1}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.inputWidth"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_width" value="<c:out value='${bean.customs["width"]}'/>" class="digits" maxlength="5" style="width:180px;text-align:right;"/>px</td>
    <td class="in_lab" width="15%"><s:message code="modelField.maxlength"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_maxlength" value="<c:out value='${bean.customs["maxlength"]}'/>" class="digits" maxlength="10" style="width:180px;"/></td>
  </tr>
  <tr class="input_type_1" style="<c:if test='${bean.type!=1}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.validation"/>:</td>
    <td class="in_ctt" colspan="3"><input type="text" name="customs_validation" value="<c:out value='${bean.customs["validation"]}'/>" maxlength="255" style="width:450px;"/><span class="in_prompt" title="<s:message code='modelField.validation.prompt' htmlEscape='true'/>"></span></td>
  </tr>
  <tr class="input_type_2" style="<c:if test='${bean.type!=2}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.inputWidth"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_width" value="<c:out value='${bean.customs["width"]}'/>" class="digits" maxlength="5" style="width:180px;text-align:right;"/>px</td>
    <td class="in_lab" width="15%"><s:message code="modelField.datePattern"/>:</td>
    <td class="in_ctt" width="35%">
      <select name="customs_datePattern">
        <option value=""><s:message code="defaultSelect"/></option>
        <option<c:if test="${bean.customs['datePattern'] eq 'yyyy-MM-ddTHH:mm:ss'}"> selected="selected"</c:if>>yyyy-MM-ddTHH:mm:ss</option>
        <option<c:if test="${bean.customs['datePattern'] eq 'yyyy-MM-dd'}"> selected="selected"</c:if>>yyyy-MM-dd</option>
      </select>
    </td>
  </tr>  
  <tr class="input_type_5" style="<c:if test='${bean.type!=5}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.selectWidth"/>:</td>
    <td class="in_ctt" colspan="3"><input type="text" name="customs_width" value="<c:out value='${bean.customs["width"]}'/>" class="digits" maxlength="5" style="width:180px;text-align:right;"/>px</td>
  </tr>
  <tr class="input_type_3 input_type_4 input_type_5" style="<c:if test='${bean.type!=3&&bean.type!=4&&bean.type!=5}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.options"/>:</td>
    <td class="in_ctt" colspan="3"><textarea name="customs_options" class="{maxlength:2000}" style="width:500px;height:100px;"><c:out value='${bean.customs["options"]}'/></textarea></td>
  </tr>
  <tr class="input_type_6" style="<c:if test='${bean.type!=6}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.rows"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_rows" value="<c:out value='${bean.customs["rows"]}'/>" class="digits" maxlength="5" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="modelField.cols"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_cols" value="<c:out value='${bean.customs["cols"]}'/>" class="digits" maxlength="5" style="width:180px;"/></td>
  </tr>
  <tr class="input_type_6" style="<c:if test='${bean.type!=6}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.maxlength"/>:</td>
    <td class="in_ctt" colspan="3"><input type="text" name="customs_maxlength" value="<c:out value='${bean.customs["maxlength"]}'/>" class="digits" maxlength="5" style="width:180px;"/></td>
  </tr>
  <tr class="input_type_7" style="<c:if test='${bean.type!=7}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.imageWidth"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="customs_imageWidth" value="${bean.customs['imageWidth']}" class="digits" maxlength="5" style="width:180px;text-align:right;"/>px</td>
    <td class="in_lab" width="15%"><s:message code="modelField.imageHeight"/>:</td>
    <td class="in_ctt" width="35%"><f:text name="customs_imageHeight" value="${bean.customs['imageHeight']}" class="digits" maxlength="5" style="width:180px;text-align:right;"/>px</td>
  </tr>
  <tr class="input_type_7" style="<c:if test='${bean.type!=7}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.imageScale"/>:</td>
    <td class="in_ctt" width="35%">
      <label><f:radio name="customs_imageScale" value="true" checked="${bean.customs['imageScale']}"/><s:message code="yes"/></label>
      <label><f:radio name="customs_imageScale" value="false" checked="${bean.customs['imageScale']}" default="false"/><s:message code="no"/></label>
    </td>
    <td class="in_lab" width="15%"><s:message code="modelField.imageWatermark"/>:</td>
    <td class="in_ctt" width="35%">
      <label><f:radio name="customs_imageWatermark" value="true" checked="${bean.customs['imageWatermark']}"/><s:message code="yes"/></label>
      <label><f:radio name="customs_imageWatermark" value="false" checked="${bean.customs['imageWatermark']}" default="false"/><s:message code="no"/></label>
    </td>
  </tr>
  <tr class="input_type_50" style="<c:if test='${bean.type!=50}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.maxlength"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_maxlength" value="<c:out value='${bean.customs["maxlength"]}'/>" class="digits" maxlength="10" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="modelField.editorToolbar"/>:</td>
    <td class="in_ctt" width="35%">
      <select name="customs_toolbar">
        <option value=""><s:message code="defaultSelect"/></option>
        <option value="Text"<c:if test="${bean.customs['toolbar'] eq 'Text'}"> selected="selected"</c:if>><s:message code="modelField.editorToolbar.Text"/></option>
        <option value="Basic"<c:if test="${bean.customs['toolbar'] eq 'Basic'}"> selected="selected"</c:if>><s:message code="modelField.editorToolbar.Basic"/></option>
      </select>
    </td>
  </tr>
  <tr class="input_type_50" style="<c:if test='${bean.type!=50}'>display:none;</c:if>">
    <td class="in_lab" width="15%"><s:message code="modelField.editorWidth"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_width" value="<c:out value='${bean.customs["width"]}'/>" class="digits" maxlength="5" style="width:180px;"/></td>
    <td class="in_lab" width="15%"><s:message code="modelField.editorHeight"/>:</td>
    <td class="in_ctt" width="35%"><input type="text" name="customs_height" value="<c:out value='${bean.customs["height"]}'/>" class="digits" maxlength="5" style="width:180px;"/></td>
  </tr>
  </tbody>
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