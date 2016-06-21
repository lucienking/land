package com.jksb.land.service.prjManage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.mapEntity.OwnnershipEntity;
import com.jksb.land.entity.prjCntManage.PCMEntity;
import com.jksb.land.repository.prjManage.PCMEntityDao;

@Component
@Transactional
public class PCMService {
	
	@Autowired
	private PCMEntityDao pcmEntityDao;
	
	/**
	 * 保存项目信息草稿 
	 * @param pcmEntity
	 */
	public PCMEntity savePCMEntity(PCMEntity pcmEntity){
		return pcmEntityDao.save(pcmEntity);
	}
	
	/**
	 * 查找项目编码
	 * @param prjCode
	 * @return 项目个数
	 */
	public int getPCMNumByProjectCodee(String code){
		return pcmEntityDao.getPCMNumByProjectCode(code);
	}
	/**
	 * 查找项目名称
	 * @param code
	 * @return 项目个数
	 */
	public int getPCMNumByProjectName(String code){
		return pcmEntityDao.getPCMNumByProjectName(code);
	}
	
	/**
	 * 查询项目
	 * @param spec 查询条件
	 * @param pageRequest
	 * @return
	 */
	public Page<PCMEntity> queryPrj(Specification<PCMEntity> spec,PageRequest pageRequest){
		return pcmEntityDao.findAll(spec, pageRequest);
	}
	
}
 