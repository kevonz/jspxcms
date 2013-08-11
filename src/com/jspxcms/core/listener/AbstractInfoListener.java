package com.jspxcms.core.listener;

import com.jspxcms.core.domain.Info;

/**
 * AbstractInfoListener
 * 
 * @author liufang
 * 
 */
public abstract class AbstractInfoListener implements InfoListener {
	public void postSave(Info[] beans) {
	}

	public void postUpdate(Info[] beans) {
	}

	public void preDelete(Integer[] ids) {
	}

	public void postDelete(Info[] beans) {
	}
}
