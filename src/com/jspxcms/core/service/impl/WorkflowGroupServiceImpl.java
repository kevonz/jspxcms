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
import com.jspxcms.core.domain.WorkflowGroup;
import com.jspxcms.core.repository.WorkflowGroupDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.WorkflowGroupService;

/**
 * WorkflowGroupServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class WorkflowGroupServiceImpl implements WorkflowGroupService {
	public List<WorkflowGroup> findList(Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(params), sort);
	}

	public RowSide<WorkflowGroup> findSide(Map<String, String[]> params,
			WorkflowGroup bean, Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<WorkflowGroup>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<WorkflowGroup> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<WorkflowGroup> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<WorkflowGroup> sp = SearchFilter.spec(filters,
				WorkflowGroup.class);
		return sp;
	}

	public WorkflowGroup get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public WorkflowGroup save(WorkflowGroup bean, Integer siteId) {
		Site site = siteService.get(siteId);
		bean.setSite(site);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public WorkflowGroup update(WorkflowGroup bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public WorkflowGroup delete(Integer id) {
		WorkflowGroup entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public WorkflowGroup[] delete(Integer[] ids) {
		WorkflowGroup[] beans = new WorkflowGroup[ids.length];
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

	private WorkflowGroupDao dao;

	@Autowired
	public void setDao(WorkflowGroupDao dao) {
		this.dao = dao;
	}
}
