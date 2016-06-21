/**
 * 
 */
package com.jksb.land.entity.contract;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 经济作物实体类
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_CTT_ECONOMICPLANT")
public class EconomicPlant extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	private String plantName;	//种植作物名称
	
	private String plantCode;	//种植作物编码
	
	private String plantType;	//种植作物大类
	
	private String plantSubType;	//种植作物二级类

	public String getPlantName() {
		return plantName;
	}

	public void setPlantName(String plantName) {
		this.plantName = plantName;
	}

	public String getPlantCode() {
		return plantCode;
	}

	public void setPlantCode(String plantCode) {
		this.plantCode = plantCode;
	}

	public String getPlantType() {
		return plantType;
	}

	public void setPlantType(String plantType) {
		this.plantType = plantType;
	}

	public String getPlantSubType() {
		return plantSubType;
	}

	public void setPlantSubType(String plantSubType) {
		this.plantSubType = plantSubType;
	}
}
