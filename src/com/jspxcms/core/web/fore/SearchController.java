package com.jspxcms.core.web.fore;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspxcms.core.domain.Site;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.support.ForeContext;

/**
 * SearchController
 * 
 * @author liufang
 * 
 */
@Controller
public class SearchController {
	public static final String TEMPLATE = "sys_search.html";

	@RequestMapping(value = "/search.jspx")
	public String search(Integer page, HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		// TODO 如何获得站点
		Site site = siteService.findUniqueSite();
		Map<String, Object> data = modelMap.asMap();
		ForeContext.setData(data, site, request);
		ForeContext.setPage(data, page);
		return site.getTemplate(TEMPLATE);
	}

	@Autowired
	private SiteService siteService;
}
