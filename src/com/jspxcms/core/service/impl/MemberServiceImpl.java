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
import com.jspxcms.core.domain.Member;
import com.jspxcms.core.repository.MemberDao;
import com.jspxcms.core.service.MemberService;

/**
 * MemberServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class MemberServiceImpl implements MemberService {
	public List<Member> findList(Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(params), sort);
	}

	public RowSide<Member> findSide(Map<String, String[]> params, Member bean,
			Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<Member>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<Member> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<Member> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<Member> sp = SearchFilter.spec(filters, Member.class);
		return sp;
	}

	public Member get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public Member save(Member bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Member update(Member bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Member delete(Integer id) {
		Member entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public Member[] delete(Integer[] ids) {
		Member[] beans = new Member[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private MemberDao dao;

	@Autowired
	public void setDao(MemberDao dao) {
		this.dao = dao;
	}
}
