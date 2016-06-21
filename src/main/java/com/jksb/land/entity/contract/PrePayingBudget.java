/**
 * 
 */
package com.jksb.land.entity.contract;


import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jksb.land.entity.IdEntity;

/**
 * 土地管理费预算
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_CTT_PREPAYINGBUDGET")
public class PrePayingBudget extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String specificYear;	//缴费年份
		
	private double payingRental; 	//应缴金额 
	
	private double paidRental;		//已缴金额
	
	private double paidBudget;		//参考应缴金额
	
	private double ownshipRental;		//欠缴金额
	
	private String isPartialAreaFree;	//是否减免面积
	
	private String isPartialRentFree;	//是否减免租金
	
	private String isDiscount;       	//是否折扣
	
	private double partialAreaFree = 0;		//减免面积
	
	private double partialRentFree = 0;		//减免租金
	
	private double disCount = 0;       		//折扣

	private List<RentalRecords> rentalRecords;		//缴费记录，OneToMany一对多，一个缴费年份可以有多个缴费记录
	
	private List<CalculatePolicy> calculatePolicy;		//计价方式，OneToMany。
	
	private String calculateProcess;

	public String getSpecificYear() {
		return specificYear;
	}

	public double getPayingRental() {
		return payingRental;
	}

	public void setPayingRental(double payingRental) {
		this.payingRental = payingRental;
	}

	public double getPaidRental() {
		return paidRental;
	}

	public void setPaidRental(double paidRental) {
		this.paidRental = paidRental;
	}

	public double getPaidBudget() {
		return paidBudget;
	}

	public void setPaidBudget(double paidBudget) {
		this.paidBudget = paidBudget;
	}

	public double getOwnshipRental() {
		return ownshipRental;
	}

	public void setOwnshipRental(double ownshipRental) {
		this.ownshipRental = ownshipRental;
	}

	public void setSpecificYear(String specificYear) {
		this.specificYear = specificYear;
	}

	public String getIsPartialAreaFree() {
		return isPartialAreaFree;
	}

	public void setIsPartialAreaFree(String isPartialAreaFree) {
		this.isPartialAreaFree = isPartialAreaFree;
	}

	public String getIsPartialRentFree() {
		return isPartialRentFree;
	}

	public void setIsPartialRentFree(String isPartialRentFree) {
		this.isPartialRentFree = isPartialRentFree;
	}

	public String getIsDiscount() {
		return isDiscount;
	}

	public void setIsDiscount(String isDiscount) {
		this.isDiscount = isDiscount;
	}

	public double getPartialAreaFree() {
		return partialAreaFree;
	}

	public void setPartialAreaFree(double partialAreaFree) {
		this.partialAreaFree = partialAreaFree;
	}

	public double getPartialRentFree() {
		return partialRentFree;
	}

	public void setPartialRentFree(double partialRentFree) {
		this.partialRentFree = partialRentFree;
	}

	public double getDisCount() {
		return disCount;
	}

	public void setDisCount(double disCount) {
		this.disCount = disCount;
	}
	
	@JsonBackReference
	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY, mappedBy="prePayingBudget")	
	public List<RentalRecords> getRentalRecords() {
		return rentalRecords;
	}

	public void setRentalRecords(List<RentalRecords> rentalRecords) {
		this.rentalRecords = rentalRecords;
	}

	public String getCalculateProcess() {
		return calculateProcess;
	}

	public void setCalculateProcess(String calculateProcess) {
		this.calculateProcess = calculateProcess;
	}

	@JsonBackReference
	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY, mappedBy="prePayingBudget")	
	public List<CalculatePolicy> getCalculatePolicy() {
		return calculatePolicy;
	}
	
	public void setCalculatePolicy(List<CalculatePolicy> calculatePolicy) {
		this.calculatePolicy = calculatePolicy;
	}

}
