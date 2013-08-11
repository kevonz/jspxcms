<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jspxcms.core.domain.*"%>
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
	$("input[name='title']").focus();
});
function uploadFile(name,button) {
	if($("#f_"+name).val()=="") {alert("<s:message code='pleaseSelectTheFile'/>");return;}
	Cms.uploadFile("../upload_file.do",name,button);
}
function uploadVideo(name,button) {
	if($("#f_"+name).val()=="") {alert("<s:message code='pleaseSelectTheFile'/>");return;}
	Cms.uploadFile("../upload_video.do",name,button);
}
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
</script>
</head>
<body class="c_body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="c_bar">
  <span class="c_position"><s:message code="info.management"/> - <s:message code="${oprt=='edit'?'edit':'create'}"/></span>
</div>
<form id="validForm" action="${oprt=='edit'?'update':'save'}.do" method="post">
<tags:search_params/>
<f:hidden name="queryNodeId" value="${queryNodeId}"/>
<f:hidden name="queryNodeType" value="${queryNodeType}"/>
<f:hidden name="oid" value="${bean.id}"/>
<f:hidden name="position" value="${position}"/>
<input type="hidden" id="redirect" name="redirect" value="edit"/>
<table border="0" cellpadding="0" cellspacing="0" class="in_tb">
  <tr>
    <td colspan="4" class="in_opt">
			<div class="in_btn"><input type="button" value="<s:message code="create"/>" onclick="location.href='create.do?queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="copy"/>" onclick="location.href='create.do?id=${bean.id}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="delete"/>" onclick="if(confirmDelete()){location.href='delete.do?ids=${bean.id}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstring}';}"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="prev"/>" onclick="location.href='edit.do?id=${side.prev.id}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&position=${position-1}&${searchstring}';"<c:if test="${empty side.prev}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"><input type="button" value="<s:message code="next"/>" onclick="location.href='edit.do?id=${side.next.id}&queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&position=${position+1}&${searchstring}';"<c:if test="${empty side.next}"> disabled="disabled"</c:if>/></div>
			<div class="in_btn"></div>
			<div class="in_btn"><input type="button" value="<s:message code="return"/>" onclick="location.href='list.do?queryNodeId=${queryNodeId}&queryNodeType=${queryNodeType}&${searchstring}';"/></div>
      <div style="clear:both;"></div>
    </td>
  </tr>
<c:set var="colCount" value="${0}"/>
  <c:forEach var="field" items="${model.fields}">
  <c:if test="${colCount%2==0||!field.dblColumn}"><tr></c:if>
  <td class="in_lab" width="15%"><c:if test="${field.required}"><em class="required">*</em></c:if><c:out value="${field.label}"/>:</td>
  <td<c:if test="${field.type!=50}"> class="in_ctt"</c:if><c:choose><c:when test="${field.dblColumn}"> width="35%"</c:when><c:otherwise> width="85%" colspan="3"</c:otherwise></c:choose>>
  <c:choose>
  <c:when test="${field.custom}">
  
  </c:when>
  <c:otherwise>
  <c:choose>
  <c:when test="${field.name eq 'node'}">
    <f:hidden id="nodeId" name="nodeId" value="${node.id}"/>
    <f:hidden id="nodeIdNumber" value="${node.id}"/>
    <f:hidden id="nodeIdName" value="${node.fullName}"/>
    <f:text id="nodeIdNameDisplay" value="${node.fullName}" readonly="readonly" style="width:160px;"/><input id="nodeIdButton" type="button" value="F7"/>
    <script type="text/javascript">
    $(function(){
    	Cms.f7.node("${ctx}","nodeId",{
    		"title": "<s:message code='info.pleaseSelectNode'/>",
    		params: {"isRealNode": true}
    	});
    });
    </script>
  </c:when>
  <c:when test="${field.name eq 'nodes'}">
  	<div id="nodeIds">
  	<c:set var="nodes" value="${bean.nodesExcludeSelf}"/>
  	<c:forEach var="n" items="${nodes}">
  		<f:hidden name="nodeIds" value="${n.id}"/>
  	</c:forEach>
  	</div>
  	<div id="nodeIdsNumber">
  	<c:forEach var="n" items="${nodes}">
  		<f:hidden name="nodeIdsNumber" value="${n.id}"/>
  	</c:forEach>
  	</div>
  	<div id="nodeIdsName">
  	<c:forEach var="n" items="${nodes}">
  		<f:hidden name="nodeIdsName" value="${n.fullName}"/>
  	</c:forEach>
  	</div>
    <f:text id="nodeIdsNameDisplay" value="" readonly="readonly" style="width:160px;"/><input id="nodeIdsButton" type="button" value="F7"/>
    <script type="text/javascript">
    $(function(){
    	Cms.f7.nodeMulti("${ctx}","nodeIds",{
    		"title": "<s:message code='info.pleaseSelectNodes'/>",
    		params: {"isRealNode": true}
    	});
    });
    </script>
  </c:when>
  <c:when test="${field.name eq 'specials'}">
  	<div id="specialIds">
  	<c:forEach var="s" items="${bean.specials}">
  		<f:hidden name="specialIds" value="${s.id}"/>
  	</c:forEach>
  	</div>
  	<div id="specialIdsNumber">
  	<c:forEach var="s" items="${bean.specials}">
  		<f:hidden name="specialIdsNumber" value="${s.id}"/>
  	</c:forEach>
  	</div>
  	<div id="specialIdsName">
  	<c:forEach var="s" items="${bean.specials}">
  		<f:hidden name="specialIdsName" value="${s.title}"/>
  	</c:forEach>
  	</div>
    <f:text id="specialIdsNameDisplay" value="" readonly="readonly" style="width:160px;"/><input id="specialIdsButton" type="button" value="F7"/>
    <script type="text/javascript">
    $(function(){
    	Cms.f7.specialMulti("${ctx}","specialIds",{
    		"title": "<s:message code='info.pleaseSelectSpecials'/>"
    	});
    });
    </script>
  </c:when>
  <c:when test="${field.name eq 'title'}">
    <div>
	    <f:text name="title" value="${bean.title}" class="required" maxlength="150" style="width:500px;"/>
	    <label><input type="checkbox" onclick="$('#linkUrlDiv').toggle(this.checked);"<c:if test="${bean.link}"> checked="checked"</c:if>/><s:message code="info.linkUrl"/></label>
	  </div>
    <div id="linkUrlDiv" style="padding-top:2px;<c:if test="${!bean.link}">display:none;</c:if>">
    	<f:text name="linkUrl" value="${bean.linkUrl}" maxlength="255" style="width:500px;" />
  	</div>
  </c:when>
  <c:when test="${field.name eq 'color'}">
    <f:text id="color" name="color" value="${bean.color}" maxlength="50" style="width:70px;"/>
    <script type="text/javascript">
    	$("#color").colorPicker();
    </script>
    <label><f:checkbox name="strong" value="${bean.strong}"/><s:message code="info.strong"/></label>
    <label><f:checkbox name="em" value="${bean.em}"/><s:message code="info.em"/></label>
  </c:when>
  <c:when test="${field.name eq 'subtitle'}">
    <f:text name="subtitle" value="${bean.subtitle}" maxlength="150" style="width:500px;"/>
  </c:when>
  <c:when test="${field.name eq 'fullTitle'}">
    <f:text name="fullTitle" value="${bean.fullTitle}" maxlength="150" style="width:500px;"/>
  </c:when>
  <c:when test="${field.name eq 'tagKeywords'}">
    <f:text name="tagKeywords" value="${bean.tagKeywords}" maxlength="150" style="width:500px;"/>
    <input type="button" value="<s:message code='info.getTagKeywords'/>" onclick="var button=this;$(button).prop('disabled',true);$.get('get_keywords.do',{title:$('input[name=title]').val()},function(data){$('input[name=tagKeywords]').val(data);$(button).prop('disabled',false);})"/>
  </c:when>
  <c:when test="${field.name eq 'metaDescription'}">
    <f:textarea name="metaDescription" value="${bean.metaDescription}" class="{maxlength:255}" style="width:500px;height:80px;"/>
  </c:when>
  <c:when test="${field.name eq 'priority'}">
		<select name="priority" style="width:50px;">
  		<c:forEach var="i" begin="0" end="9">
  		<option<c:if test="${i==bean.priority}"> selected="selected"</c:if>>${i}</option>
  		</c:forEach>
  	</select>
  </c:when>
  <c:when test="${field.name eq 'publishDate'}">
    <input type="text" name="publishDate" value="<fmt:formatDate value="${bean.publishDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-ddTHH:mm:ss'});" class="${oprt=='edit'?'required':''}" style="width:180px;"/>
  </c:when>
  <c:when test="${field.name eq 'infoPath'}">
    <f:text name="infoPath" value="${bean.infoPath}" maxlength="255" style="width:180px;"/>
  </c:when>
  <c:when test="${field.name eq 'infoTemplate'}">
    <f:text name="infoTemplate" value="${bean.infoTemplate}" maxlength="255" style="width:180px;"/>
  </c:when>
  <c:when test="${field.name eq 'source'}">
    <f:text name="source" value="${bean.source}" maxlength="50" style="width:100px;"/>
    url:<f:text name="sourceUrl" value="${bean.sourceUrl}" maxlength="50" style="width:100px;"/>
  </c:when>
  <c:when test="${field.name eq 'author'}">
    <f:text name="author" value="${bean.author}" maxlength="50" style="width:180px;"/>
  </c:when>
  <c:when test="${field.name eq 'attributes'}">
  	<c:set var="attrs" value="${bean.attrs}"/>
  	<c:forEach var="attr" items="${attrList}">
  	<label><input type="checkbox" name="attrIds" value="${attr.id}" onclick="$('#attr_img_${attr.id}').toggle(this.checked);"<c:if test="${fnx:contains_co(attrs,attr)}"> checked="checked"</c:if>/><c:out value="${attr.name}"/>(<c:out value="${attr.number}"/>)</label> &nbsp;
  	</c:forEach>
    <c:forEach var="attr" items="${attrList}">
    <c:if test="${attr.withImage}">
    	</td>
    </tr>
    <tr id="attr_img_${attr.id}"<c:if test="${!fnx:contains_co(attrs,attr)}"> style="display:none;"</c:if>>
    	<td class="in_lab" width="15%">
    		<em class="required">*</em>${attr.name}
    	</td>
    	<td class="in_ctt" width="85%" colspan="3">
    		<tags:image_upload name="attrImages_${attr.id}" value="${fnx:invoke1(bean,'getInfoAttr',attr).image}" width="${attr.imageWidth}" height="${attr.imageHeight}"/>
    </c:if>
    </c:forEach>
  </c:when>
  <c:when test="${field.name eq 'smallImage'}">
    <tags:image_upload name="smallImage" value="${bean.smallImage}" width="${field.customs['imageWidth']}" height="${field.customs['imageHeight']}" watermark="${field.customs['imageWatermark']}" scale="${field.customs['imageScale']}"/>
  </c:when>
  <c:when test="${field.name eq 'largeImage'}">
    <tags:image_upload name="largeImage" value="${bean.largeImage}" width="${field.customs['imageWidth']}" height="${field.customs['imageHeight']}" watermark="${field.customs['imageWatermark']}" scale="${field.customs['imageScale']}"/>
  </c:when>
  <c:when test="${field.name eq 'file'}">
  	<div>
	    <f:text id="fileName" name="fileName" value="${bean.fileName}" maxlength="255" style="width:180px;"/>
	    url:<f:text id="file" name="file" value="${bean.file}" maxlength="255" style="width:280px;"/>
	    <s:message code="info.file.length"/>:<f:text id="fileLength" name="fileLength" value="${bean.fileLength}" class="digits" style="width:100px;"/>
    </div>
    <div style="padding-top:3px;">
    	<input id="f_file" name="f_file" type="file" size="23" style="width:235px;"/> <input type="button" onclick="uploadFile('file',this)" value="<s:message code="upload"/>"/>
    </div>
  </c:when>
  <c:when test="${field.name eq 'video'}">
  	<div>
	    <f:text id="videoName" name="videoName" value="${bean.videoName}" maxlength="255" style="width:180px;"/>
	    url:<f:text id="video" name="video" value="${bean.video}" maxlength="255" style="width:280px;"/>
    </div>
    <div style="padding-top:3px;">
    	<input id="f_video" name="f_vedio" type="file" size="23" style="width:235px;"/> <input type="button" onclick="uploadVideo('video',this)" value="<s:message code="upload"/>"/>
    </div>
  </c:when>
  <c:when test="${field.name eq 'text'}">
    <f:textarea id="clobs_text" name="clobs_text" value="${bean.text}"/>
    <script type="text/javascript">
      CKEDITOR.replace("clobs_text",{
        toolbar:'Cms',
        filebrowserUploadUrl : '../upload_file.do',
        filebrowserImageUploadUrl : '../upload_image.do',
        filebrowserFlashUploadUrl : '../upload_flash.do'
      });
    </script>
  </c:when>
  <c:otherwise>
    System field not found: '${field.name}'
  </c:otherwise>
  </c:choose>
  </c:otherwise>
  </c:choose>
  </td><c:if test="${colCount%2==1||!field.dblColumn}"></tr></c:if>
  <c:if test="${field.dblColumn}"><c:set var="colCount" value="${colCount+1}"/></c:if>
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