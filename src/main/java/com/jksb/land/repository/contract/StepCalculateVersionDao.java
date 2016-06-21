/**
 * 
 */
package com.jksb.land.repository.contract;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.StepCalculateVersion;

/**
 * @author Willian Chan
 *
 */
public interface StepCalculateVersionDao extends JpaSpecificationExecutor<StepCalculateVersion>,
		PagingAndSortingRepository<StepCalculateVersion, Long> {

}
