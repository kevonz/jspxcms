package com.jspxcms.core.web.back.f7;

import java.io.File;
import java.io.FileFilter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspxcms.common.web.PathResolver;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.support.Context;
import com.jspxcms.core.support.WebFile;

/**
 * WebFileF7Controller
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core/web_file")
public class WebFileF7Controller {

	@RequestMapping("f7_dir.do")
	public String f7Dir(HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		String parentId = Servlets.getParameter(request, "parentId");
		Site site = Context.getCurrentSite(request);
		File root = new File(pathResolver.getPath(""));
		String base = site.getFilesBasePath("");
		if (StringUtils.isBlank(parentId)) {
			parentId = base;
		}

		String[] ids = Servlets.getParameterValues(request, "ids");
		final String[] realIds = new String[ids.length];
		for (int i = 0, len = ids.length; i < len; i++) {
			realIds[i] = pathResolver.getPath(ids[i]);
		}
		String realPath = pathResolver.getPath(parentId);
		File parent = new File(realPath);
		WebFile parentWebFile = new WebFile(parent, root.getAbsolutePath(),
				request.getContextPath());
		List<WebFile> list = parentWebFile.listFiles(new FileFilter() {
			public boolean accept(File pathname) {
				if (pathname.isDirectory()) {
					String path = pathname.getAbsolutePath();
					for (String id : realIds) {
						if (path.equals(id)
								|| path.startsWith(id + File.separator)) {
							return false;
						}
					}
					return true;
				}
				return false;
			}
		});
		parentWebFile.setCurrent(true);
		list.add(0, parentWebFile);
		if (parentId.length() > base.length()) {
			WebFile ppWebFile = parentWebFile.getParentFile();
			ppWebFile.setParent(true);
			list.add(0, ppWebFile);
			modelMap.addAttribute("ppId", ppWebFile.getId());
		}
		modelMap.addAttribute("ids", ids);
		modelMap.addAttribute("parentId", parentId);
		modelMap.addAttribute("list", list);
		return "core/web_file/f7_dir";
	}

	@RequestMapping("f7_dir_list.do")
	public String f7DirList(HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		f7Dir(request, modelMap);
		return "core/web_file/f7_dir_list";
	}

	@Autowired
	private PathResolver pathResolver;
}
