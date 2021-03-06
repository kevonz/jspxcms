package com.jspxcms.core.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.core.domain.Attribute;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.repository.AttributeDao;
import com.jspxcms.core.service.AttributeService;
import com.jspxcms.core.service.SiteService;

/**
 * AttributeServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class AttributeServiceImpl implements AttributeService {
	public List<Attribute> findList(Integer siteId) {
		return dao.findBySiteId(siteId, new Sort("seq", "id"));
	}

	public List<Attribute> findByNumber(String[] numbers) {
		return dao.findByNumber(numbers);
	}

	public Attribute get(Integer id) {
		return dao.findOne(id);
	}

	public boolean numberExist(String number, Integer siteId) {
		return dao.countByNumber(number, siteId) > 0;
	}

	@Transactional
	public Attribute save(Attribute bean, Integer siteId) {
		Site site = siteService.get(siteId);
		bean.setSite(site);
		if (bean.getImageHeight() != null && bean.getImageWidth() != null) {
			bean.setWithImage(true);
		} else {
			bean.setWithImage(false);
		}
		bean.applyDefaultValue();
		dao.save(bean);
		return bean;
	}

	@Transactional
	public Attribute update(Attribute bean) {
		if (bean.getImageHeight() != null && bean.getImageWidth() != null) {
			bean.setWithImage(true);
		} else {
			bean.setWithImage(false);
			bean.setImageWidth(null);
			bean.setImageHeight(null);
		}
		bean.applyDefaultValue();
		dao.save(bean);
		return bean;
	}

	@Transactional
	public Attribute[] batchUpdate(Integer[] id, String[] name,
			String[] number, Integer[] imageWidth, Integer[] imageHeight) {
		Attribute[] beans = new Attribute[id.length];
		for (int i = 0, len = id.length; i < len; i++) {
			beans[i] = get(id[i]);
			beans[i].setSeq(i);
			beans[i].setName(name[i]);
			beans[i].setNumber(number[i]);
			beans[i].setImageWidth(imageWidth[i]);
			beans[i].setImageHeight(imageHeight[i]);
			update(beans[i]);
		}
		return beans;
	}

	@Transactional
	public Attribute delete(Integer id) {
		Attribute entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public Attribute[] delete(Integer[] ids) {
		Attribute[] beans = new Attribute[ids.length];
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

	private AttributeDao dao;

	@Autowired
	public void setDao(AttributeDao dao) {
		this.dao = dao;
	}
}
