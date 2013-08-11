package com.jspxcms.core.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.core.domain.Info;
import com.jspxcms.core.domain.InfoBuffer;
import com.jspxcms.core.repository.InfoBufferDao;
import com.jspxcms.core.service.InfoBufferService;
import com.jspxcms.core.service.InfoQueryService;

/**
 * InfoBufferServiceImpl
 * 
 * @author liufang
 * 
 */
@Service
@Transactional(readOnly = true)
public class InfoBufferServiceImpl implements InfoBufferService {

	public InfoBuffer get(Integer id) {
		return dao.findOne(id);
	}

	@Transactional
	public InfoBuffer save(InfoBuffer bean, Info info) {
		bean.setInfo(info);
		bean.applyDefaultValue();
		bean = dao.save(bean);
		info.setBuffer(bean);
		return bean;
	}

	@Transactional
	public int updateViews(Integer id) {
		Info info = infoQueryService.get(id);
		InfoBuffer buffer = info.getBuffer();
		if (buffer == null) {
			buffer = new InfoBuffer();
			save(buffer, info);
		}
		int views = info.getViews();
		int buffViews = buffer.getViews() + 1;
		if (buffViews >= 10) {
			buffer.setViews(0);
			info.setViews(views + buffViews);
		} else {
			buffer.setViews(buffViews);
		}
		return views + buffViews;
	}

	@Transactional
	public int updateDownloads(Integer id) {
		Info info = infoQueryService.get(id);
		InfoBuffer buffer = info.getBuffer();
		if (buffer == null) {
			buffer = new InfoBuffer();
			save(buffer, info);
		}
		int downloads = info.getDownloads() + 1;
		info.setDownloads(downloads);
		return downloads;
	}

	private InfoQueryService infoQueryService;
	private InfoBufferDao dao;

	@Autowired
	public void setInfoQueryService(InfoQueryService infoQueryService) {
		this.infoQueryService = infoQueryService;
	}

	@Autowired
	public void setDao(InfoBufferDao dao) {
		this.dao = dao;
	}
}
