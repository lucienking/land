package com.jksb.land.entity.bpm;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jksb.land.entity.IdEntity;

/**
 *  流程跟踪日志
 * @author wangxj
 * 
 */

@Entity
@Table(name = "BASE_BPM_TRACKLOG")
public class TrackLog extends IdEntity {

	private static final long serialVersionUID = 1L;

	private Long orderId;			 //订单ID

	private String orderName;     	 //订单名称
	
	private String nodeName;		 //节点名称
	
	private String preStatus;		 //上一状态  --pause
	
	private String currentStatus;	 //目前状态
	
	private String operateAccount;		//操作账号
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date operateDate;			//操作日期
	
	private String operateContent;		//操作内容
	
	private String opinion;				//处理意见

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getPreStatus() {
		return preStatus;
	}

	public void setPreStatus(String preStatus) {
		this.preStatus = preStatus;
	}

	public String getCurrentStatus() {
		return currentStatus;
	}

	public void setCurrentStatus(String currentStatus) {
		this.currentStatus = currentStatus;
	}

	public String getOperateAccount() {
		return operateAccount;
	}

	public void setOperateAccount(String operateAccount) {
		this.operateAccount = operateAccount;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getOperateDate() {
		return operateDate;
	}

	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}

	public String getOperateContent() {
		return operateContent;
	}

	public void setOperateContent(String operateContent) {
		this.operateContent = operateContent;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
}
