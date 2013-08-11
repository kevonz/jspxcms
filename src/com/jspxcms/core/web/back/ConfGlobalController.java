package com.jspxcms.core.web.back;

import static com.jspxcms.core.support.Constants.MESSAGE;
import static com.jspxcms.core.support.Constants.SAVE_SUCCESS;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Global;
import com.jspxcms.core.service.GlobalService;

/**
 * ConfGlobalController
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/conf_global")
public class ConfGlobalController {
	@RequiresPermissions("core:conf_global:edit")
	@RequestMapping("edit.do")
	public String edit(org.springframework.ui.Model modelMap) {
		return "core/conf_global/conf_global";
	}

	@RequiresPermissions("core:conf_global:update")
	@RequestMapping("update.do")
	public String update(@ModelAttribute("bean") Global bean,
			HttpServletRequest request, RedirectAttributes ra) {
		Map<String, String> sysCustoms = Servlets.getParameterMap(request,
				"sys_", true);
		service.update(bean, sysCustoms);
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		return "redirect:edit.do";
	}

	@ModelAttribute("bean")
	public Global preloadBean() {
		return service.findUnique();
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setDisallowedFields("version");
	}

	@Autowired
	private GlobalService service;
}
