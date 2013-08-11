<%@ tag pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="s" uri="http://www.springframework.org/tags" %><%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<%@ attribute name="name" type="java.lang.String" required="true" rtexprvalue="true"%>
<%@ attribute name="value" type="java.lang.String" required="true" rtexprvalue="true"%>
<%@ attribute name="width" type="java.lang.String" required="false" rtexprvalue="true"%>
<%@ attribute name="height" type="java.lang.String" required="false" rtexprvalue="true"%>
<%@ attribute name="scale" type="java.lang.String" required="false" rtexprvalue="true"%>
<%@ attribute name="watermark" type="java.lang.String" required="false" rtexprvalue="true"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="45%">
  		<div>
  			<f:text id="${name}" name="${name}" value="${value}" onchange="fn_${name}(this.value);" style="width:180px;"/>
  			<input type="button" value="F7" disabled="disabled"/>
  		</div>
      <div style="margin-top:2px;"><input type="file" id="f_${name}" name="f_${name}" size="23" style="width:235px;"/></div>      
      <table class="upload_table" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><s:message code="width"/>: <f:text id="w_${name}" value="${width}" default="100" style="width:70px;"/></td>
          <td><label><input type="checkbox" id="s_${name}"<c:if test="${!empty scale&&scale=='true'}"> checked="checked"</c:if>/><s:message code="scale"/></label><f:hidden id="s_${name}" value="${scale}" default="false"/></td>
          <td><input type="button" onclick="uploadImg('${name}',this);" value="<s:message code='upload'/>"/></td>
        </tr>
        <tr>
          <td><s:message code="height"/>: <f:text id="h_${name}" value="${height}" default="100" style="width:70px;"/></td>
          <td><label><input type="checkbox" id="wm_${name}"<c:if test="${!empty watermark&&watermark=='true'}"> checked="checked"</c:if>/><s:message code="watermark"/></label><f:hidden id="wm_${name}" value="${watermark}" default="false"/></td>
          <td><input type="button" onclick="imgCrop('${name}');" value="<s:message code='crop'/>"/></td>
        </tr>
      </table>
    </td>
    <td width="55%" align="center" valign="middle">
      <img id="img_${name}" style="display:none;"/>
		  <script type="text/javascript">
		    function fn_${name}(src) {
		    	Cms.scaleImg("img_${name}",300,100,src);
		    };
		    fn_${name}("${value}");
		  </script>
		</td>
	</tr>
</table>

