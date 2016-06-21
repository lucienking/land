package com.jksb.land.service.landInfo;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jksb.land.entity.landInfo.ExternalCompanyOrPersonalLandRentForm;
import com.jksb.land.repository.landInfo.LandLeaseDao;


@Service
@Transactional
public class LandLeaseService {

	@Autowired
	private LandLeaseDao landLeaseDao;
	public ExternalCompanyOrPersonalLandRentForm getResearchFormByNum(String num){
		return this.landLeaseDao.findByNum(num);
	}
	
	public void saveLandLease(ExternalCompanyOrPersonalLandRentForm form){
		this.landLeaseDao.save(form);
	}
	
}
