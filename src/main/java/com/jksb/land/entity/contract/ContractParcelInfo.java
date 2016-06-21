/**
 * 
 */
package com.jksb.land.entity.contract;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jksb.land.entity.IdEntity;

/**
 * 承包地块信息
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_CTT_CONTRACTPARCELINFO")
public class ContractParcelInfo extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String contractParcelCode;		//承包地编号
	
	private String contractParcelLevel;		//承包地块等级
	
	private double contractParcellArea;		//承包地块面积
	
	private String contractParcelType;		//承包地块类型
	
	private String contractLocation;		//承包地座落
	
	private String contractShiz;			//承包地四至
	
	private String plantCrops;			    //合同中的自营经济种植作物
	
	private List<PlantingRelationship> plantingRelation;		//地块种植作物关系
	
	@JsonBackReference
	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="contractParcelCode",referencedColumnName="contractParcelCode")
	public List<PlantingRelationship> getPlantingRelation() {
		return plantingRelation;
	}

	public void setPlantingRelation(List<PlantingRelationship> plantingRelation) {
		this.plantingRelation = plantingRelation;
	}

	public String getContractParcelCode() {
		return contractParcelCode;
	}

	public void setContractParcelCode(String contractParcelCode) {
		this.contractParcelCode = contractParcelCode;
	}

	public String getContractParcelLevel() {
		return contractParcelLevel;
	}

	public void setContractParcelLevel(String contractParcelLevel) {
		this.contractParcelLevel = contractParcelLevel;
	}

	public double getContractParcellArea() {
		return contractParcellArea;
	}

	public void setContractParcellArea(double contractParcellArea) {
		this.contractParcellArea = contractParcellArea;
	}

	public String getContractParcelType() {
		return contractParcelType;
	}

	public void setContractParcelType(String contractParcelType) {
		this.contractParcelType = contractParcelType;
	}
	
	public String getContractLocation() {
		return contractLocation;
	}

	public void setContractLocation(String contractLocation) {
		this.contractLocation = contractLocation;
	}

	public String getContractShiz() {
		return contractShiz;
	}

	public void setContractShiz(String contractShiz) {
		this.contractShiz = contractShiz;
	}

	public String getPlantCrops() {
		return plantCrops;
	}

	public void setPlantCrops(String plantCrops) {
		this.plantCrops = plantCrops;
	}
}
