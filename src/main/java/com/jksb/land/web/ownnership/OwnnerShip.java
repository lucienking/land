package com.jksb.land.web.ownnership;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.persistence.SearchFilter.Operator;
import com.jksb.land.common.persistence.SpecificationFactory;
import com.jksb.land.common.util.FileUtil;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.common.util.doc.DocProcess;
import com.jksb.land.common.util.json.MessageObject;
import com.jksb.land.entity.mapEntity.OccupiedEntity;
import com.jksb.land.entity.mapEntity.OwnnershipEntity;
import com.jksb.land.service.common.ProcedureExecuteService;
import com.jksb.land.service.ownnership.OccupiedService;
import com.jksb.land.service.ownnership.OwnnershipService;
import com.jksb.land.web.BaseController;

@Controller
@RequestMapping(value = "/ownnership/")
public class OwnnerShip extends BaseController {

	@Autowired
	private OwnnershipService ownnershipService;

	@Autowired
	private OccupiedService occupiedService;

	@Autowired
	private ProcedureExecuteService procedureExecuteService;

	/**
	 * 权属信息
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/ownnershipinfo")
	public String occupied() {
		return "/ownnership/ownnershipinfo";
	}

	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/ownnershipOrg")
	public List<Map<String, Object>> ownnershipOrg() {
		String queryStr = "select t.farmCode farmCode,t.NCMC NCMC from QUANSHU_HNNC t group by t.farmCode,t.NCMC";
		List<Map<String, Object>> list = procedureExecuteService
				.getArcgisQueryResult(queryStr, null);
		return list;
	}

	/**
	 * 争议地管理页面
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/disputeManage")
	@RequiresPermissions("004002")
	public String ownershipManage() {
		return "/ownnership/disputeManage";
	}

	/**
	 * 争议地查询
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/disputeList")
	public Map<String, Object> disputeList(HttpServletRequest request) {
		SpecificationFactory<OwnnershipEntity> specf = new SpecificationFactory<OwnnershipEntity>();
		specf.addSearchParam("parcelCode", Operator.LIKE,
				request.getParameter("parcelCode"));
		specf.addSearchParam("disputeObject", Operator.LIKE,
				request.getParameter("disputeObject"));
		specf.addSearchParam("disputeArea", Operator.GTE,
				request.getParameter("min"));
		specf.addSearchParam("disputeArea", Operator.LTE,
				request.getParameter("max"));
		specf.addSearchParam("farmCode", Operator.EQ,
				PrincipalUtil.getCurrentUserDepartmentCode());
		Page<OwnnershipEntity> ownershipEntitys = ownnershipService
				.getAllOwnnerParcel(specf.getSpecification(),
						buildPageRequest(request));
		return convertToResult(ownershipEntitys);
	}

	/**
	 * 新增争议地信息
	 * 
	 * @param oe
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("004002001")
	public Map<String, Object> createParcel(@Valid OwnnershipEntity oe) {
		oe.setFarmCode(PrincipalUtil.getCurrentUserDepartmentCode());
		ownnershipService.saveDisputeParcel(oe);
		return convertToResult("message", "新增成功");
	}

	/**
	 * 编辑争议地
	 * 
	 * @param oe
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("004002003")
	public Map<String, Object> updateParcel(@Valid OwnnershipEntity oe) {
		oe.setFarmCode(PrincipalUtil.getCurrentUserDepartmentCode());
		ownnershipService.saveDisputeParcel(oe);
		return convertToResult("message", "修改成功");
	}

	/**
	 * 删除多个争议地
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@RequiresPermissions("004002002")
	public Map<String, Object> deleteParcel(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		String[] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for (String id : idarr) {
			idlist.add(Long.valueOf(id));
		}
		ownnershipService.deleteDisputeParcel(idlist);
		return convertToResult("message", "删除成功");
	}

	// 被占地管理------------------------------------------------------------------------------------------------------------------------------
	/**
	 * 被占地管理页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/occupiedManage")
	@RequiresPermissions("004003")
	public String occupiedManage(Model model) {
		return "/ownnership/occupiedManage";
	}

	/**
	 * 被占地信息列表
	 * 
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/occupiedList")
	public Map<String, Object> occupiedList(HttpServletRequest request)
			throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SpecificationFactory<OccupiedEntity> specif = new SpecificationFactory<OccupiedEntity>();
		specif.addSearchParam("occupiedNO", Operator.LIKE,
				request.getParameter("occupiedNO"));
		specif.addSearchParam("isWoodland", Operator.EQ,
				request.getParameter("isWoodland"));
		specif.addSearchParam("occupiedArea", Operator.GTE,
				request.getParameter("occupiedArea_low"));
		specif.addSearchParam("occupiedArea", Operator.LTE,
				request.getParameter("occupiedArea_high"));
		specif.addSearchParam("isWoodland", Operator.EQ,
				request.getParameter("isWoodland"));
		specif.addSearchParam("issueSituation", Operator.EQ,
				request.getParameter("issueSituation"));
		specif.addSearchParam("certificateNO", Operator.LIKE,
				request.getParameter("certificateNO"));
		specif.addSearchParam("originalType", Operator.EQ,
				request.getParameter("originalType"));
		specif.addSearchParam("currentUse", Operator.EQ,
				request.getParameter("currentUse"));
		specif.addSearchParam("occupiedObject", Operator.EQ,
				request.getParameter("occupiedObject"));
		specif.addSearchParam("occupiedForm", Operator.EQ,
				request.getParameter("occupiedForm"));
		specif.addSearchParam("processingMeans", Operator.EQ,
				request.getParameter("processingMeans"));
		specif.addSearchParam("isTransfer", Operator.EQ,
				request.getParameter("isTransfer"));
		specif.addSearchParam(
				"occupiedDate",
				Operator.GTE,
				request.getParameter("occupiedDate_low") == null ? null : sdf
						.parse(request.getParameter("occupiedDate_low")));
		specif.addSearchParam(
				"occupiedDate",
				Operator.LTE,
				request.getParameter("occupiedDate_high") == null ? null : sdf
						.parse(request.getParameter("occupiedDate_high")));
		specif.addSearchParam(
				"issueingDate",
				Operator.GTE,
				request.getParameter("issueingDate_low") == null ? null : sdf
						.parse(request.getParameter("issueingDate_low")));
		specif.addSearchParam(
				"issueingDate",
				Operator.LTE,
				request.getParameter("issueingDate_high") == null ? null : sdf
						.parse(request.getParameter("issueingDate_high")));
		specif.addSearchParam("farmCode", Operator.EQ,
				PrincipalUtil.getCurrentUserDepartmentCode());
		Page<OccupiedEntity> oes = occupiedService.getOccupied(
				specif.getSpecification(), buildPageRequest(request));
		return convertToResult(oes);
	}

	/**
	 * 新增被占地信息
	 * 
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/occupiedcreate")
	public Map<String, Object> occupiedCreate(@Valid OccupiedEntity oe) {
		oe.setFarmCode(PrincipalUtil.getCurrentUserDepartmentCode());
		occupiedService.savaOccupiedEntity(oe);
		return convertToResult("message", "添加成功");
	}

	/**
	 * 修改被占地信息
	 * 
	 * @param oe
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/occupiedupdate")
	public Map<String, Object> occupiedUpdate(@Valid OccupiedEntity oe) {
		oe.setFarmCode(PrincipalUtil.getCurrentUserDepartmentCode());
		occupiedService.savaOccupiedEntity(oe);
		return convertToResult("message", "修改成功");
	}

	/**
	 * 删除多个争议地
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/occupieddelete")
	public Map<String, Object> occupieddelete(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		String[] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for (String id : idarr) {
			idlist.add(Long.valueOf(id));
		}
		occupiedService.deleteOccupiedParcels(idlist);
		return convertToResult("message", "删除成功");
	}

	// 文件控制-------------------------------------------------------------------------------------------------------------------------------
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

}
