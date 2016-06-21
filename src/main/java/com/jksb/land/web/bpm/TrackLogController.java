package com.jksb.land.web.bpm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jksb.land.entity.bpm.TrackLog;
import com.jksb.land.service.bpm.TrackLogService;
import com.jksb.land.web.BaseController;

/**
 * 流程日志跟踪 controller
 * @author wangxj
 *
 */
@Controller
@RequestMapping("/bpm/track")
public class TrackLogController extends BaseController {
	
	@Autowired 
	private TrackLogService trackLogService;
	
	@RequestMapping(method = RequestMethod.GET,value = "/trackDisplay")
	public String contractDetailInfo(Long id,String orderName,Model model){
		List<TrackLog> tracks = trackLogService.getTrackLogByOrder(id,orderName);
		model.addAttribute("tracks",tracks);
		return  "/bpm/trackDisplay";
	}
}
