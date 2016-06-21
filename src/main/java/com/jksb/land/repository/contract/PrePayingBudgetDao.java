package com.jksb.land.repository.contract;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.PrePayingBudget;

public interface PrePayingBudgetDao extends JpaSpecificationExecutor<PrePayingBudget>,
		PagingAndSortingRepository<PrePayingBudget,Long> {

	/**
	 * 通过ID获取应缴金额记录
	 * @param id
	 * @return
	 */
	/*@Query("select pb from PrePayingBudget pb where pb.contract.contractCode=?1")
	public List<PrePayingBudget> getPrePayingBudgetByContractCode(String contractCode);*/
	
	@Query("select pb from PrePayingBudget pb where pb.id=?1")
	public PrePayingBudget findPrePayingBudgetById(Long id);
}
