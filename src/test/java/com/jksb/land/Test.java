package com.jksb.land;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jksb.land.common.util.CommonUtil;
import com.jksb.land.common.util.SystemParamUtil;
import com.jksb.land.rest.RestRemoteTransfer;


public class Test {
	public static void main(String[] args){
		
		Map<String, String> rst;
		
		String date  = CommonUtil.getNowDateFormat("yyMMddHHmmssSSS");
		int random  = (int) (Math.random()*9000+1000);
		System.out.println(date);
		System.out.println(random);
		/*try {
			rst = getPeopleInfo("132401182011027263");
			for(String m:rst.keySet()){
				System.out.println(m+":"+rst.get(m));
			}
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		
		 /*DateFormat df =  DateFormat.getDateInstance();
		 Date start = new Date();
		 Date end = new Date();;
		 try {
			start = df.parse("2015-06-10");
			end = df.parse("2020-06-10");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		List<String> list = getYearMonthList(start,end);
		for(String s:list){
			System.out.println(s);
		} */
	}

	private static List<String> getYearMonthList(Date start, Date end) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		List<String> years = new ArrayList<String>();

		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(start);
		c2.setTime(end);
		while (c1.compareTo(c2) <= 0) {
			Date prex = c1.getTime();
			String str = sdf.format(prex);
			c1.add(Calendar.YEAR, 1);
			Date hrex = c1.getTime();
			String str2 = sdf.format(hrex);
			years.add(str + "-" + str2 );
		}
		
		return years;
	}
	
	
	private final static String REST_GET_PEOPLEINFO_URL_DEFAULT = "http://10.215.200.121:8080/resident/api/v1/rkxx/getPersonal";

	public static Map<String,String> getPeopleInfo(String idCardNO) throws ClientProtocolException, IOException{
		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpPost httppost = new HttpPost(getUploadFileSavePath());
		List<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();
		params.add(new BasicNameValuePair("gmsfhm",idCardNO));
		httppost.setEntity(new UrlEncodedFormEntity(params));
		HttpResponse re = httpclient.execute(httppost);
		String bodyAsString = EntityUtils.toString(re.getEntity());
		ObjectMapper mapper = new ObjectMapper();  
		JavaType javaType = mapper.getTypeFactory().constructParametricType(Map.class,String.class,String.class);
		Map<String,String> map = mapper.readValue(bodyAsString, javaType);
		return map;
	}
	
	private static String getUploadFileSavePath(){
		String path = "";//SystemParamUtil.getParamValueByCode(REST_GET_PEOPLEINFO_URL);
		if(StringUtils.isBlank(path))
			path = REST_GET_PEOPLEINFO_URL_DEFAULT;
		return path;
	}
}
