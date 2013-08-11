package com.jspxcms.core.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.core.domain.Info;
import com.jspxcms.core.domain.InfoDetail;
import com.jspxcms.core.domain.InfoFile;
import com.jspxcms.core.domain.InfoImage;
import com.jspxcms.core.domain.Node;
import com.jspxcms.core.domain.Special;
import com.jspxcms.core.domain.Tag;
import com.jspxcms.core.listener.InfoListener;
import com.jspxcms.core.repository.InfoDao;
import com.jspxcms.core.service.InfoAttributeService;
import com.jspxcms.core.service.InfoDetailService;
import com.jspxcms.core.service.InfoService;
import com.jspxcms.core.service.NodeQueryService;
import com.jspxcms.core.service.NodeService;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SpecialService;
import com.jspxcms.core.service.TagService;
import com.jspxcms.core.service.UserService;

/**
 * 信息Service实现
 * 
 * @author liufang
 * 
 */
@Service
@Transactional
public class InfoServiceImpl implements InfoService {
	public Info save(Info bean, InfoDetail detail, Integer[] nodeIds,
			Integer[] specialIds, Map<String, String> customs,
			Map<String, String> clobs, List<InfoImage> images,
			List<InfoFile> files, Integer[] attrIds,
			Map<String, String> attrImages, String[] tagNames, Integer nodeId,
			Integer creatorId, Integer siteId) {
		bean.setSite(siteService.get(siteId));
		bean.setCreator(userService.get(creatorId));
		bean.setNode(nodeService.refer(nodeId));
		bean.setCustoms(customs);
		bean.setClobs(clobs);
		bean.setImages(images);
		bean.setFiles(files);
		List<Tag> tags = tagService.refer(tagNames, siteId);
		bean.setTags(tags);
		List<Node> nodes = nodeQueryService.findByIds(nodeIds, nodeId);
		bean.setNodes(nodes);
		List<Special> specials = specialService.refer(specialIds);
		bean.setSpecials(specials);
		if (detail != null && StringUtils.isNotBlank(detail.getSmallImage())) {
			bean.setWithImage(true);
		}

		bean.applyDefaultValue();
		bean = dao.save(bean);
		infoDetailService.save(detail, bean);
		infoAttrService.save(bean, attrIds, attrImages);
		firePostSave(new Info[] { bean });
		return bean;
	}

	public Info update(Info bean, InfoDetail detail, Integer[] nodeIds,
			Integer[] specialIds, Map<String, String> customs,
			Map<String, String> clobs, List<InfoImage> images,
			List<InfoFile> files, Integer[] attrIds,
			Map<String, String> attrImages, String[] tagNames, Integer nodeId) {
		if (detail != null && StringUtils.isNotBlank(detail.getSmallImage())) {
			bean.setWithImage(true);
		}
		bean.applyDefaultValue();
		bean = dao.save(bean);
		if (nodeId != null) {
			nodeService.derefer(bean.getNode());
			bean.setNode(nodeService.refer(nodeId));
		}
		bean.getCustoms().clear();
		if (!CollectionUtils.isEmpty(customs)) {
			bean.getCustoms().putAll(customs);
		}
		bean.getClobs().clear();
		if (!CollectionUtils.isEmpty(clobs)) {
			bean.getClobs().putAll(clobs);
		}
		bean.getImages().clear();
		if (!CollectionUtils.isEmpty(images)) {
			bean.getImages().addAll(images);
		}
		bean.getFiles().clear();
		if (!CollectionUtils.isEmpty(files)) {
			bean.getFiles().addAll(files);
		}
		List<Tag> tags = bean.getTags();
		tagService.derefer(tags);
		tags.clear();
		List<Tag> newTags = tagService.refer(tagNames, bean.getSite().getId());
		tags.addAll(newTags);
		List<Node> nodes = bean.getNodes();
		nodeService.derefer(nodes);
		nodes.clear();
		// 将主节点也加入副节点，便于查询。
		List<Node> newNodes = nodeQueryService.findByIds(nodeIds, nodeId);
		nodes.addAll(newNodes);
		List<Special> specials = bean.getSpecials();
		specialService.derefer(specials);
		specials.clear();
		List<Special> newSpecials = specialService.refer(specialIds);
		specials.addAll(newSpecials);

		infoDetailService.update(detail, bean);
		infoAttrService.update(bean, attrIds, attrImages);
		firePostUpdate(new Info[] { bean });
		return bean;
	}

	private Info doDelete(Integer id) {
		Info entity = dao.findOne(id);
		if (entity != null) {
			dao.delete(entity);
		}
		return entity;
	}

	public Info delete(Integer id) {
		firePreDelete(new Integer[] { id });
		Info bean = doDelete(id);
		if (bean != null) {
			firePostDelete(new Info[] { bean });
		}
		return bean;
	}

	public Info[] delete(Integer[] ids) {
		firePreDelete(ids);
		List<Info> list = new ArrayList<Info>(ids.length);
		Info bean;
		for (int i = 0; i < ids.length; i++) {
			bean = delete(ids[i]);
			if (bean != null) {
				list.add(bean);
			}
		}
		Info[] beans = list.toArray(new Info[list.size()]);
		firePostDelete(beans);
		return beans;
	}

	private void firePostSave(Info[] bean) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (InfoListener listener : listeners) {
				listener.postSave(bean);
			}
		}
	}

	private void firePostUpdate(Info[] bean) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (InfoListener listener : listeners) {
				listener.postUpdate(bean);
			}
		}
	}

	private void firePreDelete(Integer[] ids) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (InfoListener listener : listeners) {
				listener.preDelete(ids);
			}
		}
	}

	private void firePostDelete(Info[] bean) {
		if (!CollectionUtils.isEmpty(listeners)) {
			for (InfoListener listener : listeners) {
				listener.postDelete(bean);
			}
		}
	}

	private List<InfoListener> listeners;
	private InfoAttributeService infoAttrService;
	private TagService tagService;
	private InfoDetailService infoDetailService;
	private SpecialService specialService;
	private NodeService nodeService;
	private NodeQueryService nodeQueryService;
	private UserService userService;
	private SiteService siteService;

	@Autowired(required = false)
	public void setListeners(List<InfoListener> listeners) {
		this.listeners = listeners;
	}

	@Autowired
	public void setInfoAttrService(InfoAttributeService infoAttrService) {
		this.infoAttrService = infoAttrService;
	}

	@Autowired
	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}

	@Autowired
	public void setInfoDetailService(InfoDetailService infoDetailService) {
		this.infoDetailService = infoDetailService;
	}

	@Autowired
	public void setSpecialService(SpecialService specialService) {
		this.specialService = specialService;
	}

	@Autowired
	public void setNodeService(NodeService nodeService) {
		this.nodeService = nodeService;
	}

	@Autowired
	public void setNodeQueryService(NodeQueryService nodeQueryService) {
		this.nodeQueryService = nodeQueryService;
	}

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Autowired
	public void setSiteService(SiteService siteService) {
		this.siteService = siteService;
	}

	private InfoDao dao;

	@Autowired
	public void setDao(InfoDao dao) {
		this.dao = dao;
	}
}
