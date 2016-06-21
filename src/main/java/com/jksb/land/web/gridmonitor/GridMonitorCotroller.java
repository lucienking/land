package com.jksb.land.web.gridmonitor;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.service.common.GridLocationService;
import com.jksb.land.web.BaseController;

/**
 * 网格员动态监控
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/grid/")
public class GridMonitorCotroller extends BaseController {

	@Autowired
	private GridLocationService gridLocationService;
	/**
	 * 网格员监控
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/gridMonitor")
	public String gridMonitor(){
		return "/gridmonitor/gridmonitor";
	}
	
	/**
	 * 网格员路径
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/findLocations")
	public Map<String,Object> findLocations(HttpServletRequest request) throws ParseException{
		String phones=request.getParameter("phone");
		String date=request.getParameter("date");
		String [] phoneArr=phones.split(",");
		String sql="";
		if(phones!=""){
			sql="select * from tb_order a where a.phone_number in (";
			for(int i=0;i<phoneArr.length;i++){
				sql+="\'"+phoneArr[i]+"\'";
				if(i!=phoneArr.length-1){
					sql+=",";
				}
			}
			sql+=")";
		}
		if(date!=""){
			sql+=" and a.report_date BETWEEN DATE_FORMAT('"+date+" 00:00:00', '%Y-%m-%d %H:%i:%s') AND DATE_FORMAT('"+date+" 23:59:59', '%Y-%m-%d %H:%i:%s')";
		}
		List<Map<String,Object>> locations=new ArrayList<Map<String,Object>>();
		locations=gridLocationService.getLocationsWithTemplate(sql);
		return convertToResult("serviceLocation",locations);
	}
}
