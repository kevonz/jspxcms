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
	var onCheck = function(event, treeId, treeNode) {
		var treeObj = $.fn.zTree.getZTreeObj("_f7_perm_tree");
		var nodes = treeObj.getCheckedNodes(true);
		var perms = "";
		for(var i=0,len=nodes.length;i<len;i++) {
			var p = nodes[i].perms;
			if(p) {
				perms += p+",";
			}			
		}
		if(perms.length>0) {
			perms = perms.substring(0,perms.length-1);
		}
		$("#_f7_number").val(perms);
	}
	var setting = {
		check: {
			enable: true,
			chkboxType: {"Y":"ps","N":"s"}
		},
		callback: {
			onCheck: onCheck
		},
		view: {
			expandSpeed: ""
		}
	};
	var perms = $("#permsNumber").val();
	var isChecked = function(perm) {
		return perms.indexOf(perm)!=-1;
	}
	var zNodes =[
  	{"name":"<s:message code='role.perms.root'/>","perms":"index,container,nav_homepage,core:homepage:welcome","open":true,"checked":isChecked("index"),"children":[
  		{"name":"<s:message code='navigation.homepage'/>","perms":"nav_homepage","checked":isChecked("nav_homepage"),"children":[
  		  {"name":"<s:message code='homepage.environment'/>","perms":"core:homepage:environment","checked":isChecked("core:homepage:environment")},
  		  {"name":"<s:message code='homepage.personal'/>","perms":"core:homepage:personal","checked":isChecked("core:homepage:personal")}
  		]},
  		{"name":"<s:message code='info.management'/>","perms":"core:info,commons:img_crop,core:upload","checked":isChecked("core:info"),"children":[
  		  
  		]},
  		{"name":"<s:message code='node.management'/>","perms":"core:node,commons:img_crop,core:upload","checked":isChecked("core:node"),"children":[
      	
  		]},
  		{"name":"<s:message code='webFile.management'/>","perms":"core:web_file","checked":isChecked("core:web_file"),"children":[
				/* {"name":"<s:message code='webFile.siteFile'/>","perms":""} */
  		]},
  		{"name":"<s:message code='navigation.infoRelated'/>","perms":"nav_info_related","checked":isChecked("nav_info_related"),"children":[
				{"name":"<s:message code='specialCategory.management'/>","perms":"core:special_category","checked":isChecked("core:special_category")},
				{"name":"<s:message code='special.management'/>","perms":"core:special","checked":isChecked("core:special")},
				{"name":"<s:message code='tag.management'/>","perms":"core:tag","checked":isChecked("core:tag")},
				{"name":"<s:message code='comment.management'/>","perms":"core:comment","checked":isChecked("core:comment")}
  		]},
  		{"name":"<s:message code='navigation.user'/>","perms":"nav_user","checked":isChecked("nav_user"),"children":[
				{"name":"<s:message code='admin.management'/>","perms":"core:admin","checked":isChecked("core:admin")},
				{"name":"<s:message code='role.management'/>","perms":"core:role","checked":isChecked("core:role")}
  		]},
  		{"name":"<s:message code='navigation.config'/>","perms":"nav_config","checked":isChecked("nav_config"),"children":[
				{"name":"<s:message code='site.configuration'/>","perms":"core:conf_site","checked":isChecked("core:conf_site")},
			  {"name":"<s:message code='global.configuration'/>","perms":"core:conf_global","checked":isChecked("core:conf_global")},
			  {"name":"<s:message code='model.management'/>","perms":"core:model,core:model_field","checked":isChecked("core:model")} ,
			  {"name":"<s:message code='attribute.management'/>","perms":"core:attribute","checked":isChecked("core:attribute")}
  		]}
  	]}
	];
	var ztree = $.fn.zTree.init($("#_f7_perm_tree"), setting, zNodes);
	onCheck();
});
</script>
<input type="hidden" id="_f7_id" value=""/>
<input type="hidden" id="_f7_number" value=""/>
<input type="hidden" id="_f7_name" value=""/>
<ul id="_f7_perm_tree" class="ztree" style="padding-top:5px"></ul>