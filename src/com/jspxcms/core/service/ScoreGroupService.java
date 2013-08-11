package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort;

import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.ScoreGroup;

/**
 * ScoreGroupService
 * 
 * @author liufang
 * 
 */
public interface ScoreGroupService {
	public List<ScoreGroup> findList(Map<String, String[]> params, Sort sort);

	public RowSide<ScoreGroup> findSide(Map<String, String[]> params,
			ScoreGroup bean, Integer position, Sort sort);

	public ScoreGroup get(Integer id);

	public ScoreGroup save(ScoreGroup bean, Integer siteId);

	public ScoreGroup update(ScoreGroup bean);

	public ScoreGroup delete(Integer id);

	public ScoreGroup[] delete(Integer[] ids);
}
