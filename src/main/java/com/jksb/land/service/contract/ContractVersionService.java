package com.jksb.land.service.contract;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.ContractVersion;
import com.jksb.land.repository.contract.ContractVersionDao;

@Component
@Transactional
public class ContractVersionService {
	@Autowired
	private ContractVersionDao contractVersionDao;
	
	/**
	 * 分页查询合同版本
	 * @param pageRequest
	 * @return
	 */
	public Page<ContractVersion> getVersionByPage(PageRequest pageRequest){
		return contractVersionDao.findAll(pageRequest);
	}
	
	/**
	 * 保存合同版本
	 * @param cv
	 * @return
	 */
	public ContractVersion saveContractVersion(ContractVersion cv){
		return contractVersionDao.save(cv);
	}
	
	/**
	 * 删除合同版本
	 * @param ids
	 */
	public void deleConVersion(List<Long> idlist){
		contractVersionDao.deleteConVersionById(idlist);
	}
}
