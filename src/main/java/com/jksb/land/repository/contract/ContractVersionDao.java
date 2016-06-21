package com.jksb.land.repository.contract;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.ContractVersion;

public interface ContractVersionDao extends JpaSpecificationExecutor<ContractVersion>,	PagingAndSortingRepository<ContractVersion, Long> {

	/**
	 * 根据id集删除合同版本
	 */
	@Modifying
	@Query("delete from ContractVersion cv where cv.id in (?1)")
	public void deleteConVersionById(List<Long> ids);
}
