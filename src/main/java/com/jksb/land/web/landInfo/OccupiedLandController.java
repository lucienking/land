package com.jksb.land.web.landInfo;

import java.util.Date;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.landInfo.OccupiedLandInfoForm;
import com.jksb.land.entity.landInfo.OccupiedLandInfoNoAuthForm;
import com.jksb.land.service.landInfo.OccupiedLandService;
import com.jksb.land.web.BaseController;

@Controller
@RequestMapping("/occupiedLand")
public class OccupiedLandController extends BaseController{

	private  static final String isAuthentic = "Y";
	
	private  static final String isNotAuthentic = "N";
	
	@Autowired
	private OccupiedLandService occupiedLandSerive;
	
	@RequestMapping("/occupiedLandToAdd")
	public String occupiedLandToAdd(Model model){
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/landInfo/occupiedLandToAdd";
	}
	
	/**
	 * @author chens
	 * 已确权被占地信息登记
	 * 
	 * */
	@RequestMapping("/addOccupiedLand")
	@ResponseBody
	public Map<String,Object> addOccupiedLand(@Valid OccupiedLandInfoForm occupiedLandInfoForm){
		Date date = new Date();
		String userAccount = PrincipalUtil.getCurrentUserAccount();
		occupiedLandInfoForm.setCreateTime(date);
		occupiedLandInfoForm.setCreateName(userAccount);
		occupiedLandInfoForm.setIsAuthentic(isAuthentic);
		try {
			this.occupiedLandSerive.saveOccupiedLand(occupiedLandInfoForm);
			return convertToResult("message","登记成功");
		} catch (Exception e) {
			e.printStackTrace();
			return convertToResult("message","系统运行出错，请联系管理员");
		}
	}
	/**
	 * @author chens
	 * 校验编号是否存在
	 * 
	 * */
	@RequestMapping("/getFormByNum")
	@ResponseBody
	public OccupiedLandInfoForm getFormByNum(String num){
		OccupiedLandInfoForm form = null;
		try {
			form = occupiedLandSerive.getResearchFormByNum(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  form;
	}
	
	/**
	 * @author chens
	 * 未确权被占地登记
	 * 
	 * */
	@RequestMapping("/occupiedLandToAddNoAuthenticLight")
	public String occupiedLandNoAuthenticLightToAdd(Model model){
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/landInfo/occupiedLandToAddNoAuthenticLight";
	}
	
	
	@RequestMapping("/addOccupiedLandNoAuthenticLight")
	@ResponseBody
	public Map<String,Object> addOccupiedLandNoAuthenticLight(@Valid OccupiedLandInfoNoAuthForm occupiedLandInfoNoAuthForm){
		Date date = new Date();
		String userAccount = PrincipalUtil.getCurrentUserAccount();
		occupiedLandInfoNoAuthForm.setCreateTime(date);
		occupiedLandInfoNoAuthForm.setCreateName(userAccount);
		occupiedLandInfoNoAuthForm.setIsAuthentic(isNotAuthentic);
		try {
			this.occupiedLandSerive.saveOccupiedLandInfoNoAuth(occupiedLandInfoNoAuthForm);
			return convertToResult("message","登记成功");
		} catch (Exception e) {
			e.printStackTrace();
			return convertToResult("message","系统运行出错，请联系管理员");
		}
	}
	
	@RequestMapping("/getNoAuthFormByNum")
	@ResponseBody
	public OccupiedLandInfoNoAuthForm getFormNoAuthByNum(String num){
		OccupiedLandInfoNoAuthForm form = null;
		try {
			form = occupiedLandSerive.getResearchNoAuthFormByNum(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  form;
	}
	
}
