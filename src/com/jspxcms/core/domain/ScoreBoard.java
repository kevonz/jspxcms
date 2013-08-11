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
 * ScoreBoard
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_scoreboard")
public class ScoreBoard implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public void applyDefaultValue() {
	}

	private Integer id;
	private Set<User> users;
	private ScoreItem item;

	private String ftype;
	private Integer fid;
	private Integer score;

	@Id
	@Column(name = "f_scoreboard_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_scoreboard", pkColumnValue = "cms_scoreboard", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_scoreboard")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "cms_scoreboard_scoreuser", joinColumns = @JoinColumn(name = "f_scoreboard_id"), inverseJoinColumns = @JoinColumn(name = "f_user_id"))
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_scoreitem_id", nullable = false)
	public ScoreItem getItem() {
		return this.item;
	}

	public void setItem(ScoreItem item) {
		this.item = item;
	}

	@Column(name = "f_ftype", nullable = false, length = 4)
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

	@Column(name = "f_score", nullable = false)
	public Integer getScore() {
		return this.score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

}
