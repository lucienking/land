package com.jksb.land.repository.contract;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.StepCalculateDetail;

public interface StepCalculateDetailDao  extends JpaSpecificationExecutor<StepCalculateDetail>,
PagingAndSortingRepository<StepCalculateDetail, Long> {

	@Query("select scd from StepCalculateDetail scd where scd.stepCalculateVersion.versionCode = ?1 and scd.stepStart < ?2")
	public List<StepCalculateDetail> getPriceByStepVersionAndRange(String versionCode,double area);
	
}
