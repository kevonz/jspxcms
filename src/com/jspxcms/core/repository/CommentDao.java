package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Comment;

/**
 * CommentDao
 * 
 * @author liufang
 * 
 */
public interface CommentDao extends Repository<Comment, Integer>,
		CommentDaoPlus {
	public Page<Comment> findAll(Specification<Comment> spec, Pageable pageable);

	public List<Comment> findAll(Specification<Comment> spec,
			Limitable limitable);

	public Comment findOne(Integer id);

	public Comment save(Comment bean);

	public void delete(Comment bean);

	// --------------------

}
