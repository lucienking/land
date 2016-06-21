package com.jksb.land.service.staticData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.staticData.ReferencedPriceEntity;
import com.jksb.land.repository.staticData.ReferencedPriceDao;

/**
 * 参考价格（总局）
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class ReferencedPriceService {
	@Autowired
	private ReferencedPriceDao referencedPriceDao;
	
	public double getReferencedPrice(String farmCode,String refLandType,String refLandLevel){
		ReferencedPriceEntity referencedPriceEntity = referencedPriceDao.getReferencedPrice(farmCode,refLandType,refLandLevel);
		double price = 0;
		if(referencedPriceEntity != null) price = referencedPriceEntity.getRefPrice();  
		return  price;
	}
}
