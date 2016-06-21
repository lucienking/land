package com.jksb.land.entity.contract;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;


@Entity
@Table(name = "BUSI_CTT_CONTRACTORENTERPRISE")
public class ContractorEnterprise extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String organizationCode;   //组织机构代码
	
	private String isInnerDept;        //是否内部单位
	
	private String legalPersonName;	   //企业法人
	
	private String legalPersonIdNO;	   //法人身份证
	
	private String contractorName;			//承包方名称
	
	private double contractArea;			//承包面积
	
	public String getContractorName() {
		return contractorName;
	}

	public void setContractorName(String contractorName) {
		this.contractorName = contractorName;
	}

	public double getContractArea() {
		return contractArea;
	}

	public void setContractArea(double contractArea) {
		this.contractArea = contractArea;
	}
	
	public String getOrganizationCode() {
		return organizationCode;
	}

	public void setOrganizationCode(String organizationCode) {
		this.organizationCode = organizationCode;
	}

	public String getIsInnerDept() {
		return isInnerDept;
	}

	public void setIsInnerDept(String isInnerDept) {
		this.isInnerDept = isInnerDept;
	}

	public String getLegalPersonName() {
		return legalPersonName;
	}

	public void setLegalPersonName(String legalPersonName) {
		this.legalPersonName = legalPersonName;
	}

	public String getLegalPersonIdNO() {
		return legalPersonIdNO;
	}

	public void setLegalPersonIdNO(String legalPersonId) {
		this.legalPersonIdNO = legalPersonId;
	}
}
