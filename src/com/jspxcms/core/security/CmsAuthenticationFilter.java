package com.jspxcms.core.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.service.UserService;

/**
 * CmsAuthenticationFilter
 * 
 * @author liufang
 * 
 */
public class CmsAuthenticationFilter extends FormAuthenticationFilter {
	private Logger logger = LoggerFactory
			.getLogger(CmsAuthenticationFilter.class);

	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) {
		boolean isAllowed = super.isAccessAllowed(request, response,
				mappedValue);
		if (isAllowed && isLoginRequest(request, response)) {
			try {
				issueSuccessRedirect(request, response);
			} catch (Exception e) {
				logger.error("", e);
			}
			return false;
		}
		return isAllowed;
	}

	@Override
	protected boolean onLoginSuccess(AuthenticationToken token,
			Subject subject, ServletRequest request, ServletResponse response)
			throws Exception {
		ShiroUser user = (ShiroUser) subject.getPrincipal();
		String ip = Servlets.getRemoteAddr(request);
		userService.updateLoginInfo(user.id, ip);
		return super.onLoginSuccess(token, subject, request, response);
	}

	private UserService userService;

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
}
