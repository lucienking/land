/**
 * 
 */
package com.jksb.land.repository.ownnership;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.mapEntity.OwnnershipEntity;

/**
 * @author Willian Chan
 *
 */
public interface OwnnershipDao extends JpaSpecificationExecutor<OwnnershipEntity>,
		PagingAndSortingRepository<OwnnershipEntity, Long> {
	
	/*
	 * 根据ID集删除多个实体
	 */
	@Modifying
	@Query("delete from OwnnershipEntity oe where oe.id in (?1)")
	public void deleteDisputeByIds(List<Long> ids);
}
