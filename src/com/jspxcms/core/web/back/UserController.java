package com.jspxcms.core.web.back;

import static com.jspxcms.core.support.Constants.CREATE;
import static com.jspxcms.core.support.Constants.DELETE_SUCCESS;
import static com.jspxcms.core.support.Constants.EDIT;
import static com.jspxcms.core.support.Constants.MESSAGE;
import static com.jspxcms.core.support.Constants.OPERATION_SUCCESS;
import static com.jspxcms.core.support.Constants.OPRT;
import static com.jspxcms.core.support.Constants.SAVE_SUCCESS;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jspxcms.common.util.RowSide;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.User;
import com.jspxcms.core.service.UserService;
import com.jspxcms.core.support.Constants;
import com.jspxcms.core.support.Context;

/**
 * UserController
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/user")
public class UserController {
	private static final Logger logger = LoggerFactory
			.getLogger(UserController.class);

	@RequiresPermissions("core:user:list")
	@RequestMapping("list.do")
	public String list(
			@PageableDefaults(sort = "id", sortDir = Direction.DESC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		Page<User> pagedList = service.findPage(params, pageable);
		modelMap.addAttribute("pagedList", pagedList);
		return "core/user/user_list";
	}

	@RequiresPermissions("core:user:create")
	@RequestMapping("create.do")
	public String create(Integer id, org.springframework.ui.Model modelMap) {
		if (id != null) {
			User bean = service.get(id);
			modelMap.addAttribute("bean", bean);
		}
		modelMap.addAttribute(OPRT, CREATE);
		return "core/user/user_form";
	}

	@RequiresPermissions("core:user:edit")
	@RequestMapping("edit.do")
	public String edit(
			Integer id,
			Integer position,
			@PageableDefaults(sort = "id", sortDir = Direction.DESC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		User bean = service.get(id);
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		RowSide<User> side = service.findSide(params, bean, position,
				pageable.getSort());
		modelMap.addAttribute("bean", bean);
		modelMap.addAttribute("side", side);
		modelMap.addAttribute("position", position);
		modelMap.addAttribute(OPRT, EDIT);
		return "core/user/user_form";
	}

	@RequiresPermissions("core:user:save")
	@RequestMapping("save.do")
	public String save(User bean, String redirect, HttpServletRequest request,
			RedirectAttributes ra) {
		Site site = Context.getCurrentSite(request);
		Integer orgId = site.getOrg().getId();
		String ip = Servlets.getRemoteAddr(request);
		service.save(bean, orgId, ip);
		logger.info("save User, username={}.", bean.getUsername());
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		if (Constants.REDIRECT_LIST.equals(redirect)) {
			return "redirect:list.do";
		} else if (Constants.REDIRECT_CREATE.equals(redirect)) {
			return "redirect:create.do";
		} else {
			ra.addAttribute("id", bean.getId());
			return "redirect:edit.do";
		}
	}

	@RequiresPermissions("core:user:update")
	@RequestMapping("update.do")
	public String update(@ModelAttribute("bean") User bean, Integer position,
			String redirect, RedirectAttributes ra) {
		service.update(bean);
		logger.info("update User, username={}.", bean.getUsername());
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		if (Constants.REDIRECT_LIST.equals(redirect)) {
			return "redirect:list.do";
		} else {
			ra.addAttribute("id", bean.getId());
			ra.addAttribute("position", position);
			return "redirect:edit.do";
		}
	}

	@RequiresPermissions("core:user:delete")
	@RequestMapping("delete.do")
	public String delete(Integer[] ids, RedirectAttributes ra) {
		User[] beans = service.delete(ids);
		for (User bean : beans) {
			logger.info("delete User, username={}.", bean.getUsername());
		}
		ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);
		return "redirect:list.do";
	}

	// 删除密码
	@RequiresPermissions("core:user:delete_password")
	@RequestMapping("/delete_password.do")
	public String deletePassword(Integer[] ids, RedirectAttributes ra) {
		User[] beans = service.deletePassword(ids);
		for (User bean : beans) {
			logger.info("delete User password, username={}..",
					bean.getUsername());
		}
		ra.addFlashAttribute(MESSAGE, OPERATION_SUCCESS);
		return "redirect:list.do";
	}

	/**
	 * 检查用户名是否存在
	 * 
	 * @return
	 */
	@RequiresPermissions("core:user:check_username")
	@RequestMapping("check_username.do")
	@ResponseBody
	public String checkUsername(String username, String original) {
		if (StringUtils.isBlank(username)) {
			return "false";
		}
		if (StringUtils.equals(username, original)) {
			return "true";
		}
		// 检查数据库是否重名
		String result = service.usernameExist(username) ? "false" : "true";
		return result;
	}

	@ModelAttribute("bean")
	public User preloadBean(@RequestParam(required = false) Integer oid) {
		return oid != null ? service.get(oid) : null;
	}

	@Autowired
	private UserService service;
}
