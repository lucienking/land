package com.jksb.land.repository.landContract;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landContract.ContractRegion;

public interface ContractRegionDao extends PagingAndSortingRepository<ContractRegion, Long>,JpaSpecificationExecutor<ContractRegion>  {

	@Query("select count(*) from ContractRegion where regionId=?1 and landContract.state=?2 and landContract.id<>?3")
	int countByRegionIdAndLandContractStateAndNotLandContractId(String regionId,int state,long dataId);
	
	int countByRegionIdAndLandContractState(String regionId,int state);
}
