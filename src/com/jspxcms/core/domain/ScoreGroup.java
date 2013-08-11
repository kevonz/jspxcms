package com.jspxcms.core.domain;

import java.util.Set;

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

/**
 * ScoreGroup
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_scoregroup")
public class ScoreGroup implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public void applyDefaultValue() {
	}

	private Integer id;
	private Site site;

	private String name;
	private String description;
	private Integer seq;
	private Set<ScoreItem> items;

	@Id
	@Column(name = "f_scoregroup_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_scoregroup", pkColumnValue = "cms_scoregroup", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_scoregroup")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_site_id", nullable = false)
	public Site getSite() {
		return this.site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	@Column(name = "f_name", nullable = false, length = 150)
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "group")
	public Set<ScoreItem> getItems() {
		return this.items;
	}

	public void setItems(Set<ScoreItem> items) {
		this.items = items;
	}

}
