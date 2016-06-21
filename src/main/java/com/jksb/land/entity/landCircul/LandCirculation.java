/**
 * 
 */
package com.jksb.land.entity.landCircul;


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
import com.jksb.land.entity.sys.Attachment;

/**
 * @author wangxj
 * 农用地调查表 人口信息表
 */
@Entity
@Table(name = "BUSI_LC_LANDCIRCULATION")
public class LandCirculation extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String circulNo;   				//流转单编号 
	
	private String circulTitle;				//流转单标题
	
	private String circulStatus;    		//流转单状态
	
	private String originContractor; 		//源承包人（流转人）
	
	private String originContractorType; 	//源承包人类型（流转人类型）
	
	private String originContractorId; 		//源承包人身份证号（流转人身份证号）
	
	private String originContractorTele; 	//源承包人电话号（流转人电话号）
	
	private String currentContractor;  		//现承包人 （承流转人）
	
	private String currentContractorType;  	//现承包人类型 （承流转人类型）
	
	private String currentContractorId;  	//现承包人身份证号 （承流转人身份证号）
	
	private String currentContractorTele;   //现承包人电话号 （承流转人电话号）
	
	private String circulType;				//流转类型
	
	private String circulMethod;			//流转方式
	
	private Double circulArea;				//流转面积 
	
	private int	circulYear;					//流转年限
	
	private Double circulPrice;				//流转价格
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date circulDate;				//流转时间
	
	private String detailDescrip;			//详细描述
	
	private String landNo;					//地块编号
	
	private String landLocation;			//地块地址
	
	private String landType;				//地块类型
	
	private ResidentsGroup residentsGroup;  //居民小组
	
	private String isZjPermit;				//是否总局批准
	
	private Double qmfzwPay;				//青苗及附着物补偿费
	
	private Double ldlPay;					//劳动力安置补助费
	
	private Double jcssPay;					//基础设施补偿费
	
	private String repayMethod;				//偿付方式
	
	private String userId;					//申请登记人账号
	
	private String userName;				//申请登记人
	
	private String currentUserId;			//当前操作员账号
	
	private String currentUserName;			//当前操作员
	
	public String getCirculMethod() {
		return circulMethod;
	}

	public void setCirculMethod(String circulMethod) {
		this.circulMethod = circulMethod;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getCirculDate() {
		return circulDate;
	}

	public void setCirculDate(Date circulDate) {
		this.circulDate = circulDate;
	}

	public String getIsZjPermit() {
		return isZjPermit;
	}

	public void setIsZjPermit(String isZjPermit) {
		this.isZjPermit = isZjPermit;
	}

	public Double getQmfzwPay() {
		return qmfzwPay;
	}

	public void setQmfzwPay(Double qmfzwPay) {
		this.qmfzwPay = qmfzwPay;
	}

	public Double getLdlPay() {
		return ldlPay;
	}

	public void setLdlPay(Double ldlPay) {
		this.ldlPay = ldlPay;
	}

	public Double getJcssPay() {
		return jcssPay;
	}

	public void setJcssPay(Double jcssPay) {
		this.jcssPay = jcssPay;
	}

	public String getRepayMethod() {
		return repayMethod;
	}

	public void setRepayMethod(String repayMethod) {
		this.repayMethod = repayMethod;
	}

	private List<Attachment> attachment;		// 合同附件信息

	public String getCirculNo() {
		return circulNo;
	}

	public void setCirculNo(String circulNo) {
		this.circulNo = circulNo;
	}

	public String getCirculTitle() {
		return circulTitle;
	}

	public void setCirculTitle(String circulTitle) {
		this.circulTitle = circulTitle;
	}

	public String getCirculStatus() {
		return circulStatus;
	}

	public void setCirculStatus(String circulStatus) {
		this.circulStatus = circulStatus;
	}

	public String getOriginContractor() {
		return originContractor;
	}

	public void setOriginContractor(String originContractor) {
		this.originContractor = originContractor;
	}

	public String getOriginContractorType() {
		return originContractorType;
	}

	public void setOriginContractorType(String originContractorType) {
		this.originContractorType = originContractorType;
	}

	public String getOriginContractorId() {
		return originContractorId;
	}

	public void setOriginContractorId(String originContractorId) {
		this.originContractorId = originContractorId;
	}

	public String getOriginContractorTele() {
		return originContractorTele;
	}

	public void setOriginContractorTele(String originContractorTele) {
		this.originContractorTele = originContractorTele;
	}

	public String getCurrentContractor() {
		return currentContractor;
	}

	public void setCurrentContractor(String currentContractor) {
		this.currentContractor = currentContractor;
	}

	public String getCurrentContractorType() {
		return currentContractorType;
	}

	public void setCurrentContractorType(String currentContractorType) {
		this.currentContractorType = currentContractorType;
	}

	public String getCurrentContractorId() {
		return currentContractorId;
	}

	public void setCurrentContractorId(String currentContractorId) {
		this.currentContractorId = currentContractorId;
	}

	public String getCurrentContractorTele() {
		return currentContractorTele;
	}

	public void setCurrentContractorTele(String currentContractorTele) {
		this.currentContractorTele = currentContractorTele;
	}

	public String getCirculType() {
		return circulType;
	}

	public void setCirculType(String circulType) {
		this.circulType = circulType;
	}

	public Double getCirculArea() {
		return circulArea;
	}

	public void setCirculArea(Double circulArea) {
		this.circulArea = circulArea;
	}

	public int getCirculYear() {
		return circulYear;
	}

	public void setCirculYear(int circulYear) {
		this.circulYear = circulYear;
	}

	public Double getCirculPrice() {
		return circulPrice;
	}

	public void setCirculPrice(Double circulPrice) {
		this.circulPrice = circulPrice;
	}

	public String getDetailDescrip() {
		return detailDescrip;
	}

	public void setDetailDescrip(String detailDescrip) {
		this.detailDescrip = detailDescrip;
	}

	public String getLandNo() {
		return landNo;
	}

	public void setLandNo(String landNo) {
		this.landNo = landNo;
	}

	public String getLandLocation() {
		return landLocation;
	}

	public void setLandLocation(String landLocation) {
		this.landLocation = landLocation;
	}

	public String getLandType() {
		return landType;
	}

	public void setLandType(String landType) {
		this.landType = landType;
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
	@JoinColumn(name="circulId")
	public List<Attachment> getAttachment() {
		return attachment;
	}

	public void setAttachment(List<Attachment> attachment) {
		this.attachment = attachment;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCurrentUserId() {
		return currentUserId;
	}

	public void setCurrentUserId(String currentUserId) {
		this.currentUserId = currentUserId;
	}

	public String getCurrentUserName() {
		return currentUserName;
	}

	public void setCurrentUserName(String currentUserName) {
		this.currentUserName = currentUserName;
	}

}
