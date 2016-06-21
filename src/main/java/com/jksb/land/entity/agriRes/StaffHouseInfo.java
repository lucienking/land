/**
 * 
 */
package com.jksb.land.entity.agriRes;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * @author Willian Chan
 *	职工住房信息
 */

@Entity
@Table(name = "BUSI_AR_STAFFHOUSE")
public class StaffHouseInfo extends IdEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String houseType;		//住房类型 1:混钢；2：砖混；3：砖木；4：简易；5：其他
	
	private double houseArea;		//建筑面积
	
	private double occupiedArea;	//占地面积
	
	private AgriResearchForm agriResearchForm; //农用地调查表

	public String getHouseType() {
		return houseType;
	}

	public void setHouseType(String houseType) {
		this.houseType = houseType;
	}

	public double getHouseArea() {
		return houseArea;
	}

	public void setHouseArea(double houseArea) {
		this.houseArea = houseArea;
	}

	public double getOccupiedArea() {
		return occupiedArea;
	}

	public void setOccupiedArea(double occupiedArea) {
		this.occupiedArea = occupiedArea;
	}

	public AgriResearchForm getAgriResearchForm() {
		return agriResearchForm;
	}

	public void setAgriResearchForm(AgriResearchForm agriResearchForm) {
		this.agriResearchForm = agriResearchForm;
	}
	
	
}
