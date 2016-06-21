package com.jksb.land.service.contract;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.ContractorPersonal;
import com.jksb.land.repository.contract.ContractorPersonalDao;

@Component
@Transactional
public class ContractorPersonalService {
	
	@Autowired
	private ContractorPersonalDao contractorPersonalDao;
	
	public ContractorPersonal save(ContractorPersonal personal){
		return contractorPersonalDao.save(personal);
	}
	
	public ContractorPersonal getContractorPersonalById(Long id){
		return contractorPersonalDao.findContractorPersonalById(id);
	}
	 
}
