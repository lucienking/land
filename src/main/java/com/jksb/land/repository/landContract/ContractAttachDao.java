package com.jksb.land.repository.landContract;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landContract.ContractAttach;

public interface ContractAttachDao extends PagingAndSortingRepository<ContractAttach, Long>,JpaSpecificationExecutor<ContractAttach> {

}
