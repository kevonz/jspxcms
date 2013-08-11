package com.jspxcms.core.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * ScoreItem
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_scoreitem")
public class ScoreItem implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public void applyDefaultValue() {
	}

	private Integer id;
	private Site site;
	private ScoreGroup group;

	private String name;
	private String icon;
	private Integer seq;

	@Id
	@Column(name = "f_scoreitem_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_scoreitem", pkColumnValue = "cms_scoreitem", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_scoreitem")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_scoregroup_id", nullable = false)
	public ScoreGroup getGroup() {
		return this.group;
	}

	public void setGroup(ScoreGroup group) {
		this.group = group;
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

	@Column(name = "f_icon")
	public String getIcon() {
		return this.icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@Column(name = "f_seq", nullable = false)
	public Integer getSeq() {
		return this.seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}
}
