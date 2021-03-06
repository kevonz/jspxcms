package com.jspxcms.core.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Transient;

/**
 * Role
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_role")
public class Role implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	@Transient
	public RoleSite getRoleSite(Integer siteId) {
		Set<RoleSite> rss = getRoleSites();
		for (RoleSite rs : rss) {
			if (rs.getSite().getId().equals(siteId)) {
				return rs;
			}
		}
		return null;
	}

	@Transient
	public String getPerms(Integer siteId) {
		RoleSite rs = getRoleSite(siteId);
		return rs != null ? rs.getPerms() : null;
	}

	@Transient
	public Boolean getAllPerm(Integer siteId) {
		RoleSite rs = getRoleSite(siteId);
		return rs != null ? rs.getAllPerm() : null;
	}

	@Transient
	public void applyDefaultValue() {
		if (getSeq() == null) {
			setSeq(Integer.MAX_VALUE);
		}
	}

	private Integer id;
	private Set<RoleSite> roleSites;
	private Site site;

	private String name;
	private String description;
	private Integer seq;

	@Id
	@Column(name = "f_role_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_role", pkColumnValue = "cms_role", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_role")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REMOVE }, mappedBy = "role")
	public Set<RoleSite> getRoleSites() {
		return this.roleSites;
	}

	public void setRoleSites(Set<RoleSite> roleSites) {
		this.roleSites = roleSites;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_site_id", nullable = false)
	public Site getSite() {
		return this.site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	@Column(name = "f_name", nullable = false, length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "f_description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "f_seq", nullable = false)
	public Integer getSeq() {
		return this.seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}
}
