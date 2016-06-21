package com.jksb.land.web.statistics;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.service.common.ProcedureExecuteService;
import com.jksb.land.web.BaseController;




/**
 * 租金统计Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/statistics/")
public class RentalStatisticsController extends BaseController{

	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	/**
	 * 承包期限统计界面<br/>
	 * 权限编码 008
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/rentalInfo")
	@RequiresPermissions("008")
	public String  rentalInfo(Model model){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "statistics/rentalStatistics";
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getRentalData")
	public List<Map<String,Object>> getRentalData(HttpServletRequest request){
		Map<String,Object> param = new HashMap<String,Object>();
		String farmCode =  request.getParameter("farmCode");
		param.put("farmCode",farmCode );
		
		List<Map<String,Object>> result = procedureExecuteService.getLandResult("land_proc_contract_rentalInfoStatistics(:farmCode)", param);
		return result;
	}
}
