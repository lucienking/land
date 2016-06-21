package com.jksb.land.entity.contract;

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
 * 承包合同实体类
 * @author Willian Chan
 * 
 */

@Entity
@Table(name = "BUSI_CTT_CONTRACT")
public class Contract extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String contractCode;	//合同编码：与合同编号不同，合同编码由信息中心编制，用于标记数据组织层级。
	
	private String contractNo;		//合同编号：农场自行编制并管理
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date dateOfSigning;		//合同签订日期
	
	private int leaseTerm;			//承包期
	
	private String firstParty;		//甲方
	
	private String firstPtRepresentative;	//甲方法定代表人
	
	private String secondParty;		//乙方
	
	private String secondPartyType;		//乙方类型  PERSONAL  ENTERPRISE
	
	private String secondPtRepresentative; // 乙方法定代表人
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date startDate;					//合同起始/有效时间
	
	@DateTimeFormat(pattern="yyyy-MM-dd")  
	private Date expiredDate;				//合同到期时间
	
	private String signingAddress;			//合同签订地址
	
	private String supplementaryProvisions;	//合同补充条款
	
	private int contractStatus;		//合同状态，0：已登记；1：待审核；2：审核通过；3：审核不通过；4：已生效；5：已过期；6：已过期
	
	private double signingPrice;	//签订单价（单位：元/亩）
	
	private String landLevel;		//土地等级
	
	private String landType;		//土地类型 
	
	private String landExtend;		//四至
	
	private double useArea;			//承包 面积
	
	private String landLocation;	//土地座落
	
	private String isStepedCount;	//是否阶梯计价
	
	private String isRegularlyRaise;	//是否定期递增：若为真,必须填5年增长率
	
	private double ratePerFiveYear;		//5年上涨率
	
	private String creator;		//创建人
	
	private Date createTime;	//创建时间
	
	private String operator;	//操作人
	
	private Date updateTime;	//更新时间
	
	private double affordableArea ;	//保障性用地面积
	
	private double gisArea;			//GIS统计计算面积
	
	private String auditOpinion;		//审核意见，用于审核不通过时，说明不通过的理由
	
	//	一对多外部关系实体，oneToMany
	private List<ContractorPersonal> contractorPersonal;			//承包者信息,FK
	
	//	一对多外部关系实体，oneToMany
	private List<ContractorEnterprise> contractorEnterprise;			//承包者信息,FK
	
	//	一对多外部关系实体，oneToMany
	private List<ContractParcelInfo> contractParcelInfo;			//承包地信息,FK
	
	private List<ContractAttachment> contractAttachment;		// 合同附件信息
	
	private List<PrePayingBudget> prePayingBudget;				//应缴费用
	
	//	多对一外部关系实体,ManyToOne
	private ResidentsGroup residentsGroup;				//居民小组编码,FK

	private ContractVersion contractVersion;			//合同版本号,FK
	
	private StepCalculateVersion stepCalculateVersion;	//阶梯计价版本号，FK
	
	private String plantCrops;							//自营经济种植作物
	
	public String getContractCode() {
		return contractCode;
	}

	public void setContractCode(String contractCode) {
		this.contractCode = contractCode;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getDateOfSigning() {
		return dateOfSigning;
	}

	public void setDateOfSigning(Date dateOfSigning) {
		this.dateOfSigning = dateOfSigning;
	}

	public int getLeaseTerm() {
		return leaseTerm;
	}

	public void setLeaseTerm(int leaseTerm) {
		this.leaseTerm = leaseTerm;
	}

	public String getFirstParty() {
		return firstParty;
	}

	public void setFirstParty(String firstParty) {
		this.firstParty = firstParty;
	}

	public String getFirstPtRepresentative() {
		return firstPtRepresentative;
	}

	public void setFirstPtRepresentative(String firstPtRepresentative) {
		this.firstPtRepresentative = firstPtRepresentative;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getExpiredDate() {
		return expiredDate;
	}

	public void setExpiredDate(Date expiredDate) {
		this.expiredDate = expiredDate;
	}

	public String getSigningAddress() {
		return signingAddress;
	}

	public void setSigningAddress(String signingAddress) {
		this.signingAddress = signingAddress;
	}

	public String getSupplementaryProvisions() {
		return supplementaryProvisions;
	}

	public void setSupplementaryProvisions(String supplementaryProvisions) {
		this.supplementaryProvisions = supplementaryProvisions;
	}

	public int getContractStatus() {
		return contractStatus;
	}

	public void setContractStatus(int contractStatus) {
		this.contractStatus = contractStatus;
	}

	public double getSigningPrice() {
		return signingPrice;
	}

	public void setSigningPrice(double signingPrice) {
		this.signingPrice = signingPrice;
	}

	public String getSecondPartyType() {
		return secondPartyType;
	}

	public void setSecondPartyType(String secondPartyType) {
		this.secondPartyType = secondPartyType;
	}

	public String getLandLevel() {
		return landLevel;
	}

	public void setLandLevel(String landLevel) {
		this.landLevel = landLevel;
	}

	public String getLandType() {
		return landType;
	}

	public void setLandType(String landType) {
		this.landType = landType;
	}

	public String getLandExtend() {
		return landExtend;
	}

	public void setLandExtend(String landExtend) {
		this.landExtend = landExtend;
	}

	public double getUseArea() {
		return useArea;
	}

	public void setUseArea(double useArea) {
		this.useArea = useArea;
	}

	public String getLandLocation() {
		return landLocation;
	}

	public void setLandLocation(String landLocation) {
		this.landLocation = landLocation;
	}

	public String getIsStepedCount() {
		return isStepedCount;
	}

	public void setIsStepedCount(String isStepedCount) {
		this.isStepedCount = isStepedCount;
	}

	public String getIsRegularlyRaise() {
		return isRegularlyRaise;
	}

	public void setIsRegularlyRaise(String isRegularlyRaise) {
		this.isRegularlyRaise = isRegularlyRaise;
	}

	public double getRatePerFiveYear() {
		return ratePerFiveYear;
	}

	public void setRatePerFiveYear(double ratePerFiveYear) {
		this.ratePerFiveYear = ratePerFiveYear;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
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

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="residentsGrpCode" ,referencedColumnName="residentsGrpCode")//关联列名
	public ResidentsGroup getResidentsGroup() {
		return residentsGroup;
	}

	public void setResidentsGroup(ResidentsGroup residentsGroup) {
		this.residentsGroup = residentsGroup;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="contractVersionNo",referencedColumnName="contractVersionNo")
	public ContractVersion getContractVersion() {
		return contractVersion;
	}

	public void setContractVersion(ContractVersion contractVersion) {
		this.contractVersion = contractVersion;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="versionCode",referencedColumnName="versionCode")
	public StepCalculateVersion getStepCalculateVersion() {
		return stepCalculateVersion;
	}

	public void setStepCalculateVersion(StepCalculateVersion stepCalculateVersion) {
		this.stepCalculateVersion = stepCalculateVersion;
	}

	public double getGisArea() {
		return gisArea;
	}

	public void setGisArea(double gisArea) {
		this.gisArea = gisArea;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="contractCode",referencedColumnName="contractCode")
	public List<ContractorPersonal> getContractorPersonal() {
		return contractorPersonal;
	}

	public void setContractorPersonal(List<ContractorPersonal> contractorPersonal) {
		this.contractorPersonal = contractorPersonal;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="contractCode",referencedColumnName="contractCode")
	public List<ContractorEnterprise> getContractorEnterprise() {
		return contractorEnterprise;
	}

	public void setContractorEnterprise(List<ContractorEnterprise> contractorEnterprise) {
		this.contractorEnterprise = contractorEnterprise;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="contractCode",referencedColumnName="contractCode")
	public List<ContractParcelInfo> getContractParcelInfo() {
		return contractParcelInfo;
	}

	public void setContractParcelInfo(List<ContractParcelInfo> contractParcelInfo) {
		this.contractParcelInfo = contractParcelInfo;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="contractCode",referencedColumnName="contractCode")
	public List<ContractAttachment> getContractAttachment() {
		return contractAttachment;
	}

	public void setContractAttachment(List<ContractAttachment> contractAttachment) {
		this.contractAttachment = contractAttachment;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name="contractCode",referencedColumnName="contractCode")
	public List<PrePayingBudget> getPrePayingBudget() {
		return prePayingBudget;
	}

	public void setPrePayingBudget(List<PrePayingBudget> prePayingBudget) {
		this.prePayingBudget = prePayingBudget;
	}

	public String getAuditOpinion() {
		return auditOpinion;
	}

	public void setAuditOpinion(String auditOpinion) {
		this.auditOpinion = auditOpinion;
	}

	public double getAffordableArea() {
		return affordableArea;
	}

	public void setAffordableArea(double affordableArea) {
		this.affordableArea = affordableArea;
	}

	public String getSecondParty() {
		return secondParty;
	}

	public void setSecondParty(String secondParty) {
		this.secondParty = secondParty;
	}

	public String getSecondPtRepresentative() {
		return secondPtRepresentative;
	}

	public void setSecondPtRepresentative(String secondPtRepresentative) {
		this.secondPtRepresentative = secondPtRepresentative;
	}

	public String getPlantCrops() {
		return plantCrops;
	}

	public void setPlantCrops(String plantCrops) {
		this.plantCrops = plantCrops;
	}

}
