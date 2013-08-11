package com.jspxcms.core.service.impl;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.Workflow;
import com.jspxcms.core.repository.WorkflowDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.WorkflowService;

/**
 * WorkflowServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class WorkflowServiceImpl implements WorkflowService {
	public List<Workflow> findList(Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(params), sort);
	}

	public RowSide<Workflow> findSide(Map<String, String[]> params,
			Workflow bean, Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<Workflow>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<Workflow> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<Workflow> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<Workflow> sp = SearchFilter.spec(filters, Workflow.class);
		return sp;
	}

	public Workflow get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public Workflow save(Workflow bean, Integer siteId) {
		Site site = siteService.get(siteId);
		bean.setSite(site);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Workflow update(Workflow bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Workflow delete(Integer id) {
		Workflow entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public Workflow[] delete(Integer[] ids) {
		Workflow[] beans = new Workflow[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private SiteService siteService;

	@Autowired
	public void setSiteService(SiteService siteService) {
		this.siteService = siteService;
	}

	private WorkflowDao dao;

	@Autowired
	public void setDao(WorkflowDao dao) {
		this.dao = dao;
	}
}
