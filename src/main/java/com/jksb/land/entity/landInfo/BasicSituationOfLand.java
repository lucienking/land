package com.jksb.land.entity.landInfo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.jksb.land.entity.IdEntity;

@Entity
@Table(name = "BASE_BASICSITUATIONOFLAND")
public class BasicSituationOfLand extends IdEntity{

	private static final long serialVersionUID = 1L;
	
	//使用情况
	private String landNo;						//地块编号
	
	private Double actualArea; 					//实际使用面积
	
	private Double beginUseArea;				//起始使用面积
	
	private String beginTime; 					//起始使用时间
	
	private String landLocation;				//地块所在地
	
	private String growPlant;					//种植作物
	
	private String isBreakContractUse;			//是否违约使用
	
	//转包情况
	private String isLandSubContract;			//是否转包
	
	private String isAgreeByFarm;				//是否经农场同意
	
	private String subContractArea;				//转包面积
	
	private String subContractRent;				//转包租金
	
	private String subContractTime;				//转包时间
	
	private String currentUseName;				//当前使用人姓名
	
	private String currentUseCompany;			//当前使用人单位
	
	private String isBreakContractSubContract;	//是否违约使用(转包)

	public String getLandNo() {
		return landNo;
	}

	public void setLandNo(String landNo) {
		this.landNo = landNo;
	}

	public Double getActualArea() {
		return actualArea;
	}

	public void setActualArea(Double actualArea) {
		this.actualArea = actualArea;
	}
	
	public Double getBeginUseArea() {
		return beginUseArea;
	}

	public void setBeginUseArea(Double beginUseArea) {
		this.beginUseArea = beginUseArea;
	}


	public String getLandLocation() {
		return landLocation;
	}

	public void setLandLocation(String landLocation) {
		this.landLocation = landLocation;
	}

	public String getGrowPlant() {
		return growPlant;
	}

	public void setGrowPlant(String growPlant) {
		this.growPlant = growPlant;
	}

	public String getIsBreakContractUse() {
		return isBreakContractUse;
	}

	public void setIsBreakContractUse(String isBreakContractUse) {
		this.isBreakContractUse = isBreakContractUse;
	}

	public String getIsLandSubContract() {
		return isLandSubContract;
	}

	public void setIsLandSubContract(String isLandSubContract) {
		this.isLandSubContract = isLandSubContract;
	}

	public String getIsAgreeByFarm() {
		return isAgreeByFarm;
	}

	public void setIsAgreeByFarm(String isAgreeByFarm) {
		this.isAgreeByFarm = isAgreeByFarm;
	}

	public String getSubContractArea() {
		return subContractArea;
	}

	public void setSubContractArea(String subContractArea) {
		this.subContractArea = subContractArea;
	}

	public String getSubContractRent() {
		return subContractRent;
	}

	public void setSubContractRent(String subContractRent) {
		this.subContractRent = subContractRent;
	}

	public String getCurrentUseName() {
		return currentUseName;
	}

	public void setCurrentUseName(String currentUseName) {
		this.currentUseName = currentUseName;
	}

	public String getCurrentUseCompany() {
		return currentUseCompany;
	}

	public void setCurrentUseCompany(String currentUseCompany) {
		this.currentUseCompany = currentUseCompany;
	}

	public String getIsBreakContractSubContract() {
		return isBreakContractSubContract;
	}

	public void setIsBreakContractSubContract(String isBreakContractSubContract) {
		this.isBreakContractSubContract = isBreakContractSubContract;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getSubContractTime() {
		return subContractTime;
	}

	public void setSubContractTime(String subContractTime) {
		this.subContractTime = subContractTime;
	}
	
}
