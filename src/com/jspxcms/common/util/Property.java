package com.jspxcms.common.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;

/**
 * Spring properties工具类
 * 
 * @author liufang
 * 
 */
public class Property implements BeanFactoryAware {
	private BeanFactory beanFactory;
	private Properties properties;

	public void setProperties(Properties properties) {
		this.properties = properties;
	}

	public List<String> getList(String prefix) {
		if (properties == null || prefix == null) {
			return Collections.emptyList();
		}
		List<String> list = new ArrayList<String>();
		Enumeration<?> en = properties.propertyNames();
		String key;
		while (en.hasMoreElements()) {
			key = (String) en.nextElement();
			if (key.startsWith(prefix)) {
				list.add(properties.getProperty(key));
			}
		}
		return list;
	}

	public <T> List<T> getBeanList(String prefix, Class<T> requiredType) {
		List<String> nameList = getList(prefix);
		if (nameList.isEmpty()) {
			return Collections.emptyList();
		}
		List<T> objectList = new ArrayList<T>(nameList.size());
		for (String name : nameList) {
			objectList.add(beanFactory.getBean(name, requiredType));
		}
		return objectList;
	}

	public List<Object> getBeanList(String prefix) {
		return getBeanList(prefix, Object.class);
	}

	public <T> List<T> getBeanList(String prefix, String className)
			throws ClassNotFoundException {
		@SuppressWarnings("unchecked")
		Class<T> clazz = (Class<T>) Class.forName(className);
		return getBeanList(prefix, clazz);
	}

	public void setBeanFactory(BeanFactory beanFactory) throws BeansException {
		this.beanFactory = beanFactory;
	}
}
