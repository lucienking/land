package com.jksb.land.entity.mapEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 权属地块实体
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_MAP_OWNERSHIP")
public class OwnnershipEntity extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String parcelCode;		//争议地块编码
	
	private String disputeObject;	//争议对象
	
	private double disputeArea;			//争议面积
	
	private String farmCode;

	public String getParcelCode() {
		return parcelCode;
	}

	public void setParcelCode(String parcelCode) {
		this.parcelCode = parcelCode;
	}

	public String getDisputeObject() {
		return disputeObject;
	}

	public void setDisputeObject(String disputeObject) {
		this.disputeObject = disputeObject;
	}

	public double getDisputeArea() {
		return disputeArea;
	}

	public void setDisputeArea(double disputeArea) {
		this.disputeArea = disputeArea;
	}

	public String getFarmCode() {
		return farmCode;
	}

	public void setFarmCode(String farmCode) {
		this.farmCode = farmCode;
	}
	
}
