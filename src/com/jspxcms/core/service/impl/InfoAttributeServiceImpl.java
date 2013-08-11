package com.jspxcms.core.service.impl;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.core.domain.Attribute;
import com.jspxcms.core.domain.Info;
import com.jspxcms.core.domain.InfoAttribute;
import com.jspxcms.core.repository.InfoAttributeDao;
import com.jspxcms.core.service.AttributeService;
import com.jspxcms.core.service.InfoAttributeService;

/**
 * InfoAttributeServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class InfoAttributeServiceImpl implements InfoAttributeService {
	public InfoAttribute get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public InfoAttribute save(InfoAttribute bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Set<InfoAttribute> save(Info info, Integer[] attrIds,
			Map<String, String> attrImages) {
		Set<InfoAttribute> infoAttrs = new HashSet<InfoAttribute>();
		if (ArrayUtils.isNotEmpty(attrIds)) {
			InfoAttribute infoAttr;
			Attribute attr;
			String image;
			for (Integer attrId : attrIds) {
				infoAttr = new InfoAttribute();
				attr = attributeService.get(attrId);
				image = attrImages.get(attrId.toString());
				infoAttr.setInfo(info);
				infoAttr.setAttribute(attr);
				if (StringUtils.isNotBlank(image)) {
					infoAttr.setImage(image);
				}
				save(infoAttr);
			}
		}
		return infoAttrs;
	}

	@Transactional
	public InfoAttribute update(InfoAttribute bean) {
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public Set<InfoAttribute> update(Info info, Integer[] attrIds,
			Map<String, String> attrImages) {
		dao.deleteByInfoId(info.getId());
		return save(info, attrIds, attrImages);
	}

	@Transactional
	public InfoAttribute delete(Integer id) {
		InfoAttribute entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public InfoAttribute[] delete(Integer[] ids) {
		InfoAttribute[] beans = new InfoAttribute[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private AttributeService attributeService;

	@Autowired
	public void setAttributeService(AttributeService attributeService) {
		this.attributeService = attributeService;
	}

	private InfoAttributeDao dao;

	@Autowired
	public void setDao(InfoAttributeDao dao) {
		this.dao = dao;
	}
}
