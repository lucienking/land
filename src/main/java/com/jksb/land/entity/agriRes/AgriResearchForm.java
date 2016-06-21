/**
 * 
 */
package com.jksb.land.entity.agriRes;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jksb.land.entity.IdEntity;
import com.jksb.land.entity.staticData.ResidentsGroup;

/**
 * @author Willian Chan
 * 农用地调查表 人口信息表
 */
@Entity
@Table(name = "BUSI_AR_RESEARCHFORM")
public class AgriResearchForm extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String cardNo;			//编号
	
	private String isCombined;		//是否属于并场队人员
	
	private String houseLocation;	//居住地址
	
	private String telephoneNumber; //家庭电话
	
	private String remark;			//备注
	
	private String familyNo;		//户号
	
	private String familyHost;		//户主
	
	private String familyHostId; 	//户主身份证
	
	private String familyLocation;	//户口所在地
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date researchDate;	//调查日期
	
	private String researchObject;	//调查对象
	
	private String investigator;	//调查人(信息采集人)
	
	private Date createTime; 		//创建时间
	
	private Date updateTime;		//更新时间
	
	private String creator;			//创建人
	
	private String updater;			//更新人
	
	//	多对一外部关系实体,ManyToOne
	private ResidentsGroup residentsGroup;				//居民小组编码,FK
	
	private List<AgriPerson> agriPerson;			//调查表人口信息
	
	private List<AgriSelfParcel> agriSelfParcel;	//调查表土地信息
	
	private List<AgriSubContract> agriSubContract;	//调查表转包信息
	
	private List<StaffHouseInfo> staffHouseInfo;    //家庭居住房屋信息
	
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getIsCombined() {
		return isCombined;
	}

	public void setIsCombined(String isCombined) {
		this.isCombined = isCombined;
	}

	public String getHouseLocation() {
		return houseLocation;
	}

	public void setHouseLocation(String houseLocation) {
		this.houseLocation = houseLocation;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getFamilyNo() {
		return familyNo;
	}

	public void setFamilyNo(String familyNo) {
		this.familyNo = familyNo;
	}

	public String getFamilyHost() {
		return familyHost;
	}

	public void setFamilyHost(String familyHost) {
		this.familyHost = familyHost;
	}

	public String getFamilyHostId() {
		return familyHostId;
	}

	public void setFamilyHostId(String familyHostId) {
		this.familyHostId = familyHostId;
	}

	public String getFamilyLocation() {
		return familyLocation;
	}

	public void setFamilyLocation(String familyLocation) {
		this.familyLocation = familyLocation;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}

	public String getTelephoneNumber() {
		return telephoneNumber;
	}

	public void setTelephoneNumber(String telephoneNumber) {
		this.telephoneNumber = telephoneNumber;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getResearchDate() {
		return researchDate;
	}

	public void setResearchDate(Date researchDate) {
		this.researchDate = researchDate;
	}

	public String getResearchObject() {
		return researchObject;
	}

	public void setResearchObject(String researchObject) {
		this.researchObject = researchObject;
	}

	public String getInvestigator() {
		return investigator;
	}

	public void setInvestigator(String investigator) {
		this.investigator = investigator;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="residentsGrpCode" ,referencedColumnName="residentsGrpCode")//关联列名
	public ResidentsGroup getResidentsGroup() {
		return residentsGroup;
	}

	public void setResidentsGroup(ResidentsGroup residentsGroup) {
		this.residentsGroup = residentsGroup;
	}
	
	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="cardNo",referencedColumnName="cardNo")
	public List<AgriPerson> getAgriPerson() {
		return agriPerson;
	}

	public void setAgriPerson(List<AgriPerson> agriPerson) {
		this.agriPerson = agriPerson;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="cardNo",referencedColumnName="cardNo")
	public List<AgriSelfParcel> getAgriSelfParcel() {
		return agriSelfParcel;
	}

	public void setAgriSelfParcel(List<AgriSelfParcel> agriSelfParcel) {
		this.agriSelfParcel = agriSelfParcel;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="cardNo",referencedColumnName="cardNo")
	public List<AgriSubContract> getAgriSubContract() {
		return agriSubContract;
	}

	public void setAgriSubContract(List<AgriSubContract> agriSubContract) {
		this.agriSubContract = agriSubContract;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="cardNo",referencedColumnName="cardNo")
	public List<StaffHouseInfo> getStaffHouseInfo() {
		return staffHouseInfo;
	}

	public void setStaffHouseInfo(List<StaffHouseInfo> staffHouseInfo) {
		this.staffHouseInfo = staffHouseInfo;
	}
}
