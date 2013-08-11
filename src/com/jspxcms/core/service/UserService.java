package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.User;

/**
 * UserService
 * 
 * @author liufang
 * 
 */
public interface UserService {
	public Page<User> findPage(Map<String, String[]> params, Pageable pageable);

	public RowSide<User> findSide(Map<String, String[]> params, User bean,
			Integer position, Sort sort);

	public List<User> findByUsername(String[] usernames);

	public User findByUsername(String username);

	public boolean usernameExist(String username);

	public User getAnonymous();

	public Integer getAnonymousId();

	public User get(Integer id);

	public void updatePassword(Integer userId, String rawPassword);

	public void updateLoginInfo(Integer userId, String loginIp);

	public User save(User bean, Integer orgId, String ip);

	public User update(User bean);

	public User deletePassword(Integer id);

	public User[] deletePassword(Integer[] ids);

	public User disable(Integer id);

	public User[] disable(Integer[] ids);

	public User undisable(Integer id);

	public User[] undisable(Integer[] ids);

	public User delete(Integer id);

	public User[] delete(Integer[] ids);
}
