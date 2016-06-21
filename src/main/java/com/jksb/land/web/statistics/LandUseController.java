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
 * 土地利用统计Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/statistics/")
public class LandUseController extends BaseController{

	private final static Logger logger = LoggerFactory.getLogger(LandUseController.class);
	
	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	/**
	 * 土地利用统计界面<br/>
	 * 权限编码 008002
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/landuse")
	@RequiresPermissions("008002")
	public String  menusManager(Model model){	
		logger.debug("statistics");
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/statistics/landuse";
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getLandUseData")
	public List<Map<String,Object>> getLandUseData(HttpServletRequest request){
		Map<String,Object> param = new HashMap<String,Object>();
		String farmCode = getParameter("farmCode") ;
		param.put("farmCode",farmCode );
	 
		List<Map<String,Object>> result = procedureExecuteService.getArcgisResult("land_proc_landuse_statistic(:farmCode)", param);
		
		return result;
	}
	
	
	/**
	 * 土地利用统计界面 -- 提供给社区集成<br/>
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/landuseForEntry")
	public String landuseManager(Model model,HttpServletRequest request){	
		model.addAttribute("farmCode", getFarmCodeParameter());
		return "/statistics/landuseForEntry";
	}
	
	/**
	 * test
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/test")
	public List<Map<String,Object>> getTestData(HttpServletRequest request){
	 
		String sql = "select shape shape from T201512160947 where objectid = '1172'";
		List<Map<String,Object>> result = procedureExecuteService
					.getArcgisQueryResult(sql, null);
		return result;
	}
}
