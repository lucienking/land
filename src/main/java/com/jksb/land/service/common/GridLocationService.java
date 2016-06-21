/**
 * 
 */
package com.jksb.land.service.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Willian Chan
 *
 */
@Component
@Transactional
public class GridLocationService {
	@PersistenceContext(unitName = "gpsJpa")
	private EntityManager communityEntityManager;
	
	/**
	 * 根据电话号码查询网格员提交的信息记录。
	 * @param params 
	 * <ul><li>包含一个phone字符串用于存电话号码（多个）以及一个date日期表示查询指定某日的记录</li></ul>
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getLocationsWithTemplate(String sql){
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		List<Map<String,Object>> rows = new ArrayList<Map<String,Object>>();
		Session session =(Session) communityEntityManager.getDelegate();
		SQLQuery sqlQuery = session.createSQLQuery(sql);
		sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
		rows = sqlQuery.list();
//		时间转换字符串
		for(Map<String,Object> row:rows){
			String report_date=formatter.format(row.get("report_date"));
			row.put("report_date", report_date);
		}
		return rows;
	}
	

}
