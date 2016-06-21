package com.jksb.land.entity.contract;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 承包人实体类
 * @author Willian Chan
 *
 */
@Entity
@Table(name = "BUSI_CTT_CONTRACTORPERSONAL")
public class ContractorPersonal extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String contractorIdType;	// 证件类型
	
	private String contractorIDNO;		//承包人证件号
	
	private String contractorPhoneNumber;		//联系电话
	
	private String contractorDepartment;		//工作单位
	
	private String contractorAddr;		//承包人住址
	
	private String isStaff;				//是否职工
	
	private String residentTypeCode;	//居民类型编码
	
	private String residentTypeName;	//居民类型名称
	
	private String huhao;				//户号
	
	private String isCadres;			//是否干部
	
	private String isRespOfSecPt;		//是否乙方
	
	private String contractorName;			//承包方名称
	
	private double contractArea;			//承包面积
	
	private Contract contract;
	
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
	
	public String getResidentTypeCode() {
		return residentTypeCode;
	}

	public void setResidentTypeCode(String residentTypeCode) {
		this.residentTypeCode = residentTypeCode;
	}

	public String getResidentTypeName() {
		return residentTypeName;
	}

	public void setResidentTypeName(String residentTypeName) {
		this.residentTypeName = residentTypeName;
	}

	public String getHuhao() {
		return huhao;
	}

	public void setHuhao(String huhao) {
		this.huhao = huhao;
	}

	public String getContractorPhoneNumber() {
		return contractorPhoneNumber;
	}

	public String getContractorDepartment() {
		return contractorDepartment;
	}

	public void setContractorDepartment(String contractorDepartment) {
		this.contractorDepartment = contractorDepartment;
	}

	public void setContractorPhoneNumber(String contractorPhoneNumber) {
		this.contractorPhoneNumber = contractorPhoneNumber;
	}

	public String getContractorAddr() {
		return contractorAddr;
	}

	public void setContractorAddr(String contractorAddr) {
		this.contractorAddr = contractorAddr;
	}

	public String getContractorIDNO() {
		return contractorIDNO;
	}

	public void setContractorIDNO(String contractorIDNO) {
		this.contractorIDNO = contractorIDNO;
	}

	public String getContractorIdType() {
		return contractorIdType;
	}

	public void setContractorIdType(String contractorIdType) {
		this.contractorIdType = contractorIdType;
	}

	public String getIsStaff() {
		return isStaff;
	}

	public void setIsStaff(String isStaff) {
		this.isStaff = isStaff;
	}

	public String getIsCadres() {
		return isCadres;
	}

	public void setIsCadres(String isCadres) {
		this.isCadres = isCadres;
	}

	public String getIsRespOfSecPt() {
		return isRespOfSecPt;
	}

	public void setIsRespOfSecPt(String isRespOfSecPt) {
		this.isRespOfSecPt = isRespOfSecPt;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}
}
