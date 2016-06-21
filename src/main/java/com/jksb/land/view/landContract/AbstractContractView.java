package com.jksb.land.view.landContract;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class AbstractContractView {
	
	protected String contractFarm;
	
	protected String contractCode;
	
	protected Integer contractYear;
	
	protected String partyA;
	
	protected String partyB;
	
	protected String belongGroup;
	
	protected String landPurpose;
	
	protected Float areaOfLand;
	
	protected Integer timeLimit;
	
	protected Date startDate;
	
	protected Date endDate;
	
	protected String remarks;
	
	protected Date signingDate;
	
	protected Float baseRental;//基本地价收费总额
	
	protected Float increaseRental;//阶梯地价递增总额
	
	protected String wan;
	
	protected String qian;
	
	protected String bai;
	
	protected String shi;
	
	protected String yuan;
	
	protected String jiao;
	
	protected String fen;
	
	protected SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");

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

	public Integer getContractYear() {
		return contractYear;
	}

	public void setContractYear(Integer contractYear) {
		this.contractYear = contractYear;
	}

	public String getPartyA() {
		return partyA;
	}

	public void setPartyA(String partyA) {
		this.partyA = partyA;
	}

	public String getPartyB() {
		return partyB;
	}

	public void setPartyB(String partyB) {
		this.partyB = partyB;
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

	public Integer getTimeLimit() {
		return timeLimit;
	}

	public void setTimeLimit(Integer timeLimit) {
		this.timeLimit = timeLimit;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		if(startDate!=null&&startDate.trim()!=""){
			try {
				this.startDate = sdf.parse(startDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		if(endDate!=null&&endDate.trim()!=""){
			try {
				this.endDate = sdf.parse(endDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
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

	public void setSigningDate(String signingDate) {
		if(signingDate!=null&&signingDate.trim()!=""){
			try {
				this.signingDate = sdf.parse(signingDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

	public Float getAreaOfLand() {
		return areaOfLand;
	}

	public void setAreaOfLand(Float areaOfLand) {
		this.areaOfLand = areaOfLand;
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
