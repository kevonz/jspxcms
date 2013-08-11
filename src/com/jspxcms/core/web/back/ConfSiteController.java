package com.jspxcms.core.web.back;

import static com.jspxcms.core.support.Constants.MESSAGE;
import static com.jspxcms.core.support.Constants.SAVE_SUCCESS;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jspxcms.core.domain.Site;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.support.Context;

/**
 * ConfSiteController
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/conf_site")
public class ConfSiteController {
	@RequiresPermissions("core:conf_site:edit")
	@RequestMapping("edit.do")
	public String edit(org.springframework.ui.Model modelMap) {
		return "core/conf_site/conf_site";
	}

	@RequiresPermissions("core:conf_site:update")
	@RequestMapping("update.do")
	public String update(@ModelAttribute("bean") Site bean,
			RedirectAttributes ra) {
		service.update(bean);
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		return "redirect:edit.do";
	}

	@ModelAttribute("bean")
	public Site preloadBean(HttpServletRequest request) {
		return Context.getCurrentSite(request);
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setDisallowedFields("version");
	}

	@Autowired
	private SiteService service;
}
