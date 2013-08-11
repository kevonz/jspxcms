package com.jspxcms.core.support;

import com.jspxcms.common.util.Uploads;

/**
 * UploadUtils
 * 
 * @author liufang
 * 
 */
public class UploadUtils {
	public static final String IMAGE = "image";
	public static final String FILE = "file";
	public static final String FLASH = "flash";
	public static final String VIDEO = "video";

	public static final String QUICK_UPLOAD = "public";

	public static String getUrl(Integer siteId, String type, String extension) {
		StringBuilder name = new StringBuilder();
		name.append(Constants.UPLOADS);
		name.append('/').append(siteId);
		name.append('/').append(type);
		name.append('/').append(QUICK_UPLOAD);
		name.append(Uploads.randomName(extension));
		return name.toString();
	}
}
