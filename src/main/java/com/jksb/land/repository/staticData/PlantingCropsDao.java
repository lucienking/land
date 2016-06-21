/**
 * 
 */
package com.jksb.land.repository.staticData;

import java.util.Map;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.staticData.PlantingCropsEntity;

/**
 * 种植作物类型
 * @author Willian Chan
 *
 */
public interface PlantingCropsDao extends JpaSpecificationExecutor<PlantingCropsEntity>,
PagingAndSortingRepository<PlantingCropsEntity, Long> {
	
	@Query("select pc from PlantingCropsEntity pc where pc.pcName=?1")
	public PlantingCropsEntity findByPcName(String pcName);
}
