package com.jksb.land.web.statistics;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



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
 * 承包人统计Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/statistics/")
public class ContractorStatisticsController extends BaseController{

	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	/**
	 * 种植作物统计界面<br/>
	 * 权限编码 008
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractor")
	@RequiresPermissions("008")
	public String  manager(Model model){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "statistics/contractorStatistics";
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getContractorData")
	public List<Map<String,Object>> getContractorData(){
		Map<String,Object> param = new HashMap<String,Object>();
		String farmCode = getParameter("farmCode") ;
		param.put("farmCode",farmCode );
		List<Map<String,Object>> list = procedureExecuteService.getLandResult("land_proc_contract_contractorStatistics(:farmCode)", param);
		return list;
	}
}
