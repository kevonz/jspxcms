package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Role;

/**
 * RoleDao
 * 
 * @author liufang
 * 
 */
public interface RoleDao extends Repository<Role, Integer>, RoleDaoPlus {
	public List<Role> findAll(Specification<Role> spec, Sort sort);

	public List<Role> findAll(Specification<Role> spec, Limitable limit);

	public Role findOne(Integer id);

	public Role save(Role bean);

	public void delete(Role bean);

	// --------------------

	@Query("from Role bean where bean.site.id=?1 order by bean.seq asc,bean.id asc")
	public List<Role> findBySiteId(Integer siteId);
}
