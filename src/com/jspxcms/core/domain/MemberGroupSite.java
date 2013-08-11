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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * MemberGroupSite
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_membergroup_site")
public class MemberGroupSite implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public void applyDefaultValue() {
	}

	private Integer id;
	private Set<Node> viewRights;
	private Set<Node> contriRights;
	private MemberGroup memberGroup;
	private Site site;

	private Boolean allView;
	private Boolean allContri;
	private Boolean allExemption;

	@Id
	@Column(name = "f_memgroupsite_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_membergroup_site", pkColumnValue = "cms_membergroup_site", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_membergroup_site")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_memgroupnode_view", joinColumns = @JoinColumn(name = "f_memgroupsite_id"), inverseJoinColumns = @JoinColumn(name = "f_node_id"))
	public Set<Node> getViewRights() {
		return viewRights;
	}

	public void setViewRights(Set<Node> viewRights) {
		this.viewRights = viewRights;
	}

	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_memgroupnode_contri", joinColumns = @JoinColumn(name = "f_memgroupsite_id"), inverseJoinColumns = @JoinColumn(name = "f_node_id"))
	public Set<Node> getContriRights() {
		return contriRights;
	}

	public void setContriRights(Set<Node> contriRights) {
		this.contriRights = contriRights;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_membergroup_id", nullable = false)
	public MemberGroup getMemberGroup() {
		return this.memberGroup;
	}

	public void setMemberGroup(MemberGroup memberGroup) {
		this.memberGroup = memberGroup;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_site_id", nullable = false)
	public Site getSite() {
		return this.site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	@Column(name = "f_is_all_view", nullable = false, length = 1)
	public Boolean getAllView() {
		return this.allView;
	}

	public void setAllView(Boolean allView) {
		this.allView = allView;
	}

	@Column(name = "f_is_all_contri", nullable = false, length = 1)
	public Boolean getAllContri() {
		return this.allContri;
	}

	public void setAllContri(Boolean allContri) {
		this.allContri = allContri;
	}

	@Column(name = "f_is_all_exemption", nullable = false, length = 1)
	public Boolean getAllExemption() {
		return this.allExemption;
	}

	public void setAllExemption(Boolean allExemption) {
		this.allExemption = allExemption;
	}

}
