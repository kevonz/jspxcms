package com.jspxcms.core.service.impl;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.security.CredentialsDigest;
import com.jspxcms.common.security.Digests;
import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.User;
import com.jspxcms.core.repository.UserDao;
import com.jspxcms.core.service.OrgService;
import com.jspxcms.core.service.UserService;

/**
 * UserServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {
	private static final int SALT_SIZE = 8;

	public Page<User> findPage(Map<String, String[]> params, Pageable pageable) {
		return dao.findAll(spec(params), pageable);
	}

	public RowSide<User> findSide(Map<String, String[]> params, User bean,
			Integer position, Sort sort) {
		if (position == null) {
			return new RowSide<User>();
		}
		Limitable limit = RowSide.limitable(position, sort);
		List<User> list = dao.findAll(spec(params), limit);
		return RowSide.create(list, bean);
	}

	private Specification<User> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<User> sp = SearchFilter.spec(filters, User.class);
		return sp;
	}

	public List<User> findByUsername(String[] usernames) {
		return dao.findByUsername(usernames);
	}

	public User getAnonymous() {
		return dao.findOne(0);
	}

	public Integer getAnonymousId() {
		return 0;
	}

	public User get(Integer id) {
		return dao.findOne(id);
	}

	public User findByUsername(String username) {
		return dao.findByUsername(username);
	}

	public boolean usernameExist(String username) {
		return dao.countByUsername(username) > 0;
	}

	@Transactional
	public void updatePassword(Integer userId, String rawPassword) {
		User user = get(userId);
		user.setRawPassword(rawPassword);
		entryptPassword(user);
		dao.save(user);
	}

	@Transactional
	public void updateLoginInfo(Integer userId, String loginIp) {
		User user = get(userId);
		user.setPrevLoginIp(user.getLastLoginIp());
		user.setPrevLoginDate(user.getLastLoginDate());
		user.setLastLoginIp(loginIp);
		user.setLastLoginDate(new Timestamp(System.currentTimeMillis()));
		user.setLogins(user.getLogins() + 1);
	}

	@Transactional
	public User deletePassword(Integer id) {
		User bean = get(id);
		bean.setPassword(null);
		return bean;
	}

	@Transactional
	public User[] deletePassword(Integer[] ids) {
		User[] beans = new User[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = deletePassword(ids[i]);
		}
		return beans;
	}

	@Transactional
	public User disable(Integer id) {
		User bean = get(id);
		bean.setStatus(User.DISABLED);
		return bean;
	}

	@Transactional
	public User[] disable(Integer[] ids) {
		User[] beans = new User[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = disable(ids[i]);
		}
		return beans;
	}

	@Transactional
	public User undisable(Integer id) {
		User bean = get(id);
		if (bean.getStatus() == User.DISABLED) {
			bean.setStatus(User.NORMAL);
		}
		return bean;
	}

	@Transactional
	public User[] undisable(Integer[] ids) {
		User[] beans = new User[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = undisable(ids[i]);
		}
		return beans;
	}

	@Transactional
	public User save(User bean, Integer orgId, String ip) {
		bean.setOrg(orgService.get(orgId));
		bean.setCreationIp(ip);
		entryptPassword(bean);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public User update(User bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public User delete(Integer id) {
		User entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public User[] delete(Integer[] ids) {
		User[] beans = new User[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private void entryptPassword(User bean) {
		byte[] saltBytes = Digests.generateSalt(SALT_SIZE);
		bean.setSaltBytes(saltBytes);

		String rawPass = bean.getRawPassword();
		String encPass = credentialsDigest.digest(rawPass, saltBytes);
		bean.setPassword(encPass);
	}

	private OrgService orgService;
	private CredentialsDigest credentialsDigest;

	@Autowired
	public void setOrgService(OrgService orgService) {
		this.orgService = orgService;
	}

	@Autowired
	public void setCredentialsDigest(CredentialsDigest credentialsDigest) {
		this.credentialsDigest = credentialsDigest;
	}

	private UserDao dao;

	@Autowired
	public void setDao(UserDao dao) {
		this.dao = dao;
	}

}
