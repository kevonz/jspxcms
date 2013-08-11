package com.jspxcms.core.web.back;

import static com.jspxcms.core.support.Constants.CREATE;
import static com.jspxcms.core.support.Constants.DELETE_SUCCESS;
import static com.jspxcms.core.support.Constants.EDIT;
import static com.jspxcms.core.support.Constants.MESSAGE;
import static com.jspxcms.core.support.Constants.OPERATION_SUCCESS;
import static com.jspxcms.core.support.Constants.OPRT;
import static com.jspxcms.core.support.Constants.SAVE_SUCCESS;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jspxcms.common.util.RowSide;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Admin;
import com.jspxcms.core.domain.Role;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.User;
import com.jspxcms.core.service.AdminService;
import com.jspxcms.core.service.RoleService;
import com.jspxcms.core.service.UserService;
import com.jspxcms.core.support.Constants;
import com.jspxcms.core.support.Context;

/**
 * AdminController
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory
			.getLogger(AdminController.class);

	@RequiresPermissions("core:admin:list")
	@RequestMapping("list.do")
	public String list(
			@PageableDefaults(sort = "id", sortDir = Direction.DESC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		Page<Admin> pagedList = service.findPage(params, pageable);
		modelMap.addAttribute("pagedList", pagedList);
		return "core/admin/admin_list";
	}

	@RequiresPermissions("core:admin:create")
	@RequestMapping("create.do")
	public String create(Integer id, HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		Site site = Context.getCurrentSite(request);
		if (id != null) {
			Admin bean = service.get(id);
			modelMap.addAttribute("bean", bean);
		}
		List<Role> roleList = roleService.findList(site.getId());
		modelMap.addAttribute("roleList", roleList);
		modelMap.addAttribute(OPRT, CREATE);
		return "core/admin/admin_form";
	}

	@RequiresPermissions("core:admin:edit")
	@RequestMapping("edit.do")
	public String edit(
			Integer id,
			Integer position,
			@PageableDefaults(sort = "id", sortDir = Direction.DESC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		Site site = Context.getCurrentSite(request);
		Admin bean = service.get(id);
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		RowSide<Admin> side = service.findSide(params, bean, position,
				pageable.getSort());
		List<Role> roleList = roleService.findList(site.getId());
		modelMap.addAttribute("roleList", roleList);
		modelMap.addAttribute("bean", bean);
		modelMap.addAttribute("side", side);
		modelMap.addAttribute("position", position);
		modelMap.addAttribute(OPRT, EDIT);
		return "core/admin/admin_form";
	}

	@RequiresPermissions("core:admin:save")
	@RequestMapping("save.do")
	public String save(Admin bean, User user, Integer[] roleIds,
			String redirect, HttpServletRequest request, RedirectAttributes ra) {
		Site site = Context.getCurrentSite(request);
		Integer orgId = site.getOrg().getId();
		User currUser = Context.getCurrentUser(request);
		Integer currRank = currUser.getAdmin().getRank();
		String ip = Servlets.getRemoteAddr(request);
		service.save(bean, user, roleIds, orgId, ip, currRank);
		logger.info("save Admin, username={}.", bean.getUsername());
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

	@RequiresPermissions("core:admin:update")
	@RequestMapping("update.do")
	public String update(@ModelAttribute("bean") Admin bean,
			@ModelAttribute("user") User user, Integer[] roleIds,
			Integer position, String redirect, RedirectAttributes ra) {
		service.update(bean, user, roleIds);
		logger.info("update Admin, username={}.", bean.getUsername());
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		if (Constants.REDIRECT_LIST.equals(redirect)) {
			return "redirect:list.do";
		} else {
			ra.addAttribute("id", bean.getId());
			ra.addAttribute("position", position);
			return "redirect:edit.do";
		}
	}

	@RequiresPermissions("core:admin:delete")
	@RequestMapping("delete.do")
	public String delete(Integer[] ids, RedirectAttributes ra) {
		Admin[] beans = service.delete(ids);
		for (Admin bean : beans) {
			logger.info("delete Admin, username={}.", bean.getUsername());
		}
		ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);
		return "redirect:list.do";
	}

	// 删除密码
	@RequiresPermissions("core:admin:delete_password")
	@RequestMapping("delete_password.do")
	public String deletePassword(Integer[] ids, RedirectAttributes ra) {
		User[] beans = userService.deletePassword(ids);
		for (User bean : beans) {
			logger.info("delete Admin password, username={}..",
					bean.getUsername());
		}
		ra.addFlashAttribute(MESSAGE, OPERATION_SUCCESS);
		return "redirect:list.do";
	}

	// 禁用账户
	@RequiresPermissions("core:admin:disable")
	@RequestMapping("disable.do")
	public String disable(Integer[] ids, RedirectAttributes ra) {
		User[] beans = userService.disable(ids);
		for (User bean : beans) {
			logger.info("disable Admin, username={}..", bean.getUsername());
		}
		ra.addFlashAttribute(MESSAGE, OPERATION_SUCCESS);
		return "redirect:list.do";
	}

	// 反禁用账户
	@RequiresPermissions("core:admin:undisable")
	@RequestMapping("undisable.do")
	public String undisable(Integer[] ids, RedirectAttributes ra) {
		User[] beans = userService.undisable(ids);
		for (User bean : beans) {
			logger.info("undisable Admin, username={}..", bean.getUsername());
		}
		ra.addFlashAttribute(MESSAGE, OPERATION_SUCCESS);
		return "redirect:list.do";
	}

	/**
	 * 检查用户名是否存在
	 * 
	 * @return
	 */
	@RequiresPermissions("core:admin:check_username")
	@RequestMapping("check_username.do")
	public void checkUsername(String username, String original,
			HttpServletResponse response) {
		if (StringUtils.isBlank(username)) {
			Servlets.writeHtml(response, "false");
			return;
		}
		if (StringUtils.equals(username, original)) {
			Servlets.writeHtml(response, "true");
			return;
		}
		// 检查数据库是否重名
		User user = userService.findByUsername(username);
		if (user == null || user.getAdmin() == null) {
			Servlets.writeHtml(response, "true");
		} else {
			Servlets.writeHtml(response, "false");
		}
	}

	@ModelAttribute("bean")
	public void preloadBean(@RequestParam(required = false) Integer oid,
			org.springframework.ui.Model modelMap) {
		if (oid != null) {
			Admin bean = service.get(oid);
			if (bean != null) {
				modelMap.addAttribute("bean", bean);
				modelMap.addAttribute("user", bean.getUser());
			}
		}
	}

	@Autowired
	private RoleService roleService;
	@Autowired
	private UserService userService;
	@Autowired
	private AdminService service;
}
