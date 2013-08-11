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
import com.jspxcms.core.domain.Org;
import com.jspxcms.core.repository.OrgDao;
import com.jspxcms.core.service.OrgService;

/**
 * OrgServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class OrgServiceImpl implements OrgService {
	public List<Org> findList(Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(params), sort);
	}

	public RowSide<Org> findSide(Map<String, String[]> params, Org bean,
			Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<Org>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<Org> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<Org> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<Org> sp = SearchFilter.spec(filters, Org.class);
		return sp;
	}

	public Org get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public Org save(Org bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Org update(Org bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Org delete(Integer id) {
		Org entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public Org[] delete(Integer[] ids) {
		Org[] beans = new Org[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private OrgDao dao;

	@Autowired
	public void setDao(OrgDao dao) {
		this.dao = dao;
	}
}
