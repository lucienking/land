/**
 * 
 */
package com.jksb.land.entity.mapEntity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jksb.land.entity.IdEntity;

/**
 * 被占地实体
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_MAP_OCCUPIED")
public class OccupiedEntity extends IdEntity {

	private static final long serialVersionUID = 1L;

	private String occupiedNO;		//宗地编号
	
	private double occupiedArea;	//占有面积
	
	private String city;			//市县
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date occupiedDate;		//占地时间
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date issueingDate;		//发证时间
	
	private String occupiedStage;	//占地阶段
	
	private String isWoodland;	//是否是林地
	
	private String issueSituation;	//登记发证情形
	
	private String certificateNO;	//证书编号
	
	private String originalType;	//被占土地原地类
	
	private String currentUse;		//被占后用途
	
	private String occupiedObject;	//占地主体
	
	private String occupiedForm;	//占地形式
	
	private String processingMeans;	//做过何种处理
	
	private String isTransfer;	//是否属于土地划转
	
	private String currentOwner;	//现土地权利人
	
	private String curOwnerCertificate;	//现土地权利人证书编号
	
	private String farmCode;	//农场编码

	public String getFarmCode() {
		return farmCode;
	}

	public void setFarmCode(String farmCode) {
		this.farmCode = farmCode;
	}

	public String getOccupiedNO() {
		return occupiedNO;
	}

	public void setOccupiedNO(String occupiedNO) {
		this.occupiedNO = occupiedNO;
	}

	public double getOccupiedArea() {
		return occupiedArea;
	}

	public void setOccupiedArea(double occupiedArea) {
		this.occupiedArea = occupiedArea;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getOccupiedDate() {
		return occupiedDate;
	}

	public void setOccupiedDate(Date occupiedDate) {
		this.occupiedDate = occupiedDate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getIssueingDate() {
		return issueingDate;
	}

	public void setIssueingDate(Date issueingDate) {
		this.issueingDate = issueingDate;
	}

	public String getOccupiedStage() {
		return occupiedStage;
	}

	public void setOccupiedStage(String occupiedStage) {
		this.occupiedStage = occupiedStage;
	}



	public String getIssueSituation() {
		return issueSituation;
	}

	public void setIssueSituation(String issueSituation) {
		this.issueSituation = issueSituation;
	}

	public String getCertificateNO() {
		return certificateNO;
	}

	public void setCertificateNO(String certificateNO) {
		this.certificateNO = certificateNO;
	}

	public String getOriginalType() {
		return originalType;
	}

	public void setOriginalType(String originalType) {
		this.originalType = originalType;
	}

	public String getCurrentUse() {
		return currentUse;
	}

	public void setCurrentUse(String currentUse) {
		this.currentUse = currentUse;
	}

	public String getOccupiedObject() {
		return occupiedObject;
	}

	public void setOccupiedObject(String occupiedObject) {
		this.occupiedObject = occupiedObject;
	}

	public String getOccupiedForm() {
		return occupiedForm;
	}

	public void setOccupiedForm(String occupiedForm) {
		this.occupiedForm = occupiedForm;
	}


	public String getProcessingMeans() {
		return processingMeans;
	}

	public void setProcessingMeans(String processingMeans) {
		this.processingMeans = processingMeans;
	}



	public String getIsWoodland() {
		return isWoodland;
	}

	public void setIsWoodland(String isWoodland) {
		this.isWoodland = isWoodland;
	}

	public String getIsTransfer() {
		return isTransfer;
	}

	public void setIsTransfer(String isTransfer) {
		this.isTransfer = isTransfer;
	}

	public String getCurrentOwner() {
		return currentOwner;
	}

	public void setCurrentOwner(String currentOwner) {
		this.currentOwner = currentOwner;
	}

	public String getCurOwnerCertificate() {
		return curOwnerCertificate;
	}

	public void setCurOwnerCertificate(String curOwnerCertificate) {
		this.curOwnerCertificate = curOwnerCertificate;
	}
	
	
}
