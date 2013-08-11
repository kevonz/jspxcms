package com.jspxcms.core.service;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Admin;
import com.jspxcms.core.domain.User;

/**
 * AdminService
 * 
 * @author liufang
 * 
 */
public interface AdminService {
	public Page<Admin> findPage(Map<String, String[]> params, Pageable pageable);

	public RowSide<Admin> findSide(Map<String, String[]> params, Admin bean,
			Integer position, Sort sort);

	public Admin get(Integer id);

	public Admin save(Admin bean, User user, Integer[] roleIds, Integer orgId,
			String ip, int opratorRank);

	public Admin update(Admin bean, User user, Integer[] roleIds);

	public Admin delete(Integer id);

	public Admin[] delete(Integer[] ids);
}
