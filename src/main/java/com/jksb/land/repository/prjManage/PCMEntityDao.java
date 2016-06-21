/**
 * 
 */
package com.jksb.land.repository.prjManage;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.prjCntManage.PCMEntity;

/**
 * @author Willian Chan
 *
 */
public interface PCMEntityDao extends JpaSpecificationExecutor<PCMEntity>,
		PagingAndSortingRepository<PCMEntity, Long> {
	/**
	 * 根据项目编号查询项目个数
	 * @param code
	 * @return
	 */
	@Query("select count(1) from PCMEntity p where p.projectCode = ?1 ")
	public int getPCMNumByProjectCode(String code);
	
	/**
	 * 根据项目名称查询项目个数
	 * @param code
	 * @return
	 */
	@Query("select count(1) from PCMEntity p where p.projectName = ?1 ")
	public int getPCMNumByProjectName(String code);
}
