package com.jksb.land.service.landCircul;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.common.bpm.TrackLogUtil;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.landCircul.LandCirculation;
import com.jksb.land.repository.landCircul.LandCirculationDao;

@Component
@Transactional
public class LandCirculService {

	
	@Autowired
	private LandCirculationDao landCirculationDao;
	
	/**
	 * 分页查询 
	 * @param spec
	 * @param pageRequest
	 * @return
	 */
	public Page<LandCirculation> getLandCirculationByPage(Specification<LandCirculation> spec,PageRequest pageRequest){
		return landCirculationDao.findAll(spec,pageRequest);
	}
	
	public List<LandCirculation> getAllLandCirculation(Specification<LandCirculation> spec){
		return landCirculationDao.findAll(spec);
	}
	
	/**
	 * 保存
	 * @param landCirculation
	 */
	public void saveLandCirculation(LandCirculation landCirculation,String nodeName,String opinion,String content){
		landCirculation.setCurrentUserId(PrincipalUtil.getCurrentUserAccount());
		landCirculation.setCurrentUserName(PrincipalUtil.getCurrentUserAccount());
		landCirculation = landCirculationDao.save(landCirculation);
		
		if(opinion == null || "".equals(opinion)) opinion = "自动";
		TrackLogUtil.saveTrackLog(landCirculation.getCirculStatus(), nodeName, "circulation", landCirculation.getId(), opinion,content);
	}
	
	/**
	 * 保存
	 * @param landCirculation
	 */
	public LandCirculation save(LandCirculation landCirculation){
		return landCirculationDao.save(landCirculation);
	}
	
	public LandCirculation getLandCirculationById(Long id){
		return landCirculationDao.findOne(id);
	}
}
