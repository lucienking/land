package com.jksb.land.entity.landInfo;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.jksb.land.entity.IdEntity;

@Entity
@Table(name="BUSI_SELFUSEFARMLANDFORM")
public class SelfUseFarmLandForm extends IdEntity{

	private static final long serialVersionUID = 1L;
	
	private String num;             //编号
	
	private String communityNum;    //社区编码
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date addTime;		   //登记时间

	private String userName;	    //操作用户
	
	private List<SelfUseFarmLand> selfUseFarmLand;

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getCommunityNum() {
		return communityNum;
	}

	public void setCommunityNum(String communityNum) {
		this.communityNum = communityNum;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@OneToMany(cascade=CascadeType.ALL,fetch = FetchType.LAZY)
	@JoinColumn(name="num",referencedColumnName="num")
	public List<SelfUseFarmLand> getSelfUseFarmLand() {
		return selfUseFarmLand;
	}

	public void setSelfUseFarmLand(List<SelfUseFarmLand> selfUseFarmLand) {
		this.selfUseFarmLand = selfUseFarmLand;
	}
	
}
