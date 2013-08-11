package com.jspxcms.core.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Lob;

/**
 * InfoImage
 * 
 * @author liufang
 * 
 */
@Embeddable
public class InfoImage implements Serializable {
	private static final long serialVersionUID = 1L;

	private String name;
	private String url;
	private String text;

	@Column(name = "f_name", length = 150)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "f_url", nullable = false)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Lob
	@Column(name = "f_text")
	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

}
