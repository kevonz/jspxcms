package com.jspxcms.core.domain;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.MapKeyColumn;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.CollectionUtils;

import com.jspxcms.common.web.Anchor;
import com.jspxcms.common.web.PageUrlResolver;
import com.jspxcms.core.support.Constants;
import com.jspxcms.core.support.Siteable;

/**
 * Node
 * 
 * @author liufang
 * 
 */
@Entity
@Table(name = "cms_node")
public class Node implements java.io.Serializable, Anchor, Siteable,
		PageUrlResolver {
	private static final long serialVersionUID = 1L;
	/**
	 * 手动生成
	 */
	public static final int STATIC_MANUAL = 0;
	/**
	 * 自动生成信息页
	 */
	public static final int STATIC_INFO = 1;
	/**
	 * 自动生成信息页、节点页
	 */
	public static final int STATIC_INFO_NODE = 2;
	/**
	 * 自动生成信息页、节点页、父节点页、首页
	 */
	public static final int STATIC_INFO_NODE_PARENT = 3;

	/**
	 * 树编码长度
	 */
	public static int TREE_NUMBER_LENGTH = 4;
	/**
	 * 替换标识:节点ID
	 */
	public static String PATH_NODE_ID = "{node_id}";
	/**
	 * 替换标识:节点编码
	 */
	public static String PATH_NODE_NUMBER = "{node_number}";

	/**
	 * 节点正文KEY
	 */
	public static String NODE_TEXT = "text";

	@Transient
	public String getUrl() {
		return getUrl(1);
	}

	@Transient
	public String getUrl(Integer page) {
		return getGenerate() ? getUrlStatic(page) : getUrlDynamic(page);
	}

	@Transient
	public String getUrlDynamic() {
		return getUrlDynamic(1);
	}

	@Transient
	public String getUrlDynamicFull() {
		return getUrlDynamicFull(1);
	}

	@Transient
	public String getUrlDynamicFull(Integer page) {
		return getUrlDynamic(page, true);
	}

	@Transient
	public String getUrlDynamic(Integer page) {
		boolean isFull = getSite().getWithDomain();
		return getUrlDynamic(page, isFull);
	}

	@Transient
	public String getUrlDynamic(Integer page, boolean isFull) {
		String linkUrl = getLinkUrlWithContextPath();
		if (StringUtils.isNotBlank(linkUrl)) {
			return linkUrl;
		}
		StringBuilder sb = new StringBuilder();
		String ctx = getSite().getContextPath();
		if (StringUtils.isNotBlank(ctx)) {
			sb.append(ctx);
		}
		sb.append("/");
		// 首页直接使用根路径
		if (getParent() != null) {
			sb.append(Constants.NODE_PATH);
			sb.append("/").append(getId());
			if (page != null && page > 1) {
				sb.append("_").append(page);
			}
			sb.append(Constants.DYNAMIC_SUFFIX);
		}
		return sb.toString();
	}

	@Transient
	public String getUrlStatic() {
		return getUrlStatic(1);
	}

	@Transient
	public String getUrlStatic(Integer page) {
		boolean isFull = getSite().getWithDomain();
		return getUrlStatic(page, isFull, false);
	}

	@Transient
	public String getUrlStaticFull() {
		return getUrlStaticFull(1);
	}

	@Transient
	public String getUrlStaticFull(Integer page) {
		return getUrlStatic(page, true, false);
	}

	@Transient
	public String getUrlStatic(Integer page, boolean isFull, boolean forRealPath) {
		String linkUrl = getLinkUrlWithContextPath();
		if (StringUtils.isNotBlank(linkUrl)) {
			return linkUrl;
		}
		// 超过静态化页数，则为动态页。
		if (page != null && page > getStaticPageOrDef()) {
			return getUrlDynamic(page);
		}
		String path = getNodePathOrDef();
		path = StringUtils.replace(path, PATH_NODE_ID, getId().toString());
		String number = getNumber();
		if (StringUtils.isBlank(number)) {
			number = getId().toString();
		}
		path = StringUtils.replace(path, PATH_NODE_NUMBER, number);
		String extension = getNodeExtensionOrDef();
		if (page != null && page > 1) {
			if (StringUtils.isNotBlank(extension)) {
				path += "_" + page + extension;
			} else {
				path += "_" + page;
			}
		} else if (!forRealPath && getDefPageOrDef()) {
			path = path.substring(0, path.lastIndexOf("/") + 1);
		} else {
			if (StringUtils.isNotBlank(extension)) {
				path += extension;
			}
		}
		String ctx = getSite().getContextPath();
		if (!forRealPath && StringUtils.isNotBlank(ctx)) {
			path = ctx + path;
		}
		return path;
	}

	@Transient
	public String getPageUrl(Integer page) {
		return getUrl(page);
	}

	@Transient
	public String getLinkUrlWithContextPath() {
		String linkUrl = getLinkUrl();
		if (StringUtils.isNotBlank(linkUrl)) {
			if (linkUrl.startsWith("/")) {
				String ctx = getSite().getContextPath();
				if (StringUtils.isNotBlank(ctx)) {
					linkUrl = ctx + linkUrl;
				}
			}
		}
		return linkUrl;

	}

	@Transient
	public String getFullName() {
		StringBuilder sb = new StringBuilder();
		Node node = this;
		sb.append(node.getName());
		node = node.getParent();
		while (node != null) {
			sb.insert(0, " - ");
			sb.insert(0, node.getName());
			node = node.getParent();
		}
		return sb.toString();
	}

	@Transient
	public String getTemplate() {
		String tpl = getNodeTemplate();
		if (StringUtils.isBlank(tpl)) {
			Model model = getNodeModel();
			if (getParent() == null) {
				tpl = model.getTemplate();
			} else {
				if (CollectionUtils.isEmpty(getChildren())) {
					tpl = model.getListTemplate();
				} else {
					tpl = model.getCoverTemplate();
				}
			}
		}
		tpl = getSite().getTemplate(tpl);
		return tpl;
	}

	@Transient
	public String getInfoTemplateOrDef() {
		String tpl = getInfoTemplate();
		if (StringUtils.isBlank(tpl)) {
			Model model = getInfoModel();
			tpl = model.getTemplate();
		}
		tpl = getSite().getTemplate(tpl);
		return tpl;
	}

	@Transient
	public boolean getGenerate() {
		if (StringUtils.isNotBlank(getLinkUrl())) {
			return false;
		}
		return getGenerateNodeOrDef();
	}

	@Transient
	public boolean getGenerateNodeOrDef() {
		Boolean gen = getGenerateNode();
		return gen != null ? gen : getModel().getGenerateNode();
	}

	@Transient
	public boolean getGenerateInfoOrDef() {
		Boolean gen = getGenerateInfo();
		return gen != null ? gen : getModel().getGenerateInfo();
	}

	@Transient
	public String getNodePathOrDef() {
		return getNodePath() != null ? getNodePath() : getModel().getNodePath();
	}

	@Transient
	public String getInfoPathOrDef() {
		return getInfoPath() != null ? getInfoPath() : getModel().getInfoPath();
	}

	@Transient
	public String getNodeExtensionOrDef() {
		return getNodeExtension() != null ? getNodeExtension() : getModel()
				.getNodeExtension();
	}

	@Transient
	public String getInfoExtensionOrDef() {
		return getInfoExtension() != null ? getInfoExtension() : getModel()
				.getInfoExtension();
	}

	@Transient
	public int getStaticMethodOrDef() {
		return getStaticMethod() != null ? getStaticMethod() : getModel()
				.getStaticMethod();
	}

	@Transient
	public int getStaticPageOrDef() {
		return getStaticPage() != null ? getStaticPage() : getModel()
				.getStaticPage();
	}

	@Transient
	public boolean getDefPageOrDef() {
		return getDefPage() != null ? getDefPage() : getModel().getDefPage();
	}

	@Transient
	public String getTitle() {
		return getName();
	}

	@Transient
	public String getColor() {
		return null;
	}

	@Transient
	public Boolean getStrong() {
		return null;
	}

	@Transient
	public Boolean getEm() {
		return null;
	}

	@Transient
	public static String getTreeHex(long num) {
		BigInteger big = BigInteger.valueOf(num);
		String hex = big.toString(Character.MAX_RADIX);
		return StringUtils.leftPad(hex, TREE_NUMBER_LENGTH, '0');
	}

	@Transient
	public long getTreeMaxLong() {
		BigInteger big = new BigInteger(getTreeMax(), Character.MAX_RADIX);
		return big.longValue();
	}

	@Transient
	public Model getModel() {
		return getNodeModel();
	}

	@Transient
	public List<Node> getHierarchy() {
		List<Node> hierarchy = new LinkedList<Node>();
		Node node = this;
		while (node != null) {
			hierarchy.add(0, node);
			node = node.getParent();
		}
		return hierarchy;
	}

	@Transient
	public String getText() {
		Map<String, String> clobs = getClobs();
		return clobs != null ? clobs.get(NODE_TEXT) : null;
	}

	@Transient
	public void setText(String text) {
		Map<String, String> clobs = getClobs();
		if (clobs == null) {
			clobs = new HashMap<String, String>();
			setClobs(clobs);
		}
		clobs.put(NODE_TEXT, text);
	}

	@Transient
	public String getLinkUrl() {
		return getDetail() != null ? getDetail().getLinkUrl() : null;
	}

	@Transient
	public String getMetaKeywords() {
		return getDetail() != null ? getDetail().getMetaKeywords() : null;
	}

	@Transient
	public String getMetaDescription() {
		return getDetail() != null ? getDetail().getMetaDescription() : null;
	}

	@Transient
	public String getKeywords() {
		String keywords = getMetaKeywords();
		if (StringUtils.isBlank(keywords)) {
			return getName();
		} else {
			return keywords;
		}
	}

	@Transient
	public String getDescription() {
		String description = getMetaDescription();
		if (StringUtils.isBlank(description)) {
			return getName();
		} else {
			return description;
		}
	}

	@Transient
	public Boolean getNewWindow() {
		return getDetail() != null ? getDetail().getNewWindow() : null;
	}

	@Transient
	public String getNodeTemplate() {
		return getDetail() != null ? getDetail().getNodeTemplate() : null;
	}

	@Transient
	public String getInfoTemplate() {
		return getDetail() != null ? getDetail().getInfoTemplate() : null;
	}

	@Transient
	public Boolean getGenerateNode() {
		return getDetail() != null ? getDetail().getGenerateNode() : null;
	}

	@Transient
	public Boolean getGenerateInfo() {
		return getDetail() != null ? getDetail().getGenerateInfo() : null;
	}

	@Transient
	public String getNodeExtension() {
		return getDetail() != null ? getDetail().getNodeExtension() : null;
	}

	@Transient
	public String getInfoExtension() {
		return getDetail() != null ? getDetail().getInfoExtension() : null;
	}

	@Transient
	public String getNodePath() {
		return getDetail() != null ? getDetail().getNodePath() : null;
	}

	@Transient
	public String getInfoPath() {
		return getDetail() != null ? getDetail().getInfoPath() : null;
	}

	@Transient
	public Boolean getDefPage() {
		return getDetail() != null ? getDetail().getDefPage() : null;
	}

	@Transient
	public Integer getStaticMethod() {
		return getDetail() != null ? getDetail().getStaticMethod() : null;
	}

	@Transient
	public Integer getStaticPage() {
		return getDetail() != null ? getDetail().getStaticPage() : null;
	}

	@Transient
	public String getSmallImage() {
		return getDetail() != null ? getDetail().getSmallImage() : null;
	}

	@Transient
	public String getLargeImage() {
		return getDetail() != null ? getDetail().getLargeImage() : null;
	}

	@Transient
	public NodeDetail getDetail() {
		Set<NodeDetail> set = getDetails();
		if (!CollectionUtils.isEmpty(set)) {
			return set.iterator().next();
		} else {
			return null;
		}
	}

	@Transient
	public void setDetail(NodeDetail detail) {
		Set<NodeDetail> set = getDetails();
		if (set == null) {
			set = new HashSet<NodeDetail>(1);
			setDetails(set);
		} else {
			set.clear();
		}
		set.add(detail);
	}

	@Transient
	public NodeBuffer getBuffer() {
		Set<NodeBuffer> set = getBuffers();
		if (!CollectionUtils.isEmpty(set)) {
			return set.iterator().next();
		} else {
			return null;
		}
	}

	@Transient
	public void setBuffer(NodeBuffer buffer) {
		Set<NodeBuffer> set = getBuffers();
		if (set == null) {
			set = new HashSet<NodeBuffer>(1);
			setBuffers(set);
		} else {
			set.clear();
		}
		set.add(buffer);
	}

	@Transient
	public void applyDefaultValue() {
		if (getCreationDate() == null) {
			setCreationDate(new Timestamp(System.currentTimeMillis()));
		}
		if (getRefers() == null) {
			setRefers(0);
		}
		if (getViews() == null) {
			setViews(0);
		}
		if (getRealNode() == null) {
			setRealNode(true);
		}
		if (getHidden() == null) {
			setHidden(false);
		}
	}

	private Integer id;
	private Map<String, String> customs;
	private Map<String, String> clobs;
	private List<Node> children;
	private Set<NodeDetail> details;
	private Set<NodeBuffer> buffers;
	private Node parent;
	private Site site;
	private Workflow workflow;
	private User creator;
	private Model nodeModel;
	private Model infoModel;

	private String number;
	private String name;
	private String treeNumber;
	private Integer treeLevel;
	private String treeMax;
	private Date creationDate;
	private Integer refers;
	private Integer views;
	private Boolean realNode;
	private Boolean hidden;
	private Byte p1;
	private Byte p2;
	private Byte p3;
	private Byte p4;
	private Byte p5;
	private Byte p6;

	public Node() {
	}

	public Node(Site site, User creator, Model nodeModel, String name,
			String treeNumber, Integer treeLevel, String treeMax) {
		this.site = site;
		this.creator = creator;
		this.nodeModel = nodeModel;
		this.name = name;
		this.treeNumber = treeNumber;
		this.treeLevel = treeLevel;
		this.treeMax = treeMax;
	}

	@Id
	@Column(name = "f_node_id", unique = true, nullable = false)
	@TableGenerator(name = "tg_cms_node", pkColumnValue = "cms_node", table = "t_id_table", pkColumnName = "f_table", valueColumnName = "f_id_value", initialValue = 1, allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "tg_cms_node")
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	@OrderBy(value = "treeNumber asc, id asc")
	public List<Node> getChildren() {
		return this.children;
	}

	public void setChildren(List<Node> children) {
		this.children = children;
	}

	@ElementCollection
	@CollectionTable(name = "cms_node_custom", joinColumns = @JoinColumn(name = "f_node_id"))
	@MapKeyColumn(name = "f_key", length = 50)
	@Column(name = "f_value", length = 2000)
	public Map<String, String> getCustoms() {
		return this.customs;
	}

	public void setCustoms(Map<String, String> customs) {
		this.customs = customs;
	}

	@Lob
	@ElementCollection
	@CollectionTable(name = "cms_node_clob", joinColumns = @JoinColumn(name = "f_node_id"))
	@MapKeyColumn(name = "f_key", length = 50)
	@Column(name = "f_value", length = 2000)
	public Map<String, String> getClobs() {
		return this.clobs;
	}

	public void setClobs(Map<String, String> clobs) {
		this.clobs = clobs;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REMOVE }, mappedBy = "node")
	public Set<NodeDetail> getDetails() {
		return details;
	}

	public void setDetails(Set<NodeDetail> details) {
		this.details = details;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_parent_id")
	public Node getParent() {
		return this.parent;
	}

	public void setParent(Node parent) {
		this.parent = parent;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_site_id", nullable = false)
	public Site getSite() {
		return this.site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_workflow_id", nullable = false)
	public Workflow getWorkflow() {
		return workflow;
	}

	public void setWorkflow(Workflow workflow) {
		this.workflow = workflow;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_creator_id", nullable = false)
	public User getCreator() {
		return this.creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_node_model_id", nullable = false)
	public Model getNodeModel() {
		return this.nodeModel;
	}

	public void setNodeModel(Model nodeModel) {
		this.nodeModel = nodeModel;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "f_info_model_id")
	public Model getInfoModel() {
		return this.infoModel;
	}

	public void setInfoModel(Model infoModel) {
		this.infoModel = infoModel;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REMOVE }, mappedBy = "node")
	public Set<NodeBuffer> getBuffers() {
		return buffers;
	}

	public void setBuffers(Set<NodeBuffer> buffers) {
		this.buffers = buffers;
	}

	@Column(name = "f_number", length = 100)
	public String getNumber() {
		return this.number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	@Column(name = "f_name", nullable = false, length = 150)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "f_tree_number", nullable = false, length = 100)
	public String getTreeNumber() {
		return this.treeNumber;
	}

	public void setTreeNumber(String treeNumber) {
		this.treeNumber = treeNumber;
	}

	@Column(name = "f_tree_level", nullable = false)
	public Integer getTreeLevel() {
		return this.treeLevel;
	}

	public void setTreeLevel(Integer treeLevel) {
		this.treeLevel = treeLevel;
	}

	@Column(name = "f_tree_max", nullable = false, length = 20)
	public String getTreeMax() {
		return this.treeMax;
	}

	public void setTreeMax(String treeMax) {
		this.treeMax = treeMax;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "f_creation_date", nullable = false, length = 19)
	public Date getCreationDate() {
		return this.creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	@Column(name = "f_refers", nullable = false)
	public Integer getRefers() {
		return refers;
	}

	public void setRefers(Integer refers) {
		this.refers = refers;
	}

	@Column(name = "f_views", nullable = false)
	public Integer getViews() {
		return this.views;
	}

	public void setViews(Integer views) {
		this.views = views;
	}

	@Column(name = "f_is_real_node", nullable = false, length = 1)
	public Boolean getRealNode() {
		return this.realNode;
	}

	public void setRealNode(Boolean realNode) {
		this.realNode = realNode;
	}

	@Column(name = "f_is_hidden", nullable = false, length = 1)
	public Boolean getHidden() {
		return this.hidden;
	}

	public void setHidden(Boolean hidden) {
		this.hidden = hidden;
	}

	@Column(name = "f_p1")
	public Byte getP1() {
		return this.p1;
	}

	public void setP1(Byte p1) {
		this.p1 = p1;
	}

	@Column(name = "f_p2")
	public Byte getP2() {
		return this.p2;
	}

	public void setP2(Byte p2) {
		this.p2 = p2;
	}

	@Column(name = "f_p3")
	public Byte getP3() {
		return this.p3;
	}

	public void setP3(Byte p3) {
		this.p3 = p3;
	}

	@Column(name = "f_p4")
	public Byte getP4() {
		return this.p4;
	}

	public void setP4(Byte p4) {
		this.p4 = p4;
	}

	@Column(name = "f_p5")
	public Byte getP5() {
		return this.p5;
	}

	public void setP5(Byte p5) {
		this.p5 = p5;
	}

	@Column(name = "f_p6")
	public Byte getP6() {
		return this.p6;
	}

	public void setP6(Byte p6) {
		this.p6 = p6;
	}
}
