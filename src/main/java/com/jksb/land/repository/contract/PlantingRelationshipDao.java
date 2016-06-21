/**
 * 
 */
package com.jksb.land.repository.contract;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.PlantingRelationship;

/**
 * @author Willian Chan
 *
 */
public interface PlantingRelationshipDao extends JpaSpecificationExecutor<PlantingRelationship>,
		PagingAndSortingRepository<PlantingRelationship, Long> {
	
//	@Query("select pr.contractParcelInfo.contractParcelCode contractParcelCode"
//			+ ",pr.plantingCrops.pcName pcName,pr.plantedArea plantedArea"
//			+ ",pr.plantedAcount plantedAcount,pr.plantedYear plantedYear from PlantingRelationship pr")
//	public List<Map<String,String>> listPR();
}
