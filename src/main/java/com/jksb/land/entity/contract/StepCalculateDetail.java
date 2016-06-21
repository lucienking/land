package com.jksb.land.entity.contract;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;


@Entity
@Table(name = "BUSI_CTT_STEPCALCULATEDETAIL")
public class StepCalculateDetail  extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	private double stepStart;				//阶梯范围起
	
	private double stepEnd;					//阶梯范围止
	
	private double setpCoefficient;			//阶梯计算系数
	
	private int stepLong;					//阶梯步长
	
	private StepCalculateVersion stepCalculateVersion; // 阶梯计价版本

	public double getStepStart() {
		return stepStart;
	}

	public void setStepStart(double stepStart) {
		this.stepStart = stepStart;
	}

	public double getStepEnd() {
		return stepEnd;
	}

	public void setStepEnd(double stepEnd) {
		this.stepEnd = stepEnd;
	}

	public double getSetpCoefficient() {
		return setpCoefficient;
	}

	public void setSetpCoefficient(double setpCoefficient) {
		this.setpCoefficient = setpCoefficient;
	}

	public int getStepLong() {
		return stepLong;
	}

	public void setStepLong(int stepLong) {
		this.stepLong = stepLong;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="versionCode")
	public StepCalculateVersion getStepCalculateVersion() {
		return stepCalculateVersion;
	}

	public void setStepCalculateVersion(StepCalculateVersion stepCalculateVersion) {
		this.stepCalculateVersion = stepCalculateVersion;
	}
}
