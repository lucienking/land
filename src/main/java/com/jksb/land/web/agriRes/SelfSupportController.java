package com.jksb.land.web.agriRes;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.agriRes.AgriPerson;
import com.jksb.land.entity.agriRes.AgriResearchForm;
import com.jksb.land.entity.agriRes.AgriSelfParcel;
import com.jksb.land.entity.agriRes.AgriSubContract;
import com.jksb.land.rest.RestRemoteTransfer;
import com.jksb.land.service.ServiceException;
import com.jksb.land.service.agriRes.AgriResearchService;
import com.jksb.land.service.common.ProcedureExecuteService;
import com.jksb.land.web.BaseController;

/**
 * 农用地调查 - 自营经济地调查
 * 
 * @author wangxj
 *
 */

@Controller
@RequestMapping("/agriRes/selfSupport")
public class SelfSupportController extends BaseController {
	
	@Autowired
	private AgriResearchService agriResearchService;
	
	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	@Autowired
	private RestRemoteTransfer restRemoteTransfer;
	
	private final static Logger logger = LoggerFactory.getLogger(SelfSupportController.class);
	
	/**
	 * 人口信息登记菜单
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/people")
	@RequiresPermissions("009002")
	public String  people(Model model){	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		model.addAttribute("date",sdf.format(new Date()));
		return "/agriRes/familypeopleinfo";
	}
	
	/**
	 * 人口信息调查登记
	 */
	@ResponseBody
	@RequestMapping(value = "/createForm", method = RequestMethod.POST)
	@RequiresPermissions("009002")
	public Map<String,Object>  submitResearch(@Valid AgriResearchForm agriResearchForm){
		
		List<AgriPerson> person = agriResearchForm.getAgriPerson();
		agriResearchForm.setAgriPerson(person);
		
		agriResearchService.saveResearch(agriResearchForm);
		return convertToResult("message","登记成功"); 
	}
	
	/**
	 * 土地信息调查登记
	 */
	@ResponseBody
	@RequestMapping(value = "/addLandInfo", method = RequestMethod.POST)
	@RequiresPermissions("009002")
	public Map<String,Object>  submitLand(@ModelAttribute("form") AgriResearchForm agriResearchForm,
			AgriResearchForm form){
		
		List<AgriSelfParcel> agriSelfParcel = form.getAgriSelfParcel();
		agriResearchForm.setAgriSelfParcel(agriSelfParcel); 
		List<AgriSubContract> agriSubContract = form.getAgriSubContract();
		agriResearchForm.setAgriSubContract(agriSubContract);
		
		agriResearchService.saveResearch(agriResearchForm);
		return convertToResult("message","登记成功"); 
	}
	
	/**
	 * 土地信息登记菜单
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/land")
	@RequiresPermissions("009002")
	public String  land(Model model){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/agriRes/familylandinfo";
	}
	
	/**
	 * 地块信息调查登记
	 */
	
	@ResponseBody
	@RequestMapping(value = "/createParcel", method = RequestMethod.POST)
	@RequiresPermissions("009002")
	public Map<String,Object>  submitParcel(@Valid AgriResearchForm agriResearchFormInfo){
		agriResearchService.saveResearch(agriResearchFormInfo);
		return convertToResult("message","登记成功"); 
	}
	
	/**
	 * 农用地调查信息查询
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/formInfoQuery")
	@RequiresPermissions("009")
	public String  formQuery(Model model,String farmCode,String zdCode){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		if(farmCode!= null &&farmCode != "" && zdCode !=null && zdCode!=""){
			model.addAttribute("queryfarmCode", farmCode);
			model.addAttribute("zdCode", zdCode);
		}
		return "/agriRes/formInfoQuery";
	}
	
	/**
	 * 条件查询调查表
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getFormInfoByCondition")
	public Map<String,Object> getFormInfo(HttpServletRequest request) throws ParseException{
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("cardNo",getParameter("cardNo") );
		param.put("familyNo",getParameter("familyNo") );
		param.put("familyHost",getParameter("familyHost") );
		param.put("telephoneNumber",getParameter("telephoneNumber") );
		param.put("farmCode",getParameter("farmCode") );
		param.put("zdCode",getParameter("zdCode") );
		
		StringBuilder sb = new StringBuilder();
		sb.append("land_proc_agriSearchForm_query(:cardNo,:familyNo,:familyHost,:telephoneNumber,");
		sb.append(":farmCode,:zdCode,");
		sb.append(":queryTotal,:pageSize,:pageNumber,:orderStr,:orderDerect)");
		Map<String,Object> list = procedureExecuteService
				.getLandResult(sb.toString(),param,getPage(request));
		return list;
	}
	
	
	/**
	 * 根据Id 查找调查表详细信息展示页面
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/formDetailInfo")
	public String contractDetailInfo(Long id,Model model){
		AgriResearchForm form = agriResearchService.getResearchFormById(id);
		int parcelNum = form.getAgriSelfParcel() == null?0:form.getAgriSelfParcel().size();
		int subContractNum = form.getAgriSubContract() == null ? 0:form.getAgriSubContract().size();
		int parcel = (7-parcelNum)>0?(7-parcelNum):0;
		int subContract = (7-subContractNum)>0?(7-subContractNum):0;
		if(parcelNum>7 && subContractNum<7)
			subContract = parcelNum-subContractNum;
		else if (parcelNum < 7 && subContractNum>7)
			parcel = subContractNum-parcelNum;
		model.addAttribute("form",form);
		model.addAttribute("parcelNum",parcel);
		model.addAttribute("subContractNum",subContract);
		model.addAttribute("totalNum",subContractNum>parcelNum?subContractNum:parcelNum);
		return  "/agriRes/formInfoDetail";
	}
	
	/**
	 * 根据Id 查找调查表详细信息编辑页面
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/formDetailEdit")
	public String contractDetailEdit(Long id,Model model){
		AgriResearchForm form = agriResearchService.getResearchFormById(id);
		int parcelNum = form.getAgriSelfParcel() == null?0:form.getAgriSelfParcel().size();
		int subContractNum = form.getAgriSubContract() == null ? 0:form.getAgriSubContract().size();
		int parcel = (7-parcelNum)>0?(7-parcelNum):0;
		int subContract = (7-subContractNum)>0?(7-subContractNum):0;
		if(parcelNum>7 && subContractNum<7)
			subContract = parcelNum-subContractNum;
		else if (parcelNum < 7 && subContractNum>7)
			parcel = subContractNum-parcelNum;
		model.addAttribute("form",form);
		model.addAttribute("parcelNum",parcel);
		model.addAttribute("subContractNum",subContract);
		model.addAttribute("totalNum",subContractNum>parcelNum?subContractNum:parcelNum);
		return  "/agriRes/formInfoEdit";
	}
	
	/**
	 * 调查表编辑
	 * @param contract
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/formInfoUpdate", method = RequestMethod.POST)
	public  Map<String,Object> updateFormInfo(@ModelAttribute("form")  AgriResearchForm agriResearchFormInfo,
			  AgriResearchForm agriResearchForm){
		List<AgriPerson> person = agriResearchForm.getAgriPerson();
		agriResearchFormInfo.setAgriPerson(person);
		agriResearchService.saveResearch(agriResearchFormInfo);
		return convertToResult("message","编辑成功"); 
	}
	
	/**
	 * 删除调查表
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/formdelete", method = RequestMethod.GET)
	public Map<String,Object>  delete(Long id){
		agriResearchService.deleteResearch(id);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 农用地调查地块打印
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/agriPrintQuery")
	@RequiresPermissions("009")
	public String  agriPrintQuery(Model model){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/agriRes/agriPrintQuery";
	}
	
	/**
	 * 条件查询地块
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getAgriSelfParcel")
	public Map<String,Object> getAgriSelfParcel(HttpServletRequest request) throws ParseException{
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("familyHost",getParameter("familyHost") );
		param.put("IDcardNo",getParameter("idcardNo") );
		param.put("farmCode",getParameter("farmCode") );
		param.put("zdCode",getParameter("zdCode") );
		
		StringBuilder sb = new StringBuilder();
		sb.append("land_proc_agriSelfParcel_query(:familyHost,:IDcardNo,");
		sb.append(":farmCode,:zdCode,");
		sb.append(":queryTotal,:pageSize,:pageNumber,:orderStr,:orderDerect)");
		Map<String,Object> list = procedureExecuteService
				.getLandResult(sb.toString(),param,getPage(request));
		return list;
	}
	
	
	
	@RequestMapping(method = RequestMethod.GET,value = "/forwardToMap")
	@RequiresPermissions("009")
	public String  forwardToMap(Model model,String farmCode,String zdCode,String groupName,String farmName,String contractorName){	
		model.addAttribute("farmCode",farmCode);
		model.addAttribute("zdCode",zdCode);
		model.addAttribute("groupName",groupName);
		model.addAttribute("farmName",farmName);
		model.addAttribute("contractorName",contractorName);
		return "/agriRes/agrisurveyPrint";
	}
	
	@RequestMapping(method = RequestMethod.GET,value = "/mapPrintPreview")
	@RequiresPermissions("009")
	public String  mapPrintPreview(Model model,String jpgUrl,String title,String department){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String [] jpgUrls = jpgUrl.split(",");
		List<String> list = new ArrayList<String>();
		List<List<String>> pageList = new ArrayList<List<String>>();
		
		for(int i =0;i<jpgUrls.length;i++){
			 list.add(jpgUrls[i]);
			 if((i+1)%4==0||(i+1)==jpgUrls.length) {
				 pageList.add(list);
				 list = new ArrayList<String>();
			 }
		}
		model.addAttribute("pageList",pageList);
		model.addAttribute("title",title);
		model.addAttribute("department",department);
		model.addAttribute("date",sdf.format(new Date()));
		return "/agriRes/mapPrintPreview";
	}
	
	/**
	 * 根据cardNo 查询调查表
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getFormBycardNo")
	public AgriResearchForm getFormBycardNo(String cardNo){
		AgriResearchForm form = agriResearchService.getResearchFormByCardNo(cardNo);
		return  form;
	}
	
	
	@ModelAttribute
	public void getForm(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("form", agriResearchService.getResearchFormById(id));
		}
	}
	
	/**
	 * 人口信息
	 * @param idNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getPeopleInfo")
	public Map<String,Object> getPeopleInfo(String idNo){
		AgriPerson cp = new AgriPerson();
		Map<String, String> map = new HashMap<String,String>();
		try {
			map = restRemoteTransfer.getPeopleInfo(idNo);
			cp.setPersionId(map.get("gmsfhm"));
			cp.setPersonName(map.get("xm"));
			cp.setCurrentResident(map.get("jtzz"));
			logger.info("NO:{},Name:{}",map.get("gmsfhm"),map.get("xm"));
		} catch (Exception e) {
			logger.info("接口错误:{}",e.getMessage());
			throw new ServiceException("接口错误");
		}  
		return convertToResult("person",cp);
	}
}
