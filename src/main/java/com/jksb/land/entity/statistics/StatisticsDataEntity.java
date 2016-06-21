package com.jksb.land.entity.statistics;

import java.io.Serializable;


/**
 * 统计结果对象  eCharts
 * @author wangxj
 *
 */
public class StatisticsDataEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Double value;
	
	private String name;

	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
