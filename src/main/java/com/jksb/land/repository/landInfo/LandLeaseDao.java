package com.jksb.land.repository.landInfo;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landInfo.ExternalCompanyOrPersonalLandRentForm;
import com.jksb.land.entity.landInfo.SelfUseFarmLand;

public interface LandLeaseDao extends JpaSpecificationExecutor<SelfUseFarmLand>,
PagingAndSortingRepository<ExternalCompanyOrPersonalLandRentForm, Long>{

	public ExternalCompanyOrPersonalLandRentForm findByNum(String num);
}
