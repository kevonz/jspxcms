package com.jspxcms.core.listener;

import com.jspxcms.core.domain.Node;

/**
 * NodeListener
 * 
 * @author liufang
 * 
 */
public interface NodeListener {
	public void postSave(Node[] beans);

	public void postUpdate(Node[] beans);

	public void preDelete(Integer[] ids);

	public void postDelete(Node[] beans);
}
