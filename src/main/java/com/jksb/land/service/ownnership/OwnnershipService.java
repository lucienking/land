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

import com.jksb.land.entity.mapEntity.OwnnershipEntity;
import com.jksb.land.repository.ownnership.OwnnershipDao;

/**
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class OwnnershipService {
	@Autowired
	private OwnnershipDao ownnershipDao;
	
	/**
	 * 根据条件获取争议地信息
	 * @param spec
	 * @param pageRequest
	 * @return
	 */
	public Page<OwnnershipEntity> getAllOwnnerParcel(Specification<OwnnershipEntity> spec,PageRequest pageRequest){
		return ownnershipDao.findAll(spec, pageRequest);
	}
	
	/**
	 * 保存争议地信息
	 * @param oe
	 * @return
	 */
	public OwnnershipEntity saveDisputeParcel(OwnnershipEntity oe){
		return ownnershipDao.save(oe);
	}
	
	/**
	 * 删除多个争议地信息
	 * @param idlist
	 */
	public void deleteDisputeParcel(List<Long> idlist){
		ownnershipDao.deleteDisputeByIds(idlist);
	}
}


