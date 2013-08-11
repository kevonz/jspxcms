package com.jspxcms.core.web.fore;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.jspxcms.common.security.Captchas;
import com.jspxcms.common.web.Anchor;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Comment;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.User;
import com.jspxcms.core.service.CommentService;
import com.jspxcms.core.service.UserService;
import com.jspxcms.core.support.Context;
import com.jspxcms.core.support.ForeContext;
import com.jspxcms.core.support.ForeUtils;
import com.jspxcms.core.support.Response;
import com.jspxcms.core.support.Siteable;
import com.octo.captcha.service.CaptchaService;

/**
 * CommentController
 * 
 * @author liufang
 * 
 */
@Controller
public class CommentController {
	public static final String TPL_PREFIX = "sys_comment";
	public static final String TPL_SUFFIX = ".html";
	public static final String TEMPLATE = TPL_PREFIX + TPL_SUFFIX;

	@RequestMapping(value = "/comment.jspx")
	public String veiw(String ftype, Integer fid, Integer page,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		if (StringUtils.isBlank(ftype)) {
			ftype = "Info";
		}
		if (fid == null) {
			// TODO
		}
		Object bean = service.getEntity(ftype, fid);
		if (bean == null) {
			// TODO
		}
		Anchor anchor = (Anchor) bean;
		Site site = ((Siteable) bean).getSite();
		modelMap.addAttribute("anchor", anchor);
		Map<String, Object> data = modelMap.asMap();
		ForeContext.setData(data, site, request);
		ForeContext.setPage(data, page);
		return site.getTemplate(TEMPLATE);
	}

	@RequestMapping(value = "/comment_submit.jspx")
	public String submit(String fname, String ftype, Integer fid, String text,
			String captcha, HttpServletRequest request,
			HttpServletResponse response, org.springframework.ui.Model modelMap)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException {
		if (StringUtils.isBlank(fname)) {
			fname = "com.jspxcms.core.domain.InfoComment";
		}
		if (StringUtils.isBlank(ftype)) {
			ftype = "Info";
		}
		if (fid == null) {
			// TODO
		}
		Object bean = service.getEntity(ftype, fid);
		if (bean == null) {
			// TODO
		}
		Site site = ((Siteable) bean).getSite();
		Response resp = new Response();
		boolean valid = Captchas.isValid(captchaService, request, captcha);
		User user = Context.getCurrentUser(request);
		if (valid) {
			Comment comment = (Comment) Class.forName(fname).newInstance();
			comment.setFid(fid);
			comment.setText(text);
			if (user == null) {
				user = userService.getAnonymous();
			}
			comment.setIp(Servlets.getRemoteAddr(request));
			service.save(comment, user.getId(), site.getId());
			resp.status = 0;
		} else {
			resp.status = 1;
			Locale locale = RequestContextUtils.getLocale(request);
			resp.messages.add(ms.getMessage("error.captcha", null, locale));
		}
		return ForeUtils.response(response, request, modelMap, site, resp);
	}

	@RequestMapping(value = "/comment_list.jspx")
	public String list(String ftype, Integer fid, Integer page,
			HttpServletRequest request, org.springframework.ui.Model modelMap) {
		if (StringUtils.isBlank(ftype)) {
			ftype = "Info";
		}
		if (fid == null) {
			// TODO
		}
		Object bean = service.getEntity(ftype, fid);
		if (bean == null) {
			// TODO
		}
		Anchor anchor = (Anchor) bean;
		Site site = ((Siteable) bean).getSite();
		String tpl = Servlets.getParameter(request, "tpl");
		if (StringUtils.isBlank(tpl)) {
			tpl = "_list";
		}
		modelMap.addAttribute("anchor", anchor);
		Map<String, Object> data = modelMap.asMap();
		ForeContext.setData(data, site, request);
		ForeContext.setPage(data, page);
		return site.getTemplate(TPL_PREFIX + tpl + TPL_SUFFIX);
	}

	@Autowired
	private MessageSource ms;
	@Autowired
	private CaptchaService captchaService;
	@Autowired
	private UserService userService;
	@Autowired
	private CommentService service;

}
