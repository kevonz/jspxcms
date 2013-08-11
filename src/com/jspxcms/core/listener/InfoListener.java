package com.jspxcms.core.listener;

import com.jspxcms.core.domain.Info;

/**
 * InfoListener
 * 
 * @author liufang
 * 
 */
public interface InfoListener {
	public void postSave(Info[] beans);

	public void postUpdate(Info[] beans);

	public void preDelete(Integer[] ids);

	public void postDelete(Info[] beans);
}
