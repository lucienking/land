package com.jksb.land.service.statistic;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.statistics.StatisticsDataEntity;

/**
 * 统计通用service
 * @author wangxj
 *
 */
@Component
@Transactional
public class StatisticService {

	@PersistenceContext(unitName = "arcgisJpa")
	private EntityManager arcgisEntityManager;
	
	@PersistenceContext(unitName = "landJpa")
	private EntityManager landEntityManager;
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getResult(String procName,Map<String,Object> param){
		List<Map<String,Object>> rows = new ArrayList<Map<String,Object>>();
		Session session =(Session) landEntityManager.getDelegate();
		SQLQuery sqlQuery = session.createSQLQuery("{call "+procName+"}");
		sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
		if(param!=null)
			for(Entry<String, Object> entry : param.entrySet() ){
				sqlQuery.setParameter(entry.getKey(), entry.getValue()) ;
			}
		rows = sqlQuery.list();
		return rows;
	}
	
	/**
	 * 获取统计数据对象
	 * @param procName
	 * @param param
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<StatisticsDataEntity> getStatisticData(String procName,Map<String,Object> param){
		List<StatisticsDataEntity> list = new ArrayList<StatisticsDataEntity>();
		Query query = arcgisEntityManager.createNativeQuery("{call "+procName+"}");
		if(param!=null)
			for(Entry<String, Object> entry : param.entrySet() ){
				query.setParameter(entry.getKey(), entry.getValue()) ;
			}
		List result = query.getResultList();
		if (result!=null){ 
			Iterator iterator = result.iterator(); 
			while( iterator.hasNext() ){ 
				Object[] row = ( Object[]) iterator.next(); 
				String name = row[0].toString(); 
				Double value = Double.valueOf(row[1].toString());
				StatisticsDataEntity sde = new StatisticsDataEntity();
				sde.setName(name);
				sde.setValue(value);
				list.add(sde);
			} 
		} 
		return list;
	}
	
	@SuppressWarnings("rawtypes")
	public List<Object[]> getStatisticRow(String procName,Map<String,Object> param){
		List<Object[]> list = new ArrayList<Object[]>();
		Query query = arcgisEntityManager.createNativeQuery("{call "+procName+"}");
		if(param!=null)
			for(Entry<String, Object> entry : param.entrySet() ){
				query.setParameter(entry.getKey(), entry.getValue()) ;
			}
		List result = query.getResultList();
		if (result!=null){ 
			Iterator iterator = result.iterator(); 
			while( iterator.hasNext() ){ 
				Object[] row = ( Object[]) iterator.next(); 
				list.add(row);
			} 
		} 
		return list;
	}
	
	/**
	 * 获取统列对象
	 * @param procName
	 * @param param
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<StatisticsDataEntity> getLandStatisticData(String procName,Map<String,Object> param){
		List<StatisticsDataEntity> list = new ArrayList<StatisticsDataEntity>();
		Query query = landEntityManager.createNativeQuery("{call "+procName+"}");
		if(param!=null)
			for(Entry<String, Object> entry : param.entrySet() ){
				query.setParameter(entry.getKey(), entry.getValue()) ;
			}
		List result = query.getResultList();
		if (result!=null){ 
			Iterator iterator = result.iterator(); 
			while( iterator.hasNext() ){ 
				Object[] row = ( Object[]) iterator.next(); 
				String name = row[0].toString(); 
				Double value = Double.valueOf(row[1].toString());
				StatisticsDataEntity sde = new StatisticsDataEntity();
				sde.setName(name);
				sde.setValue(value);
				list.add(sde);
			} 
		} 
		return list;
	}
	
	@SuppressWarnings("rawtypes")
	public List<Object[]> getLandStatisticRow(String procName,Map<String,Object> param){
		List<Object[]> list = new ArrayList<Object[]>();
		Query query = landEntityManager.createNativeQuery("{call "+procName+"}");
		if(param!=null)
			for(Entry<String, Object> entry : param.entrySet() ){
				query.setParameter(entry.getKey(), entry.getValue()) ;
			}
		List result = query.getResultList();
		if (result!=null){ 
			Iterator iterator = result.iterator(); 
			while( iterator.hasNext() ){ 
				Object[] row = ( Object[]) iterator.next(); 
				list.add(row);
			} 
		} 
		return list;
	}
}
