package com.jksb.land.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jksb.land.common.util.SystemParamUtil;

/**
 * REST接口调用 人口信息查询
 * @author wangxj
 *
 */
@Component
public class RestRemoteTransfer {
	
	// REST 接口地址参数名，配置于数据库中
	private final static String REST_GET_PEOPLEINFO_URL = "REST_GET_PEOPLEINFO_URL";
	
	//REST 接口默认地址
	private final static String REST_GET_PEOPLEINFO_URL_DEFAULT = "http://10.215.200.121:8080/resident/api/v1/rkxx/getPersonal";

	public Map<String,String> getPeopleInfo(String idCardNO) throws ClientProtocolException, IOException{
		CloseableHttpClient httpclient = HttpClients.createDefault(); 
		HttpPost httppost = new HttpPost(getRemoteTransferPath());   //初始化httpClient
		
		List<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();
		params.add(new BasicNameValuePair("gmsfhm",idCardNO));
		httppost.setEntity(new UrlEncodedFormEntity(params));       //设置请求参数
		
		HttpResponse re = httpclient.execute(httppost);
		String bodyAsString = EntityUtils.toString(re.getEntity()); //得到响应报文
		
		ObjectMapper mapper = new ObjectMapper();  
		JavaType javaType = mapper.getTypeFactory().constructParametricType(Map.class,String.class,String.class);
		Map<String,String> map = mapper.readValue(bodyAsString, javaType);  //转换自定义数据类型
		return map;
	}
	
	/**
	 * 获取接口地址从数据库中,如果果为空，则取默认地址
	 * @return
	 */
	private String getRemoteTransferPath(){
		String path = SystemParamUtil.getParamValueByCode(REST_GET_PEOPLEINFO_URL);
		if(StringUtils.isBlank(path))
			path = REST_GET_PEOPLEINFO_URL_DEFAULT;
		return path;
	}
	
}
