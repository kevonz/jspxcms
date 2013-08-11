package com.jspxcms.core.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.jspxcms.core.domain.Node;
import com.jspxcms.core.domain.NodeDetail;
import com.jspxcms.core.listener.NodeListener;
import com.jspxcms.core.repository.NodeDao;
import com.jspxcms.core.service.ModelService;
import com.jspxcms.core.service.NodeDetailService;
import com.jspxcms.core.service.NodeService;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.UserService;

/**
 * NodeServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional
public class NodeServiceImpl implements NodeService {
	public Node save(Node bean, NodeDetail detail, Map<String, String> customs,
			Map<String, String> clobs, Integer parentId, Integer nodeModelId,
			Integer infoModelId, Integer creatorId, Integer siteId) {
		Node parent = null;
		if (parentId != null) {
			parent = dao.findOne(parentId);
			bean.setParent(parent);
		}
		if (nodeModelId != null) {
			bean.setNodeModel(modelService.get(nodeModelId));
		}
		if (infoModelId != null) {
			bean.setInfoModel(modelService.get(infoModelId));
			bean.setRealNode(true);
		} else {
			// 首页必须为真实节点
			bean.setRealNode(bean.getParent() == null);
		}
		bean.setCreator(userService.get(creatorId));
		bean.setSite(siteService.get(siteId));
		bean.setCustoms(customs);
		bean.setClobs(clobs);
		treeSave(bean, parent);

		bean.applyDefaultValue();
		bean = dao.save(bean);

		nodeDetailService.save(detail, bean);
		firePostSave(new Node[] { bean });
		return bean;
	}

	private void treeSave(Node bean, Node parent) {
		bean.setTreeMax(Node.getTreeHex(0));
		if (parent == null) {
			bean.setTreeLevel(0);
			bean.setTreeNumber(Node.getTreeHex(0));
			bean.setTreeMax(Node.getTreeHex(0));
		} else {
			bean.setTreeLevel(parent.getTreeLevel() + 1);
			String max = parent.getTreeMax();
			bean.setTreeNumber(parent.getTreeNumber() + "-" + max);
			long big = parent.getTreeMaxLong() + 1;
			parent.setTreeMax(Node.getTreeHex(big));
			dao.save(parent);
		}
	}

	public Node update(Node bean, NodeDetail detail,
			Map<String, String> customs, Map<String, String> clobs,
			Integer nodeModelId, Integer infoModelId) {
		if (nodeModelId != null) {
			bean.setNodeModel(modelService.get(nodeModelId));
		}
		if (infoModelId != null) {
			bean.setInfoModel(modelService.get(infoModelId));
			bean.setRealNode(true);
		} else {
			bean.setInfoModel(null);
			// 首页必须为真实节点
			bean.setRealNode(bean.getParent() == null);
		}
		bean.getCustoms().clear();
		if (!CollectionUtils.isEmpty(customs)) {
			bean.getCustoms().putAll(customs);
		}
		bean.getClobs().clear();
		if (!CollectionUtils.isEmpty(clobs)) {
			bean.getClobs().putAll(clobs);
		}
		nodeDetailService.update(detail, bean);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		firePostUpdate(new Node[] { bean });
		return bean;
	}

	public Node[] batchUpdate(Integer[] id, String[] name, String[] number,
			Integer[] views, Boolean[] hidden, Boolean isUpdateTree,
			Integer siteId) {
		Map<Integer, List<Integer>> listMap = new HashMap<Integer, List<Integer>>();
		Node[] beans = new Node[id.length];
		for (int i = 0, len = id.length; i < len; i++) {
			beans[i] = dao.findOne(id[i]);
			beans[i].setName(name[i]);
			beans[i].setNumber(number[i]);
			beans[i].setViews(views[i]);
			beans[i].setHidden(hidden[i]);
			dao.save(beans[i]);
			if (isUpdateTree != null && isUpdateTree) {
				Node parent = beans[i].getParent();
				Integer parentId;
				if (parent != null) {
					parentId = parent.getId();
				} else {
					parentId = -1;
				}
				List<Integer> list = listMap.get(parentId);
				if (list != null) {
					list.add(id[i]);
				} else {
					list = new ArrayList<Integer>();
					list.add(id[i]);
					listMap.put(parentId, list);
				}
			}
		}
		String parentTreeNumber, origTreeNumber, treeNumber;
		for (Entry<Integer, List<Integer>> entry : listMap.entrySet()) {
			Integer parentId = entry.getKey();
			List<Integer> ids = entry.getValue();
			if (parentId == -1) {
				continue;
			}
			int len = ids.size();
			if (dao.countByParentId(parentId) != len) {
				continue;
			}
			parentTreeNumber = dao.findTreeNumber(parentId);
			dao.appendModifiedFlag(siteId, parentTreeNumber + "%",
					parentTreeNumber);
			for (int i = 0; i < len; i++) {
				origTreeNumber = dao.findTreeNumber(ids.get(i));
				treeNumber = parentTreeNumber + "-" + Node.getTreeHex(i);
				dao.updateTreeNumber(siteId, origTreeNumber + "%", treeNumber,
						treeNumber.length() + 2);
			}
			// 修改父节点的treeMax
			dao.updateTreeMax(parentId, Node.getTreeHex(len));
		}
		return beans;
	}

	public int move(Integer[] ids, Integer id, Integer siteId) {
		Node parent = dao.findOne(id);
		String parentTreeNumber = parent.getTreeNumber();
		long big = parent.getTreeMaxLong();
		String currTreeNumber, treeNumber;
		int count = 0;
		for (int i = 0, len = ids.length; i < len; i++) {
			dao.updateTreeMax(id, Node.getTreeHex(big + 1));
			treeNumber = dao.findTreeNumber(ids[i]);
			currTreeNumber = parentTreeNumber + "-" + Node.getTreeHex(big++);
			count += dao.updateTreeNumber(siteId, treeNumber + "%",
					currTreeNumber, treeNumber.length() + 1);
			dao.updateParentId(ids[i], id);
		}
		return count;
	}

	private Set<Node> doDelete(Node bean, Set<Node> deleted) {
		if (bean != null) {
			Collection<Node> children = bean.getChildren();
			if (!CollectionUtils.isEmpty(children)) {
				for (Node n : children) {
					doDelete(n, deleted);
				}
			}
			dao.delete(bean);
			deleted.add(bean);
		}
		return deleted;
	}

	public Node delete(Integer id) {
		Node bean = dao.findOne(id);
		if (bean == null) {
			return null;
		}
		Set<Node> deleted = new HashSet<Node>();
		firePreDelete(new Integer[] { id });
		doDelete(bean, deleted);
		firePostDelete(deleted.toArray(new Node[deleted.size()]));
		return bean;
	}

	public Node[] delete(Integer[] ids) {
		firePreDelete(ids);
		Set<Node> deleted = new HashSet<Node>();
		Node bean;
		for (int i = 0; i < ids.length; i++) {
			bean = dao.findOne(ids[i]);
			doDelete(bean, deleted);
		}
		Node[] beans = deleted.toArray(new Node[deleted.size()]);
		firePostDelete(beans);
		return beans;
	}

	public Node refer(Integer nodeId) {
		Node node = dao.findOne(nodeId);
		node.setRefers(node.getRefers() + 1);
		return node;
	}

	public List<Node> refer(Integer[] nodeIds) {
		if (ArrayUtils.isEmpty(nodeIds)) {
			return Collections.emptyList();
		}
		Set<Integer> nodeIdSet = new HashSet<Integer>();
		List<Node> nodes = new ArrayList<Node>(nodeIds.length);
		for (Integer nodeId : nodeIds) {
			if (!nodeIdSet.contains(nodeId)) {
				nodes.add(refer(nodeId));
				nodeIdSet.add(nodeId);
			}
		}
		return nodes;
	}

	public void derefer(Node node) {
		node.setRefers(node.getRefers() - 1);
	}

	public void derefer(Collection<Node> nodes) {
		for (Node node : nodes) {
			derefer(node);
		}
	}

	private void firePostSave(Node[] bean) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (NodeListener listener : listeners) {
				listener.postSave(bean);
			}
		}
	}

	private void firePostUpdate(Node[] bean) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (NodeListener listener : listeners) {
				listener.postUpdate(bean);
			}
		}
	}

	private void firePreDelete(Integer[] ids) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (NodeListener listener : listeners) {
				listener.preDelete(ids);
			}
		}
	}

	private void firePostDelete(Node[] bean) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (NodeListener listener : listeners) {
				listener.postDelete(bean);
			}
		}
	}

	private List<NodeListener> listeners;
	private ModelService modelService;
	private NodeDetailService nodeDetailService;
	private UserService userService;
	private SiteService siteService;

	@Autowired(required = false)
	public void setListeners(List<NodeListener> listeners) {
		this.listeners = listeners;
	}

	@Autowired
	public void setModelService(ModelService modelService) {
		this.modelService = modelService;
	}

	@Autowired
	public void setNodeDetailService(NodeDetailService nodeDetailService) {
		this.nodeDetailService = nodeDetailService;
	}

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Autowired
	public void setSiteService(SiteService siteService) {
		this.siteService = siteService;
	}

	private NodeDao dao;

	@Autowired
	public void setDao(NodeDao dao) {
		this.dao = dao;
	}
}
