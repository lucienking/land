package com.jksb.land.repository.landInfo;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landInfo.SelfUseFarmLand;
import com.jksb.land.entity.landInfo.SelfUseFarmLandForm;

public interface SelfUseFarmLandDao extends JpaSpecificationExecutor<SelfUseFarmLand>,
PagingAndSortingRepository<SelfUseFarmLandForm, Long>{

	public SelfUseFarmLandForm findByNum(String num);
}
