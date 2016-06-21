package com.jksb.land.entity.landInfo;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.jksb.land.entity.IdEntity;

@Entity
@Table(name = "BASE_EXTERNALCOMPANYORPERSONALLANDRENTFORM")
public class ExternalCompanyOrPersonalLandRentForm extends IdEntity{

	private static final long serialVersionUID = 1L;

	private String num;						//编号
	
	private String communityNum;  			//社区编号
	
	private String orgAddress;  			//单位地址
	
	private String name;					//姓名
	
	private String sex;						//性别
	
	private String nation;					//民族
	
	private String age;						//年龄
	
	private String identityNo;				//身份证号
	
	private String companyName;				//单位名称
	
	private String orgCode;					//组织机构的代码
	
	private Double contractArea;			//合同签订面积
	
	private Double contractPrice;			//合同签订单价
	
	private Double payRentByYear;			//年缴租金
	
	private String contractSignTime;			//合同签订时间
	
	private Double contractPromiseTime;		//合同约定年限
	
	private String isApprove;				//是否总局批准
	
	private List<BasicSituationOfLand> BasicSituationOfLands;
	
	private String researchName;			//被调查人姓名
	
	private String gatherName;				//信息采集姓名
	
	private String remark;					//备注
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createTime;				//表格创建时间
	
	private String createName;				//表格创建用户

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getCommunityNum() {
		return communityNum;
	}

	public void setCommunityNum(String communityNum) {
		this.communityNum = communityNum;
	}

	public String getOrgAddress() {
		return orgAddress;
	}

	public void setOrgAddress(String orgAddress) {
		this.orgAddress = orgAddress;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getIdentityNo() {
		return identityNo;
	}

	public void setIdentityNo(String identityNo) {
		this.identityNo = identityNo;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public Double getContractArea() {
		return contractArea;
	}

	public void setContractArea(Double contractArea) {
		this.contractArea = contractArea;
	}

	public Double getContractPrice() {
		return contractPrice;
	}

	public void setContractPrice(Double contractPrice) {
		this.contractPrice = contractPrice;
	}

	public Double getPayRentByYear() {
		return payRentByYear;
	}

	public void setPayRentByYear(Double payRentByYear) {
		this.payRentByYear = payRentByYear;
	}

	public String getContractSignTime() {
		return contractSignTime;
	}

	public void setContractSignTime(String contractSignTime) {
		this.contractSignTime = contractSignTime;
	}

	public Double getContractPromiseTime() {
		return contractPromiseTime;
	}

	public void setContractPromiseTime(Double contractPromiseTime) {
		this.contractPromiseTime = contractPromiseTime;
	}

	public String getIsApprove() {
		return isApprove;
	}

	public void setIsApprove(String isApprove) {
		this.isApprove = isApprove;
	}

	@OneToMany(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
	@JoinColumn(name="num",referencedColumnName="num")
	public List<BasicSituationOfLand> getBasicSituationOfLands() {
		return BasicSituationOfLands;
	}

	public void setBasicSituationOfLands(
			List<BasicSituationOfLand> basicSituationOfLands) {
		BasicSituationOfLands = basicSituationOfLands;
	}

	public String getResearchName() {
		return researchName;
	}

	public void setResearchName(String researchName) {
		this.researchName = researchName;
	}

	public String getGatherName() {
		return gatherName;
	}

	public void setGatherName(String gatherName) {
		this.gatherName = gatherName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}
	
}
