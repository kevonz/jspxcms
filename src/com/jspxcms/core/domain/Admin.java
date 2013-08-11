package com.jspxcms.core.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;

/**
 * Admin
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_admin")
public class Admin implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	@Transient
	public Set<String> getPerms(Integer siteId) {
		Set<Role> roles = getRoles();
		boolean isAllPerm = false;
		Set<String> set = new HashSet<String>();
		String perms;
		for (Role role : roles) {
			if (role.getAllPerm(siteId)) {
				isAllPerm = true;
				break;
			} else {
				perms = role.getPerms(siteId);
				if (StringUtils.isNotBlank(perms)) {
					for (String perm : StringUtils.split(perms, ',')) {
						set.add(perm);
					}
				}
			}
		}
		if (isAllPerm) {
			set.clear();
			set.add("*");
		}
		return set;
	}

	@Transient
	public String getUsername() {
		User user = getUser();
		return user != null ? user.getUsername() : null;
	}

	@Transient
	public String getRealName() {
		User user = getUser();
		return user != null ? user.getRealName() : null;
	}

	@Transient
	public String getEmail() {
		User user = getUser();
		return user != null ? user.getEmail() : null;
	}

	@Transient
	public String getMobile() {
		User user = getUser();
		return user != null ? user.getMobile() : null;
	}

	@Transient
	public Date getCreationDate() {
		User user = getUser();
		return user != null ? user.getCreationDate() : null;
	}

	@Transient
	public String getCreationIp() {
		User user = getUser();
		return user != null ? user.getCreationIp() : null;
	}

	@Transient
	public Date getLastLoginDate() {
		User user = getUser();
		return user != null ? user.getLastLoginDate() : null;
	}

	@Transient
	public String getLastLoginIp() {
		User user = getUser();
		return user != null ? user.getLastLoginIp() : null;
	}

	@Transient
	public Date getPrevLoginDate() {
		User user = getUser();
		return user != null ? user.getPrevLoginDate() : null;
	}

	@Transient
	public String getPrevLoginIp() {
		User user = getUser();
		return user != null ? user.getPrevLoginIp() : null;
	}

	@Transient
	public Integer getLogins() {
		User user = getUser();
		return user != null ? user.getLogins() : null;
	}

	@Transient
	public Integer getStatus() {
		User user = getUser();
		return user != null ? user.getStatus() : null;
	}

	public void applyDefaultValue() {
		if (getRank() == null) {
			setRank(1);
		}
	}

	private Integer id;
	private User user;
	private Set<Role> roles;

	private Integer rank;

	@Id
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@MapsId
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_admin_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_admin_role", joinColumns = @JoinColumn(name = "f_admin_id"), inverseJoinColumns = @JoinColumn(name = "f_role_id"))
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@Column(name = "f_rank", nullable = false)
	public Integer getRank() {
		return this.rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}

}
