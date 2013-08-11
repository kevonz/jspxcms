package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Info;

/**
 * InfoDao
 * 
 * @author liufang
 * 
 */
public interface InfoDao extends Repository<Info, Integer>, InfoDaoPlus {
	public Page<Info> findAll(Specification<Info> spec, Pageable pageable);

	public List<Info> findAll(Specification<Info> spec, Limitable limitable);

	public List<Info> findAll(Iterable<Integer> ids);

	public Info findOne(Integer id);

	public Info save(Info bean);

	public void delete(Info bean);

	// --------------------

}
