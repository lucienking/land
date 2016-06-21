/*package com.jksb.land.repository.contract;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.Contract;

public interface ContractInfoDao extends
		PagingAndSortingRepository<Contract, Long>,
		JpaSpecificationExecutor<Contract> {

	public Contract findByContractCode(String code);
	
	@Query(" select con from Contract con ")
	public List<Contract> findContractInfo();
	
}
*/