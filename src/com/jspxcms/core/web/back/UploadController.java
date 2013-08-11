package com.jspxcms.core.web.back;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.util.CollectionUtils;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jspxcms.common.image.Images;
import com.jspxcms.common.util.Files;
import com.jspxcms.common.util.JsonMapper;
import com.jspxcms.common.web.PathResolver;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.support.Context;
import com.jspxcms.core.support.UploadUtils;

/**
 * UploadController
 * 
 * @author liufang
 * 
 */
@Controller
@RequestMapping("/core")
public class UploadController {
	private static final Logger logger = LoggerFactory
			.getLogger(UploadController.class);

	@RequiresPermissions("core:upload:image")
	@RequestMapping(value = "upload_image.do", method = RequestMethod.POST)
	public void uploadImage(Boolean watermark, Boolean scale, Integer width,
			Integer height, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		upload(request, response, UploadUtils.IMAGE, watermark, scale, width,
				height);
	}

	@RequiresPermissions("core:upload:flash")
	@RequestMapping(value = "upload_flash.do", method = RequestMethod.POST)
	public void uploadFlash(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		upload(request, response, UploadUtils.FLASH);
	}

	@RequiresPermissions("core:upload:file")
	@RequestMapping(value = "upload_file.do", method = RequestMethod.POST)
	public void uploadFile(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		upload(request, response, UploadUtils.FILE);
	}

	@RequiresPermissions("core:upload:video")
	@RequestMapping(value = "upload_video.do", method = RequestMethod.POST)
	public void uploadVideo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		upload(request, response, UploadUtils.VIDEO);
	}

	private void upload(HttpServletRequest request,
			HttpServletResponse response, String type) throws IOException {
		upload(request, response, type, null, null, null, null);
	}

	private void upload(HttpServletRequest request,
			HttpServletResponse response, String type, Boolean watermark,
			Boolean scale, Integer width, Integer height) throws IOException {
		Site site = Context.getCurrentSite(request);
		String contextPath = request.getContextPath();
		MultipartFile file = getUploadFile(request);
		Map<String, Object> resultMap = doUpload(file, type, site.getId(),
				contextPath, watermark, scale, width, height);
		String ckeditor = request.getParameter("CKEditor");
		if (ckeditor != null) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			String error = resultMap.get("error").toString();
			String callback = request.getParameter("CKEditorFuncNum");
			out.println("<script type=\"text/javascript\">");
			out.println("(function(){var d=document.domain;while (true){try{var A=window.parent.document.domain;break;}catch(e) {};d=d.replace(/.*?(?:\\.|$)/,'');if (d.length==0) break;try{document.domain=d;}catch (e){break;}}})();\n");
			if (StringUtils.isBlank(error)) {
				String fileUrl = resultMap.get("fileUrl").toString();
				out.println("window.parent.CKEDITOR.tools.callFunction("
						+ callback + ",'" + fileUrl + "',''" + ");");
			} else {
				out.println("alert('" + error + "');");
			}
			out.print("</script>");
			out.flush();
			out.close();
		}
		JsonMapper mapper = new JsonMapper();
		String json = mapper.toJson(resultMap);
		logger.debug(json);
		Servlets.writeHtml(response, json);
	}

	private Map<String, Object> doUpload(MultipartFile file, String type,
			Integer siteId, String contextPath, Boolean watermark,
			Boolean scale, Integer width, Integer height) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (file == null || file.isEmpty()) {
			map.put("error", "no file upload!");
			logger.debug("file is empty");
		} else {
			String extension = FilenameUtils.getExtension(
					file.getOriginalFilename()).toLowerCase();
			if (!UploadUtils.IMAGE.equals(type) || watermark == null) {
				watermark = false;
			}
			if (!UploadUtils.IMAGE.equals(type) || scale == null
					|| width == null || height == null) {
				scale = false;
			}
			if (scale) {
				try {
					if (!Images.isImgExtension(extension)
							|| !Images.isImage(file.getInputStream())) {
						scale = false;
					}
				} catch (IOException e) {
					logger.error("", e);
					scale = false;
				}
			}
			String url = UploadUtils.getUrl(siteId, type, extension);
			File dest = getDestFile(url);

			try {
				dest.mkdirs();
				if (scale) {
					storeImg(file, width, height, dest, extension);
				} else {
					file.transferTo(dest);
				}
				String fileName = file.getOriginalFilename();
				long fileLength = file.getSize();
				String fileUrl;
				if (StringUtils.isNotBlank(contextPath)) {
					fileUrl = contextPath + url;
				} else {
					fileUrl = url;
				}
				map.put("error", "");
				map.put("fileUrl", fileUrl);
				map.put("fileName", fileName);
				map.put("fileLength", fileLength);
				map.put("fileExtension", extension);
			} catch (IllegalStateException e) {
				map.put("error", e.getMessage());
				logger.error("", e);
			} catch (IOException e) {
				map.put("error", e.getMessage());
				logger.error("", e);
			}
		}
		return map;
	}

	private MultipartFile getUploadFile(HttpServletRequest request) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		if (CollectionUtils.isEmpty(fileMap)) {
			throw new IllegalStateException("No upload file found!");
		}
		return fileMap.entrySet().iterator().next().getValue();
	}

	private File getDestFile(String url) {
		String real = pathResolver.getPath(url);
		logger.debug("file path: " + real);
		File dest = new File(real);
		dest = Files.getUniqueFile(dest);
		return dest;
	}

	private void storeImg(MultipartFile file, Integer width, Integer height,
			File dest, String extension) throws IOException {
		BufferedImage buff = ImageIO.read(file.getInputStream());
		BufferedImage thumbnail = Scalr.resize(buff, Scalr.Method.QUALITY,
				width, height);
		ImageIO.write(thumbnail, extension, dest);
	}

	private PathResolver pathResolver;

	@Autowired
	public void setPathResolver(PathResolver pathResolver) {
		this.pathResolver = pathResolver;
	}
}
