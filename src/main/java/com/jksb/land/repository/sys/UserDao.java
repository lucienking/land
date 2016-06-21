
package com.jksb.land.repository.sys;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.sys.UserEntity;

public interface UserDao extends PagingAndSortingRepository<UserEntity, Long> {
	
}
