package com.jksb.land.repository.agriRes;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.agriRes.AgriResearchForm;

public interface AgriResearchDao extends PagingAndSortingRepository<AgriResearchForm, Long>,JpaSpecificationExecutor<AgriResearchForm> {
	
	public AgriResearchForm getResearchFormById(Long id);
	
	@Query("select form from AgriResearchForm form where form.cardNo = ?1")
	public AgriResearchForm getResearchFormByCardNo(String cardNo);
}
