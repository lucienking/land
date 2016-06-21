package com.jksb.land.repository.contract;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.contract.Contract;

public interface ContractDao extends PagingAndSortingRepository<Contract, Long>,JpaSpecificationExecutor<Contract> {

	public Contract getContractById(Long id);
	
	/**
	 * 查询合同唯一性
	 * @param code
	 * @return
	 */
	@Query("select count(1) from Contract con where con.contractCode = ?1 ")
	public int getContractNumByCode(String code);
	
	/**
	 * 根据合同编码查询合同
	 * @param code
	 * @return
	 */
	@Query("select con from Contract con where con.contractCode = ?1 ")
	public Contract getContractByCode(String code);
	
	/**
	 * 修改合同状态
	 * @param ids
	 * @param status
	 */
	@Modifying
	@Query("update Contract con set con.contractStatus=?2 where con.id in (?1) ")
	public void saveStatus(List<Long> ids,int status);
	
	/**
	 * 添加审核意见
	 * @param ids
	 * @param opinion
	 */
	@Modifying
	@Query("update Contract con set con.auditOpinion=?2 where con.id in (?1) ")
	public void setOpinion(List<Long> ids,String opinion);
}
