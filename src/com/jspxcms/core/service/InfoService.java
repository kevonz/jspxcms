package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import com.jspxcms.core.domain.Info;
import com.jspxcms.core.domain.InfoDetail;
import com.jspxcms.core.domain.InfoFile;
import com.jspxcms.core.domain.InfoImage;

/**
 * InfoService
 * 
 * @author liufang
 * 
 */
public interface InfoService {
	public Info save(Info bean, InfoDetail detail, Integer[] nodeIds,
			Integer[] specialIds, Map<String, String> customs,
			Map<String, String> clobs, List<InfoImage> images,
			List<InfoFile> files, Integer[] attrIds,
			Map<String, String> attrImages, String[] tagNames, Integer nodeId,
			Integer creatorId, Integer siteId);

	public Info update(Info bean, InfoDetail detail, Integer[] nodeIds,
			Integer[] specialIds, Map<String, String> customs,
			Map<String, String> clobs, List<InfoImage> images,
			List<InfoFile> files, Integer[] attrIds,
			Map<String, String> attrImages, String[] tagNames, Integer nodeId);

	public Info delete(Integer id);

	public Info[] delete(Integer[] ids);
}
