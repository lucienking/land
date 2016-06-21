package com.jksb.land.web.landCircul;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.persistence.SpecificationFactory;
import com.jksb.land.common.persistence.SearchFilter.Operator;
import com.jksb.land.common.util.CommonUtil;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.landCircul.LandCirculation;
import com.jksb.land.entity.staticData.ResidentsGroup;
import com.jksb.land.entity.sys.Attachment;
import com.jksb.land.service.landCircul.LandCirculService;
import com.jksb.land.service.staticData.ResidentsGroupService;
import com.jksb.land.web.BaseController;

/**
 * 土地流转controller
 * 
 * @author wangxj
 *
 */

@Controller
@RequestMapping("/landCirculation")
public class LandCirculController extends BaseController {
	
	@Autowired
	private ResidentsGroupService residentsGroupService;
	
	@Autowired
	private LandCirculService landCirculService;
	
	/**
	 * 土地流转申请界面
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/application")
	@RequiresPermissions("011")
	public String  application(Model model){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		model.addAttribute("currentDate", CommonUtil.getNowDateFormat("yyyy-MM-dd"));
		
		return "/landCircul/application";
	} 
	
	/**
	 * 申请提交
	 * @param contract
	 * @param residentsGroup
	 * @param contractorType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create/{status}", method = RequestMethod.POST)
	@RequiresPermissions("011")
	public Map<String,Object>  createApplication(@Valid LandCirculation circulation,
					@ModelAttribute("group")ResidentsGroup residentsGroup,
					 @PathVariable("status") String status){
		circulation.setResidentsGroup(residentsGroup);
		
		//合同附件
		List<Attachment> as = circulation.getAttachment();
		circulation.setAttachment(as);
		
		circulation.setUserId(PrincipalUtil.getCurrentUserAccount());
		circulation.setUserName(PrincipalUtil.getCurrentUserName());
		circulation.setCurrentUserId(PrincipalUtil.getCurrentUserAccount());
		circulation.setCurrentUserName(PrincipalUtil.getCurrentUserName());
		
		circulation.setCirculStatus(status);
		
		landCirculService.saveLandCirculation(circulation,"提交",null,status);
		return convertToResult("message","操作成功"); 
	}
	
	/**
	 * 申请提交
	 * @param contract
	 * @param residentsGroup
	 * @param contractorType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/edit/{status}", method = RequestMethod.POST)
	@RequiresPermissions("011")
	public Map<String,Object>  editApplication(@ModelAttribute("application") LandCirculation circulation,
					@ModelAttribute("group")ResidentsGroup residentsGroup,
					 @PathVariable("status") String status){
		circulation.setResidentsGroup(residentsGroup);
		
		//合同附件
		List<Attachment> as = circulation.getAttachment();
		circulation.setAttachment(as);
		
		PrincipalUtil.getCurrentUserAccount();
		
		circulation.setCirculStatus(status);
		
		landCirculService.saveLandCirculation(circulation,"提交",null,status);
		return convertToResult("message","操作成功"); 
	}
	
	/**
	 * 申请更改
	 * @param contract
	 * @param residentsGroup
	 * @param contractorType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update/{status}", method = RequestMethod.POST)
	@RequiresPermissions("011")
	public Map<String,Object>  createApplication(@ModelAttribute("application")LandCirculation circulation, 
					 @PathVariable("status") String status,@ModelAttribute("opinion")String opinion){
		String nodeName = "";
		circulation.setCirculStatus(status);
		if("CHECKING".equals(status)||"RETURN".equals(status)) nodeName ="认领";
		else if ("CHECKEDSUCCESS".equals(status)||"CHECKEDFAIL".equals(status)) nodeName="审批";
		landCirculService.saveLandCirculation(circulation,nodeName,opinion,status);
		return convertToResult("message","操作成功"); 
	}
	
	@ModelAttribute
	public void getResidentsGroup(@RequestParam(value = "residentsGrpCode", defaultValue = "-1") String code, Model model) {
		if (StringUtils.isNotBlank(code)) {
			model.addAttribute("group", residentsGroupService.getResidentsGroupByCode(code));
		}
	}
	
	@ModelAttribute
	public void getApplication(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
			model.addAttribute("application", landCirculService.getLandCirculationById(id));
	}
	
	/**
	 * 土地流转流程界面
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/process/{type}")
	@RequiresPermissions("011")
	public String  process(Model model,@PathVariable("type") String type){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/landCircul/application"+type;
	}
	
	/**
	 * 查询
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getAllApplication/{type}")
	public Map<String,Object> getPageApplication(HttpServletRequest request,@PathVariable("type") String type) {
		SpecificationFactory<LandCirculation> specf = new SpecificationFactory<LandCirculation>();
		specf.addSearchParam("circulNo", Operator.EQ, request.getParameter("circulNo"));
		List<String> inList = new ArrayList<String>();
		if("Mine".equals(type)){
			inList.add("DRAFT");
			inList.add("RETURN");
			inList.add("PENDING");
			inList.add("CHECKING");
			inList.add("CHECKEDSUCCESS");
			inList.add("CHECKEDFAIL");
			specf.addSearchParam("circulStatus", Operator.IN,inList);
			specf.addSearchParam("userId", Operator.EQ,PrincipalUtil.getCurrentUserAccount());
		}else if("Handling".equals(type)){
			inList.add("CHECKING");
			specf.addSearchParam("circulStatus", Operator.IN,inList);
			specf.addSearchParam("currentUserId", Operator.EQ,PrincipalUtil.getCurrentUserAccount());
		}else if("Handled".equals(type)){
			inList.add("CHECKEDSUCCESS");
			inList.add("CHECKEDFAIL");
			specf.addSearchParam("circulStatus", Operator.IN,inList);
			specf.addSearchParam("currentUserId", Operator.EQ,PrincipalUtil.getCurrentUserAccount());
		} 
		Page<LandCirculation> list = landCirculService
				.getLandCirculationByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(list);
	}
	
	/**
	 * 根据Id 查找申请表详细信息展示页面
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/applicationDetail")
	public String applicationDetail(Long id,Model model){
		LandCirculation circul = landCirculService.getLandCirculationById(id);
		
		model.addAttribute("circul",circul);
		return  "/landCircul/applicationDetail";
	}
	
	/**
	 * 校验编号重复
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/validateCirculNo")
	public Map<String,Object> validateCirculNo(String circulNo) {
		String exist = "N";
		SpecificationFactory<LandCirculation> specf = new SpecificationFactory<LandCirculation>();
		specf.addSearchParam("circulNo", Operator.EQ, getParameter("circulNo"));
		List<LandCirculation> list = landCirculService.getAllLandCirculation(specf.getSpecification());
		if(list.size()>0) exist = "Y";
		return convertToResult("exist",exist);
	}
}
