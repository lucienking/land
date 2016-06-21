package com.jksb.land.entity.sys;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.jksb.land.entity.IdEntity;

/**
 * 权限实体类
 * @author wangxj
 *
 */

@Entity
@Table(name="BASE_SYS_AUTHORITY")
public class AuthorityEntity  extends IdEntity{
	
	private static final long serialVersionUID = 1L;
	
	private String authorCode;
	
	private String authorName;
	
	private String authorDesc;

	public String getAuthorCode() {
		return authorCode;
	}

	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getAuthorDesc() {
		return authorDesc;
	}

	public void setAuthorDesc(String authorDesc) {
		this.authorDesc = authorDesc;
	}
}
