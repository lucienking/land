package com.jksb.land.service.landInfo;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.jksb.land.entity.landInfo.OccupiedLandInfoForm;
import com.jksb.land.entity.landInfo.OccupiedLandInfoNoAuthForm;
import com.jksb.land.repository.landInfo.OccupiedLandDao;
import com.jksb.land.repository.landInfo.OccupiedLandInfoNoAuthDao;

@Transactional
@Component
public class OccupiedLandService {

	@Autowired
	private OccupiedLandDao occupiedLandDao;
	
	@Autowired
	private OccupiedLandInfoNoAuthDao occupiedLandInfoNoAuthDao;
	
	public void saveOccupiedLand(OccupiedLandInfoForm form){
		this.occupiedLandDao.save(form);
	}
	
	public OccupiedLandInfoForm getResearchFormByNum(String num){
		return this.occupiedLandDao.findByNum(num);
	}
	
	/**
	 * 保存未确权信息
	 * 
	 * */
	public void saveOccupiedLandInfoNoAuth(OccupiedLandInfoNoAuthForm form){
		this.occupiedLandInfoNoAuthDao.save(form);
	}
	
	public OccupiedLandInfoNoAuthForm getResearchNoAuthFormByNum(String num){
		return this.occupiedLandInfoNoAuthDao.findByNum(num);
	}
}
