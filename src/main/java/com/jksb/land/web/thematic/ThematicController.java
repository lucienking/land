package com.jksb.land.web.thematic;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jksb.land.common.util.FileUtil;
import com.jksb.land.common.util.JsonMapper;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.common.util.doc.DocProcess;
import com.jksb.land.common.util.json.MessageObject;
import com.jksb.land.service.common.ProcedureExecuteService;
import com.jksb.land.web.BaseController;

@Controller
@RequestMapping(value = "/thematicMap/")
public class ThematicController extends BaseController {

	@Autowired
	private ProcedureExecuteService procedureExecuteService;

	/**
	 * 土地属性值PH
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/PH")
	public String ph() {
		return "/thematicMap/ph";

	}

	/**
	 * 种植作物管理
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/plantingCropsManage")
	public String plantingCropsManage(Model model) {
		model.addAttribute("farmName",
				PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode",
				PrincipalUtil.getCurrentUserDepartmentCode());
		return "/thematicMap/plantingCropsManage";
	}

	/**
	 * 土地直方图
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/statistics")
	public String statistics() {

		return "/thematicMap/statistics";
	}

	/**
	 * 被占地
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/occupied")
	public String occupied() {
		return "/thematicMap/occupied";
	}

	/**
	 * 影像
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/image")
	public String image() {
		return "/thematicMap/image";
	}

	/**
	 * 芒果分布专题图
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/mango")
	public String mango() {
		return "/thematicMap/mango";
	}

	/**
	 * 芒果获取农场编号和农场编码
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/mangguoOrg")
	public List<Map<String, Object>> mangguoOrg() {
		String queryStr = "select t.farmCode farmCode,t.NCMC NCMC,'false' selected  from LG_ZIYINGJINGJI_MANGGUO t group by t.farmCode,t.NCMC";
		List<Map<String, Object>> list = procedureExecuteService
				.getArcgisQueryResult(queryStr, null);
		return list;
	}
	/**
	 * 自营经济获取农场编号和农场编码
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/zyjjOrg")
	public List<Map<String, Object>> zyjjOrg() {
		String queryStr = "select t.farmcode farmCode,t.NCMC NCMC from ZYJJ_HNNC t group by t.farmcode,t.NCMC";
		List<Map<String, Object>> list = procedureExecuteService
				.getArcgisQueryResult(queryStr, null);
		return list;
	}
	/**
	 * 获取农场编号和农场编码
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/imageOrg")
	public List<Map<String, Object>> imageOrg() {
		String queryStr = "select t.DataId farmCode,t.OrganName NCMC from HNNC_CJ_WGS84 t group by t.DataId,t.OrganName";
		List<Map<String, Object>> list = procedureExecuteService
				.getArcgisQueryResult(queryStr, null);
		return list;
	}

	/**
	 * 自营经济图
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/selfEconomy")
	public String landuse() {
		return "/thematicMap/selfEconomy";
	}

	/**
	 * 权属图
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/ownership")
	public String ownership() {
		return "/thematicMap/ownership";
	}

	/**
	 * 林地
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/wood")
	public String wood() {
		return "/thematicMap/wood";
	}

	/**
	 * 影像卷帘
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/mapswipe")
	public String mapswipe() {
		return "/thematicMap/mapswipe";
	}

	/**
	 * 分析功能
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/analysis")
	public String analysis() {
		return "/thematicMap/analysis";
	}

	/**
	 * 农用地调查功能
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/agrisurvey")
	public String agrisurvey() {
		return "/thematicMap/agrisurvey";
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

	private String getDocSavePath() {
		String userDir = FileUtil.getUserDir();
		String dir = userDir + File.separator + "temp_land_download";
		System.out.println("发包文件保存路径:" + dir);
		return dir;
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

	/**
	 * 传入IntersectAndtoJson的参数、服务地址，并返回json的值
	 * 
	 * @param request
	 * @return
	 * @throws ClientProtocolException
	 * @throws IOException
	 */

	@SuppressWarnings("static-access")
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/runIntersectGeoProcessing")
	public static String runIntersectGeoProcessing(HttpServletRequest request)
			throws ClientProtocolException, IOException {
		String itemId = request.getParameter("itemID");
		String landuse = request.getParameter("landuse");
		String intersectService = request.getParameter("intersectservice");
		String Intersect_input = request.getParameter("Intersect_input");
		String path_ToJSON = request.getParameter("path_ToJSON");
		String serverPath = request.getParameter("serverPath");
		String intersectJson = null;
		// String filepath = null;

		if (itemId != null && intersectService != null && serverPath != null
				&& landuse != null && Intersect_input != null
				&& path_ToJSON != null && intersectService != null) {
			CloseableHttpClient httpclient = HttpClients.createDefault();
			HttpPost httppost = new HttpPost(intersectService); // 初始化httpClient
			List<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();

			params.add(new BasicNameValuePair("itemId", itemId));
			params.add(new BasicNameValuePair("serverPath", serverPath));
			params.add(new BasicNameValuePair("Landuse", landuse));
			params.add(new BasicNameValuePair("Intersect_input",
					Intersect_input));
			params.add(new BasicNameValuePair("path_ToJSON", path_ToJSON));
			params.add(new BasicNameValuePair("f", "pjson"));// 每个GP必须的参数

			httppost.setEntity(new UrlEncodedFormEntity(params)); // 设置请求参数

			HttpResponse re = httpclient.execute(httppost);
			String bodyAsString = EntityUtils.toString(re.getEntity()); // 得到响应报文
			System.out.println("bodyAsString:" + bodyAsString);
			intersectJson = bodyAsString;

		} else {
			System.out.println("传入参数为空");
		}
		return intersectJson;
	}

}
