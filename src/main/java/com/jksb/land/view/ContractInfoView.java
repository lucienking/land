package com.jksb.land.view;

public class ContractInfoView {
	
	private Long id;
	
	private String contractCode;   //合同编码
	
	private Double contractArea;    //承包面积
	
	private long ContractTime;    //承包年限
	
	private String Arrears;         //欠缴金额
	
	private int flag;            //合同状态
	
	private String contractor;   //承包人

	public String getContractCode() {
		return contractCode;
	}

	public void setContractCode(String contractCode) {
		this.contractCode = contractCode;
	}

	public Double getContractArea() {
		return contractArea;
	}

	public void setContractArea(Double contractArea) {
		this.contractArea = contractArea;
	}

	public long getContractTime() {
		return ContractTime;
	}

	public void setContractTime(long contractTime) {
		ContractTime = contractTime;
	}

	public String getArrears() {
		return Arrears;
	}

	public void setArrears(String arrears) {
		Arrears = arrears;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getContractor() {
		return contractor;
	}

	public void setContractor(String contractor) {
		this.contractor = contractor;
	}
}
