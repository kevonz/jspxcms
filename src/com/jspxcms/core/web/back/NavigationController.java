package com.jspxcms.core.web.back;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspxcms.core.support.Context;

/**
 * NavigationController
 * 
 * @author liufang
 * 
 */
@Controller
public class NavigationController {
	@RequestMapping({ "/", "/index.do" })
	public String index(HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		Subject subject = SecurityUtils.getSubject();
		if (subject.isAuthenticated()) {
			modelMap.addAttribute("user", Context.getCurrentUser(request));
			return "index";
		} else {
			return "login";
		}
	}

	@RequestMapping("/container.do")
	public String container() {
		return "container";
	}

	@RequestMapping("/nav_homepage.do")
	public String navHomepage() {
		return "navigations/nav_homepage";
	}

	@RequiresPermissions("nav_info_related")
	@RequestMapping("/nav_info_related.do")
	public String navInfoRelated() {
		return "navigations/nav_info_related";
	}

	@RequiresPermissions("nav_user")
	@RequestMapping("/nav_user.do")
	public String navUser() {
		return "navigations/nav_user";
	}

	@RequiresPermissions("nav_config")
	@RequestMapping("/nav_config.do")
	public String navConfig() {
		return "navigations/nav_config";
	}
}
