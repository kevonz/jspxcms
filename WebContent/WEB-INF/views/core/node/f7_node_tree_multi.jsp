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
.f7-table{width:100%;border-collapse:collapse;}
.f7-table td{border-bottom:1px solid #C5C5C5;padding:2px 5px;cursor:pointer;white-space:nowrap;}
.f7-hover{background-color:#f3f8ff;}
.f7-selected{background-color:#ddecff;}
.f7-left{border:1px solid #999;width:230px;height:310px;overflow:auto;}
.f7-right{border:1px solid #999;width:230px;height:310px;overflow:auto;}
.f7-ul{padding:0 8px;height:290px;overflow:auto;}
.f7-ul li{padding:1px 3px;margin-top:2px;cursor:pointer;border:1px solid #84acdd;}
</style>
<script type="text/javascript">
$(function() {
	var template = $.format($("#_f7_template").val());
	var rightContainer = $("#_f7_right_container");
	var addButton = $("#_f7_add_button");
	var removeButton = $("#_f7_remove_button");
	var addAllButton = $("#_f7_addAll_button");
	var removeAllButton = $("#_f7_removeAll_button");
	var selectableRow = function(row) {
		row = $(row);
		row.hover(function(){
			$(this).addClass("f7-hover");
		},function(){
			$(this).removeClass("f7-hover");				
		});
		row.click(function(event){
			var selected = $(this).hasClass("f7-selected");
			if(selected) {
				$(this).removeClass("f7-selected");				
			} else {
				$(this).addClass("f7-selected");
			}
			var anySelected = false;
			rightContainer.find("tr").each(function() {
				if($(this).hasClass("f7-selected")) {
					anySelected = true;
				}
			});
			removeButton.prop("disabled",!anySelected);
		});
		row.dblclick(function() {
			$(this).remove();
			var anySelected = false;
			rightContainer.find("tr").each(function() {
				if($(this).hasClass("f7-selected")) {
					anySelected = true;
				}
			});
			removeButton.prop("disabled",!anySelected);
		});
	};
	rightContainer.find("tr").each(function() {
		selectableRow(this);
	});
	var add = function(isAll) {
		var tree = $.fn.zTree.getZTreeObj("_f7_nodeTree");
		var nodes;
		if(isAll) {
			nodes = tree.transformToArray(tree.getNodes());
		} else {
			nodes = tree.getSelectedNodes();			
		}
		for(var i=0,len=nodes.length;i<len;i++) {
			var selected = false;
			rightContainer.find("input[name='f7_ids']").each(function() {
				if($(this).val()==nodes[i].id) {
					selected = true;
				}
			});
			tree.cancelSelectedNode(nodes[i]);
			if(selected) {
				continue;
			}
			var tr = $(template(nodes[i].id,nodes[i].id,nodes[i].fullName));
			rightContainer.append(tr);
			selectableRow(tr);
		}
		addButton.prop("disabled", true);
	};
	var remove = function(isAll) {
		if(isAll) {
			rightContainer.empty();
			removeButton.prop("disabled",true);
		} else {
			rightContainer.find("tr").each(function() {
				if($(this).hasClass("f7-selected")) {
					$(this).remove();
				}
			});
			var anySelected = false;
			rightContainer.find("tr").each(function() {
				if($(this).hasClass("f7-selected")) {
					anySelected = true;
				}
			});
			removeButton.prop("disabled",!anySelected);
		}
	};
	addButton.click(function(){add(false);});
	addAllButton.click(function(){add(true);});
	removeButton.click(function(){remove(false);});
	removeAllButton.click(function(){remove(true);});
	var setting = {
		view: {
			expandSpeed: "",
			dblClickExpand: function(treeId, treeNode) {
				return false;				
			}
		},
		callback: {
			onClick: function(event, treeId, treeNode) {
				addButton.prop("disabled", false);
			},
			onDblClick: function(event, treeId, treeNode) {
				add();
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
  	{"id":${node.id},"pId":<c:out value="${node.parent.id}" default="null"/>,"fullName":"${node.fullName}","name":"${node.name}",<c:choose><c:when test="${empty node.parent}">"open":true</c:when><c:otherwise>"open":false</c:otherwise></c:choose>}<c:if test="${!status.last}">,</c:if>
  	</c:forEach>
  ];
	var ztree = $.fn.zTree.init($("#_f7_nodeTree"), setting, zNodes);
});
</script>
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
		<div class="f7-left">
			<ul id="_f7_nodeTree" class="ztree"></ul>
		</div>
		</td>
		<td width="60" align="center" valign="middle">
			<div><button id="_f7_add_button" disabled="disabled">&nbsp;&gt;&nbsp;</button></div>
			<div style="padding-top:5px;"><button id="_f7_remove_button" disabled="disabled">&nbsp;&lt;&nbsp;</button></div>
			<div style="padding-top:5px;"><button id="_f7_addAll_button">&nbsp;&gt;&gt;&nbsp;</button></div>
			<div style="padding-top:5px;"><button id="_f7_removeAll_button">&nbsp;&lt;&lt;&nbsp;</button></div>
		</td>
		<td valign="top">
		<div class="f7-right">
			<table id="_f7_right_container" border="0" cellpadding="0" cellspacing="0" class="f7-table">
				<c:forEach var="bean" items="${beans}">
				<tr>
					<td>
						<c:out value="${bean.fullName}"/>
						<input type="hidden" name="f7_ids" value="${bean.id}"/>
						<input type="hidden" name="f7_numbers" value="${bean.id}"/>
						<input type="hidden" name="f7_names" value="${bean.fullName}"/>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		</td>
	</tr>
</table>
<textarea id="_f7_template" style="display:none;">
<tr>
	<td>
		<c:out value="{2}"/>
		<input type="hidden" name="f7_ids" value="{0}"/>
		<input type="hidden" name="f7_numbers" value="{1}"/>
		<input type="hidden" name="f7_names" value="{2}"/>
	</td>
</tr>
</textarea>