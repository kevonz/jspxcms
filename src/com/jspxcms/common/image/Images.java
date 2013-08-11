package com.jspxcms.common.image;

import java.io.InputStream;

import org.apache.commons.lang3.StringUtils;

/**
 * 图片工具类
 * 
 * @author liufang
 * 
 */
public class Images {
	/**
	 * 图片扩展名
	 */
	public static final String[] IMG_EXTENSIONS = new String[] { "jpeg", "jpg",
			"png", "gif", "bmp", "pcx", "iff", "ras", "pbm", "pgm", "ppm",
			"psd" };

	/**
	 * 是否是图片扩展名
	 * 
	 * @param extension
	 * @return
	 */
	public static final boolean isImgExtension(String extension) {
		if (StringUtils.isBlank(extension)) {
			return false;
		}
		for (String imgExt : IMG_EXTENSIONS) {
			if (StringUtils.equalsIgnoreCase(imgExt, extension)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Checks if the underlying input stream contains an image.
	 * 
	 * @param in
	 *            input stream of an image
	 * @return <code>true</code> if the underlying input stream contains an
	 *         image, else <code>false</code>
	 */
	public static boolean isImage(final InputStream in) {
		ImageInfo ii = new ImageInfo();
		ii.setInput(in);
		return ii.check();
	}
}
