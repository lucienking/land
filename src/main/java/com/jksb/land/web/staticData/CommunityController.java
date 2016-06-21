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

import com.jksb.land.entity.staticData.CommunityEntity;
import com.jksb.land.service.staticData.CommunityService;
import com.jksb.land.web.BaseController;
/**
 * 合同Controller
 * 
 * @author Willian Chan
 *
 */
@Controller
@RequestMapping("/community")
public class CommunityController extends BaseController {
	
	@Autowired
	private CommunityService communityService;

	/**
	 * 生成社区选项
	 * @param code
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getCommunityByFarmCode")
	public List<Map<String,Object>>  getCommunityByFarmCode(@RequestParam(value = "farmCode", defaultValue = "0") String code){
		List<CommunityEntity> communitys = communityService.getCommunityByFarmCode(code); 
		List<Map<String,Object>> select =  new ArrayList<Map<String,Object>>();
		Map<String, Object> defau = new HashMap<String, Object>();
		defau.put("id", "");
		defau.put("text", "--请选择--");
		defau.put("selected",true);
		select.add(defau);
		for(CommunityEntity com :communitys){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", com.getCommunityCode());
			map.put("text", com.getCommunityName());
			select.add(map);
		}
		return select;
	}
}
