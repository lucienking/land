package com.jksb.land.service.bpm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.bpm.TrackLog;
import com.jksb.land.repository.bpm.TrackLogDao;


@Component
@Transactional
public class TrackLogService {
	
	@Autowired 
	private TrackLogDao trackLogDao;
	
	/**
	 * 获取全部单据日志
	 * @param menu
	 * @return
	 */
	public List<TrackLog> getAllTrackLogs(){
		return (List<TrackLog>) trackLogDao.findAll();
	}
	  
	/**
	 * 分页查询单据日志
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<TrackLog> getLogsByPage(Specification<TrackLog> spec,PageRequest pageRequest){
		return trackLogDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存单据日志
	 * @param param
	 * @return
	 */
	public TrackLog saveLog(TrackLog param){
		return trackLogDao.save(param);
	} 
	
	/**
	 * 根据订单查询日志
	 * @param orderId
	 * @param orderName
	 * @return
	 */
	public List<TrackLog> getTrackLogByOrder(Long orderId,String orderName){
		return trackLogDao.findTrackLogByOrder(orderId, orderName);
	}
	
	/**
	 * 根据订单询日志
	 * @param orderId
	 * @param orderName
	 * @return
	 */
	public List<TrackLog> getTrackLogogByNode(Long orderId,String orderName){
		return trackLogDao.findTrackLogByOrder(orderId, orderName);
	}
}
