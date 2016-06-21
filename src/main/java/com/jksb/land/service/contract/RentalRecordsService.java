package com.jksb.land.service.contract;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.PrePayingBudget;
import com.jksb.land.entity.contract.RentalRecords;
import com.jksb.land.repository.contract.PrePayingBudgetDao;
import com.jksb.land.repository.contract.RentalRecordsDao;

@Component
@Transactional
public class RentalRecordsService {
	@Autowired
	private RentalRecordsDao rentalRecordsDao;
	
	@Autowired
	private PrePayingBudgetDao prePayingBudgetDao;
	
	/**
	 * 保存租金记录信息
	 * @param rentalRecords
	 * @return
	 */
	public RentalRecords saveRentalRecords(RentalRecords rentalRecords){
		return rentalRecordsDao.save(rentalRecords);
	}
	
	/**
	 * 根据应缴金额年度获取交租记录
	 * @param ids
	 * @return
	 */
	public Map<String,Object> getRentalRecordsByPBID(List<Long> ids){
		return rentalRecordsDao.getRentalRecordsByPBID(ids);
	}
	
	/**
	 * 登记缴费后，修改实缴、欠缴金额
	 * @param rentalRecords
	 */
	public void fixOwnship(RentalRecords rentalRecords){
		//获取该租金记录所属的应缴金额池
		PrePayingBudget prePayingBudget=prePayingBudgetDao.findPrePayingBudgetById(rentalRecords.getPrePayingBudget().getId());
		//获取该租金记录的其他所有同池缴费记录
		List<RentalRecords> rentalRecordsList=prePayingBudget.getRentalRecords();
		//计算已缴、欠缴金额，并保存
		if(rentalRecordsList!=null){
			double alreadyPaid=0;
			for(RentalRecords rr:rentalRecordsList){
				alreadyPaid+=rr.getActualAmount();
			}
			double ownShip=prePayingBudget.getPayingRental()-alreadyPaid;
			
			prePayingBudget.setPaidRental(alreadyPaid);
			prePayingBudget.setOwnshipRental(ownShip);
			
			prePayingBudgetDao.save(prePayingBudget);
		}else{
			return;
		}
	}
}
