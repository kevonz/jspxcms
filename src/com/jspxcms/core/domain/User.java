package com.jspxcms.core.domain;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.CollectionUtils;

import com.jspxcms.common.util.Encodes;

/**
 * User
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_user", uniqueConstraints = @UniqueConstraint(columnNames = "f_username"))
public class User implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	/**
	 * 正常
	 */
	public static final int NORMAL = 0;
	/**
	 * 禁用
	 */
	public static final int DISABLED = 1;

	@Transient
	public Set<String> getPerms(Integer siteId) {
		Admin admin = getAdmin();
		return admin != null ? admin.getPerms(siteId) : null;
	}

	@Transient
	public byte[] getSaltBytes() {
		String salt = getSalt();
		if (StringUtils.isNotBlank(salt)) {
			return Encodes.decodeHex(salt);
		} else {
			return null;
		}
	}

	@Transient
	public void setSaltBytes(byte[] saltBytes) {
		if (ArrayUtils.isNotEmpty(saltBytes)) {
			setSalt(Encodes.encodeHex(saltBytes));
		} else {
			setSalt(null);
		}
	}

	@Transient
	public Admin getAdmin() {
		Set<Admin> set = getAdmins();
		if (!CollectionUtils.isEmpty(set)) {
			return set.iterator().next();
		} else {
			return null;
		}
	}

	@Transient
	public void setAdmin(Admin admin) {
		Set<Admin> set = getAdmins();
		if (CollectionUtils.isEmpty(set)) {
			set = new HashSet<Admin>(1);
			setAdmins(set);
		}
		set.add(admin);
	}

	@Transient
	public Member getMember() {
		Set<Member> set = getMembers();
		if (!CollectionUtils.isEmpty(set)) {
			return set.iterator().next();
		} else {
			return null;
		}
	}

	@Transient
	public void setMember(Member member) {
		Set<Member> set = getMembers();
		if (CollectionUtils.isEmpty(set)) {
			set = new HashSet<Member>(1);
			setMembers(set);
		}
		set.add(member);
	}

	@Transient
	public void applyDefaultValue() {
		if (getCreationDate() == null) {
			setCreationDate(new Timestamp(System.currentTimeMillis()));
		}
		if (getLogins() == null) {
			setLogins(0);
		}
		if (getStatus() == null) {
			setStatus(NORMAL);
		}
	}

	private Integer id;
	private Set<Org> orgs;
	private Set<Admin> admins;

	private Set<Member> members;
	private Org org;

	private String username;
	private String password;
	private String salt;
	private String email;
	private String realName;
	private String mobile;
	private Date prevLoginDate;
	private String prevLoginIp;
	private Date lastLoginDate;
	private String lastLoginIp;
	private Date creationDate;
	private String creationIp;
	private Integer logins;
	private Integer status;

	private String rawPassword;

	@Id
	@Column(name = "f_user_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_user", pkColumnValue = "cms_user", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_user")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_user_org", joinColumns = { @JoinColumn(name = "f_user_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "f_org_id", nullable = false, updatable = false) })
	public Set<Org> getOrgs() {
		return this.orgs;
	}

	public void setOrgs(Set<Org> orgs) {
		this.orgs = orgs;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REMOVE }, mappedBy = "user")
	public Set<Admin> getAdmins() {
		return admins;
	}

	public void setAdmins(Set<Admin> admins) {
		this.admins = admins;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REMOVE }, mappedBy = "user")
	public Set<Member> getMembers() {
		return members;
	}

	public void setMembers(Set<Member> members) {
		this.members = members;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_org_id", nullable = false)
	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	@Column(name = "f_username", unique = true, nullable = false, length = 50)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "f_password", length = 128)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "f_salt", length = 32)
	public String getSalt() {
		return this.salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	@Column(name = "f_email", length = 100)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "f_real_name", length = 100)
	public String getRealName() {
		return this.realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	@Column(name = "f_mobile", length = 100)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "f_prev_login_date", length = 19)
	public Date getPrevLoginDate() {
		return this.prevLoginDate;
	}

	public void setPrevLoginDate(Date prevLoginDate) {
		this.prevLoginDate = prevLoginDate;
	}

	@Column(name = "f_prev_login_ip", length = 100)
	public String getPrevLoginIp() {
		return this.prevLoginIp;
	}

	public void setPrevLoginIp(String prevLoginIp) {
		this.prevLoginIp = prevLoginIp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "f_last_login_date", length = 19)
	public Date getLastLoginDate() {
		return this.lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	@Column(name = "f_last_login_ip", length = 100)
	public String getLastLoginIp() {
		return this.lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "f_creation_date", nullable = false, length = 19)
	public Date getCreationDate() {
		return this.creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	@Column(name = "f_creation_ip", length = 100)
	public String getCreationIp() {
		return this.creationIp;
	}

	public void setCreationIp(String creationIp) {
		this.creationIp = creationIp;
	}

	@Column(name = "f_logins", nullable = false)
	public Integer getLogins() {
		return this.logins;
	}

	public void setLogins(Integer logins) {
		this.logins = logins;
	}

	@Column(name = "f_status", nullable = false)
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Transient
	public String getRawPassword() {
		return rawPassword;
	}

	public void setRawPassword(String rawPassword) {
		this.rawPassword = rawPassword;
	}
}
