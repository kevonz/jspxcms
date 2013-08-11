package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.User;

/**
 * UserDao
 * 
 * @author liufang
 * 
 */
public interface UserDao extends Repository<User, Integer>, UserDaoPlus {
	public Page<User> findAll(Specification<User> spec, Pageable pageable);

	public List<User> findAll(Specification<User> spec, Limitable limitable);

	public User findOne(Integer id);

	public User save(User bean);

	public void delete(User bean);

	public User findByUsername(String username);

	@Query("select count(*) from User bean where bean.username=?1")
	public long countByUsername(String username);
}
