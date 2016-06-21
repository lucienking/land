package com.jksb.land.service.contract;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.StepCalculateVersion;
import com.jksb.land.repository.contract.StepCalculateVersionDao;

@Component
@Transactional
public class StepCalculateVersionService {
	@Autowired
	private StepCalculateVersionDao stepCalculateVersionDao;
	
	public StepCalculateVersion saveStepCalculateVersion(StepCalculateVersion stepCalculateVersion){
		return stepCalculateVersionDao.save(stepCalculateVersion);
	}
}
