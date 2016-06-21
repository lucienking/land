/**
 * 
 */
package com.jksb.land.entity.agriRes;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jksb.land.entity.IdEntity;

/**
 * @author Willian Chan
 *	居民信息
 */

@Entity
@Table(name = "BUSI_AR_PERSONINFO")
public class AgriPerson extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String personName;		//职工姓名
	
	private String personSex;		//职工性别
	
	private String personAge;		//职工年龄
	
	private String personNation;	//职工民族
	
	private String isCadres;		//是否干部
	
	private String personStatus;		//职工身份
	
	private String familyRelationship;	//与户主关系 0:户主;①配偶；②子；③女；④孙子、孙女或外孙子、外孙女；⑤父母；⑥祖父母或外祖父母；⑦兄弟姐妹；8儿媳；9其他
	
	private String persionId;		//身份证号码
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createTime;		//创建时间
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateTime;		//更新时间
	
	private String creator;			//创建人
	
	private String updater;			//更新人
	
	private String education;		//学历
	
	private String married;			//婚姻状况
	
	private String currentResident;	//现居住地
	
	private String isLiveInFarm; 	//是否长期居住农场
	
	private String leaveTime;		//离场时间
	
	private String hasLand;			//是否使用土地
	
	private String employedPlace;	//从业地址
	
	private String employment;		//从事职业
	
	private String incomeType;		//主要经济来源
	
	private double income;			//主要经济来源数额
	
	private double lifeAccount;		//生活支出费用
	
	private double produceAccount;	//生产支出费用
	
	private double departmentAccount;		//住房支出费用
	
	private double furnitureAccount;		//大型家用品支出费用
	
	private double eduCulAccount;			//教育文化娱乐用品支出费用
	
	private double medicineAccount;			//医疗保健支出费用
	
	private double customAccount;			//风俗随礼支出费用
	
	private double socialSecureAccount;		//缴纳社保支出费用
	
	// private AgriResearchForm agriResearchForm; //农用地调查表

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getMarried() {
		return married;
	}

	public void setMarried(String married) {
		this.married = married;
	}

	public String getCurrentResident() {
		return currentResident;
	}

	public void setCurrentResident(String currentResident) {
		this.currentResident = currentResident;
	}

	public String getLeaveTime() {
		return leaveTime;
	}

	public void setLeaveTime(String leaveTime) {
		this.leaveTime = leaveTime;
	}

	public String getHasLand() {
		return hasLand;
	}

	public void setHasLand(String hasLand) {
		this.hasLand = hasLand;
	}

	public String getEmployedPlace() {
		return employedPlace;
	}

	public void setEmployedPlace(String employedPlace) {
		this.employedPlace = employedPlace;
	}

	public String getEmployment() {
		return employment;
	}

	public void setEmployment(String employment) {
		this.employment = employment;
	}

	public String getIncomeType() {
		return incomeType;
	}

	public void setIncomeType(String incomeType) {
		this.incomeType = incomeType;
	}

	public double getIncome() {
		return income;
	}

	public void setIncome(double income) {
		this.income = income;
	}

	public double getLifeAccount() {
		return lifeAccount;
	}

	public void setLifeAccount(double lifeAccount) {
		this.lifeAccount = lifeAccount;
	}

	public double getProduceAccount() {
		return produceAccount;
	}

	public void setProduceAccount(double produceAccount) {
		this.produceAccount = produceAccount;
	}

	public double getDepartmentAccount() {
		return departmentAccount;
	}

	public void setDepartmentAccount(double departmentAccount) {
		this.departmentAccount = departmentAccount;
	}

	public double getFurnitureAccount() {
		return furnitureAccount;
	}

	public void setFurnitureAccount(double furnitureAccount) {
		this.furnitureAccount = furnitureAccount;
	}

	public double getEduCulAccount() {
		return eduCulAccount;
	}

	public void setEduCulAccount(double eduCulAccount) {
		this.eduCulAccount = eduCulAccount;
	}

	public double getMedicineAccount() {
		return medicineAccount;
	}

	public void setMedicineAccount(double medicineAccount) {
		this.medicineAccount = medicineAccount;
	}

	public double getCustomAccount() {
		return customAccount;
	}

	public void setCustomAccount(double customAccount) {
		this.customAccount = customAccount;
	}

	public double getSocialSecureAccount() {
		return socialSecureAccount;
	}

	public void setSocialSecureAccount(double socialSecureAccount) {
		this.socialSecureAccount = socialSecureAccount;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPersonSex() {
		return personSex;
	}

	public void setPersonSex(String personSex) {
		this.personSex = personSex;
	}

	public String getPersonAge() {
		return personAge;
	}

	public void setPersonAge(String personAge) {
		this.personAge = personAge;
	}

	public String getPersonNation() {
		return personNation;
	}

	public void setPersonNation(String personNation) {
		this.personNation = personNation;
	}

	public String getIsCadres() {
		return isCadres;
	}

	public void setIsCadres(String isCadres) {
		this.isCadres = isCadres;
	}

	public String getPersonStatus() {
		return personStatus;
	}

	public void setPersonStatus(String personStatus) {
		this.personStatus = personStatus;
	}

	public String getFamilyRelationship() {
		return familyRelationship;
	}

	public void setFamilyRelationship(String familyRelationship) {
		this.familyRelationship = familyRelationship;
	}

	public String getIsLiveInFarm() {
		return isLiveInFarm;
	}

	public void setIsLiveInFarm(String isLiveInFarm) {
		this.isLiveInFarm = isLiveInFarm;
	}

	public String getPersionId() {
		return persionId;
	}

	public void setPersionId(String persionId) {
		this.persionId = persionId;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
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

	/*public AgriResearchForm getAgriResearchForm() {
		return agriResearchForm;
	}

	public void setAgriResearchForm(AgriResearchForm agriResearchForm) {
		this.agriResearchForm = agriResearchForm;
	}*/
}
