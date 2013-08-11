package com.jspxcms.core.service.impl;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.util.JsonMapper;
import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Model;
import com.jspxcms.core.domain.ModelField;
import com.jspxcms.core.repository.ModelFieldDao;
import com.jspxcms.core.service.ModelFieldService;
import com.jspxcms.core.service.ModelService;

/**
 * ModelFieldServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class ModelFieldServiceImpl implements ModelFieldService {
	public List<ModelField> findList(Integer modelId) {
		Sort sort = new Sort(Direction.ASC, "seq", "id");
		return dao.findAll(spec(null), sort);
	}

	public RowSide<ModelField> findSide(ModelField bean, Integer position) {
		if (position == null) {
			return new RowSide<ModelField>();
		}
		Sort sort = new Sort(Direction.ASC, "seq", "id");
		Limitable limit = RowSide.limitable(position, sort);
		List<ModelField> list = dao.findAll(spec(null), limit);
		return RowSide.create(list, bean);
	}

	private Specification<ModelField> spec(Map<String, String[]> params) {
		Collection<SearchFilter> filters = SearchFilter.parse(params).values();
		Specification<ModelField> sp = SearchFilter.spec(filters,
				ModelField.class);
		return sp;
	}

	public ModelField get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public ModelField[] batchSave(Integer modelId, String[] name,
			String[] label, Boolean[] dblColumn, String[] property,
			String[] custom) {
		ModelField[] beans = new ModelField[name.length];
		JsonMapper mapper = new JsonMapper();
		Map<String, String> customs;
		for (int i = 0, len = name.length; i < len; i++) {
			beans[i] = new ModelField();
			mapper.update(property[i], beans[i]);
			beans[i].setName(name[i]);
			beans[i].setLabel(label[i]);
			beans[i].setDblColumn(dblColumn[i]);
			customs = new HashMap<String, String>();
			mapper.update(custom[i], customs);
			save(beans[i], modelId, customs, null);
		}
		return beans;
	}

	@Transactional
	public ModelField save(ModelField bean, Integer modelId,
			Map<String, String> customs, Boolean clob) {
		Model model = modelService.get(modelId);
		bean.setModel(model);
		bean.setCustoms(customs);
		if (clob != null && clob) {
			bean.setInnerType(ModelField.FIELD_CUSTOM_CLOB);
		}
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public ModelField[] batchUpdate(Integer[] id, String[] name,
			String[] label, Boolean[] dblColumn) {
		ModelField[] beans = new ModelField[id.length];
		for (int i = 0, len = id.length; i < len; i++) {
			beans[i] = get(id[i]);
			// 只有自定义字段才允许改名称，系统字段不允许修改名称。
			if (beans[i].getInnerType() == ModelField.FIELD_CUSTOM) {
				beans[i].setName(name[i]);
			}
			beans[i].setLabel(label[i]);
			beans[i].setSeq(i);
			beans[i].setDblColumn(dblColumn[i]);
			update(beans[i], null, null);
		}
		return beans;
	}

	@Transactional
	public ModelField update(ModelField bean, Map<String, String> customs,
			Boolean clob) {
		if (customs != null) {
			bean.getCustoms().clear();
			bean.getCustoms().putAll(customs);
		}
		// 只有自定义字段才可以设置是否为大字段
		if (bean.isCustom() && clob != null) {
			bean.setInnerType(clob ? ModelField.FIELD_CUSTOM_CLOB
					: ModelField.FIELD_CUSTOM);
		}
		bean.applyDefaultValue();
		bean = dao.save(bean);
		return bean;
	}

	@Transactional
	public ModelField delete(Integer id) {
		ModelField entity = dao.findOne(id);
		dao.delete(entity);
		return entity;
	}

	@Transactional
	public ModelField[] delete(Integer[] ids) {
		ModelField[] beans = new ModelField[ids.length];
		for (int i = 0; i < ids.length; i++) {
			beans[i] = delete(ids[i]);
		}
		return beans;
	}

	private ModelService modelService;

	@Autowired
	public void setModelService(ModelService modelService) {
		this.modelService = modelService;
	}

	private ModelFieldDao dao;

	@Autowired
	public void setDao(ModelFieldDao dao) {
		this.dao = dao;
	}
}