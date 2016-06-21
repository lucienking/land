package com.jksb.land.service.contract;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.PrePayingBudget;
import com.jksb.land.repository.contract.PrePayingBudgetDao;

@Component
@Transactional
public class PrePayingBudgetService {
	@Autowired
	private PrePayingBudgetDao prePayingBudgetDao;
	
	/**
	 * 保存应缴金额
	 * @param prePayingBudget
	 * @return
	 */
	public PrePayingBudget savePrePayingBudget(PrePayingBudget prePayingBudget){
		return prePayingBudgetDao.save(prePayingBudget);
	}
	
	/**
	 * 通过contractCode获取应缴金额记录
	 * @param id
	 * @return
	 */
	/*public List<PrePayingBudget> getPrePayingBudgetByCode(String contractCode){
		return prePayingBudgetDao.getPrePayingBudgetByContractCode(contractCode);
	}*/
	
	/**
	 * 根据id查找
	 * @param id
	 * @return
	 */
	public PrePayingBudget getPrePayingBudgetById(Long id){
		return prePayingBudgetDao.findOne(id);
	}
}
