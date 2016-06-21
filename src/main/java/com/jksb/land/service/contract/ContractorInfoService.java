package com.jksb.land.service.contract;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.ContractorPersonal;
import com.jksb.land.repository.contract.ContractorInfoDao;

@Component
@Transactional
public class ContractorInfoService {
	 @Autowired
	 private ContractorInfoDao contractorInfoDao;
	 /**
	  * 保存承包人
	  * @param contractorInfo
	  * @return
	  */
	 public ContractorPersonal saveContractor(ContractorPersonal contractorInfo){
		 return contractorInfoDao.save(contractorInfo);
	 }
	 
}
