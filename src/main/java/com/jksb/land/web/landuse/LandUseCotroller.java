package com.jksb.land.web.landuse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.util.FileUtil;
import com.jksb.land.common.util.doc.DocProcess;
import com.jksb.land.common.util.json.MessageObject;
import com.jksb.land.service.common.ProcedureExecuteService;
import com.jksb.land.web.BaseController;

/**
 * 土地利用现状
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/landuse/")
public class LandUseCotroller extends BaseController {
	
	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	/**
	 * 土地利用现状
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/landuse")
	public String landuse(){
		return "/landuse/landuse";
	}
	
	/**
	 * 土地利用现状(全垦区)
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/landuseAll")
	public String landuseAll(){
		return "/landuse/landuseAll";
	}
	/**
	 * 规划图
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/guiHua")
	public String guiHua(){
		return "/landuse/guiHua";
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/guiHuaOrg")
	public List<Map<String,Object>>  guiHuaOrg(){
		String queryStr = "select t.farmCode farmCode,t.NCMC NCMC from GUIHUA_SHIDIAN t group by t.farmCode,t.NCMC";
		List<Map<String,Object>> list = procedureExecuteService.getArcgisQueryResult(queryStr, null);
		return list;
	}
	
	@RequestMapping("/buildDoc")
	@ResponseBody
	public MessageObject buildDoc(HttpServletResponse response, String picHref) {
		MessageObject mo = new MessageObject();
		try {
			String fileName = tempPic(picHref);
			mo.setCode("1");
			mo.setMessage(fileName);
		} catch (Exception e) {
			mo.setCode("0");
			mo.setMessage("");
			e.printStackTrace();
		}
		return mo;
	}
	@RequestMapping("/downLoadDoc")
	public void downLoadDoc(HttpServletRequest request,
			HttpServletResponse response) {
		String fileName = request.getParameter("fileName");
		try {
			// path是指欲下载的文件的路径。
			File file = new File(this.getDocSavePath() + File.separator
					+ fileName);
			// 取得文件名。
			String filename = file.getName();
			// 取得文件的后缀名。
			// String ext = filename.substring(filename.lastIndexOf(".") +
			// 1).toUpperCase();

			// 以流的形式下载文件。
			InputStream fis = new BufferedInputStream(new FileInputStream(file));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer);
			fis.close();
			// 清空response
			response.reset();
			// 设置response的Header
			response.addHeader("Content-Disposition", "attachment;filename="
					+ new String(filename.getBytes("utf-8"), "ISO-8859-1"));
			response.addHeader("Content-Length", "" + file.length());
			OutputStream toClient = new BufferedOutputStream(
					response.getOutputStream());
			response.setContentType("application/octet-stream");
			toClient.write(buffer);
			toClient.flush();
			toClient.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			FileUtil.delFile(this.getDocSavePath() + File.separator + fileName);
		}
	}

	private String tempPic(String href) throws Exception {
		String dir = this.getDocSavePath();
		FileUtil.checkDirExists(dir);
		String fileName = href.substring(href.lastIndexOf("/") + 1);
		DocProcess.download(href, fileName, dir);
		String docName = System.currentTimeMillis() + ".doc";
		String docPath = dir + File.separator + docName;

		String picPath = dir + File.separator + fileName;
		System.out.println("开始创建Doc文件...");
		DocProcess.createWordFile("土地承包发包方案\r\npic", docPath);
		System.out.println(docPath + "创建成功...开始插入图片.");
		DocProcess.insertImage(docPath, picPath, "pic");
		System.out.println(picPath + "图片插入成功...");
		FileUtil.delFile(picPath);
		return docName;
	}
	

	private String getDocSavePath() {
		String userDir = FileUtil.getUserDir();
		String dir = userDir + File.separator + "temp_land_download";
		System.out.println("发包文件保存路径:" + dir);
		return dir;
	}

}
