/**
 * 
 */
package com.jksb.land.entity.prjCntManage;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * @author Willian Chan
 *项目建设合同附件信息
 */

@Entity
@Table(name = "BUSI_PRJ_PrjAttachment")
public class PrjAttachmentEntity extends IdEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String attachmentName;		//附件名称
	
	private String attachmentType;	//附件类型
	
	private String attachmentLong;		//附件大小
	
	private String attachmentdirection;	//附件路径
	
	public PCMEntity pcmEntity;		//项目

	public String getAttachmentName() {
		return attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getAttachmentType() {
		return attachmentType;
	}

	public void setAttachmentType(String attachmentType) {
		this.attachmentType = attachmentType;
	}

	public String getAttachmentLong() {
		return attachmentLong;
	}

	public void setAttachmentLong(String attachmentLong) {
		this.attachmentLong = attachmentLong;
	}

	public String getAttachmentdirection() {
		return attachmentdirection;
	}

	public void setAttachmentdirection(String attachmentdirection) {
		this.attachmentdirection = attachmentdirection;
	}

	public PCMEntity getPcmEntity() {
		return pcmEntity;
	}

	public void setPcmEntity(PCMEntity pcmEntity) {
		this.pcmEntity = pcmEntity;
	}

	
	
	
}
