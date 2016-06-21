/**
 * 
 */
package com.jksb.land.service.staticData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.staticData.PlantingCropsEntity;
import com.jksb.land.repository.staticData.PlantingCropsDao;

/**
 * @author Willian Chan
 *
 */

@Component
@Transactional
public class PlantingCropsService {
	
	@Autowired
	private PlantingCropsDao plantingCropsDao;
	
	public PlantingCropsEntity findByPcName(String pcName){
		return plantingCropsDao.findByPcName(pcName);
	}
	
	public void deleteById(long id){
		plantingCropsDao.delete(id);
	}
}
