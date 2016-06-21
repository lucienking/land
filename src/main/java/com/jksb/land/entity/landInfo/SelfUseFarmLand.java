package com.jksb.land.entity.landInfo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.jksb.land.entity.IdEntity;
/**
 * @author chens
 * 农用地自用登记
 * */
@Entity
@Table(name="BUSI_SELFUSEFARMLAND")
public class SelfUseFarmLand extends IdEntity {

	private static final long serialVersionUID = 1L;

	private String landNum;         //宗地编号
	
	private Double landArea;        //土地面积
	
	private String landLocation;    //土地位置
	
	private String currentCrop;     //当前作物
	
	private String remark; 			//备注
	
	public String getLandNum() {
		return landNum;
	}

	public void setLandNum(String landNum) {
		this.landNum = landNum;
	}

	public Double getLandArea() {
		return landArea;
	}

	public void setLandArea(Double landArea) {
		this.landArea = landArea;
	}

	public String getLandLocation() {
		return landLocation;
	}

	public void setLandLocation(String landLocation) {
		this.landLocation = landLocation;
	}

	public String getCurrentCrop() {
		return currentCrop;
	}

	public void setCurrentCrop(String currentCrop) {
		this.currentCrop = currentCrop;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
