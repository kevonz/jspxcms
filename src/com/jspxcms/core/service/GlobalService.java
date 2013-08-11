package com.jspxcms.core.service;

import java.util.Map;

import com.jspxcms.core.domain.Global;

/**
 * GlobalService
 * 
 * @author liufang
 * 
 */
public interface GlobalService {
	public Global findUnique();

	public Global update(Global bean, Map<String, String> sysCustoms);
}
