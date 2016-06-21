package com.jksb.land.service.contract;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.StepCalculateDetail;
import com.jksb.land.repository.contract.StepCalculateDetailDao;

@Component
@Transactional
public class StepCalculateDetailService {
	
	@Autowired
	private StepCalculateDetailDao stepCalculateDetailDao;
	
	public List<StepCalculateDetail> getPriceByStepVersionAndRange(String versionCode,double area){
		return stepCalculateDetailDao.getPriceByStepVersionAndRange(versionCode, area); 
	}
	
}
