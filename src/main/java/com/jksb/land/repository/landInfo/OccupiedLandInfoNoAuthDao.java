package com.jksb.land.repository.landInfo;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landInfo.OccupiedLandInfoNoAuthForm;

public interface OccupiedLandInfoNoAuthDao extends JpaSpecificationExecutor<OccupiedLandInfoNoAuthForm>,
PagingAndSortingRepository<OccupiedLandInfoNoAuthForm, Long>{
	
	public OccupiedLandInfoNoAuthForm findByNum(String num);

}
