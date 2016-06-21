package com.jksb.land.entity.contract;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jksb.land.entity.IdEntity;

/**
 * 合同版本实体类
 * 表名：BUSI_CTT_CONTRACTVERSION
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_CTT_CONTRACTVERSION")
public class ContractVersion extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String contractVersionNo;		//合同版本编号
	
	private String contractName;			//合同版本名称
	
	private String contractDesc;			//合同版本描述
	
	private String publishDept;				//合同版本发行部门
	
	private String contractTemplate;		//合同版本模板
	
	private String creator;					//版本创建人
	
	private Date createDate;				//版本创建时间
	
	private Date updateDate;				//更新时间
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getContractVersionNo() {
		return contractVersionNo;
	}

	public void setContractVersionNo(String contractVersionNo) {
		this.contractVersionNo = contractVersionNo;
	}

	public String getPublishDept() {
		return publishDept;
	}

	public void setPublishDept(String publishDept) {
		this.publishDept = publishDept;
	}

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public String getContractDesc() {
		return contractDesc;
	}

	public void setContractDesc(String contractDesc) {
		this.contractDesc = contractDesc;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getContractTemplate() {
		return contractTemplate;
	}

	public void setContractTemplate(String contractTemplate) {
		this.contractTemplate = contractTemplate;
	}
}
