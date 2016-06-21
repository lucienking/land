/**
 * 
 */
package com.jksb.land.repository.contract;


import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.ContractParcelInfo;

/**
 * 承包地块信息DAO
 * @author Willian Chan
 *
 */
public interface ContractParcelInfoDao extends PagingAndSortingRepository<ContractParcelInfo, Long>,JpaSpecificationExecutor<ContractParcelInfo>{
	//public List<ContractParcelInfo> findBySelfEconomyParcel(SelfEconomyParcel selfEconomyParcel);
	
	public ContractParcelInfo findContractParcelInfoByContractParcelCode(String code);
}
