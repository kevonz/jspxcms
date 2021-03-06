package com.jspxcms.core.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.core.domain.Role;
import com.jspxcms.core.domain.RoleSite;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.repository.RoleSiteDao;
import com.jspxcms.core.service.RoleSiteService;

/**
 * RoleSiteServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class RoleSiteServiceImpl implements RoleSiteService {
	public RoleSite get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public RoleSite save(Role role, Site site, Boolean allPerm, String perms) {
		RoleSite bean = new RoleSite();
		bean.setRole(role);
		bean.setSite(site);
		bean.setAllPerm(allPerm);
		bean.setPerms(perms);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public RoleSite update(Role role, Site site, Boolean allPerm, String perms) {
		RoleSite bean = role.getRoleSite(site.getId());
		if (bean == null) {
			save(role, site, allPerm, perms);
		} else {
			bean.setAllPerm(allPerm);
			bean.setPerms(perms);
			bean.applyDefaultValue();
			bean = dao.save(bean);
		}
		return bean;
	}

	@Transactional
	public RoleSite delete(Integer id) {
		RoleSite entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public RoleSite[] delete(Integer[] ids) {
		RoleSite[] beans = new RoleSite[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private RoleSiteDao dao;

	@Autowired
	public void setDao(RoleSiteDao dao) {
		this.dao = dao;
	}
}
