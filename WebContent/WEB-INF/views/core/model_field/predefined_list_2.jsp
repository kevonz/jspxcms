<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jspxcms.core.domain.*,java.util.*" %>
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
<style type="text/css">
</style>
<script type="text/javascript">
$(function() {
	$("input[name=control][checked!=checked]").each(function(){
		$(this).parent().parent().find("input,select").not(this).attr("disabled","disabled").addClass("disabled");
	});
	$("#pagedTable").tableHighlight();
	$("#fieldForm").validate();
	$("input[name='control']").change(function(){
		if(this.checked) {
			$(this).parent().parent().find("input,select").not(this).removeAttr("disabled").removeClass("disabled");
		} else {
			$(this).parent().parent().find("input,select").not(this).attr("disabled","disabled").addClass("disabled");
		}
	});
});
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <div class="c_position"><s:message code="model.management"/> - <s:message code="model.type.${model.type}"/> - <s:message code="modelField.addPredefinedField"/></div>
</div>
<form id="fieldForm" action="batch_save.do" method="post">
<f:hidden name="modelId" value="${model.id}"/>
<tags:search_params/>
<div class="ls_bc_opt">
	<div class="ls_btn"><input type="submit" value="<s:message code="save"/>"/></div>
	<div class="ls_btn"></div>
	<div class="in_btn"><input type="button" value="<s:message code="return"/>" onclick="location.href='list.do?modelId=${model.id}&${searchstring}';"/></div>
	<div style="clear:both"></div>
</div>
<table id="pagedTable" border="0" border="0" cellpadding="0" cellspacing="0" class="ls_tb">
  <thead>
  <tr class="ls_table_th">
    <th width="25"><input type="checkbox" onclick="Cms.check('ids',this.checked);"/></th>
    <th><s:message code="modelField.name"/></th>
    <th><s:message code="modelField.label"/></th>
    <th><s:message code="modelField.dblColumn"/></th>
  </tr>
  </thead>
  <tbody>
  <%Model model = (Model) request.getAttribute("model"); Set<String> names = model.getPredefinedNames();%>
  <%if(!names.contains("parent")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">parent
      <input type="hidden" name="name" value="parent"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.parent'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("name")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">name
      <input type="hidden" name="name" value="name"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.name'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("number")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">number
      <input type="hidden" name="name" value="number"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.number'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("linkUrl")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">linkUrl
      <input type="hidden" name="name" value="linkUrl"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.linkUrl'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("newWindow")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">newWindow
      <input type="hidden" name="name" value="newWindow"/>
      <input type='hidden' name='property' value='{"type":5,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.newWindow'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("metaKeywords")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">metaKeywords
      <input type="hidden" name="name" value="metaKeywords"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.metaKeywords'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("metaDescription")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">metaDescription
      <input type="hidden" name="name" value="metaDescription"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.metaDescription'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("nodeModel")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">nodeModel
      <input type="hidden" name="name" value="nodeModel"/>
      <input type='hidden' name='property' value='{"type":5,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.nodeModel'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("infoModel")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">infoModel
      <input type="hidden" name="name" value="infoModel"/>
      <input type='hidden' name='property' value='{"type":5,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.infoModel'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("nodeTemplate")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">nodeTemplate
      <input type="hidden" name="name" value="nodeTemplate"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.nodeTemplate'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("infoTemplate")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">infoTemplate
      <input type="hidden" name="name" value="infoTemplate"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.infoTemplate'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("generateNode")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">generateNode
      <input type="hidden" name="name" value="generateNode"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.generateNode'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("generateInfo")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">generateInfo
      <input type="hidden" name="name" value="generateInfo"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.generateInfo'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("staticMethod")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">staticMethod
      <input type="hidden" name="name" value="staticMethod"/>
      <input type='hidden' name='property' value='{"type":5,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.staticMethod'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("staticPage")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">staticPage
      <input type="hidden" name="name" value="staticPage"/>
      <input type='hidden' name='property' value='{"type":1,"innerType":2,"defValue":1,"required":false}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.staticPage'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="true"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("smallImage")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">smallImage
      <input type="hidden" name="name" value="smallImage"/>
      <input type='hidden' name='property' value='{"type":7,"innerType":2,"required":false}'/>
      <input type='hidden' name='custom' value='{"imageWidth":"140","imageHeight":"93"}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.smallImage'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("largeImage")) {%>
  <tr>
    <td><input type="checkbox" name="control" checked="checked"/></td>
    <td align="center">largeImage
      <input type="hidden" name="name" value="largeImage"/>
      <input type='hidden' name='property' value='{"type":7,"innerType":2,"required":false}'/>
      <input type='hidden' name='custom' value='{"imageWidth":"290","imageHeight":"200"}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.largeImage'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  <%if(!names.contains("text")) {%>
  <tr>
    <td><input type="checkbox" name="control"/></td>
    <td align="center">text
      <input type="hidden" name="name" value="text"/>
      <input type='hidden' name='property' value='{"type":50,"innerType":2}'/>
      <input type='hidden' name='custom' value='{}'/>
    </td>
    <td align="center"><input type="text" name="label" value="<s:message code='node.text'/>"/></td>
    <td align="center"><f:checkbox name="dblColumn" value="false"/></td>
  </tr>
  <%}%>
  </tbody>
</table>
</form>
</body>
</html>
