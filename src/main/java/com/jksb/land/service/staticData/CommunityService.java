/**
 * 
 */
package com.jksb.land.service.staticData;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.staticData.CommunityEntity;
import com.jksb.land.repository.staticData.CommunityDao;

/**
 * 社区
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class CommunityService {
	
	@Autowired
	private CommunityDao communityDao;
	
	public CommunityEntity getCommunityById(Long id){
		return communityDao.findOne(id);
	}
	
	public List<CommunityEntity> getCommunityByFarmCode(String code){
		return communityDao.findByCommunityFarmCode(code);
	}
}
