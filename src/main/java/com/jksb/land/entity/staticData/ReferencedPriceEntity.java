package com.jksb.land.entity.staticData;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 总局价格参考表
 * @author Willian Chan
 *
 */
@Entity
@Table(name = "STAT_REF_PRICE")
public class ReferencedPriceEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	private String farmCode;	//农场编码
	
	private String refLandType;	//土地类型
	
	private String refLandLevel;	//土地等级
	
	private double refPrice;	//参考价格

	public String getFarmCode() {
		return farmCode;
	}

	public void setFarmCode(String farmCode) {
		this.farmCode = farmCode;
	}

	public double getRefPrice() {
		return refPrice;
	}

	public void setRefPrice(double refPrice) {
		this.refPrice = refPrice;
	}

	public String getRefLandType() {
		return refLandType;
	}

	public void setRefLandType(String refLandType) {
		this.refLandType = refLandType;
	}

	public String getRefLandLevel() {
		return refLandLevel;
	}

	public void setRefLandLevel(String refLandLevel) {
		this.refLandLevel = refLandLevel;
	}
	
}
