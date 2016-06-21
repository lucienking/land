package com.jksb.land.entity.agriRes;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 土地转包信息
 * @author wangxj
 *
 */

@Entity
@Table(name = "BUSI_AR_SUBCONTRACT")
public class AgriSubContract extends IdEntity {

	private static final long serialVersionUID = 1L;

	private String oldContrator;	//原承包人
	
	private String isAgreeByFarm;	//是否经农场同意
	
	private String parcelCode;		//地块编号
	
	private String subParcelCode;	//地块子号
	
	private String loacation;		//地块位置
	
	private double subcontractArea;	//转包面积
	
	private Date subcontractY;		//转包年份
	
	private double subcontractRental;	//转包租金
	
	private String presentContractor;	//现使用人姓名
	
	private String presentEnterprise;	//现使用人单位
	
	private AgriResearchForm agriResearchForm; //农用地调查表

	public String getOldContrator() {
		return oldContrator;
	}

	public void setOldContrator(String oldContrator) {
		this.oldContrator = oldContrator;
	}

	public String getIsAgreeByFarm() {
		return isAgreeByFarm;
	}

	public void setIsAgreeByFarm(String isAgreeByFarm) {
		this.isAgreeByFarm = isAgreeByFarm;
	}

	public String getParcelCode() {
		return parcelCode;
	}

	public void setParcelCode(String parcelCode) {
		this.parcelCode = parcelCode;
	}

	public String getSubParcelCode() {
		return subParcelCode;
	}

	public void setSubParcelCode(String subParcelCode) {
		this.subParcelCode = subParcelCode;
	}

	public String getLoacation() {
		return loacation;
	}

	public void setLoacation(String loacation) {
		this.loacation = loacation;
	}

	public double getSubcontractArea() {
		return subcontractArea;
	}

	public void setSubcontractArea(double subcontractArea) {
		this.subcontractArea = subcontractArea;
	}

	public Date getSubcontractY() {
		return subcontractY;
	}

	public void setSubcontractY(Date subcontractY) {
		this.subcontractY = subcontractY;
	}

	public double getSubcontractRental() {
		return subcontractRental;
	}

	public void setSubcontractRental(double subcontractRental) {
		this.subcontractRental = subcontractRental;
	}

	public String getPresentContractor() {
		return presentContractor;
	}

	public void setPresentContractor(String presentContractor) {
		this.presentContractor = presentContractor;
	}

	public String getPresentEnterprise() {
		return presentEnterprise;
	}

	public void setPresentEnterprise(String presentEnterprise) {
		this.presentEnterprise = presentEnterprise;
	}

	public AgriResearchForm getAgriResearchForm() {
		return agriResearchForm;
	}

	public void setAgriResearchForm(AgriResearchForm agriResearchForm) {
		this.agriResearchForm = agriResearchForm;
	}
}
