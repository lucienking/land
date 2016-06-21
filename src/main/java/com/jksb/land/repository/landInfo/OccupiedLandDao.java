package com.jksb.land.repository.landInfo;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landInfo.OccupiedLandInfoForm;

public interface OccupiedLandDao extends JpaSpecificationExecutor<OccupiedLandInfoForm>,PagingAndSortingRepository<OccupiedLandInfoForm, Long>{

	public OccupiedLandInfoForm findByNum(String num);
	
}
