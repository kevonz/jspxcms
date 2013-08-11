package com.jspxcms.core.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.core.domain.Site;
import com.jspxcms.core.repository.SiteDao;
import com.jspxcms.core.service.SiteService;

/**
 * SiteServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class SiteServiceImpl implements SiteService {
	public List<Site> findList() {
		List<Site> list = dao.findAll();
		return list;
	}

	public Site get(Integer id) {
		Site entity = dao.findOne(id);
		return entity;
	}

	public Site findUniqueSite() {
		Site site = dao.findUniqueSite();
		return site;
	}

	@Transactional
	public Site save(Site bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Site update(Site bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Site delete(Integer id) {
		Site bean = get(id);
		dao.delete(bean);
		return bean;
	}

	@Transactional
	public Site[] delete(Integer[] ids) {
		Site[] beans = new Site[ids.length];
		for (int i = 0, len = beans.length; i < len; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private SiteDao dao;

	@Autowired
	public void setSiteDao(SiteDao dao) {
		this.dao = dao;
	}
}
