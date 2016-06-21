package com.jksb.land.service.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.common.easyui.EasyUiPage;
import com.jksb.land.common.util.CommonUtil;

/**
 * 存储过程执行 SQL语句 执行 封装类
 * @author wangxj
 *
 */
@Component
@Transactional
public class ProcedureExecuteService {
	
	@PersistenceContext(unitName = "arcgisJpa")
	private EntityManager arcgisEntityManager;
	
	@PersistenceContext(unitName = "landJpa")
	private EntityManager landEntityManager;
	
	/**
	 * 返回Map 结果集
	 * @param procName
	 * @param param
	 * @param entityManager
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getResult(String procName,Map<String,Object> param,EntityManager entityManager){
		List<Map<String,Object>> rows = new ArrayList<Map<String,Object>>();
		Session session =(Session) entityManager.getDelegate();
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
	 * 执行SQL 返回Map 结果集
	 * @param sql
	 * @param param
	 * @param entityManager
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getQueryResult(String sql,Map<String,Object> param,EntityManager entityManager){
		List<Map<String,Object>> rows = new ArrayList<Map<String,Object>>();
		Session session =(Session) entityManager.getDelegate();
		SQLQuery sqlQuery = session.createSQLQuery(sql);
		sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
		if(param!=null)
			for(Entry<String, Object> entry : param.entrySet() ){
				sqlQuery.setParameter(entry.getKey(), entry.getValue()) ;
			}
		rows = sqlQuery.list();
		return rows;
	}
	
	/**
	 * 执行SQL 返回Map 分页结果集
	 * @param procName
	 * @param param
	 * @param entityManager
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String,Object> getQueryResultPage(String procName,Map<String,Object> param
				,EntityManager entityManager,EasyUiPage page){
		
		List<Map<String,Object>> rows = new ArrayList<Map<String,Object>>();
		Session session =(Session) entityManager.getDelegate();
		SQLQuery sqlQuery = session.createSQLQuery(procName);
		sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
		if(param!=null)
			for(Entry<String, Object> entry : param.entrySet() ){
				sqlQuery.setParameter(entry.getKey(), entry.getValue()) ;
			}
		
		int total = sqlQuery.list().size();
		sqlQuery.setFirstResult((page.getPageNumber()-1)*page.getPageSize());
		sqlQuery.setMaxResults(page.getPageSize());
		rows = sqlQuery.list();
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("total",total);
		result.put("rows", rows);
		return result;
	}
	
	/**
	 * 返回Map 分页结果集
	 * @param procName
	 * @param param
	 * @param entityManager
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String,Object> getResult(String procName,Map<String,Object> param,
				EntityManager entityManager,EasyUiPage page){
		List<Map<String,Object>> rows = new ArrayList<Map<String,Object>>();
		Session session =(Session) entityManager.getDelegate();

		SQLQuery sqlCount = session.createSQLQuery("{call "+procName+"}");
		sqlCount.setParameter("pageSize", page.getPageSize());
		sqlCount.setParameter("pageNumber", page.getPageNumber());
		sqlCount.setParameter("queryTotal", "N");
		sqlCount.setParameter("orderStr", page.getSortString()+" ");
		sqlCount.setParameter("orderDerect",""+ page.getSortType());
		for(Entry<String, Object> entry : param.entrySet() ){
			sqlCount.setParameter(entry.getKey(), entry.getValue()) ;
		}
		sqlCount.setParameter("queryTotal", "Y");
		int totalNum = (Integer) sqlCount.list().get(0);
		
		SQLQuery sqlQuery = session.createSQLQuery("{call "+procName+"}");
		sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
		sqlQuery.setParameter("pageSize", page.getPageSize());
		sqlQuery.setParameter("pageNumber", page.getPageNumber());
		sqlQuery.setParameter("queryTotal", "N");
		sqlQuery.setParameter("orderStr", CommonUtil.underscoreName(page.getSortString())+" ");
		sqlQuery.setParameter("orderDerect",""+ page.getSortType());
		for(Entry<String, Object> entry : param.entrySet() ){
			sqlQuery.setParameter(entry.getKey(), entry.getValue()) ;
		}
		rows = sqlQuery.list(); 
		
		int c = totalNum%page.getPageSize()==0?totalNum/page.getPageSize():totalNum/page.getPageSize()+1;
		int r = totalNum%page.getPageSize()==0?page.getPageSize():totalNum%page.getPageSize();
		if(c == page.getPageNumber())
			rows = rows.subList(0, r);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("total",totalNum);
		result.put("rows", rows);
		return result;
	}
	
	/**
	 * Arcgis 数据源 返回分页结果
	 * @param procName
	 * @param param
	 * @return
	 */
	public Map<String,Object> getArcgisResult(String procName,Map<String,Object> param,EasyUiPage page){
		return this.getResult(procName, param, arcgisEntityManager,page);
	}
	
	/**
	 * 国土 数据源  返回分页结果
	 * @param procName
	 * @param param
	 * @return
	 */
	public Map<String,Object> getLandResult(String procName,Map<String,Object> param,EasyUiPage page){
		return this.getResult(procName, param, landEntityManager,page);
	}
	
	/**
	 * Arcgis 数据源
	 * @param procName
	 * @param param
	 * @return
	 */
	public List<Map<String,Object>> getArcgisResult(String procName,Map<String,Object> param){
		return this.getResult(procName, param, arcgisEntityManager);
	}
	
	/**
	 * Arcgis 数据源
	 * @param procName
	 * @param param
	 * @return
	 */
	public List<Map<String,Object>> getArcgisQueryResult(String sql,Map<String,Object> param){
		return this.getQueryResult(sql, param, arcgisEntityManager);
	}
	
	/**
	 * 国土 数据源
	 * @param procName
	 * @param param
	 * @return
	 */
	public List<Map<String,Object>> getLandResult(String procName,Map<String,Object> param){
		return this.getResult(procName, param, landEntityManager);
	}
	
	/**
	 * 国土 数据源 执行查询sql
	 * @param procName
	 * @param param
	 * @return
	 */
	public Map<String,Object> getLandQueryResult(String sql,Map<String,Object> param,EasyUiPage page){
		return this.getQueryResultPage(sql, param, landEntityManager, page);
	}
	
}
