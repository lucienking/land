package com.jksb.land.entity.landContract;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 合同地块信息实体
 * @author LiuXin
 * @date 2016年6月12日
 */
@Entity
@Table(name = "CONTRACT_REGION")
public class ContractRegion extends IdEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2718764001242547892L;

	private String regionId;
	
	private String landType;
	
	private Float areaOfRegion;
	
	private String landStatus;
	
	private Float price;
	
	private Float money;
	
	private Float increaseMoney;//阶梯地价递增金额
	
	private String east;
	
	private String south;
	
	private String west;
	
	private String north;
	
	private Date createTime;
	
	private LandContract landContract;

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getLandType() {
		return landType;
	}

	public void setLandType(String landType) {
		this.landType = landType;
	}

	public Float getAreaOfRegion() {
		return areaOfRegion;
	}

	public void setAreaOfRegion(Float areaOfRegion) {
		this.areaOfRegion = areaOfRegion;
	}

	public String getLandStatus() {
		return landStatus;
	}

	public void setLandStatus(String landStatus) {
		this.landStatus = landStatus;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public Float getMoney() {
		return money;
	}

	public void setMoney(Float money) {
		this.money = money;
	}

	public String getEast() {
		return east;
	}

	public void setEast(String east) {
		this.east = east;
	}

	public String getSouth() {
		return south;
	}

	public void setSouth(String south) {
		this.south = south;
	}

	public String getWest() {
		return west;
	}

	public void setWest(String west) {
		this.west = west;
	}

	public String getNorth() {
		return north;
	}

	public void setNorth(String north) {
		this.north = north;
	}

	@ManyToOne
	@JoinColumn(name = "landContract_id")
	public LandContract getLandContract() {
		return landContract;
	}

	public void setLandContract(LandContract landContract) {
		this.landContract = landContract;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Float getIncreaseMoney() {
		return increaseMoney;
	}

	public void setIncreaseMoney(Float increaseMoney) {
		this.increaseMoney = increaseMoney;
	}
	
	
}
