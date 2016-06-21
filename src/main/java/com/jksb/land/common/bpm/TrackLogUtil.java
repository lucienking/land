package com.jksb.land.common.bpm;

import java.util.Date;


import com.jksb.land.common.context.SpringContextHolder;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.bpm.TrackLog;
import com.jksb.land.service.bpm.TrackLogService;

/**
 * 流程跟踪日志工具类
 * @author wangxj
 *
 */
public class TrackLogUtil {

	 
	/**
	 * 
	 * @param currentStatus 当前状态
	 * @param nodeName		节点名称
	 * @param orderName		订单名
	 * @param orderId	  订单ID
	 * @param opinion    处理意见
	 */
	
	public static void saveTrackLog(String currentStatus,String nodeName,String orderName,Long orderId,String opinion,String content){
		
		TrackLog trackLog =new TrackLog();
		trackLog.setCurrentStatus(currentStatus);
		trackLog.setNodeName(nodeName);
		trackLog.setOperateAccount(PrincipalUtil.getCurrentUserAccount());
		trackLog.setOperateDate(new Date());
		trackLog.setOpinion(opinion);
		trackLog.setOperateContent(content);
		trackLog.setOrderId(orderId);
		trackLog.setOrderName(orderName);
		
		TrackLogService trackLogService = (TrackLogService)SpringContextHolder.getBean("trackLogService");
		trackLogService.saveLog(trackLog);
	}
}
