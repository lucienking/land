package com.jksb.land.service.sys;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.sys.UserEntity;
import com.jksb.land.repository.sys.UserDao;

@Component
@Transactional
public class UserService {
	
	private UserDao userDao;
	
	public UserEntity getUser(Long id) {
		return userDao.findOne(id);
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
}
