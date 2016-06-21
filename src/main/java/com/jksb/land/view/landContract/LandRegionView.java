package com.jksb.land.view.landContract;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jksb.land.entity.landContract.ContractRegion;
import com.jksb.land.entity.landContract.LandContract;

public class LandRegionView {
	
	private String[] idArray;
	
	private String[] regionIdArray;
	
	private String[] landTypeArray;
			
	private String[] areaOfRegionArray;
					
	private String[] eastArray;
							
	private String[] westArray;
	
	private String[] southArray;
	
	private String[] northArray;
	
	private String[] landStatusArray;
	
	private String[] priceArray;
	
	private String[] moneyArray;
	
	private String[] increaseMoneyArray;
	
	private List<ContractRegion> regionList=new ArrayList<ContractRegion>();

	public String[] getRegionIdArray() {
		return regionIdArray;
	}

	public void setRegionIdArray(String[] regionIdArray) {
		this.regionIdArray = regionIdArray;
	}

	public String[] getLandTypeArray() {
		return landTypeArray;
	}

	public void setLandTypeArray(String[] landTypeArray) {
		this.landTypeArray = landTypeArray;
	}

	public String[] getAreaOfRegionArray() {
		return areaOfRegionArray;
	}

	public void setAreaOfRegionArray(String[] areaOfRegionArray) {
		this.areaOfRegionArray = areaOfRegionArray;
	}

	public String[] getEastArray() {
		return eastArray;
	}

	public void setEastArray(String[] eastArray) {
		this.eastArray = eastArray;
	}

	public String[] getWestArray() {
		return westArray;
	}

	public void setWestArray(String[] westArray) {
		this.westArray = westArray;
	}

	public String[] getSouthArray() {
		return southArray;
	}

	public void setSouthArray(String[] southArray) {
		this.southArray = southArray;
	}

	public String[] getNorthArray() {
		return northArray;
	}

	public void setNorthArray(String[] northArray) {
		this.northArray = northArray;
	}

	public String[] getLandStatusArray() {
		return landStatusArray;
	}

	public void setLandStatusArray(String[] landStatusArray) {
		this.landStatusArray = landStatusArray;
	}

	public String[] getPriceArray() {
		return priceArray;
	}

	public void setPriceArray(String[] priceArray) {
		this.priceArray = priceArray;
	}

	public String[] getMoneyArray() {
		return moneyArray;
	}

	public void setMoneyArray(String[] moneyArray) {
		this.moneyArray = moneyArray;
	}

	public String[] getIncreaseMoneyArray() {
		return increaseMoneyArray;
	}

	public void setIncreaseMoneyArray(String[] increaseMoneyArray) {
		this.increaseMoneyArray = increaseMoneyArray;
	}

	public String[] getIdArray() {
		return idArray;
	}

	public void setIdArray(String[] idArray) {
		this.idArray = idArray;
	}

	public List<ContractRegion> getRegionList() {
		regionList.clear();
		int size=0;
		if(regionIdArray!=null){
			size=regionIdArray.length;
		}
		for(int i=0;i<size;i++){
			ContractRegion region=new ContractRegion();
			region.setRegionId(regionIdArray[i].trim());
			region.setLandType(landTypeArray.length==0?null:landTypeArray[i].trim());
			region.setLandStatus(landStatusArray.length==0?null:landStatusArray[i].trim());
			region.setEast(eastArray.length==0?null:eastArray[i].trim());
			region.setSouth(southArray.length==0?null:southArray[i].trim());
			region.setWest(westArray.length==0?null:westArray[i].trim());
			region.setNorth(northArray.length==0?null:northArray[i].trim());
			if(idArray.length>0&&idArray[i].trim()!=""){
				region.setId(Long.parseLong(idArray[i]));
			}
			if(areaOfRegionArray.length>0&&areaOfRegionArray[i].trim()!=""){
				region.setAreaOfRegion(Float.parseFloat(areaOfRegionArray[i].trim()));
			}
			if(priceArray.length>0&&priceArray[i].trim()!=""){
				region.setPrice(Float.parseFloat(priceArray[i].trim()));
			}
			if(moneyArray.length>0&&moneyArray[i].trim()!=""){
				region.setMoney(Float.parseFloat(moneyArray[i].trim()));
			}
			/*if(increaseMoneyArray.length>0&&increaseMoneyArray[i].trim()!=""){
				region.setIncreaseMoney(Float.parseFloat(increaseMoneyArray[i].trim()));
			}*/
			region.setCreateTime(new Date());
			regionList.add(region);
		}
		return regionList;
	}
	
	public List<ContractRegion> getRegionList(LandContract contract) {
		getRegionList();
		for(ContractRegion region : regionList){
			region.setLandContract(contract);
		}
		return regionList;
	}
	
}
