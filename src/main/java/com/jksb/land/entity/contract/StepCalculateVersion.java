package com.jksb.land.entity.contract;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 阶梯计价版本号实体类
 * 表名：BUSI_CTT_STEPCALCULATEVERSION
 * @author Willian Chan 
 *
 */

@Entity
@Table(name = "BUSI_CTT_STEPCALCULATEVERSION")
public class StepCalculateVersion extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String versionCode;		    //阶梯计价版本号

	private String versionName;			//版本名称
	
	private String versionDesc;			//版本描述
	
	private String belongFarm;			//所属农场
	
	private String versionYear;			//版本年份
	
	private String creator;				//创建人
	
	private Date createDate;			//创建日期
	
	private List<StepCalculateDetail> stepCalculateDetail;   //计价详细系数
	
	public String getVersionCode() {
		return versionCode;
	}

	public void setVersionCode(String versionCode) {
		this.versionCode = versionCode;
	}

	public String getVersionName() {
		return versionName;
	}

	public void setVersionName(String versionName) {
		this.versionName = versionName;
	}

	public String getVersionDesc() {
		return versionDesc;
	}

	public void setVersionDesc(String versionDesc) {
		this.versionDesc = versionDesc;
	}

	public String getBelongFarm() {
		return belongFarm;
	}

	public void setBelongFarm(String belongFarm) {
		this.belongFarm = belongFarm;
	}

	public String getVersionYear() {
		return versionYear;
	}

	public void setVersionYear(String versionYear) {
		this.versionYear = versionYear;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY, mappedBy="stepCalculateVersion")
	public List<StepCalculateDetail> getStepCalculateDetail() {
		return stepCalculateDetail;
	}

	public void setStepCalculateDetail(List<StepCalculateDetail> stepCalculateDetail) {
		this.stepCalculateDetail = stepCalculateDetail;
	}
}
