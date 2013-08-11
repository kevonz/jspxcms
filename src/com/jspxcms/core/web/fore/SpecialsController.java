package com.jspxcms.core.web.fore;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SpecialCategory;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SpecialCategoryService;
import com.jspxcms.core.support.ForeContext;

/**
 * SpecialsController
 * 
 * @author liufang
 * 
 */
@Controller
public class SpecialsController {
	public static final String TEMPLATE = "sys_specials.html";

	@RequestMapping(value = "/specials.jspx", method = RequestMethod.GET)
	public String index(Integer page, HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		// TODO 如何获得站点
		Site site = siteService.findUniqueSite();
		Map<String, Object> data = modelMap.asMap();
		ForeContext.setData(data, site, request);
		ForeContext.setPage(data, page);
		return site.getTemplate(TEMPLATE);
	}

	@RequestMapping(value = "/specials/{categoryId:[0-9]+}.jspx")
	public String specials(@PathVariable Integer categoryId, Integer page,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		SpecialCategory category = service.get(categoryId);
		Site site = category.getSite();
		modelMap.addAttribute("category", category);
		Map<String, Object> data = modelMap.asMap();
		ForeContext.setData(data, site, request);
		ForeContext.setPage(data, page);
		return site.getTemplate(TEMPLATE);
	}

	@Autowired
	private SiteService siteService;
	@Autowired
	private SpecialCategoryService service;
}
