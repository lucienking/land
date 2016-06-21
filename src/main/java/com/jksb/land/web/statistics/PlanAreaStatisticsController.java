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
 * 规划面积统计Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/statistics/")
public class PlanAreaStatisticsController extends BaseController{

	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	/**
	 * 规划面积统计界面<br/>
	 * 权限编码 008
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/planArea")
	@RequiresPermissions("008")
	public String  menusManager(Model model){	
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/statistics/planAreaStatistics";
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getPlanAreaData")
	public List<Map<String,Object>> getLandUseData(HttpServletRequest request){
		Map<String,Object> param = new HashMap<String,Object>();
		String farmCode = request.getParameter("farmCode") ;
		param.put("farmCode",farmCode );
		List<Map<String,Object>> result = procedureExecuteService.getArcgisResult("land_proc_planarea_statistic(:farmCode)", param);
		/*List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for(Map<String,Object> d:data){
			Map<String,Object> r = new HashMap<String,Object>();
			r.put("farmCode",farmCode);
			r.put("firstType", d[0]);
			r.put("secondType", d[1]);
			r.put("area", d[2]);
			r.put("totalArea", d[3]);
			result.add(r);
		}*/
		return result;
	}
}
