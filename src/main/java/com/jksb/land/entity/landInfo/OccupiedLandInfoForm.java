package com.jksb.land.entity.landInfo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.jksb.land.entity.IdEntity;

@Entity
@Table(name="BASE_OCCUPIEDLANDINFOFORM")
public class OccupiedLandInfoForm extends IdEntity{

	private static final long serialVersionUID = 1L;
	
	private String num;						//编号
	
	private String communityNum;			//社区编号
	
	private String landCertificate;			//土地证书编号
	
	private String occupiedLandLocation;	//被占土地所在市县
	
	private Double landArea;				//地块面积
	
	private String landPracelNo;			//地块编号
	
	private String position;				//位置
	
	private String occupiedLandTime;		//占地时间
	
	private String landUseOverallPlaning;	//土地利用总体规划
	
	private String registerCertificate;		//登记发证
	
	private String landRegisterCertificateTime;		//登记发证时间
	
	private String occupiedLandOwner;			//占地主体
	
	private String occupiedLandForm;			//占地形式
	
	private String Dispose;					//做过何种处理
	
	private String occupyPeopleName;		//占用人姓名
	 
	private String occupyPeopleIdentityNo;  //占用人身份证号码
	
	private String isTransferredLand;		//是否划转土地
	
	private String nowLandPowerPeople;		//现土地权利人
	
	private Double occupiedLandBlataUpdateArea;			//被占地橡胶更新地面积
	
	private Double occupiedLandForestLandArea;			//被占地林地面积
	
	private Double occupiedLandDesertArea;				//荒地面积
	
	private Double occupiedLandTropicalCropArea;		//被占地热作地
	
	private Double occupiedLandPlough;					//被占地耕地
	
	private Double occupiedLandOtherLand;				//被占地其他土地
	
	private Double occupiedLandUseToAfforestation;		//被占用途——造林
	
	private Double occupiedLandUseToPlantBalata;		//被占用途-种橡胶
	
	private Double occupiedLandUseToPlantTropicalCrop;	//被占用途-种热带作物
	
	private Double occupiedLandUseToPaddyField;			//被占用途-水田、瓜果菜地
	
	private Double occupiedLandUseToUseToHouseTead;		//被占用途-宅基地
	
	private Double occupiedLandUseToOtherUsage;			//被占用途-其他用途
	
	private String occupiedLandExplain;					//占地说明
	
	private String remark;				//备注
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createTime;		//创建时间
	
	private String createName;		//创建用户
	
	private String researchName;	//被调查人
	
	private String gatherName;		//信息采集人签名
	
	private String isAuthentic;		//是否确权

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

	public String getLandCertificate() {
		return landCertificate;
	}

	public void setLandCertificate(String landCertificate) {
		this.landCertificate = landCertificate;
	}

	public String getOccupiedLandLocation() {
		return occupiedLandLocation;
	}

	public void setOccupiedLandLocation(String occupiedLandLocation) {
		this.occupiedLandLocation = occupiedLandLocation;
	}

	public Double getLandArea() {
		return landArea;
	}

	public void setLandArea(Double landArea) {
		this.landArea = landArea;
	}

	public String getLandPracelNo() {
		return landPracelNo;
	}

	public void setLandPracelNo(String landPracelNo) {
		this.landPracelNo = landPracelNo;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getOccupiedLandTime() {
		return occupiedLandTime;
	}

	public void setOccupiedLandTime(String occupiedLandTime) {
		this.occupiedLandTime = occupiedLandTime;
	}

	public String getLandUseOverallPlaning() {
		return landUseOverallPlaning;
	}

	public void setLandUseOverallPlaning(String landUseOverallPlaning) {
		this.landUseOverallPlaning = landUseOverallPlaning;
	}

	public String getRegisterCertificate() {
		return registerCertificate;
	}

	public void setRegisterCertificate(String registerCertificate) {
		this.registerCertificate = registerCertificate;
	}

	public String getLandRegisterCertificateTime() {
		return landRegisterCertificateTime;
	}

	public void setLandRegisterCertificateTime(String landRegisterCertificateTime) {
		this.landRegisterCertificateTime = landRegisterCertificateTime;
	}

	public String getOccupiedLandOwner() {
		return occupiedLandOwner;
	}

	public void setOccupiedLandOwner(String occupiedLandOwner) {
		this.occupiedLandOwner = occupiedLandOwner;
	}

	public String getOccupiedLandForm() {
		return occupiedLandForm;
	}

	public void setOccupiedLandForm(String occupiedLandForm) {
		this.occupiedLandForm = occupiedLandForm;
	}

	public String getDispose() {
		return Dispose;
	}

	public void setDispose(String dispose) {
		Dispose = dispose;
	}

	public String getOccupyPeopleName() {
		return occupyPeopleName;
	}

	public void setOccupyPeopleName(String occupyPeopleName) {
		this.occupyPeopleName = occupyPeopleName;
	}

	public String getOccupyPeopleIdentityNo() {
		return occupyPeopleIdentityNo;
	}

	public void setOccupyPeopleIdentityNo(String occupyPeopleIdentityNo) {
		this.occupyPeopleIdentityNo = occupyPeopleIdentityNo;
	}

	public String getIsTransferredLand() {
		return isTransferredLand;
	}

	public void setIsTransferredLand(String isTransferredLand) {
		this.isTransferredLand = isTransferredLand;
	}

	public String getNowLandPowerPeople() {
		return nowLandPowerPeople;
	}

	public void setNowLandPowerPeople(String nowLandPowerPeople) {
		this.nowLandPowerPeople = nowLandPowerPeople;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Double getOccupiedLandBlataUpdateArea() {
		return occupiedLandBlataUpdateArea;
	}

	public void setOccupiedLandBlataUpdateArea(Double occupiedLandBlataUpdateArea) {
		this.occupiedLandBlataUpdateArea = occupiedLandBlataUpdateArea;
	}

	public Double getOccupiedLandForestLandArea() {
		return occupiedLandForestLandArea;
	}

	public void setOccupiedLandForestLandArea(Double occupiedLandForestLandArea) {
		this.occupiedLandForestLandArea = occupiedLandForestLandArea;
	}

	public Double getOccupiedLandDesertArea() {
		return occupiedLandDesertArea;
	}

	public void setOccupiedLandDesertArea(Double occupiedLandDesertArea) {
		this.occupiedLandDesertArea = occupiedLandDesertArea;
	}

	public Double getOccupiedLandTropicalCropArea() {
		return occupiedLandTropicalCropArea;
	}

	public void setOccupiedLandTropicalCropArea(Double occupiedLandTropicalCropArea) {
		this.occupiedLandTropicalCropArea = occupiedLandTropicalCropArea;
	}

	public Double getOccupiedLandPlough() {
		return occupiedLandPlough;
	}

	public void setOccupiedLandPlough(Double occupiedLandPlough) {
		this.occupiedLandPlough = occupiedLandPlough;
	}

	public Double getOccupiedLandOtherLand() {
		return occupiedLandOtherLand;
	}

	public void setOccupiedLandOtherLand(Double occupiedLandOtherLand) {
		this.occupiedLandOtherLand = occupiedLandOtherLand;
	}

	public Double getOccupiedLandUseToAfforestation() {
		return occupiedLandUseToAfforestation;
	}

	public void setOccupiedLandUseToAfforestation(
			Double occupiedLandUseToAfforestation) {
		this.occupiedLandUseToAfforestation = occupiedLandUseToAfforestation;
	}

	public Double getOccupiedLandUseToPlantBalata() {
		return occupiedLandUseToPlantBalata;
	}

	public void setOccupiedLandUseToPlantBalata(Double occupiedLandUseToPlantBalata) {
		this.occupiedLandUseToPlantBalata = occupiedLandUseToPlantBalata;
	}

	public Double getOccupiedLandUseToPlantTropicalCrop() {
		return occupiedLandUseToPlantTropicalCrop;
	}

	public void setOccupiedLandUseToPlantTropicalCrop(
			Double occupiedLandUseToPlantTropicalCrop) {
		this.occupiedLandUseToPlantTropicalCrop = occupiedLandUseToPlantTropicalCrop;
	}

	public Double getOccupiedLandUseToPaddyField() {
		return occupiedLandUseToPaddyField;
	}

	public void setOccupiedLandUseToPaddyField(Double occupiedLandUseToPaddyField) {
		this.occupiedLandUseToPaddyField = occupiedLandUseToPaddyField;
	}

	public Double getOccupiedLandUseToUseToHouseTead() {
		return occupiedLandUseToUseToHouseTead;
	}

	public void setOccupiedLandUseToUseToHouseTead(
			Double occupiedLandUseToUseToHouseTead) {
		this.occupiedLandUseToUseToHouseTead = occupiedLandUseToUseToHouseTead;
	}

	public Double getOccupiedLandUseToOtherUsage() {
		return occupiedLandUseToOtherUsage;
	}

	public void setOccupiedLandUseToOtherUsage(Double occupiedLandUseToOtherUsage) {
		this.occupiedLandUseToOtherUsage = occupiedLandUseToOtherUsage;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}

	public String getOccupiedLandExplain() {
		return occupiedLandExplain;
	}

	public void setOccupiedLandExplain(String occupiedLandExplain) {
		this.occupiedLandExplain = occupiedLandExplain;
	}

	public String getResearchName() {
		return researchName;
	}

	public void setResearchName(String researchName) {
		this.researchName = researchName;
	}

	public String getGatherName() {
		return gatherName;
	}

	public void setGatherName(String gatherName) {
		this.gatherName = gatherName;
	}

	public String getIsAuthentic() {
		return isAuthentic;
	}

	public void setIsAuthentic(String isAuthentic) {
		this.isAuthentic = isAuthentic;
	}
}