package com.jspxcms.core.web.fore;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.support.ForeContext;

/**
 * AppController
 * 
 * @author liufang
 * 
 */
@Controller
public class AppController {
	@RequestMapping(value = "/app.jspx")
	public String search(Integer page, HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		// TODO 如何获得站点
		Site site = siteService.findUniqueSite();
		String template = Servlets.getParameter(request, "template");
		if (StringUtils.isBlank(template)) {
			// TODO 重定向到页面未找到
		}
		template = "app_" + template + ".html";

		Map<String, Object> data = modelMap.asMap();
		ForeContext.setData(data, site, request);
		ForeContext.setPage(data, page);
		return site.getTemplate(template);
	}

	@Autowired
	private SiteService siteService;
}
