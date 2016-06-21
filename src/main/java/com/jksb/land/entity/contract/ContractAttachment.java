/**
 * 
 */
package com.jksb.land.entity.contract;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 合同附件实体类
 * @author Willian Chan
 *
 */


@Entity
@Table(name = "BUSI_CTT_CONTRACTATTACHMENT")
public class ContractAttachment extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	private String attachmentName;		//附件名称
	
	private String attachmentType;	//附件类型
	
	private String attachmentLong;		//附件大小
	
	private String attachmentdirection;	//附件路径
	
	/*@ManyToOne(fetch = FetchType.LAZY)
	private Contract contract;			//多对一外部关系实体,ManyToOne
	
	@JoinColumn(name="contractCode",referencedColumnName="contractCode")
	@JsonIgnore
	public Contract getContract() {
		return contract;
	}

	@JsonBackReference
	public void setContract(Contract contract) {
		this.contract = contract;
	}*/

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
}
