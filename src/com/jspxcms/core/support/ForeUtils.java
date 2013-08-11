package com.jspxcms.core.support;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspxcms.common.util.JsonMapper;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Site;

/**
 * ForeUtils
 * 
 * @author liufang
 * 
 */
public abstract class ForeUtils {
	public static final String AJAX_RESPONSE = "ajax";
	public static final String PAGE_RESPONSE = "page";
	public static final String OPERATION_SUCCESS = "sys_operation_success.html";
	public static final String OPERATION_MESSAGE = "sys_operation_message.html";
	public static final String OPERATION_FAILURE = "sys_operation_failure.html";

	public static String response(HttpServletResponse response,
			HttpServletRequest request, org.springframework.ui.Model modelMap,
			Site site, Response resp) {
		String responseType = Servlets.getParameter(request, "responseType");
		if (AJAX_RESPONSE.equals(responseType)) {
			JsonMapper mapper = new JsonMapper();
			String json = mapper.toJson(resp);
			Servlets.writeHtml(response, json);
			return null;
		} else {
			modelMap.addAttribute("response", resp);
			String template;
			if (resp.status == null || resp.status == 0) {
				template = site.getTemplate(OPERATION_SUCCESS);
			} else {
				template = site.getTemplate(OPERATION_FAILURE);
			}
			Map<String, Object> data = modelMap.asMap();
			ForeContext.setData(data, site, request);
			return template;
		}
	}
}
