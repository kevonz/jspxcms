package com.jspxcms.core.domain;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapKeyColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Global
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_global")
public class Global implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	public static final String LINK_ALLOWED_EXTENSIONS = "sys_linkAllowedExtensions";
	public static final String LINK_DENIED_EXTENSIONS = "sys_linkDeniedExtensions";
	public static final String IMAGE_ALLOWED_EXTENSIONS = "sys_imageAllowedExtensions";
	public static final String IMAGE_DENIED_EXTENSIONS = "sys_imageDeniedExtensions";
	public static final String FLASH_ALLOWED_EXTENSIONS = "sys_flashAllowedExtensions";
	public static final String FLASH_DENIED_EXTENSIONS = "sys_flashDeniedExtensions";
	public static final String VIDEO_ALLOWED_EXTENSIONS = "sys_videoAllowedExtensions";
	public static final String VIDEO_DENIED_EXTENSIONS = "sys_videoDeniedExtensions";

	@Transient
	public String getLinkAllowedExtendsions() {
		return getCustoms().get(LINK_ALLOWED_EXTENSIONS);
	}

	@Transient
	public String getLinkDeniedExtendsions() {
		return getCustoms().get(LINK_DENIED_EXTENSIONS);
	}

	@Transient
	public String getImageAllowedExtendsions() {
		return getCustoms().get(IMAGE_ALLOWED_EXTENSIONS);
	}

	@Transient
	public String getImageDeniedExtendsions() {
		return getCustoms().get(IMAGE_DENIED_EXTENSIONS);
	}

	@Transient
	public String getFlashAllowedExtendsions() {
		return getCustoms().get(FLASH_ALLOWED_EXTENSIONS);
	}

	@Transient
	public String getFlashDeniedExtendsions() {
		return getCustoms().get(FLASH_DENIED_EXTENSIONS);
	}

	@Transient
	public String getVideoAllowedExtendsions() {
		return getCustoms().get(VIDEO_ALLOWED_EXTENSIONS);
	}

	@Transient
	public String getVideoDeniedExtendsions() {
		return getCustoms().get(VIDEO_DENIED_EXTENSIONS);
	}

	private Integer id;
	private Integer port;
	private String contextPath;
	private String version;

	private Map<String, String> customs = new HashMap<String, String>(0);

	@Id
	@Column(name = "f_global_id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ElementCollection
	@CollectionTable(name = "cms_global_custom", joinColumns = @JoinColumn(name = "f_global_id"))
	@MapKeyColumn(name = "f_key", length = 50)
	@Column(name = "f_value", length = 2000)
	public Map<String, String> getCustoms() {
		return this.customs;
	}

	public void setCustoms(Map<String, String> customs) {
		this.customs = customs;
	}

	@Column(name = "f_port")
	public Integer getPort() {
		return this.port;
	}

	public void setPort(Integer port) {
		this.port = port;
	}

	@Column(name = "f_context_path")
	public String getContextPath() {
		return this.contextPath;
	}

	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}

	@Column(name = "f_version", nullable = false, length = 50)
	public String getVersion() {
		return this.version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
}
