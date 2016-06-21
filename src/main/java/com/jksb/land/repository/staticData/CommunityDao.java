package com.jksb.land.repository.staticData;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.staticData.CommunityEntity;

public interface CommunityDao extends JpaSpecificationExecutor<CommunityEntity>,
		PagingAndSortingRepository<CommunityEntity, Long> {
	
	@Query("select community from CommunityEntity community where community.farmCode = ?1 order by community.communityCode")
	public List<CommunityEntity> findByCommunityFarmCode (String code);
}
