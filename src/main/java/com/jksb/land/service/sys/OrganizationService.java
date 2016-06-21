package com.jksb.land.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.sys.OrganizationEntity;
import com.jksb.land.repository.sys.OrganizationDao;


@Component
@Transactional
public class OrganizationService {
	
	@Autowired
	private OrganizationDao organizationDao ;
	
	public List<OrganizationEntity> getAllFarms(){
		return organizationDao.getAllFarms();
	}
}
