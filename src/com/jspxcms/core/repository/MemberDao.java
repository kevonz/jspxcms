package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Member;

/**
 * MemberDao
 * 
 * @author liufang
 * 
 */
public interface MemberDao extends Repository<Member, Integer>, MemberDaoPlus {
	public List<Member> findAll(Specification<Member> spec, Sort sort);

	public List<Member> findAll(Specification<Member> spec, Limitable limit);

	public Member findOne(Integer id);

	public Member save(Member bean);

	public void delete(Member bean);

	// --------------------

}
