package com.jksb.land.repository.landCircul;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.landCircul.LandCirculation;

public interface LandCirculationDao extends PagingAndSortingRepository<LandCirculation, Long>,JpaSpecificationExecutor<LandCirculation> {
	
	public LandCirculation getLandCirculationById(Long id);
	
	@Query("select c from LandCirculation c where c.circulNo = ?1")
	public LandCirculation getLandCirculationByCirculNo(String circulNo);
}
