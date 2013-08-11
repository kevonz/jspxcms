package com.jspxcms.core.service;

import java.util.Map;
import java.util.Set;

import com.jspxcms.core.domain.Info;
import com.jspxcms.core.domain.InfoAttribute;

/**
 * InfoAttributeService
 * 
 * @author liufang
 * 
 */
public interface InfoAttributeService {
	public InfoAttribute get(Integer id);

	public InfoAttribute save(InfoAttribute bean);

	public Set<InfoAttribute> save(Info info, Integer[] attrIds,
			Map<String, String> attrImages);

	public InfoAttribute update(InfoAttribute bean);

	public Set<InfoAttribute> update(Info info, Integer[] attrIds,
			Map<String, String> attrImages);

	public InfoAttribute delete(Integer id);

	public InfoAttribute[] delete(Integer[] ids);
}
