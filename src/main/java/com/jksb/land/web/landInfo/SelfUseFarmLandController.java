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
import com.jksb.land.entity.landInfo.SelfUseFarmLand;
import com.jksb.land.entity.landInfo.SelfUseFarmLandForm;
import com.jksb.land.service.landInfo.SelfUseFarmLandService;
import com.jksb.land.web.BaseController;


@Controller
@RequestMapping("/selfUseFarmLand")
public class SelfUseFarmLandController extends BaseController {

	@Autowired
	private SelfUseFarmLandService selfUseFarmService;
	
	@RequestMapping("/selfUseFarmLandAdd")
	public String selfUseFarmLand(Model model){
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/landInfo/selfUseFarmLandToAdd";
	}
	
	/**
	 * 自用农业用地登记
	 * 
	 * */
	@ResponseBody
	@RequestMapping(value="/addSelfUseFarmLand",method = RequestMethod.POST)
	public Map<String,Object> addSelfUseFarmLand(@Valid SelfUseFarmLandForm selfUseFarmLandForm){
		Date date = new Date();
		String userAccount = PrincipalUtil.getCurrentUserAccount();
		List<SelfUseFarmLand> list = selfUseFarmLandForm.getSelfUseFarmLand();
		selfUseFarmLandForm.setSelfUseFarmLand(list);
		selfUseFarmLandForm.setAddTime(date);
		selfUseFarmLandForm.setUserName(userAccount);
		selfUseFarmService.saveSelfUseFarmLand(selfUseFarmLandForm);
		return convertToResult("message","登记成功");
	}
	
	/**
	 * 根据cardNo 查询调查表
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getFormByNum")
	public SelfUseFarmLandForm getFormByNum(String num){
		SelfUseFarmLandForm form = null;
		try {
			form = selfUseFarmService.getResearchFormByNum(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  form;
	}
}
