/**
 * 
 */
package com.jksb.land.service.contract;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.ContractParcelInfo;
import com.jksb.land.repository.contract.ContractParcelInfoDao;

/**
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class ContractParcelInfoService {
	@Autowired
	private ContractParcelInfoDao cpiDao;
	
	/*
	 * 保存合同地块信息
	 */
	public ContractParcelInfo saveContractParcelInfo(ContractParcelInfo contractParcelInfo){
		return cpiDao.save(contractParcelInfo);
	};
	
	/*
	 * 按id查询地块信息
	 */
	public ContractParcelInfo getContractParcelInfoById(Long id){
		return cpiDao.findOne(id);
	};
	
	public ContractParcelInfo getContractParcelInfoByContractParcelCode(String contractParcelCode){
		return cpiDao.findContractParcelInfoByContractParcelCode(contractParcelCode);
	}
}
 