/**
 * 
 */
package com.jksb.land.entity.staticData;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 静态种植作物编码表
 * @author Willian Chan
 *
 */
@Entity
@Table(name = "STAT_PLANTINGCROPS")
public class PlantingCropsEntity extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String fstClassCode;	//大类编号
	
	private String fstClassName;	//大类名称
	
	private String scdClassCode;	//中类编号
	
	private String scdClassName;	//种类名称
	
	private String thdClassCode;	//小类编号
	
	private String thdClassName;	//小类名称
	
	private String pcCode;		//种植作物编号
	
	private String pcName;		//种植作物名称
	
	private String shotcut;	//缩写
	
	private String remark;		//说明

	public String getShotcut() {
		return shotcut;
	}

	public void setShotcut(String shotcut) {
		this.shotcut = shotcut;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getFstClassCode() {
		return fstClassCode;
	}

	public void setFstClassCode(String fstClassCode) {
		this.fstClassCode = fstClassCode;
	}

	public String getFstClassName() {
		return fstClassName;
	}

	public void setFstClassName(String fstClassName) {
		this.fstClassName = fstClassName;
	}

	public String getScdClassCode() {
		return scdClassCode;
	}

	public void setScdClassCode(String scdClassCode) {
		this.scdClassCode = scdClassCode;
	}

	public String getScdClassName() {
		return scdClassName;
	}

	public void setScdClassName(String scdClassName) {
		this.scdClassName = scdClassName;
	}

	public String getThdClassCode() {
		return thdClassCode;
	}

	public void setThdClassCode(String thdClassCode) {
		this.thdClassCode = thdClassCode;
	}

	public String getThdClassName() {
		return thdClassName;
	}

	public void setThdClassName(String thdClassName) {
		this.thdClassName = thdClassName;
	}

	public String getPcCode() {
		return pcCode;
	}

	public void setPcCode(String pcCode) {
		this.pcCode = pcCode;
	}

	public String getPcName() {
		return pcName;
	}

	public void setPcName(String pcName) {
		this.pcName = pcName;
	}
	
	
}
