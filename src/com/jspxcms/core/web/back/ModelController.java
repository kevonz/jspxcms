package com.jspxcms.core.web.back;

import static com.jspxcms.core.support.Constants.CREATE;
import static com.jspxcms.core.support.Constants.DELETE_SUCCESS;
import static com.jspxcms.core.support.Constants.EDIT;
import static com.jspxcms.core.support.Constants.MESSAGE;
import static com.jspxcms.core.support.Constants.OPRT;
import static com.jspxcms.core.support.Constants.SAVE_SUCCESS;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.jspxcms.core.domain.Model;
import com.jspxcms.core.service.ModelService;
import com.jspxcms.core.support.Constants;
import com.jspxcms.core.support.Context;

/**
 * ModelController
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/model")
public class ModelController {
	private static final Logger logger = LoggerFactory
			.getLogger(ModelController.class);

	@RequiresPermissions("core:model:list")
	@RequestMapping("list.do")
	public String list(
			@PageableDefaults(sort = { "type", "seq", "id" }, sortDir = Direction.ASC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		List<Model> list = service.findList(params, pageable.getSort());
		modelMap.addAttribute("list", list);
		return "core/model/model_list";
	}

	@RequiresPermissions("core:model:create")
	@RequestMapping("create.do")
	public String create(Integer id, org.springframework.ui.Model modelMap) {
		if (id != null) {
			Model bean = service.get(id);
			modelMap.addAttribute("bean", bean);
		}
		modelMap.addAttribute(OPRT, CREATE);
		return "core/model/model_form";
	}

	@RequiresPermissions("core:model:edit")
	@RequestMapping("edit.do")
	public String edit(Integer id, Integer position, @PageableDefaults(sort = {
			"type", "seq", "id" }, sortDir = Direction.ASC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		Model bean = service.get(id);
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		RowSide<Model> side = service.findSide(params, bean, position,
				pageable.getSort());
		modelMap.addAttribute("bean", bean);
		modelMap.addAttribute("side", side);
		modelMap.addAttribute("position", position);
		modelMap.addAttribute(OPRT, EDIT);
		return "core/model/model_form";
	}

	@RequiresPermissions("core:model:save")
	@RequestMapping("save.do")
	public String save(Model bean, String redirect, HttpServletRequest request,
			RedirectAttributes ra) {
		Integer siteId = Context.getCurrentSiteId(request);
		Map<String, String> customs = Servlets.getParameterMap(request,
				"customs_");
		service.save(bean, siteId, customs);
		logger.info("save Model, name={}.", bean.getName());
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

	@RequiresPermissions("core:model:update")
	@RequestMapping("update.do")
	public String update(@ModelAttribute("bean") Model bean, Integer position,
			String redirect, HttpServletRequest request, RedirectAttributes ra) {
		Map<String, String> customs = Servlets.getParameterMap(request,
				"customs_");
		service.update(bean, customs);
		logger.info("update Model, name={}.", bean.getName());
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		if (Constants.REDIRECT_LIST.equals(redirect)) {
			return "redirect:list.do";
		} else {
			ra.addAttribute("id", bean.getId());
			ra.addAttribute("position", position);
			return "redirect:edit.do";
		}
	}

	@RequiresPermissions("core:model:batch_update")
	@RequestMapping("batch_update.do")
	public String batchUpdate(Integer[] id, String[] name, RedirectAttributes ra) {
		if (ArrayUtils.isNotEmpty(id)) {
			Model[] beans = service.batchUpdate(id, name);
			for (Model bean : beans) {
				logger.info("update Model, name={}.", bean.getName());
			}
		}
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		return "redirect:list.do";
	}

	@RequiresPermissions("core:model:delete")
	@RequestMapping("delete.do")
	public String delete(Integer[] ids, RedirectAttributes ra) {
		Model[] beans = service.delete(ids);
		for (Model bean : beans) {
			logger.info("delete Model, name={}.", bean.getName());
		}
		ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);
		return "redirect:list.do";
	}

	@ModelAttribute("bean")
	public Model preloadBean(@RequestParam(required = false) Integer oid) {
		return oid != null ? service.get(oid) : null;
	}

	@Autowired
	private ModelService service;
}
