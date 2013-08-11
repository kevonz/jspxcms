package com.jspxcms.core.support;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.jspxcms.core.domain.Site;
import com.jspxcms.core.service.SiteService;

/**
 * SiteFilter
 * 
 * @author liufang
 * 
 */
public class SiteFilter implements Filter {
	private SiteService siteService;

	public void setSiteService(SiteService siteService) {
		this.siteService = siteService;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		Site site = siteService.findUniqueSite();
		// 站点必须存在
		if (site == null) {
			throw new IllegalStateException("no site found!");
		}
		Context.setCurrentSite(request, site);
		Context.setCurrentSite(site);
		chain.doFilter(request, response);
		Context.resetCurrentSite();
	}

	public void init(FilterConfig filterConfig) throws ServletException {
	}

	public void destroy() {
	}
}
