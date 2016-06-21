package com.jksb.land.repository.contract;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.ContractorPersonal;

public interface ContractorPersonalDao extends PagingAndSortingRepository<ContractorPersonal, Long>,JpaSpecificationExecutor<ContractorPersonal>{
	
	public ContractorPersonal findContractorPersonalById(Long id);
}
