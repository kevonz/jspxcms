package com.jspxcms.core.support;

import java.util.ArrayList;
import java.util.List;

/**
 * ForeUtils
 * 
 * @author liufang
 * 
 */
public class Response {
	public Integer status;
	public List<String> messages = new ArrayList<String>();

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public List<String> getMessages() {
		return messages;
	}

	public void setMessages(List<String> messages) {
		this.messages = messages;
	}
}
