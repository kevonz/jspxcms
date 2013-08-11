package com.jspxcms.core.domain;

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * WorkflowProcess
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_workflow_process")
public class WorkflowProcess implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public void applyDefaultValue() {
	}

	private Integer id;
	private Set<WorkflowLog> logs;
	private Set<User> users;
	private Workflow workflow;
	private User user;

	private Integer dataId;
	private Date startDate;
	private Date endDate;
	private Integer step;
	private Boolean end;

	@Id
	@Column(name = "f_workflowprocess_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_workflow_process", pkColumnValue = "cms_workflow_process", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_workflow_process")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "process")
	public Set<WorkflowLog> getLogs() {
		return this.logs;
	}

	public void setLogs(Set<WorkflowLog> logs) {
		this.logs = logs;
	}

	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_workflowproc_user", joinColumns = @JoinColumn(name = "f_workflowprocess_id"), inverseJoinColumns = @JoinColumn(name = "f_user_id"))
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_workflow_id", nullable = false)
	public Workflow getWorkflow() {
		return this.workflow;
	}

	public void setWorkflow(Workflow workflow) {
		this.workflow = workflow;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_user_id", nullable = false)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "f_data_id", nullable = false)
	public Integer getDataId() {
		return this.dataId;
	}

	public void setDataId(Integer dataId) {
		this.dataId = dataId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "f_start_date", nullable = false, length = 19)
	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "f_end_date", length = 19)
	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Column(name = "f_step", nullable = false)
	public Integer getStep() {
		return this.step;
	}

	public void setStep(Integer step) {
		this.step = step;
	}

	@Column(name = "f_is_end", nullable = false, length = 1)
	public Boolean getEnd() {
		return this.end;
	}

	public void setEnd(Boolean end) {
		this.end = end;
	}
}
