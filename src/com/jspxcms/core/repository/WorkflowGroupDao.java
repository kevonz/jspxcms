package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.WorkflowGroup;

/**
 * WorkflowGroupDao
 * 
 * @author liufang
 * 
 */
public interface WorkflowGroupDao extends Repository<WorkflowGroup, Integer>,
		WorkflowGroupDaoPlus {
	public List<WorkflowGroup> findAll(Specification<WorkflowGroup> spec,
			Sort sort);

	public List<WorkflowGroup> findAll(Specification<WorkflowGroup> spec,
			Limitable limit);

	public WorkflowGroup findOne(Integer id);

	public WorkflowGroup save(WorkflowGroup bean);

	public void delete(WorkflowGroup bean);

	// --------------------

}
