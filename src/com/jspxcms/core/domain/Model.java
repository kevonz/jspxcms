package com.jspxcms.core.domain;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapKeyColumn;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Transient;

import org.apache.commons.lang3.math.NumberUtils;

/**
 * Model
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_model")
public class Model implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	public static final int NODE_HOME = 1;
	public static final int NODE = 2;
	public static final int INFO = 3;
	public static final int SPECIAL = 4;

	public static final String DEF_HOME = "index.html";
	public static final String DEF_COVER = "cover.html";
	public static final String DEF_LIST = "list.html";
	public static final String DEF_INFO = "info.html";

	public static final String COVER_TEMPLATE = "coverTemplate";
	public static final String LIST_TEMPLATE = "listTemplate";
	public static final String TEMPLATE = "template";

	public static final String GENERATE_NODE = "generateNode";
	public static final String GENERATE_INFO = "generateInfo";
	public static final String NODE_PATH = "nodePath";
	public static final String INFO_PATH = "infoPath";
	public static final String NODE_EXTENSION = "nodeExtension";
	public static final String INFO_EXTENSION = "infoExtension";
	public static final String DEF_PAGE = "defPage";
	public static final String STATIC_METHOD = "staticMethod";
	public static final String STATIC_PAGE = "staticPage";

	@Transient
	public String getCoverTemplate() {
		Map<String, String> customs = getCustoms();
		return customs != null ? customs.get(COVER_TEMPLATE) : null;
	}

	@Transient
	public String getListTemplate() {
		Map<String, String> customs = getCustoms();
		return customs != null ? customs.get(LIST_TEMPLATE) : null;
	}

	@Transient
	public String getTemplate() {
		Map<String, String> customs = getCustoms();
		return customs != null ? customs.get(TEMPLATE) : null;
	}

	@Transient
	public boolean getGenerateNode() {
		Map<String, String> customs = getCustoms();
		String value = customs != null ? customs.get(GENERATE_NODE) : null;
		return value != null ? Boolean.valueOf(value) : false;
	}

	@Transient
	public boolean getGenerateInfo() {
		Map<String, String> customs = getCustoms();
		String value = customs != null ? customs.get(GENERATE_INFO) : null;
		return value != null ? Boolean.valueOf(value) : false;
	}

	@Transient
	public String getNodePath() {
		Map<String, String> customs = getCustoms();
		return customs != null ? customs.get(NODE_PATH) : null;
	}

	@Transient
	public String getInfoPath() {
		Map<String, String> customs = getCustoms();
		return customs != null ? customs.get(INFO_PATH) : null;
	}

	@Transient
	public String getNodeExtension() {
		Map<String, String> customs = getCustoms();
		return customs != null ? customs.get(NODE_EXTENSION) : null;
	}

	@Transient
	public String getInfoExtension() {
		Map<String, String> customs = getCustoms();
		return customs != null ? customs.get(INFO_EXTENSION) : null;
	}

	@Transient
	public boolean getDefPage() {
		Map<String, String> customs = getCustoms();
		String value = customs != null ? customs.get(DEF_PAGE) : null;
		return value != null ? Boolean.valueOf(value) : false;
	}

	@Transient
	public int getStaticMethod() {
		Map<String, String> customs = getCustoms();
		String value = customs != null ? customs.get(STATIC_METHOD) : null;
		return NumberUtils.toInt(value, Node.STATIC_INFO_NODE_PARENT);
	}

	@Transient
	public int getStaticPage() {
		Map<String, String> customs = getCustoms();
		String value = customs != null ? customs.get(STATIC_PAGE) : null;
		return NumberUtils.toInt(value, 1);
	}

	@Transient
	public Set<String> getPredefinedNames() {
		Set<String> names = new HashSet<String>();
		for (ModelField field : getFields()) {
			if (field.isPredefined()) {
				names.add(field.getName());
			}
		}
		return names;
	}

	@Transient
	public ModelField getField(String name) {
		for (ModelField field : getFields()) {
			if (field.getName().equals(name)) {
				return field;
			}
		}
		return null;
	}

	public void addField(ModelField field) {
		List<ModelField> fields = getFields();
		if (fields == null) {
			fields = new ArrayList<ModelField>();
			setFields(fields);
		}
		fields.add(field);
	}

	public void applyDefaultValue() {
		if (getSeq() == null) {
			setSeq(Integer.MAX_VALUE);
		}
	}

	private Integer id;
	private List<ModelField> fields;
	private Map<String, String> customs;
	private Site site;
	private Integer type;
	private String name;
	private Integer seq;

	public Model() {
	}

	public Model(Integer id, Site site, Integer type, String name) {
		this.id = id;
		this.site = site;
		this.type = type;
		this.name = name;
	}

	@Id
	@Column(name = "f_model_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_model", pkColumnValue = "cms_model", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_model")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REMOVE }, mappedBy = "model")
	@OrderBy(value = "seq asc, id asc")
	public List<ModelField> getFields() {
		return this.fields;
	}

	public void setFields(List<ModelField> fields) {
		this.fields = fields;
	}

	@ElementCollection
	@CollectionTable(name = "cms_model_custom", joinColumns = @JoinColumn(name = "f_model_id"))
	@MapKeyColumn(name = "f_key", length = 50)
	@Column(name = "f_value", length = 2000)
	public Map<String, String> getCustoms() {
		return this.customs;
	}

	public void setCustoms(Map<String, String> customs) {
		this.customs = customs;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_site_id", nullable = false)
	public Site getSite() {
		return site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	@Column(name = "f_type", nullable = false)
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@Column(name = "f_name", nullable = false, length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "f_seq", nullable = false)
	public Integer getSeq() {
		return this.seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

}
