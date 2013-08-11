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
 * Workflow
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_workflow")
public class Workflow implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public void applyDefaultValue() {
	}

	private Integer id;
	private Set<WorkflowStep> steps;
	private WorkflowGroup group;
	private Site site;

	private String name;
	private String description;
	private Integer seq;
	private Integer status;

	@Id
	@Column(name = "f_workflow_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_workflow", pkColumnValue = "cms_workflow", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_workflow")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "workflow")
	public Set<WorkflowStep> getSteps() {
		return this.steps;
	}

	public void setSteps(Set<WorkflowStep> steps) {
		this.steps = steps;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_workflowgroup_id", nullable = false)
	public WorkflowGroup getGroup() {
		return this.group;
	}

	public void setGroup(WorkflowGroup group) {
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

	@Column(name = "f_status", nullable = false)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
