package com.jspxcms.core.web.directive;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.common.freemarker.Freemarkers;
import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.Node;
import com.jspxcms.core.service.NodeQueryService;
import com.jspxcms.core.support.ForeContext;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import freemarker.template.TemplateModelException;

/**
 * AbstractNodeListPageDirective
 * 
 * @author liufang
 * 
 */
public abstract class AbstractNodeListPageDirective {
	public static final String SITE_ID = "siteId";
	public static final String PARENT_ID = "parentId";
	public static final String PARENT = "parent";
	public static final String IS_HIDDEN = "isHidden";
	public static final String IS_REAL_NODE = "isRealNode";
	public static final String IS_INCLUDE_CHILDREN = "isIncludeChildren";

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void doExecute(Environment env, Map params,
			TemplateModel[] loopVars, TemplateDirectiveBody body, boolean isPage)
			throws TemplateException, IOException {
		if (loopVars.length < 1) {
			throw new TemplateModelException("Loop variable is required.");
		}
		if (body == null) {
			throw new RuntimeException("missing body");
		}
		Integer parentId = Freemarkers.getInteger(params, PARENT_ID);
		String parent = Freemarkers.getString(params, PARENT);
		if (parentId == null) {
			Integer sid = ForeContext.getSiteId(env);
			if (StringUtils.isNotBlank(parent)) {
				Node pnode = service.findByNumber(sid, parent);
				if (pnode != null) {
					parentId = pnode.getId();
				}
			} else {
				Node root = service.findRoot(sid);
				if (root != null) {
					parentId = root.getId();
				}
			}
		}
		Boolean isHidden = Freemarkers.getBoolean(params, IS_HIDDEN);
		if (isHidden == null && params.get(IS_HIDDEN) == null) {
			isHidden = false;
		}
		Boolean isRealNode = Freemarkers.getBoolean(params, IS_REAL_NODE);

		boolean isIncludeChildren = Freemarkers.getBoolean(params,
				IS_INCLUDE_CHILDREN, false);
		String treeNumber = null;
		if (isIncludeChildren && parentId != null) {
			Node pnode = service.get(parentId);
			if (pnode != null) {
				treeNumber = pnode.getTreeNumber();
			}
			parentId = null;
		}

		Integer[] siteId = Freemarkers.getIntegers(params, SITE_ID);
		if (siteId == null && parentId == null
				&& StringUtils.isBlank(treeNumber)) {
			siteId = new Integer[] { ForeContext.getSiteId(env) };
		}
		Sort defSort = new Sort("treeNumber");
		if (isPage) {
			Pageable pageable = Freemarkers.getPageable(params, env, defSort);
			Page<Node> pagedList = service.findPage(siteId, parentId,
					treeNumber, isRealNode, isHidden, pageable);
			ForeContext.setTotalPages(pagedList.getTotalPages());
			loopVars[0] = env.getObjectWrapper().wrap(pagedList);
		} else {
			Limitable limitable = Freemarkers.getLimitable(params, defSort);
			List<Node> list = service.findList(siteId, parentId, treeNumber,
					isRealNode, isHidden, limitable);
			loopVars[0] = env.getObjectWrapper().wrap(list);
			body.render(env.getOut());
		}
	}

	@Autowired
	private NodeQueryService service;
}
