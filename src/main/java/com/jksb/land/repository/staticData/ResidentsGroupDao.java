/**
 * 
 */
package com.jksb.land.repository.staticData;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.staticData.ResidentsGroup;

/**
 * @author Willian Chan
 *
 */
public interface ResidentsGroupDao extends JpaSpecificationExecutor<ResidentsGroup>,
		PagingAndSortingRepository<ResidentsGroup, Long> {
	
	@Query("select group from ResidentsGroup group where group.residentsGrpCode = ?1 ")
	public ResidentsGroup findByResidentsGrpCode(String code);
	
	@Query("select group from ResidentsGroup group where group.communityEntity.communityCode = ?1 ")
	public List<ResidentsGroup> findByCommunityCode(String code);

}
