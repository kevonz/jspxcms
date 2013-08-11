package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort;

import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Org;

/**
 * OrgService
 * 
 * @author liufang
 * 
 */
public interface OrgService {
	public List<Org> findList(Map<String, String[]> params, Sort sort);

	public RowSide<Org> findSide(Map<String, String[]> params, Org bean,
			Integer position, Sort sort);

	public Org get(Integer id);

	public Org save(Org bean);

	public Org update(Org bean);

	public Org delete(Integer id);

	public Org[] delete(Integer[] ids);
}
