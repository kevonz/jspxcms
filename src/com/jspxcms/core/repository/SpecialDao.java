package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Special;

/**
 * SpecialDao
 * 
 * @author liufang
 * 
 */
public interface SpecialDao extends Repository<Special, Integer>,
		SpecialDaoPlus {
	public Page<Special> findAll(Specification<Special> spec, Pageable pageable);

	public List<Special> findAll(Specification<Special> spec,
			Limitable limitable);

	public Special findOne(Integer id);

	public Special save(Special bean);

	public void delete(Special bean);

	// --------------------

}
