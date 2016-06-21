package com.jksb.land.entity.landContract;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jksb.land.entity.IdEntity;

/**
 * 合同信息实体
 * @author LiuXin
 * @date 2016年6月12日
 */
@Entity
@Table(name = "LAND_CONTRACTS")
public class LandContract extends IdEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7258691829292451851L;
	
	private String contractNumber;
	
	private String contractFarm;
	
	private String contractCode;
	
	private Integer contractYear;
	
	private String partyA;
	
	private String representativeA;
	
	private String partyAContact;
	
	private String partyB;
	
	private String representativeB;
	
	private String partyBIDNumber;
	
	private String partyBAddress;
	
	private String partyBContact;
	
	private String belongFarm;
	
	private String belongGroup;
	
	private String landPurpose;
	
	private Float areaOfLand;
	
	private String areaOfLandCn;
	
	private Float money;
	
	private Integer timeLimit;
	
	private Date startDate;
	
	private Date endDate;
	
	private Date promiseDate;
	
	private Float price;
	
	private String moneyCn;
	
	private Integer increaseCycle;
	
	private Float increasePercentage;
	
	private Float payPercentage;
	
	private String terminationPartyB;
	
	private String remarks;
	
	private Date signingDate;
	
	private Integer state;
	
	private String farmCode;
	
	private Integer contractType;
	
	private Date createTime;
	
	private Date lastEditTime;
	
	private String creator;
	
	private String lastEditor;
	
	private List<ContractRegion> regionList;
	
	private List<ContractAttach> attachList;
	
	private Float baseRental;//基本地价收费总额
	
	private Float increaseRental;//阶梯地价递增总额
	
	private String wan;
	
	private String qian;
	
	private String bai;
	
	private String shi;
	
	private String yuan;
	
	private String jiao;
	
	private String fen;
	
	public String getContractNumber() {
		return contractNumber;
	}

	public void setContractNumber(String contractNumber) {
		this.contractNumber = contractNumber;
	}

	public String getPartyA() {
		return partyA;
	}

	public void setPartyA(String partyA) {
		this.partyA = partyA;
	}

	public String getRepresentativeA() {
		return representativeA;
	}

	public void setRepresentativeA(String representativeA) {
		this.representativeA = representativeA;
	}

	public String getPartyAContact() {
		return partyAContact;
	}

	public void setPartyAContact(String partyAContact) {
		this.partyAContact = partyAContact;
	}

	public String getPartyB() {
		return partyB;
	}

	public void setPartyB(String partyB) {
		this.partyB = partyB;
	}

	public String getRepresentativeB() {
		return representativeB;
	}

	public void setRepresentativeB(String representativeB) {
		this.representativeB = representativeB;
	}

	public String getPartyBIDNumber() {
		return partyBIDNumber;
	}

	public void setPartyBIDNumber(String partyBIDNumber) {
		this.partyBIDNumber = partyBIDNumber;
	}

	public String getPartyBAddress() {
		return partyBAddress;
	}

	public void setPartyBAddress(String partyBAddress) {
		this.partyBAddress = partyBAddress;
	}

	public String getPartyBContact() {
		return partyBContact;
	}

	public void setPartyBContact(String partyBContact) {
		this.partyBContact = partyBContact;
	}

	public String getBelongFarm() {
		return belongFarm;
	}

	public void setBelongFarm(String belongFarm) {
		this.belongFarm = belongFarm;
	}

	public String getBelongGroup() {
		return belongGroup;
	}

	public void setBelongGroup(String belongGroup) {
		this.belongGroup = belongGroup;
	}

	public String getLandPurpose() {
		return landPurpose;
	}

	public void setLandPurpose(String landPurpose) {
		this.landPurpose = landPurpose;
	}

	public Float getAreaOfLand() {
		return areaOfLand;
	}

	public void setAreaOfLand(Float areaOfLand) {
		this.areaOfLand = areaOfLand;
	}

	public String getAreaOfLandCn() {
		return areaOfLandCn;
	}

	public void setAreaOfLandCn(String areaOfLandCn) {
		this.areaOfLandCn = areaOfLandCn;
	}

	public Float getMoney() {
		return money;
	}

	public void setMoney(Float money) {
		this.money = money;
	}

	public Integer getTimeLimit() {
		return timeLimit;
	}

	public void setTimeLimit(Integer timeLimit) {
		this.timeLimit = timeLimit;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Date getPromiseDate() {
		return promiseDate;
	}

	public void setPromiseDate(Date promiseDate) {
		this.promiseDate = promiseDate;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public String getMoneyCn() {
		return moneyCn;
	}

	public void setMoneyCn(String moneyCn) {
		this.moneyCn = moneyCn;
	}

	public Integer getIncreaseCycle() {
		return increaseCycle;
	}

	public void setIncreaseCycle(Integer increaseCycle) {
		this.increaseCycle = increaseCycle;
	}

	public Float getIncreasePercentage() {
		return increasePercentage;
	}

	public void setIncreasePercentage(Float increasePercentage) {
		this.increasePercentage = increasePercentage;
	}

	public Float getPayPercentage() {
		return payPercentage;
	}

	public void setPayPercentage(Float payPercentage) {
		this.payPercentage = payPercentage;
	}

	public String getTerminationPartyB() {
		return terminationPartyB;
	}

	public void setTerminationPartyB(String terminationPartyB) {
		this.terminationPartyB = terminationPartyB;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getSigningDate() {
		return signingDate;
	}

	public void setSigningDate(Date signingDate) {
		this.signingDate = signingDate;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getContractFarm() {
		return contractFarm;
	}

	public void setContractFarm(String contractFarm) {
		this.contractFarm = contractFarm;
	}

	public String getContractCode() {
		return contractCode;
	}

	public void setContractCode(String contractCode) {
		this.contractCode = contractCode;
	}

	public String getFarmCode() {
		return farmCode;
	}

	public void setFarmCode(String farmCode) {
		this.farmCode = farmCode;
	}

	public Integer getContractYear() {
		return contractYear;
	}

	public void setContractYear(Integer contractYear) {
		this.contractYear = contractYear;
	}

	public Integer getContractType() {
		return contractType;
	}

	public void setContractType(Integer contractType) {
		this.contractType = contractType;
	}

	@OneToMany(mappedBy="landContract",orphanRemoval=true,cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	@OrderBy("id")
	@JsonIgnore
	public List<ContractRegion> getRegionList() {
		return regionList;
	}

	public void setRegionList(List<ContractRegion> regionList) {
		this.regionList = regionList;
	}

	@OneToMany(mappedBy="landContract",orphanRemoval=true,cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	@OrderBy("id")
	@JsonIgnore
	public List<ContractAttach> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<ContractAttach> attachList) {
		this.attachList = attachList;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastEditTime() {
		return lastEditTime;
	}

	public void setLastEditTime(Date lastEditTime) {
		this.lastEditTime = lastEditTime;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getLastEditor() {
		return lastEditor;
	}

	public void setLastEditor(String lastEditor) {
		this.lastEditor = lastEditor;
	}

	public Float getBaseRental() {
		return baseRental;
	}

	public void setBaseRental(Float baseRental) {
		this.baseRental = baseRental;
	}

	public Float getIncreaseRental() {
		return increaseRental;
	}

	public void setIncreaseRental(Float increaseRental) {
		this.increaseRental = increaseRental;
	}

	public String getWan() {
		return wan;
	}

	public void setWan(String wan) {
		this.wan = wan;
	}

	public String getQian() {
		return qian;
	}

	public void setQian(String qian) {
		this.qian = qian;
	}

	public String getBai() {
		return bai;
	}

	public void setBai(String bai) {
		this.bai = bai;
	}

	public String getShi() {
		return shi;
	}

	public void setShi(String shi) {
		this.shi = shi;
	}

	public String getYuan() {
		return yuan;
	}

	public void setYuan(String yuan) {
		this.yuan = yuan;
	}

	public String getJiao() {
		return jiao;
	}

	public void setJiao(String jiao) {
		this.jiao = jiao;
	}

	public String getFen() {
		return fen;
	}

	public void setFen(String fen) {
		this.fen = fen;
	}
	
	
	
}
