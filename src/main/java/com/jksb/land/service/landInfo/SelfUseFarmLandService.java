package com.jksb.land.service.landInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.landInfo.SelfUseFarmLand;
import com.jksb.land.entity.landInfo.SelfUseFarmLandForm;
import com.jksb.land.repository.landInfo.SelfUseFarmLandDao;

@Component
@Transactional
public class SelfUseFarmLandService {

	@Autowired
	private SelfUseFarmLandDao selfUseFarmLandDao; 
	
	public void saveSelfUseFarmLand(SelfUseFarmLandForm selfUseFarmLandForm){
		this.selfUseFarmLandDao.save(selfUseFarmLandForm);
	}
	
	public SelfUseFarmLandForm getResearchFormByNum(String num){
		return this.selfUseFarmLandDao.findByNum(num);
	}
}
