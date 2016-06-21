/**
 * 
 */
package com.jksb.land.entity.staticData;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jksb.land.entity.IdEntity;
import com.jksb.land.entity.sys.OrganizationEntity;

/**
 * 静态社区编码表
 * @author Willian Chan
 *
 */
@Entity
@Table(name = "STAT_COMMUNITY")
public class CommunityEntity extends IdEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String communityCode;	//社区编码
	
	private String communityName;	//社区名称
	
	private String farmCode;	//农场编码
	
	private OrganizationEntity organizationEntity;
	
	private Set<ResidentsGroup> residentsGroup;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="farm" ,referencedColumnName="orgCode")
	public OrganizationEntity getOrganizationEntity() {
		return organizationEntity;
	}

	public void setOrganizationEntity(OrganizationEntity organizationEntity) {
		this.organizationEntity = organizationEntity;
	}

	@OneToMany(cascade= CascadeType.ALL, fetch = FetchType.EAGER)
	public Set<ResidentsGroup> getResidentsGroup() {
		return residentsGroup;
	}

	@JsonBackReference
	public void setResidentsGroup(Set<ResidentsGroup> residentsGroup) {
		this.residentsGroup = residentsGroup;
	}

	public String getCommunityCode() {
		return communityCode;
	}

	public void setCommunityCode(String communityCode) {
		this.communityCode = communityCode;
	}

	public String getCommunityName() {
		return communityName;
	}

	public void setCommunityName(String communityName) {
		this.communityName = communityName;
	}

	public String getFarmCode() {
		return farmCode;
	}

	public void setFarmCode(String farmCode) {
		this.farmCode = farmCode;
	}
	
	
}
