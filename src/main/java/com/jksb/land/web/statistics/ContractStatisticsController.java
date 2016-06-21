package com.jksb.land.web.statistics;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
 * 承包面积统计Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/statistics/")
public class ContractStatisticsController extends BaseController{

	private final static Logger logger = LoggerFactory.getLogger(ContractStatisticsController.class);
	
	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	/**
	 * 承包面积统计界面<br/>
	 * 权限编码 008
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractArea")
	@RequiresPermissions("008")
	public String  menusManager(Model model){	
		logger.debug("statistics");
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "statistics/contractAreaStatistics";
	}
	
	/**
	 * 承包面积统计过程
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getContractAreaData")
	public List<Map<String,Object>> getContractAreaData(HttpServletRequest request){
		Map<String,Object> param = new HashMap<String,Object>();
		String farmCode = request.getParameter("farmCode") ;
		param.put("farmCode",farmCode );
		
		List<Map<String,Object>> result = procedureExecuteService.getLandResult("land_proc_contract_rentAreaStatistics(:farmCode)", param);
		
		return result;
	}
	
	/**
	 * 管理费用收取情况统计界面<br/>
	 * 权限编码 008
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/payment")
	@RequiresPermissions("008")
	public String  paymentManager(Model model){
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "statistics/paymentStatistics";
	}
	
	/**
	 * 管理费用收取情况统计过程
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getPaymentData")
	public List<Map<String,Object>> getPaymentData(){
		Map<String,Object> param = new HashMap<String,Object>();
		String farmCode = "1".equals(getParameter("farmCode"))?"":getParameter("farmCode");
		String yearStr = getParameter("yearStr")==null?"":getParameter("yearStr");
		param.put("farmCode",farmCode );
		param.put("yearStr",yearStr );
		List<Map<String,Object>> result = procedureExecuteService.getLandResult("land_proc_contract_paymentStatistics(:farmCode,:yearStr)", param);
		return result;
	}
	
	
	/**
	 * 承包户统计界面<br/>
	 * 权限编码 008
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractFarmily")
	@RequiresPermissions("008")
	public String  contractFarmily(Model model){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "statistics/contractFarmilyStatistics";
	}
	
	/**
	 * 承包户统计过程
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getContractFarmilyData")
	public List<Map<String,Object>> getContractFarmily(HttpServletRequest request){
		Map<String,Object> param = new HashMap<String,Object>();
		String farmCode = request.getParameter("farmCode") ;
		param.put("farmCode",farmCode );
		
		List<Map<String,Object>> result = procedureExecuteService.getLandResult("land_proc_contract_contractFamilyStatistics(:farmCode)", param);
		return result;
	}
}
