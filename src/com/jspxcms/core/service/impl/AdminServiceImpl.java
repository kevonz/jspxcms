package com.jspxcms.core.service.impl;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Admin;
import com.jspxcms.core.domain.Role;
import com.jspxcms.core.domain.User;
import com.jspxcms.core.repository.AdminDao;
import com.jspxcms.core.service.AdminService;
import com.jspxcms.core.service.RoleService;
import com.jspxcms.core.service.UserService;

/**
 * AdminServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class AdminServiceImpl implements AdminService {
	public Page<Admin> findPage(Map<String, String[]> params, Pageable pageable) {
		return dao.findAll(spec(params), pageable);
	}

	public RowSide<Admin> findSide(Map<String, String[]> params, Admin bean,
			Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<Admin>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<Admin> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<Admin> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<Admin> sp = SearchFilter.spec(filters, Admin.class);
		return sp;
	}

	public Admin get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public Admin save(Admin bean, User user, Integer[] roleIds, Integer orgId,
			String ip, int opratorRank) {
		User origUser = userService.findByUsername(user.getUsername());
		if (origUser != null) {
			user = origUser;
		} else {
			userService.save(user, orgId, ip);
		}
		bean.setUser(user);
		if (ArrayUtils.isNotEmpty(roleIds)) {
			Set<Role> roles = new HashSet<Role>(roleIds.length);
			for (Integer roleId : roleIds) {
				roles.add(roleService.get(roleId));
			}
			bean.setRoles(roles);
		}
		bean.setRank(opratorRank + 1);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Admin update(Admin bean, User user, Integer[] roleIds) {
		Set<Role> roles = bean.getRoles();
		roles.clear();
		if (ArrayUtils.isNotEmpty(roleIds)) {
			for (Integer roleId : roleIds) {
				roles.add(roleService.get(roleId));
			}
		}
		bean.applyDefaultValue();
		return bean;
	}

	@Transactional
	public Admin delete(Integer id) {
		Admin entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public Admin[] delete(Integer[] ids) {
		Admin[] beans = new Admin[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private RoleService roleService;
	private UserService userService;

	@Autowired
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	private AdminDao dao;

	@Autowired
	public void setDao(AdminDao dao) {
		this.dao = dao;
	}
}
