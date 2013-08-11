package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Org;

/**
 * OrgDao
 * 
 * @author liufang
 * 
 */
public interface OrgDao extends Repository<Org, Integer>, OrgDaoPlus {
	public List<Org> findAll(Specification<Org> spec, Sort sort);

	public List<Org> findAll(Specification<Org> spec, Limitable limit);

	public Org findOne(Integer id);

	public Org save(Org bean);

	public void delete(Org bean);

	// --------------------

}
