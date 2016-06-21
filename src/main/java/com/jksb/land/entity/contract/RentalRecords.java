/**
 * 
 */
package com.jksb.land.entity.contract;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jksb.land.entity.IdEntity;

/**
 * 租金记录表
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_CTT_RENTALRECORDS")
public class RentalRecords extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private double actualAmount;	//实缴金额
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date payDate;	//缴费日期
	
	private String rentReceive;	//票据号
	
	private String rentPayerName;	//缴纳人
	
	private String rentPayerIdNO;	//缴纳人证件号
	
	private PrePayingBudget prePayingBudget;	//土地管理费预算

	public double getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(double actualAmount) {
		this.actualAmount = actualAmount;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public String getRentReceive() {
		return rentReceive;
	}

	public void setRentReceive(String rentReceive) {
		this.rentReceive = rentReceive;
	}

	public String getRentPayerName() {
		return rentPayerName;
	}

	public void setRentPayerName(String rentPayerName) {
		this.rentPayerName = rentPayerName;
	}

	public String getRentPayerIdNO() {
		return rentPayerIdNO;
	}

	public void setRentPayerIdNO(String rentPayerIdNO) {
		this.rentPayerIdNO = rentPayerIdNO;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="prePayingBudgetID")
	@JsonManagedReference
	public PrePayingBudget getPrePayingBudget() {
		return prePayingBudget;
	}
	
	
	public void setPrePayingBudget(PrePayingBudget prePayingBudget) {
		this.prePayingBudget = prePayingBudget;
	}
}
