/**
 * 
 */
package com.jksb.land.service.ownnership;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.mapEntity.OccupiedEntity;
import com.jksb.land.repository.ownnership.OccupiedDao;

/**
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class OccupiedService {
	@Autowired
	private OccupiedDao occupiedDao;
	/*
	 *根据条件查询被占地信息
	 */
	public Page<OccupiedEntity> getOccupied(Specification<OccupiedEntity> specif,PageRequest request){
		return occupiedDao.findAll(specif, request);
	}
	
	/*
	 * 保存被占地信息
	 */
	public OccupiedEntity savaOccupiedEntity(OccupiedEntity oe){
		return occupiedDao.save(oe);
	}
	
	/*
	 * 删除被占地信息
	 */
	public void deleteOccupiedParcels(List<Long> idlist){
		occupiedDao.deleteOccupiedParcels(idlist);
	}
}
