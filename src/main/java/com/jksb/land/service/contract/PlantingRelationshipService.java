package com.jksb.land.service.contract;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.Contract;
import com.jksb.land.entity.contract.PlantingRelationship;
import com.jksb.land.repository.contract.PlantingRelationshipDao;

@Component
@Transactional
public class PlantingRelationshipService {

	@Autowired
	private PlantingRelationshipDao plantingRelationshipDao;
	
	public PlantingRelationship savePlantingRelationship(PlantingRelationship plantingRelationship){
		return plantingRelationshipDao.save(plantingRelationship);
	}
	
	public List<PlantingRelationship> getParcelList(Specification<PlantingRelationship> spec){
		return plantingRelationshipDao.findAll(spec);
	}
	
	public PlantingRelationship findByid(Long id){
		return plantingRelationshipDao.findOne(id);
	}
	
	public void deleteById(long id){
		plantingRelationshipDao.delete(id);
	}
}
