package com.jksb.land.repository.bpm;



import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.bpm.TrackLog;

public interface TrackLogDao extends PagingAndSortingRepository<TrackLog, Long>,JpaSpecificationExecutor<TrackLog> {
	
	/**
	 * 根据订单和节点名查询日志
	 * @param orderId
	 * @param nodeName
	 * @return
	 */
	@Query("select track from TrackLog track where track.orderId =?1 "
			+ "and track.nodeName = ?2 and track.orderName = ?3 order by track.operateDate")
	public List<TrackLog> findTrackLogByNode(Long orderId,String nodeName,String orderName);
	
	/**
	 * 根据订单查询日志
	 * @param orderId
	 * @param nodeName
	 * @return
	 */
	@Query("select track from TrackLog track where track.orderId =?1 "
			+ "and track.orderName = ?2 order by track.operateDate")
	public List<TrackLog> findTrackLogByOrder(Long orderId,String orderName);
}
