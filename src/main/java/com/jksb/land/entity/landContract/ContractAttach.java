package com.jksb.land.entity.landContract;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 合同附件信息实体
 * @author LiuXin
 * @date 2016年6月12日
 */
@Entity
@Table(name = "CONTRACT_ATTACH")
public class ContractAttach extends IdEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9187322209471975723L;
	
	private String fileName;
	
	private String suffix;
	
	private String fileSize;
	
	private String fileSrc;
	
	private Date createTime;
	
	private LandContract landContract;
	
	private String originFileName;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileSrc() {
		return fileSrc;
	}

	public void setFileSrc(String fileSrc) {
		this.fileSrc = fileSrc;
	}

	@ManyToOne
	@JoinColumn(name = "landContract_id")
	public LandContract getLandContract() {
		return landContract;
	}

	public void setLandContract(LandContract landContract) {
		this.landContract = landContract;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getOriginFileName() {
		return originFileName;
	}

	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	
	

}
