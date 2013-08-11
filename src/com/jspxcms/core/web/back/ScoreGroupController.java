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
import com.jspxcms.core.domain.ScoreGroup;
import com.jspxcms.core.service.ScoreGroupService;
import com.jspxcms.core.support.Constants;
import com.jspxcms.core.support.Context;

/**
 * ScoreGroupController
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/score_group")
public class ScoreGroupController {
	private static final Logger logger = LoggerFactory
			.getLogger(ScoreGroupController.class);

	@RequestMapping("list.do")
	public String list(
			@PageableDefaults(sort = "id", sortDir = Direction.DESC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		List<ScoreGroup> list = service.findList(params, pageable.getSort());
		modelMap.addAttribute("list", list);
		return "core/score_group/score_group_list";
	}

	@RequestMapping("create.do")
	public String create(Integer id, org.springframework.ui.Model modelMap) {
		if (id != null) {
			ScoreGroup bean = service.get(id);
			modelMap.addAttribute("bean", bean);
		}
		modelMap.addAttribute(OPRT, CREATE);
		return "core/score_group/score_group_form";
	}

	@RequestMapping("edit.do")
	public String edit(
			Integer id,
			Integer position,
			@PageableDefaults(sort = "id", sortDir = Direction.DESC) Pageable pageable,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		ScoreGroup bean = service.get(id);
		Map<String, String[]> params = Servlets.getParameterValuesMap(request,
				Constants.SEARCH_PREFIX);
		RowSide<ScoreGroup> side = service.findSide(params, bean, position,
				pageable.getSort());
		modelMap.addAttribute("bean", bean);
		modelMap.addAttribute("side", side);
		modelMap.addAttribute("position", position);
		modelMap.addAttribute(OPRT, EDIT);
		return "core/score_group/score_group_form";
	}

	@RequestMapping("save.do")
	public String save(ScoreGroup bean, String redirect,
			HttpServletRequest request, RedirectAttributes ra) {
		Integer siteId = Context.getCurrentSiteId(request);
		service.save(bean, siteId);
		logger.info("save ScoreGroup, name={}.", bean.getName());
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

	@RequestMapping("update.do")
	public String update(@ModelAttribute("bean") ScoreGroup bean,
			Integer position, String redirect, RedirectAttributes ra) {
		service.update(bean);
		logger.info("update ScoreGroup, name={}.", bean.getName());
		ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
		if (Constants.REDIRECT_LIST.equals(redirect)) {
			return "redirect:list.do";
		} else {
			ra.addAttribute("id", bean.getId());
			ra.addAttribute("position", position);
			return "redirect:edit.do";
		}
	}

	@RequestMapping("delete.do")
	public String delete(Integer[] ids, RedirectAttributes ra) {
		ScoreGroup[] beans = service.delete(ids);
		for (ScoreGroup bean : beans) {
			logger.info("delete ScoreGroup, name={}.", bean.getName());
		}
		ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);
		return "redirect:list.do";
	}

	@ModelAttribute("bean")
	public ScoreGroup preloadBean(@RequestParam(required = false) Integer oid) {
		return oid != null ? service.get(oid) : null;
	}

	@Autowired
	private ScoreGroupService service;
}
