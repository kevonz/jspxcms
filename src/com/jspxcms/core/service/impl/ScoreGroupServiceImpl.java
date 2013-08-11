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
import com.jspxcms.core.domain.ScoreGroup;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.repository.ScoreGroupDao;
import com.jspxcms.core.service.ScoreGroupService;
import com.jspxcms.core.service.SiteService;

/**
 * ScoreGroupServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class ScoreGroupServiceImpl implements ScoreGroupService {
	public List<ScoreGroup> findList(Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(params), sort);
	}

	public RowSide<ScoreGroup> findSide(Map<String, String[]> params,
			ScoreGroup bean, Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<ScoreGroup>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<ScoreGroup> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<ScoreGroup> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<ScoreGroup> sp = SearchFilter.spec(filters,
				ScoreGroup.class);
		return sp;
	}

	public ScoreGroup get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public ScoreGroup save(ScoreGroup bean, Integer siteId) {
		Site site = siteService.get(siteId);
		bean.setSite(site);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public ScoreGroup update(ScoreGroup bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public ScoreGroup delete(Integer id) {
		ScoreGroup entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public ScoreGroup[] delete(Integer[] ids) {
		ScoreGroup[] beans = new ScoreGroup[ids.length];
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

	private ScoreGroupDao dao;

	@Autowired
	public void setDao(ScoreGroupDao dao) {
		this.dao = dao;
	}
}
