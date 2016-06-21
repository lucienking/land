package com.jksb.land.web.landInfo;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.landInfo.BasicSituationOfLand;
import com.jksb.land.entity.landInfo.ExternalCompanyOrPersonalLandRentForm;
import com.jksb.land.service.landInfo.LandLeaseService;
import com.jksb.land.web.BaseController;

@Controller
@RequestMapping("/LandLease")
public class LandLeaseController extends BaseController{
	
	@Autowired
	private LandLeaseService leaseService;

	@RequestMapping("/toLandLeaseAdd")
	public String toLandLeaseAdd(Model model){
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/landInfo/landLeaseToAdd";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/addLandLease",method = RequestMethod.POST)
	public Map<String,Object> addSelfUseFarmLand(@Valid ExternalCompanyOrPersonalLandRentForm externalCompanyOrPersonalLandRentForm){
		Date date = new Date();
		String userAccount = PrincipalUtil.getCurrentUserAccount();
		List<BasicSituationOfLand> list = externalCompanyOrPersonalLandRentForm.getBasicSituationOfLands();
		externalCompanyOrPersonalLandRentForm.setBasicSituationOfLands(list);
		externalCompanyOrPersonalLandRentForm.setCreateTime(date);
		externalCompanyOrPersonalLandRentForm.setCreateName(userAccount);
		try {
			leaseService.saveLandLease(externalCompanyOrPersonalLandRentForm);
			return convertToResult("message","登记成功");
		} catch (Exception e) {
			e.printStackTrace();
			return convertToResult("message","系统运行出错，请联系管理员");
		}
	}
	
	/**
	 * 根据cardNo 查询调查表
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getFormByNum")
	public ExternalCompanyOrPersonalLandRentForm getFormByNum(String num){
		ExternalCompanyOrPersonalLandRentForm form = null;
		try {
			form = leaseService.getResearchFormByNum(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  form;
	}
}
