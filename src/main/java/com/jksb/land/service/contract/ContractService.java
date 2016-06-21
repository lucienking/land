package com.jksb.land.service.contract;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.Contract;
import com.jksb.land.repository.contract.ContractDao;

@Component
@Transactional
public class ContractService {
	
	@Autowired
	private ContractDao contractDao;
	
	/**
	 * 分页动态查询
	 * @param spec
	 * @param pageRequest
	 * @return
	 */
	public Page<Contract> getAllContract(Specification<Contract> spec,PageRequest pageRequest){
		return contractDao.findAll(spec, pageRequest);
	}
	
	/**
	 * 动态查询
	 * @param spec
	 * @param pageRequest
	 * @return
	 */
	public List<Contract> getAllContract(Specification<Contract> spec){
		return contractDao.findAll(spec);
	}
	
	/**
	 * 保存合同
	 * @param contract
	 */
	public void saveContract(Contract contract){
		contractDao.save(contract);
	}
	
	/**
	 * 根据code查询合同
	 * @param code
	 * @return
	 */
	public Contract getContractByCode(String code){
		return contractDao.getContractByCode(code);
	}
	
	public Contract getContractById(Long id){
		return contractDao.getContractById(id);
	}
	
	/**
	 * 根据code查询合同是否存在
	 * @param code
	 * @return
	 */
	public int getContractNumByCode(String code){
		return contractDao.getContractNumByCode(code);
	}
	
	/**
	 * 合同审核不通过，并保存审核意见。
	 * @param ids
	 * @param option
	 * @param status
	 */
	public void changeStatus(List<Long> ids,String opinion,String status){
		contractDao.saveStatus(ids,Integer.parseInt(status));
		contractDao.setOpinion(ids,opinion);
	}
	
	public void passStatus(List<Long> ids,String status){
		contractDao.saveStatus(ids, Integer.parseInt(status));
	}
	
	/**
	 * 查询个数
	 * @param spec
	 * @param pageRequest
	 * @return
	 */
	public long getContractCount(Specification<Contract> spec){
		return contractDao.count(spec);
	}
}
