package com.jspxcms.core.domain;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Transient;

/**
 * RoleSite
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_role_site")
public class RoleSite implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	/**
	 * 所有信息权限
	 */
	public static final int INFO_RIGHT_ALL = 1;
	/**
	 * 组织信息权限
	 */
	public static final int INFO_RIGHT_ORG = 2;
	/**
	 * 自身信息权限
	 */
	public static final int INFO_RIGHT_SELF = 3;

	@Transient
	public void applyDefaultValue() {
		if (getAllPerm() == null) {
			setAllPerm(true);
		}
		if (getAllInfo() == null) {
			setAllInfo(true);
		}
		if (getAllNode() == null) {
			setAllNode(true);
		}
		if (getInfoRightType() == null) {
			setInfoRightType(INFO_RIGHT_ALL);
		}
	}

	private Integer id;
	private String perms;
	private Set<Node> nodeRights;
	private Set<Node> infoRights;
	private Role role;
	private Site site;

	private Boolean allPerm;
	private Boolean allNode;
	private Boolean allInfo;
	private Integer infoRightType;

	@Id
	@Column(name = "f_rolesite_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_role_site", pkColumnValue = "cms_role_site", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_role_site")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_rolenode_node", joinColumns = @JoinColumn(name = "f_rolesite_id"), inverseJoinColumns = @JoinColumn(name = "f_node_id"))
	public Set<Node> getNodeRights() {
		return nodeRights;
	}

	public void setNodeRights(Set<Node> nodeRights) {
		this.nodeRights = nodeRights;
	}

	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_rolenode_info", joinColumns = @JoinColumn(name = "f_rolesite_id"), inverseJoinColumns = @JoinColumn(name = "f_node_id"))
	public Set<Node> getInfoRights() {
		return infoRights;
	}

	public void setInfoRights(Set<Node> infoRights) {
		this.infoRights = infoRights;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_role_id", nullable = false)
	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_site_id", nullable = false)
	public Site getSite() {
		return this.site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	@Lob
	@Column(name = "f_perms")
	public String getPerms() {
		return perms;
	}

	public void setPerms(String perms) {
		this.perms = perms;
	}

	@Column(name = "f_is_all_perm", nullable = false, length = 1)
	public Boolean getAllPerm() {
		return allPerm;
	}

	public void setAllPerm(Boolean allPerm) {
		this.allPerm = allPerm;
	}

	@Column(name = "f_is_all_node", nullable = false, length = 1)
	public Boolean getAllNode() {
		return this.allNode;
	}

	public void setAllNode(Boolean allNode) {
		this.allNode = allNode;
	}

	@Column(name = "f_is_all_info", nullable = false, length = 1)
	public Boolean getAllInfo() {
		return this.allInfo;
	}

	public void setAllInfo(Boolean allInfo) {
		this.allInfo = allInfo;
	}

	@Column(name = "f_info_right_type", nullable = false)
	public Integer getInfoRightType() {
		return this.infoRightType;
	}

	public void setInfoRightType(Integer infoRightType) {
		this.infoRightType = infoRightType;
	}

}
