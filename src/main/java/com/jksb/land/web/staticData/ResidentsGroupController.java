package com.jksb.land.web.staticData;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.entity.staticData.ResidentsGroup;
import com.jksb.land.service.staticData.ResidentsGroupService;
import com.jksb.land.web.BaseController;
/**
 * 合同Controller
 * 
 * @author Willian Chan
 *
 */
@Controller
@RequestMapping("/group")
public class ResidentsGroupController extends BaseController {
	
	@Autowired
	private ResidentsGroupService residentsGroupService;

	/**
	 * 生成社区选项
	 * @param code
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getResidentsGroupByCommunity")
	public List<Map<String,Object>>  getResidentsGroupByCommunity(@RequestParam(value = "communityCode", defaultValue = "0") String code){
		List<ResidentsGroup> groups = residentsGroupService.getResidentsGroupByCommunityCode(code); 
		List<Map<String,Object>> select =  new ArrayList<Map<String,Object>>();
		Map<String, Object> defau = new HashMap<String, Object>();
		defau.put("id", "");
		defau.put("text", "--请选择--");
		defau.put("selected",true);
		select.add(defau);
		for(ResidentsGroup group :groups){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", group.getResidentsGrpCode());
			map.put("text", group.getResidentsGrpName());
			select.add(map);
		}
		return select;
	}
}
