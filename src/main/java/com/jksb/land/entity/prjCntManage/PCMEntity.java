/**
 * 
 */
package com.jksb.land.entity.prjCntManage;

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
import com.jksb.land.entity.sys.UserEntity;

/**
 * @author Willian Chan
 *	项目建设管理表单实体类
 */

@Entity
@Table(name = "BUSI_PRJ_ProConsManagement")
public class PCMEntity extends IdEntity {

	private static final long serialVersionUID = 1L;

	private String projectCode;	//项目编号
	
	private String projectName;	//项目名称
	
	private String applyCompany;	//申请单位
	
	private String projectLocation;	//项目选址
	
	private String investmentScale;	//投资规模
	
	private double useTotalArea=0;	//用地总面积
	
	private double agriLandArea;	//	农用地面积
	
	private double cultivatedArea;		//耕地面积
	
	private double constructionArea;	//	建设用地面积
	
	private double unuseArea;		//未利用地面积
	
	private double PlanningArea;	//符合规划面积
	
	private double PlanAdjustArea;		//规划调整面积
	
	private String functinalDistribution;		//项目各功能区用地情况
	
	private String supCulCompany;		//补充耕地责任承担单位
	
	private String supCulDepartment;		//补充耕地承担单位
	
	private double supCulArea;		//补充耕地面积
	
	private double AgriToConArea;		//农转用面积
	
	private String contactCompany;		//联系单位
	
	private String contactor;		//联系人
	
	private String phone;		//联系电话
	
	private String prjAddr;		//通讯地址
	
	private String remark;		//备注
	
	private String auditOpinion;		//审核意见
	
	private String prjStatus;		//项目状态
			
	private String auditer;		//审批人
	
	private String applier;		//申请人
	
	private String creator;		//创建人
	
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	private Date createTime;	//创建时间
	
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	private Date applyDate;	//申请日期
	
	private String operator;	//操作人
	
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	private Date updateTime;	//更新时间
	
	private List<PrjAttachmentEntity> prjAttachmentEntitis;	//附件



	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getApplyCompany() {
		return applyCompany;
	}

	public void setApplyCompany(String applyCompany) {
		this.applyCompany = applyCompany;
	}

	public String getProjectLocation() {
		return projectLocation;
	}

	public void setProjectLocation(String projectLocation) {
		this.projectLocation = projectLocation;
	}

	public String getInvestmentScale() {
		return investmentScale;
	}

	public void setInvestmentScale(String investmentScale) {
		this.investmentScale = investmentScale;
	}

	public double getUseTotalArea() {
		return useTotalArea;
	}

	public void setUseTotalArea(double useTotalArea) {
		this.useTotalArea = useTotalArea;
	}

	public double getAgriLandArea() {
		return agriLandArea;
	}

	public void setAgriLandArea(double agriLandArea) {
		this.agriLandArea = agriLandArea;
	}

	public double getCultivatedArea() {
		return cultivatedArea;
	}

	public void setCultivatedArea(double cultivatedArea) {
		this.cultivatedArea = cultivatedArea;
	}

	public double getConstructionArea() {
		return constructionArea;
	}

	public void setConstructionArea(double constructionArea) {
		this.constructionArea = constructionArea;
	}

	public double getUnuseArea() {
		return unuseArea;
	}

	public void setUnuseArea(double unuseArea) {
		this.unuseArea = unuseArea;
	}

	public double getPlanningArea() {
		return PlanningArea;
	}

	public void setPlanningArea(double planningArea) {
		PlanningArea = planningArea;
	}

	public double getPlanAdjustArea() {
		return PlanAdjustArea;
	}

	public void setPlanAdjustArea(double planAdjustArea) {
		PlanAdjustArea = planAdjustArea;
	}

	public String getFunctinalDistribution() {
		return functinalDistribution;
	}

	public void setFunctinalDistribution(String functinalDistribution) {
		this.functinalDistribution = functinalDistribution;
	}

	public String getSupCulCompany() {
		return supCulCompany;
	}

	public void setSupCulCompany(String supCulCompany) {
		this.supCulCompany = supCulCompany;
	}

	public String getSupCulDepartment() {
		return supCulDepartment;
	}

	public void setSupCulDepartment(String supCulDepartment) {
		this.supCulDepartment = supCulDepartment;
	}

	public double getSupCulArea() {
		return supCulArea;
	}

	public void setSupCulArea(double supCulArea) {
		this.supCulArea = supCulArea;
	}

	public double getAgriToConArea() {
		return AgriToConArea;
	}

	public void setAgriToConArea(double agriToConArea) {
		AgriToConArea = agriToConArea;
	}

	public String getContactCompany() {
		return contactCompany;
	}

	public void setContactCompany(String contactCompany) {
		this.contactCompany = contactCompany;
	}

	public String getContactor() {
		return contactor;
	}

	public void setContactor(String contactor) {
		this.contactor = contactor;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPrjAddr() {
		return prjAddr;
	}

	public void setPrjAddr(String prjAddr) {
		this.prjAddr = prjAddr;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getAuditOpinion() {
		return auditOpinion;
	}

	public void setAuditOpinion(String auditOpinion) {
		this.auditOpinion = auditOpinion;
	}

	public String getPrjStatus() {
		return prjStatus;
	}

	public void setPrjStatus(String prjStatus) {
		this.prjStatus = prjStatus;
	}

	public String getAuditer() {
		return auditer;
	}

	public void setAuditer(String auditer) {
		this.auditer = auditer;
	}
	


	public String getApplier() {
		return applier;
	}

	public void setApplier(String applier) {
		this.applier = applier;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="pcmId",referencedColumnName="id")
	public List<PrjAttachmentEntity> getPrjAttachmentEntitis() {
		return prjAttachmentEntitis;
	}

	public void setPrjAttachmentEntitis(List<PrjAttachmentEntity> prjAttachmentEntitis) {
		this.prjAttachmentEntitis = prjAttachmentEntitis;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
}
