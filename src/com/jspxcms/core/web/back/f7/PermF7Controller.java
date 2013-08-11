package com.jspxcms.core.web.back.f7;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * PermF7Controller
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/role")
public class PermF7Controller {

	@RequestMapping("f7_perm_tree.do")
	public String f7NodeTree(HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		return "core/role/f7_perm_tree";
	}

}
