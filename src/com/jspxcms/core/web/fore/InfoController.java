package com.jspxcms.core.web.fore;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jspxcms.common.web.PathResolver;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Info;
import com.jspxcms.core.domain.Node;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.service.InfoBufferService;
import com.jspxcms.core.service.InfoQueryService;
import com.jspxcms.core.support.ForeContext;
import com.jspxcms.core.support.TitleText;

/**
 * InfoController
 * 
 * @author liufang
 * 
 */
@Controller
public class InfoController {
	@RequestMapping(value = "/info/{infoId:[0-9]+}_{page:[0-9]+}.jspx")
	public String infoByPagePath(@PathVariable Integer infoId,
			@PathVariable Integer page, HttpServletRequest request,
			org.springframework.ui.Model modelMap) {
		Info info = query.get(infoId);
		String linkUrl = info.getLinkUrl();
		if (StringUtils.isNotBlank(linkUrl)) {
			return "redirect:" + linkUrl;
		}
		page = page == null ? 1 : page;
		// TODO if(content==null) {...}
		Node node = info.getNode();
		Site site = info.getSite();
		List<TitleText> textList = info.getTextList();
		TitleText infoText = TitleText.getTitleText(textList, page);
		String title = infoText.getTitle();
		String text = infoText.getText();
		modelMap.addAttribute("info", info);
		modelMap.addAttribute("node", node);
		modelMap.addAttribute("title", title);
		modelMap.addAttribute("text", text);

		Page<String> pagedList = new PageImpl<String>(Arrays.asList(text),
				new PageRequest(page - 1, 1), textList.size());
		Map<String, Object> data = modelMap.asMap();
		ForeContext.setData(data, site, request);
		ForeContext.setPage(data, page, info, pagedList);

		String template = Servlets.getParameter(request, "template");
		if (StringUtils.isNotBlank(template)) {
			return template;
		} else {
			return info.getTemplate();
		}
	}

	@RequestMapping(value = "/info/{infoId:[0-9]+}.jspx")
	public String info(@PathVariable Integer infoId, Integer page,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		return infoByPagePath(infoId, page, request, modelMap);
	}

	@RequestMapping(value = "/info_download.jspx")
	public void download(Integer id, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Info info = query.get(id);
		infoBufferservice.updateDownloads(id);
		String path = info.getFile();
		String ctx = info.getSite().getContextPath();
		if (StringUtils.isNotBlank(ctx) && path.startsWith(ctx)) {
			path = path.substring(ctx.length());
		}
		File file = new File(pathResolver.getPath(path));
		Servlets.setDownloadHeader(response, file.getName());
		int length = (int) file.length();
		response.setContentLength(length);
		OutputStream output = response.getOutputStream();
		FileUtils.copyFile(file, output);
		output.flush();
	}

	@ResponseBody
	@RequestMapping(value = "/info_views/{infoId:[0-9]+}.jspx")
	public String views(@PathVariable Integer infoId) {
		return Integer.toString(bufferService.updateViews(infoId));
	}

	@ResponseBody
	@RequestMapping(value = "/info_comments/{infoId:[0-9]+}.jspx")
	public String comments(@PathVariable Integer infoId) {
		Info info = query.get(infoId);
		int comments;
		if (info != null) {
			comments = info.getComments();
		} else {
			comments = 0;
		}
		return Integer.toString(comments);
	}

	@ResponseBody
	@RequestMapping(value = "/info_downloads/{infoId:[0-9]+}.jspx")
	public String downloads(@PathVariable Integer infoId) {
		Info info = query.get(infoId);
		int downloads;
		if (info != null) {
			downloads = info.getDownloads();
		} else {
			downloads = 0;
		}
		return Integer.toString(downloads);
	}

	@Autowired
	private InfoBufferService bufferService;
	@Autowired
	private InfoQueryService query;
	@Autowired
	private InfoBufferService infoBufferservice;
	@Autowired
	private PathResolver pathResolver;
}
