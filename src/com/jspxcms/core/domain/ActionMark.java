package com.jspxcms.core.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * ActionMark
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_action_mark")
public class ActionMark implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public void applyDefaultValue() {
	}

	private Integer id;
	private String ftype;
	private Integer fid;
	private String mark;
	private Boolean userid;

	@Id
	@Column(name = "f_actionmark_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_action_mark", pkColumnValue = "cms_action_mark", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_action_mark")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "f_ftype", nullable = false, length = 20)
	public String getFtype() {
		return this.ftype;
	}

	public void setFtype(String ftype) {
		this.ftype = ftype;
	}

	@Column(name = "f_fid", nullable = false)
	public Integer getFid() {
		return this.fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	@Column(name = "f_mark", nullable = false, length = 50)
	public String getMark() {
		return this.mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	@Column(name = "f_is_userid", nullable = false, length = 1)
	public Boolean getUserid() {
		return this.userid;
	}

	public void setUserid(Boolean userid) {
		this.userid = userid;
	}

}
