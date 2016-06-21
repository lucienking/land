/**
 * 
 */
package com.jksb.land.repository.contract;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.RentalRecords;

/**
 * 租金缴纳记录
 * @author Willian Chan
 *
 */
public interface RentalRecordsDao extends JpaSpecificationExecutor<RentalRecords>,
		PagingAndSortingRepository<RentalRecords, Long> {

	@Query("select rr from RentalRecords rr where rr.prePayingBudget in (?1)")
	public Map<String,Object> getRentalRecordsByPBID(List<Long> ids);

}
