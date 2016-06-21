/**
 * 
 */
package com.jksb.land.entity.agriRes;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jksb.land.entity.IdEntity;

/**
 * @author Willian Chan
 *	地块信息
 */

@Entity
@Table(name = "BUSI_AR_PARCELINFO")
public class AgriSelfParcel extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String contractorName;  //土地使用人
	
	private String parcelOrigin;	//土地来源
	
	private String landType;		//用地类型：1、保障性用地；2、经营性用地
	
	private String parcelCode;		//地块编号
	
	private String subParcelCode;   //地块子号
	
	private double theySaidArea;	//自报面积
	
	private String location;		//地块所在地
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date startY;			//起始使用年份
	
	private String isSigned;		//是否签订合同
	
	private String contractCode;	//合同编码
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date signingY;			//合同签订年份
	
	private int leaseTerm;			//合同约定年限
	
	private double signingArea;		//合同签订面积
	
	private double actualArea;		//核实面积
	
	private double rentalPrice;		//土地承包租金
	
	private String plant;			//种植作物
	
	private String isBreakRule;	//是否违规使用
	
	private String isSubcontract;	//是否转包
	
	private AgriResearchForm agriResearchForm; //农用地调查表
	
	public String getParcelCode() {
		return parcelCode;
	}

	public void setParcelCode(String parcelCode) {
		this.parcelCode = parcelCode;
	}

	public double getTheySaidArea() {
		return theySaidArea;
	}

	public void setTheySaidArea(double theySaidArea) {
		this.theySaidArea = theySaidArea;
	}

	public String getContractCode() {
		return contractCode;
	}

	public void setContractCode(String contractCode) {
		this.contractCode = contractCode;
	}

	public double getSigningArea() {
		return signingArea;
	}

	public void setSigningArea(double signingArea) {
		this.signingArea = signingArea;
	}

	public double getActualArea() {
		return actualArea;
	}

	public void setActualArea(double actualArea) {
		this.actualArea = actualArea;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getStartY() {
		return startY;
	}

	public void setStartY(Date startY) {
		this.startY = startY;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getSigningY() {
		return signingY;
	}

	public void setSigningY(Date signingY) {
		this.signingY = signingY;
	}

	public int getLeaseTerm() {
		return leaseTerm;
	}

	public void setLeaseTerm(int leaseTerm) {
		this.leaseTerm = leaseTerm;
	}

	public double getRentalPrice() {
		return rentalPrice;
	}

	public void setRentalPrice(double rentalPrice) {
		this.rentalPrice = rentalPrice;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPlant() {
		return plant;
	}

	public void setPlant(String plant) {
		this.plant = plant;
	}

	public String getIsBreakRule() {
		return isBreakRule;
	}

	public void setIsBreakRule(String isBreakRule) {
		this.isBreakRule = isBreakRule;
	}

	public String getIsSubcontract() {
		return isSubcontract;
	}

	public void setIsSubcontract(String isSubcontract) {
		this.isSubcontract = isSubcontract;
	}

	public String getContractorName() {
		return contractorName;
	}

	public void setContractorName(String contractorName) {
		this.contractorName = contractorName;
	}

	public String getParcelOrigin() {
		return parcelOrigin;
	}

	public void setParcelOrigin(String parcelOrigin) {
		this.parcelOrigin = parcelOrigin;
	}

	public String getLandType() {
		return landType;
	}

	public void setLandType(String landType) {
		this.landType = landType;
	}

	public String getSubParcelCode() {
		return subParcelCode;
	}

	public void setSubParcelCode(String subParcelCode) {
		this.subParcelCode = subParcelCode;
	}

	public String getIsSigned() {
		return isSigned;
	}

	public void setIsSigned(String isSigned) {
		this.isSigned = isSigned;
	}

	public AgriResearchForm getAgriResearchForm() {
		return agriResearchForm;
	}

	public void setAgriResearchForm(AgriResearchForm agriResearchForm) {
		this.agriResearchForm = agriResearchForm;
	}
}
