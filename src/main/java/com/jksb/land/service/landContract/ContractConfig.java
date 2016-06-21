package com.jksb.land.service.landContract;

import java.util.HashMap;
import java.util.Map;

public class ContractConfig {

	private Map<String,String> farmMap=new HashMap<String,String>();

	public Map<String, String> getFarmMap() {
		return farmMap;
	}

	public void setFarmMap(Map<String, String> farmMap) {
		this.farmMap = farmMap;
	}
	
}
