/**
 * 
 */
package com.jksb.land.entity.contract;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jksb.land.entity.IdEntity;
import com.jksb.land.entity.staticData.PlantingCropsEntity;

/**
 * 种植关系实体类
 *
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_CTT_PLANTINGRELATIONSHIP")
public class PlantingRelationship extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	private int plantedAcount;	//株数
	
	private double plantedArea;	//面积（亩）
	
	private float	percentage;		//百分比
	
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	private Date plantedYear;		//定植年度
	
	private PlantingCropsEntity plantingCrops;		//种植作物
	
	private ContractParcelInfo contractParcelInfo;	//地块编号
	
	@ManyToOne
	@JoinColumn(name="contractParcelCode")
	@JsonManagedReference
	public ContractParcelInfo getContractParcelInfo() {
		return contractParcelInfo;
	}

	public void setContractParcelInfo(ContractParcelInfo contractParcelInfo) {
		this.contractParcelInfo = contractParcelInfo;
	}

	public float getPercentage() {
		return percentage;
	}

	public void setPercentage(float percentage) {
		this.percentage = percentage;
	}

	public int getPlantedAcount() {
		return plantedAcount;
	}

	public void setPlantedAcount(int plantedAcount) {
		this.plantedAcount = plantedAcount;
	}

	public double getPlantedArea() {
		return plantedArea;
	}

	public void setPlantedArea(double plantedArea) {
		this.plantedArea = plantedArea;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getPlantedYear() {
		return plantedYear;
	}

	public void setPlantedYear(Date plantedYear) {
		this.plantedYear = plantedYear;
	}

	@ManyToOne
	@JoinColumn(name="plantingCropsId")
	public PlantingCropsEntity getPlantingCrops() {
		return plantingCrops;
	}

	public void setPlantingCrops(PlantingCropsEntity plantingCrops) {
		this.plantingCrops = plantingCrops;
	}
	

	
	
}
