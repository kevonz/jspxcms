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
import com.jspxcms.core.domain.MemberGroup;
import com.jspxcms.core.repository.MemberGroupDao;
import com.jspxcms.core.service.MemberGroupService;

/**
 * MemberGroupServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class MemberGroupServiceImpl implements MemberGroupService {
	public List<MemberGroup> findList(Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(params), sort);
	}

	public RowSide<MemberGroup> findSide(Map<String, String[]> params,
			MemberGroup bean, Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<MemberGroup>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<MemberGroup> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<MemberGroup> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<MemberGroup> sp = SearchFilter.spec(filters,
				MemberGroup.class);
		return sp;
	}

	public MemberGroup get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public MemberGroup save(MemberGroup bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public MemberGroup update(MemberGroup bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public MemberGroup delete(Integer id) {
		MemberGroup entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public MemberGroup[] delete(Integer[] ids) {
		MemberGroup[] beans = new MemberGroup[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private MemberGroupDao dao;

	@Autowired
	public void setDao(MemberGroupDao dao) {
		this.dao = dao;
	}
}
