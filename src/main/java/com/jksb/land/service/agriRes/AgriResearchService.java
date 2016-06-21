package com.jksb.land.service.agriRes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.agriRes.AgriResearchForm;
import com.jksb.land.repository.agriRes.AgriResearchDao;


@Component
@Transactional
public class AgriResearchService {
	
	@Autowired
	private AgriResearchDao agriResearchDao;
	
	/**
	 * 保存人口信息表
	 * @param agriResearchFormInfo
	 */
	public void saveResearch(AgriResearchForm agriResearchFormInfo){
		agriResearchDao.save(agriResearchFormInfo);
	}
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return
	 */
	public AgriResearchForm getResearchFormById(Long id){
		return agriResearchDao.getResearchFormById(id); 
	}
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return
	 */
	public AgriResearchForm	getResearchFormByCardNo(String cardNo){
		return agriResearchDao.getResearchFormByCardNo(cardNo);
	}
	
	public void deleteResearch(Long id){
		  agriResearchDao.delete(id);
	}
	
	public void deleteResearch(AgriResearchForm agriResearchFormInfo){
		  agriResearchDao.delete(agriResearchFormInfo);
	}
}
