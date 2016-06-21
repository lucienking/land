package com.jksb.land.repository.contract;


import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.ContractorPersonal;

public interface ContractorInfoDao extends JpaSpecificationExecutor<ContractorPersonal>,PagingAndSortingRepository<ContractorPersonal, Long> {
	/**
	 * 根据身份证号查找承包人
	 */
	//@Query("select contractor from Contractor where id in (?1)")
	public ContractorPersonal findByContractorIDNO(String identity);
	
	/**
	 * 根据合同编号查找承包人
	 * @param code
	 * @return
	 */
/*//	@Query("select contractor from Contractor c where c.contract.contractCode in (?1)")
	public List<ContractorPersonal> findByContractCode(String code);*/
}
