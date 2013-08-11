package com.jspxcms.core.service.impl;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SpecialCategory;
import com.jspxcms.core.repository.SpecialCategoryDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SpecialCategoryService;

/**
 * SpecialCategoryServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class SpecialCategoryServiceImpl implements SpecialCategoryService {
	public List<SpecialCategory> findList(Integer siteId,
			Map<String, String[]> params, Sort sort) {
		return dao.findAll(spec(siteId, params), sort);
	}

	public RowSide<SpecialCategory> findSide(Integer siteId,
			Map<String, String[]> params, SpecialCategory bean,
			Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<SpecialCategory>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<SpecialCategory> list = dao.findAll(spec(siteId, params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<SpecialCategory> spec(final Integer siteId,
			Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		final Specification<SpecialCategory> fs = SearchFilter.spec(filters,
				SpecialCategory.class);
		Specification<SpecialCategory> sp = new Specification<SpecialCategory>() {
			public Predicate toPredicate(Root<SpecialCategory> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Path<Integer> siteIdPath = root.get("site").<Integer> get("id");
				Predicate siteIdPred = cb.equal(siteIdPath, siteId);
				return cb.and(fs.toPredicate(root, query, cb), siteIdPred);
			}
		};
		return sp;
	}

	public List<SpecialCategory> findList(Integer siteId) {
		return dao.findAll(spec(siteId, null), new Sort(Direction.ASC, "seq",
				"id"));
	}

	public List<SpecialCategory> findList(Integer[] siteId, Limitable limitable) {
		return dao.getList(siteId, limitable);
	}

	public SpecialCategory get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public SpecialCategory save(SpecialCategory bean, Integer siteId) {
		Site site = siteService.get(siteId);
		bean.setSite(site);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public SpecialCategory update(SpecialCategory bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public SpecialCategory[] batchUpdate(Integer[] id, String[] name,
			Integer[] views) {
		SpecialCategory[] beans = new SpecialCategory[id.length];
		for (int i = 0, len = id.length; i < len; i++) {
			beans[i] = get(id[i]);
			beans[i].setSeq(i);
			beans[i].setName(name[i]);
			beans[i].setViews(views[i]);
			update(beans[i]);
		}
		return beans;
	}

	@Transactional
	public SpecialCategory delete(Integer id) {
		SpecialCategory entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public SpecialCategory[] delete(Integer[] ids) {
		SpecialCategory[] beans = new SpecialCategory[ids.length];
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

	private SpecialCategoryDao dao;

	@Autowired
	public void setDao(SpecialCategoryDao dao) {
		this.dao = dao;
	}
}
