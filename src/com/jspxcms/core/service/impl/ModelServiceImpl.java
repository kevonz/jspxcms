package com.jspxcms.core.service.impl;

import java.util.Collection;
import java.util.HashMap;
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
import com.jspxcms.core.domain.Model;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.repository.ModelDao;
import com.jspxcms.core.service.ModelService;
import com.jspxcms.core.service.SiteService;

/**
 * ModelServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class ModelServiceImpl implements ModelService {
	public List<Model> findList(Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(params), sort);
	}

	public RowSide<Model> findSide(Map<String, String[]> params, Model bean,
			Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<Model>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<Model> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<Model> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<Model> sp = SearchFilter.spec(filters, Model.class);
		return sp;
	}

	public List<Model> findList(Integer siteId, Integer type) {
		return dao.findList(siteId, type);
	}

	public Model findDefault(Integer siteId, Integer type) {
		return dao.findDefault(siteId, type);
	}

	public Model get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public Model save(Model bean, Integer siteId, Map<String, String> customs) {
		Site site = siteService.get(siteId);
		bean.setSite(site);
		bean.setCustoms(customs);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Model[] batchUpdate(Integer[] id, String[] name) {
		Map<Integer, Integer> seqMap = new HashMap<Integer, Integer>();
		Model[] beans = new Model[id.length];
		for (int i = 0, len = id.length; i < len; i++) {
			beans[i] = get(id[i]);
			Integer type = beans[i].getType();
			Integer seq = seqMap.get(type);
			if (seq == null) {
				seq = 0;
				seqMap.put(type, seq);
			} else {
				seq++;
				seqMap.put(type, seq);
			}
			beans[i].setSeq(seq);
			beans[i].setName(name[i]);
			update(beans[i], null);
		}
		return beans;
	}

	@Transactional
	public Model update(Model bean, Map<String, String> customs) {
		if (customs != null) {
			bean.getCustoms().clear();
			bean.getCustoms().putAll(customs);
		}
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Model delete(Integer id) {
		Model entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public Model[] delete(Integer[] ids) {
		Model[] beans = new Model[ids.length];
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

	private ModelDao dao;

	@Autowired
	public void setDao(ModelDao dao) {
		this.dao = dao;
	}
}
