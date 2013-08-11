<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
var messageOptions = {};
function messageCallback() {
	setTimeout(function() {
		$("#message_toggler").hide();
	}, 600 );
};
function showMessage(message) {
	if(message) {
		$("#message_effect").html(message);
	}
	$("#message_toggler").show();
	$("#message_toggler").css("left",($(window).width() - $("#message_toggler").outerWidth())/2);
	$("#message_effect").effect("highlight", messageOptions, 1200);
	$("#message_effect").effect("highlight", messageOptions, 1200, messageCallback);		
}
<c:if test="${!empty message}">
$(function() {
	showMessage();
});
</c:if>
</script>
<s:message code="operationSuccess" var="operationSuccess"/>
<div id="message_toggler" style="display:none;position:absolute;top:5px;background-color:#ccc;">
	<div id="message_effect" style="font-size:14px;font-weight:bold;padding:6px 20px;_width:50px;word-break:keep-all;white-space:nowrap;text-align:center;color:#6b7e1e;">
		<s:message code="${message}" text="" var="msg"/>
		<c:choose>
			<c:when test="${msg!=''}">${msg}</c:when>
			<c:otherwise><s:message code="operationSuccess"/></c:otherwise>
		</c:choose>
	</div>
</div>
