package com.jksb.land.service.contract;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.CalculatePolicy;
import com.jksb.land.repository.contract.CalculatePolicyDao;

/**
 * 计价政策
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class CalculatePolicyService {
	@Autowired
	private CalculatePolicyDao calculatePolicyDao;
	/**
	 * 计价政策
	 * @param calculatePolicy
	 * @return
	 */
	public CalculatePolicy saveCalculatePolicy(CalculatePolicy calculatePolicy){
		return calculatePolicyDao.save(calculatePolicy);
	}
	
}
