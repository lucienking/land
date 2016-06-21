package com.jksb.land.entity.staticData;


import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 静态居民小组编码表
 * @author Willian Chan
 *
 */

@Entity
@Table(name = "STAT_ResidentsGroup")
public class ResidentsGroup extends IdEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String residentsGrpCode;	//居民小组编码
	
	private String residentsGrpName;	//居民小组名称
	
	private CommunityEntity communityEntity;		//社区编码
	
	public String getResidentsGrpCode() {
		return residentsGrpCode;
	}

	public void setResidentsGrpCode(String residentsGrpCode) {
		this.residentsGrpCode = residentsGrpCode;
	}

	public String getResidentsGrpName() {
		return residentsGrpName;
	}

	public void setResidentsGrpName(String residentsGrpName) {
		this.residentsGrpName = residentsGrpName;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="communityCode",referencedColumnName="communityCode")
	public CommunityEntity getCommunityEntity() {
		return communityEntity;
	}

	public void setCommunityEntity(CommunityEntity communityEntity) {
		this.communityEntity = communityEntity;
	}
}
