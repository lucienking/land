package com.jksb.land.repository.sys;



import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.sys.SysLogEntity;

public interface SysLogDao extends PagingAndSortingRepository<SysLogEntity, Long>,JpaSpecificationExecutor<SysLogEntity> {
	
}
