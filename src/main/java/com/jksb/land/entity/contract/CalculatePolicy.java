/**
 * 
 */
package com.jksb.land.entity.contract;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jksb.land.entity.IdEntity;

/**
 * 计价政策
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "BUSI_CTT_CALCULATEPOLICY")
public class CalculatePolicy extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	private int policyType;		//政策类型
	
	private String policyInterpret;		//政策说明
	
	private double	 countValue;		//计价值
	
	@ManyToOne(fetch = FetchType.LAZY)
	private PrePayingBudget prePayingBudget;	//土地管理费预算

	public int getPolicyType() {
		return policyType;
	}

	public void setPolicyType(int policyType) {
		this.policyType = policyType;
	}

	public String getPolicyInterpret() {
		return policyInterpret;
	}

	public void setPolicyInterpret(String policyInterpret) {
		this.policyInterpret = policyInterpret;
	}

	public double getCountValue() {
		return countValue;
	}

	public void setCountValue(double countValue) {
		this.countValue = countValue;
	}
	
	@JoinColumn(name="prePayingBudgetID")
	@JsonManagedReference
	public PrePayingBudget getPrePayingBudget() {
		return prePayingBudget;
	}

	public void setPrePayingBudget(PrePayingBudget prePayingBudget) {
		this.prePayingBudget = prePayingBudget;
	}
}
