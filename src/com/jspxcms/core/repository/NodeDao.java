package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Node;

/**
 * NodeDao
 * 
 * @author liufang
 * 
 */
public interface NodeDao extends Repository<Node, Integer>, NodeDaoPlus {
	public List<Node> findAll(Specification<Node> spec, Sort sort);

	public List<Node> findAll(Specification<Node> spec, Limitable limit);

	public List<Node> findAll(Iterable<Integer> ids);

	public Node findOne(Integer id);

	public Node save(Node bean);

	public void delete(Node bean);

	// --------------------

	public List<Node> findBySiteIdAndParentIdIsNull(Integer siteId);

	public List<Node> findBySiteIdAndNumber(Integer siteId, String number);

	@Query("select count(*) from Node bean where bean.parent.id = ?1")
	public long countByParentId(Integer parentId);

	@Query("select count(*) from Node bean where bean.site.id = ?1 and bean.parent.id is null")
	public long countRoot(Integer siteId);

	@Query("select bean.treeNumber from Node bean where bean.id = ?1")
	public String findTreeNumber(Integer id);

	@Modifying
	@Query("update from Node bean set bean.treeNumber=CONCAT('*',bean.treeNumber) where bean.site.id = ?1 and bean.treeNumber like ?2 and bean.treeNumber <> ?3")
	public int appendModifiedFlag(Integer siteId, String treeNumberStart,
			String treeNumber);

	@Modifying
	@Query("update from Node bean set bean.treeNumber=CONCAT(?3,SUBSTRING(bean.treeNumber,?4,LENGTH(bean.treeNumber))),bean.treeLevel=(LENGTH(bean.treeNumber)-4)/5 where bean.site.id = ?1 and bean.treeNumber like ?2")
	public int updateTreeNumber(Integer siteId, String treeNumber,
			String value, int len);

	@Modifying
	@Query("update from Node bean set bean.parent.id = ?2 where bean.id = ?1")
	public int updateParentId(Integer id, Integer parentId);

	@Modifying
	@Query("update from Node bean set bean.treeMax = ?2 where bean.id = ?1")
	public int updateTreeMax(Integer id, String treeMax);

}
