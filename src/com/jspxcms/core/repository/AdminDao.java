package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Admin;

/**
 * AdminDao
 * 
 * @author liufang
 * 
 */
public interface AdminDao extends Repository<Admin, Integer>, AdminDaoPlus {
	public Page<Admin> findAll(Specification<Admin> spec, Pageable pageable);

	public List<Admin> findAll(Specification<Admin> spec, Limitable limitable);

	public Admin findOne(Integer id);

	public Admin save(Admin bean);

	public void delete(Admin bean);

	// --------------------

}
