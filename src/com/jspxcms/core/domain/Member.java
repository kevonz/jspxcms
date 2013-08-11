package com.jspxcms.core.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Member
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_member")
public class Member implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

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
	public String getMobile() {
		User user = getUser();
		return user != null ? user.getMobile() : null;
	}

	public void applyDefaultValue() {
	}

	private Integer id;
	private User user;
	private MemberGroup memberGroup;
	private String avatar;
	private String selfIntro;
	private String comeFrom;
	private Boolean gender;
	private Integer status;

	@Id
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@MapsId
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_member_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_membergroup_id", nullable = false)
	public MemberGroup getMemberGroup() {
		return this.memberGroup;
	}

	public void setMemberGroup(MemberGroup memberGroup) {
		this.memberGroup = memberGroup;
	}

	@Column(name = "f_avatar")
	public String getAvatar() {
		return this.avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	@Column(name = "f_self_intro")
	public String getSelfIntro() {
		return this.selfIntro;
	}

	public void setSelfIntro(String selfIntro) {
		this.selfIntro = selfIntro;
	}

	@Column(name = "f_come_from", length = 100)
	public String getComeFrom() {
		return this.comeFrom;
	}

	public void setComeFrom(String comeFrom) {
		this.comeFrom = comeFrom;
	}

	@Column(name = "f_gender", length = 1)
	public Boolean getGender() {
		return this.gender;
	}

	public void setGender(Boolean gender) {
		this.gender = gender;
	}

	@Column(name = "f_status", nullable = false)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
