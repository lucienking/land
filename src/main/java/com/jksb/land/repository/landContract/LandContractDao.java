package com.jksb.land.repository.landContract;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landContract.LandContract;

public interface LandContractDao extends PagingAndSortingRepository<LandContract, Long>,JpaSpecificationExecutor<LandContract>  {

	/**
	 * 注销合同状态
	 */
	@Modifying
	@Query(value="update LandContract set state=?1 where state=?2 and id in ?3 ")
	int updateContractStates(int newState,int oldState,Iterable<Long> ids);
	
	/**
	 * 注销合同状态
	 */
	/*@Modifying
	@Query("update LandContract set state=?1 where id =?2")
	public void updateCancelState(int updateState,Long id);*/
}
