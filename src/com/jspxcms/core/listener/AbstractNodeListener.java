package com.jspxcms.core.listener;

import com.jspxcms.core.domain.Node;

/**
 * AbstractNodeListener
 * 
 * @author liufang
 * 
 */
public abstract class AbstractNodeListener implements NodeListener {
	public void postSave(Node[] beans) {
	}

	public void postUpdate(Node[] beans) {
	}

	public void preDelete(Integer[] ids) {
	}

	public void postDelete(Node[] beans) {
	}
}
