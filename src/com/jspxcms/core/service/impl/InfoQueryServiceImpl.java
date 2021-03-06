package com.jspxcms.core.service.impl;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Info;
import com.jspxcms.core.repository.InfoDao;
import com.jspxcms.core.service.InfoQueryService;

/**
 * 信息Service实现
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class InfoQueryServiceImpl implements InfoQueryService {
	public Page<Info> findAll(Integer mainNodeId, Integer nodeId,
			String treeNumber, Map<String, String[]> params, Pageable pageable) {
		if (mainNodeId == null && nodeId == null
				&& StringUtils.isBlank(treeNumber)) {
			List<Info> emptyList = Collections.emptyList();
			return new PageImpl<Info>(emptyList, pageable, 0);
		}
		return dao.findAll(spec(mainNodeId, nodeId, treeNumber, params),
				pageable);
	}

	public List<Info> findAll(Iterable<Integer> ids) {
		return dao.findAll(ids);
	}

	public RowSide<Info> findSide(Integer mainNodeId, Integer nodeId,
			String treeNumber, Map<String, String[]> params, Info bean,
			Integer position, Sort sort) {
		if (position == null
				|| (mainNodeId == null && nodeId == null && StringUtils
						.isBlank(treeNumber))) {
			return new RowSide<Info>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<Info> list = dao.findAll(
				spec(mainNodeId, nodeId, treeNumber, params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<Info> spec(final Integer mainNodeId,
			final Integer nodeId, final String treeNumber,
			Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		final Specification<Info> fs = SearchFilter.spec(filters, Info.class);
		Specification<Info> sp = new Specification<Info>() {
			public Predicate toPredicate(Root<Info> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate pred = fs.toPredicate(root, query, cb);
				if (mainNodeId != null) {
					pred = cb.and(pred, cb.equal(root.get("node")
							.<Integer> get("id"), mainNodeId));
				}
				if (nodeId != null) {
					pred = cb.and(pred, cb.equal(root.join("nodes")
							.<Integer> get("id"), nodeId));
				}
				if (StringUtils.isNotBlank(treeNumber)) {
					pred = cb.and(pred, cb.like(
							root.get("node").<String> get("treeNumber"),
							treeNumber + "%"));
				}
				return pred;
			}
		};
		return sp;
	}

	public List<Info> findList(Integer[] nodeId, Integer[] attrId,
			Integer[] specialId, Integer[] tagId, Integer[] siteId,
			Integer[] mainNodeId, Integer[] userId, String[] treeNumber,
			String[] specialTitle, String[] tagName, Integer[] priority,
			Date startDate, Date endDate, String[] title, Integer[] includeId,
			Integer[] excludeId, Integer[] excludeMainNodeId,
			String[] excludeTreeNumber, Boolean isWithImage, String[] status,
			Limitable limitable) {
		return dao.findList(nodeId, attrId, specialId, tagId, siteId,
				mainNodeId, userId, treeNumber, specialTitle, tagName,
				priority, startDate, endDate, title, includeId, excludeId,
				excludeMainNodeId, excludeTreeNumber, isWithImage, status,
				limitable);
	}

	public Page<Info> findPage(Integer[] nodeId, Integer[] attrId,
			Integer[] specialId, Integer[] tagId, Integer[] siteId,
			Integer[] mainNodeId, Integer[] userId, String[] treeNumber,
			String[] specialTitle, String[] tagName, Integer[] priority,
			Date startDate, Date endDate, String[] title, Integer[] includeId,
			Integer[] excludeId, Integer[] excludeMainNodeId,
			String[] excludeTreeNumber, Boolean isWithImage, String[] status,
			Pageable pageable) {
		return dao.findPage(nodeId, attrId, specialId, tagId, siteId,
				mainNodeId, userId, treeNumber, specialTitle, tagName,
				priority, startDate, endDate, title, includeId, excludeId,
				excludeMainNodeId, excludeTreeNumber, isWithImage, status,
				pageable);
	}

	public Info findNext(Integer id, boolean bySite) {
		Info info = get(id);
		if (info != null) {
			Integer siteId = bySite ? info.getSite().getId() : null;
			Integer nodeId = bySite ? null : info.getNode().getId();
			return dao.findNext(siteId, nodeId, id, info.getPublishDate());
		} else {
			return null;
		}
	}

	public Info findPrev(Integer id, boolean bySite) {
		Info info = get(id);
		if (info != null) {
			Integer siteId = bySite ? info.getSite().getId() : null;
			Integer nodeId = bySite ? null : info.getNode().getId();
			return dao.findPrev(siteId, nodeId, id, info.getPublishDate());
		} else {
			return null;
		}
	}

	public Info get(Integer id) {
		return dao.findOne(id);
	}

	private InfoDao dao;

	@Autowired
	public void setDao(InfoDao dao) {
		this.dao = dao;
	}
}
