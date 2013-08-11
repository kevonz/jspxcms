package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.ScoreGroup;

/**
 * ScoreGroupDao
 * 
 * @author liufang
 * 
 */
public interface ScoreGroupDao extends Repository<ScoreGroup, Integer>,
		ScoreGroupDaoPlus {
	public List<ScoreGroup> findAll(Specification<ScoreGroup> spec, Sort sort);

	public List<ScoreGroup> findAll(Specification<ScoreGroup> spec,
			Limitable limit);

	public ScoreGroup findOne(Integer id);

	public ScoreGroup save(ScoreGroup bean);

	public void delete(ScoreGroup bean);

	// --------------------

}
