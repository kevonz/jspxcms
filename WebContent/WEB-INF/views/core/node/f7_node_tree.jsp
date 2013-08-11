<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fnx" uri="http://java.sun.com/jsp/jstl/functionsx"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<style type="text/css">
.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
.ztree li ul.level0 {padding:0; background:none;}
</style>
<script type="text/javascript">
$(function() {
	var setting = {
		view: {
			expandSpeed: "",
			dblClickExpand: function(treeId, treeNode) {
				return false;				
			}
		},
		callback: {
			onClick: function(event, treeId, treeNode) {
				$("#_f7_id").val(treeNode.id);
				$("#_f7_name").val(treeNode.fullName);
			},
			onDblClick: function(event, treeId, treeNode) {
				$("#_f7_id").val(treeNode.id);
				$("#_f7_name").val(treeNode.fullName);
				$("#_f7_ok").click();
			}
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
	var zNodes =[
  	<c:forEach var="node" items="${list}" varStatus="status">
  	<c:if test="${empty excludeChildrenBean || !fn:startsWith(node.treeNumber,excludeChildrenBean.treeNumber)}">
  	{"id":${node.id},"pId":<c:out value="${node.parent.id}" default="null"/>,"fullName":"${node.fullName}","name":"${node.name}",<c:choose><c:when test="${empty node.parent}">"open":true</c:when><c:otherwise>"open":false</c:otherwise></c:choose>}<c:if test="${!status.last}">,</c:if>
  	</c:if>
  	</c:forEach>
  ];
	var ztree = $.fn.zTree.init($("#_f7_nodeTree"), setting, zNodes);
	var selectedNode = ztree.getNodesByParam("id",${id});
	ztree.selectNode(selectedNode[0]);
});
</script>
<input type="hidden" id="_f7_id" value=""/>
<input type="hidden" id="_f7_name" value=""/>
<ul id="_f7_nodeTree" class="ztree" style="padding-top:5px"></ul>