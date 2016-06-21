/**
 * 
 */
package com.jksb.land.entity.prjCntManage;

import com.jksb.land.entity.IdEntity;

/**
 * @author Willian Chan
 *
 */
public class prjParcel extends IdEntity {

	/**
	 * 项目建设地块
	 */
	private static final long serialVersionUID = 1L;
	
	private String prjParcelNO;

	public String getPrjParcelNO() {
		return prjParcelNO;
	}

	public void setPrjParcelNO(String prjParcelNO) {
		this.prjParcelNO = prjParcelNO;
	}
}
