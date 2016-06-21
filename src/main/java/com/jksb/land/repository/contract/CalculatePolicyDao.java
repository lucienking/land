package com.jksb.land.repository.contract;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.CalculatePolicy;


public interface CalculatePolicyDao extends JpaSpecificationExecutor<CalculatePolicy>,
		PagingAndSortingRepository<CalculatePolicy, Long> {

}
