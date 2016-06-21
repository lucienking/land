/**
 * 
 */
package com.jksb.land.service.staticData;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.staticData.ResidentsGroup;
import com.jksb.land.repository.staticData.ResidentsGroupDao;

/**
 * 居民小组
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class ResidentsGroupService {
	@Autowired
	private ResidentsGroupDao residentsGroupDao;
	
	public ResidentsGroup getResidentsGroupById(Long id){
		return residentsGroupDao.findOne(id);
	}
	
	/**
	 * 按编码查询居民小组
	 * @param code
	 * @return
	 */
	public ResidentsGroup getResidentsGroupByCode(String code){
		return residentsGroupDao.findByResidentsGrpCode(code);
	}
	
	
	public List<ResidentsGroup> getResidentsGroupByCommunityCode(String code){
		return residentsGroupDao.findByCommunityCode(code);
	}
	
}
