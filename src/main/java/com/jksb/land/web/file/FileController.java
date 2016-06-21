package com.jksb.land.web.file;

import java.io.File;














import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jksb.land.common.util.SystemParamUtil;
import com.jksb.land.service.ServiceException;
import com.jksb.land.web.BaseController;


@Controller
@RequestMapping("/file")
public class FileController extends BaseController{
	
	private final static String SYSPARAM_UPLOADPATH = "SYS_PARAM_UPLOADPATH";
	
	private final static String DEFAULT_UPLOADPATH = "/upload";
	
	/**
	 *  文件上传
	 *  
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/upload")
	public String upload(@RequestParam MultipartFile file,HttpServletRequest request){
		String resultCode = "0";
		String filePath = "";
		String fileType = file.getContentType();
		String fileSize= String.valueOf(file.getSize());
		StringBuffer sb = new StringBuffer();
		String myFileName = file.getOriginalFilename();  
		if(myFileName.trim() !=""){  
			//定义上传路径  
			filePath = getUploadFileSavePath() +dynamicPath(request)+getDatePath();  
			try {
				File path =new File(filePath); 
				if(!path .exists()  && !path .isDirectory()) path.mkdirs();
				File localFile = new File(filePath+myFileName);  
        	  	file.transferTo(localFile);
        	  	resultCode = "1";
			} catch (Exception e) {
				throw new ServiceException("文件上传失败",e);
			} 
		}
		sb.append("{'resultCode':'").append(resultCode)
		  .append("','fileName':'").append(myFileName)
		  .append("','fileSize':'").append(fileSize)
		  .append("','fileType':'").append(fileType)
		  .append("','filePath':'").append(filePath).append("'}");
		return sb.toString();
	}
	/**
	 * 下载
	 * @param fileName
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/download")
    public String download(String filePath,String fileName, HttpServletRequest request,
            HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName="
                + fileName);
        try {
            InputStream inputStream = new FileInputStream(new File(filePath
                    + File.separator + fileName));
 
            OutputStream os = response.getOutputStream();
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }
 
             // 这里主要关闭。
            os.close();
 
            inputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
	
	private String getUploadFileSavePath(){
		String path = SystemParamUtil.getParamValueByCode(SYSPARAM_UPLOADPATH);
		if(StringUtils.isBlank(path))
			path = DEFAULT_UPLOADPATH;
		return path;
	}
	
	private String dynamicPath(HttpServletRequest request){
		String path = "default/";
		if(StringUtils.isNotBlank(request.getParameter("savePath")))
			path = request.getParameter("savePath")+"/";
		return path;
	}
	
	private String getDatePath(){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		return sdf.format(date)+"/";
	}
}
