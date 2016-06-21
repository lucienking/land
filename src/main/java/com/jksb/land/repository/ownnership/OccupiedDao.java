/**
 * 
 */
package com.jksb.land.repository.ownnership;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.mapEntity.OccupiedEntity;

/**
 * 被占地实体接口
 * @author Willian Chan
 *
 */
public interface OccupiedDao extends JpaSpecificationExecutor<OccupiedEntity>,
		PagingAndSortingRepository<OccupiedEntity, Long> {

	/*
	 * 根据ID集删除多个实体
	 */
	@Modifying
	@Query("delete from OccupiedEntity oe where oe.id in (?1)")
	public void deleteOccupiedParcels(List<Long> idlist);
}
