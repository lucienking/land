package com.jksb.land.common.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;


public class PrincipalUtil {
	
	private final static Logger logger = LoggerFactory.getLogger(PrincipalUtil.class);
	
	public final static String URL_PARAM_CAS_AUTHORITY = "authority";
	
	public final static String URL_PARAM_CAS_PERMISSION = "url";
	
	public final static String URL_PARAM_CAS_ROLE = "role";
	
	public final static String URL_PARAM_CAS_APPCODE = "appCode";
	
	public final static String PROPERTY_APPLICATION_CODE = "application.code";
	
	public final static String PROPERTY_FILE_NAME = "application"; 
	
	/**
	 * 获取登录用户的信息，如果未登录则返回null
	 * @param subject
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public static Map<String,String> getPrincipalInfo(Subject subject) throws UnsupportedEncodingException{
		Map<String,String> infomap=new HashMap<String,String>();
		if(subject==null){
				return null;
	   	 }
		SimplePrincipalCollection principalCollection= (SimplePrincipalCollection) subject .getPrincipals();
		 if (principalCollection==null) {
			return null;
		}
		List<Object> listPrincipals = principalCollection.asList();
		Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
		String username =URLDecoder.decode(attributes.get("username"), "UTF-8");
		String id = URLDecoder.decode(attributes.get("id"), "UTF-8");
		String name = URLDecoder.decode(attributes.get("name"), "UTF-8");
		String departmentName = URLDecoder.decode(attributes.get("depname"), "UTF-8");
		String departmentCode = URLDecoder.decode(attributes.get("depcode"), "UTF-8");
		String departmentLevel = URLDecoder.decode(attributes.get("deplevel"), "UTF-8");
		String phone_number = URLDecoder.decode(attributes.get("phone_number"), "UTF-8");
	//	String weixin_id = URLDecoder.decode(attributes.get("weixin_id"), "UTF-8");
		infomap.put("username", username);
		infomap.put("id", id);
		infomap.put("name", name);
		infomap.put("departmentName", departmentName);
		infomap.put("departmentCode", departmentCode);
		infomap.put("departmentLevel", departmentLevel);
		infomap.put("phone_number", phone_number);
	//	infomap.put("weixin_id", weixin_id);
		return infomap;
	}
	
	/**
	 * 获取当前登录操作员ID
	 * @param subject
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public static Long getCurrentUserId(){
		Subject subject = SecurityUtils.getSubject();
		Long userId = 0L;
		if(subject!=null&&subject .getPrincipals()!=null){
			SimplePrincipalCollection principalCollection= (SimplePrincipalCollection) subject .getPrincipals();
			List<Object> listPrincipals = principalCollection.asList();
			Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
			try {
				String id = URLDecoder.decode(attributes.get("id"), "UTF-8");
				userId = StringUtils.isNumeric(id)? Integer.valueOf(id):0L;
			} catch (UnsupportedEncodingException e) {
				logger.error("UnsupportedEncodingException"+e.toString());
			}
		}
		return userId;
	}
	
	
	/**
	 * 获取当前登录操作员登录账号
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String getCurrentUserAccount(){
		return getValueByName("username");
	}
	
	/**
	 * 获取当前登录操作员登录员名字
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String getCurrentUserName(){
		return getValueByName("name");
	}
	
	/**
	 * 获取当前登录操作员部门名称
	 * @return
	 */
	public static String getCurrentUserDepartmentName(){
		return getValueByName("depname");
	}
	
	/**
	 * 获取当前登录操作员部门编码
	 * @return
	 */
	public static String getCurrentUserDepartmentCode(){
		return getValueByName("depcode");
	}
	
	/**
	 * 获取当前登录操作员登录账号
	 * @param subject
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public static String getCurrentUserName(PrincipalCollection principals){
		String username = "";
		if(principals!=null){
			SimplePrincipalCollection principalCollection= (SimplePrincipalCollection) principals;
			List<Object> listPrincipals = principalCollection.asList();
			Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
			try {
				username = URLDecoder.decode(attributes.get("username"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				logger.error("UnsupportedEncodingException"+e.toString());
			}
		}
		return username;
	}
	
	/**
	 * 是否拥有permission权限 
	 * @param permission
	 * @return
	 */
	public static boolean isHavePermission(String permission){
		boolean isShow = Boolean.FALSE ;
		Subject currentUser = SecurityUtils.getSubject(); 
		if(StringUtils.isBlank(permission)) 
			isShow = Boolean.FALSE;
		else if (currentUser.hasRole("admin")||currentUser.isPermitted(permission)) {  
			isShow = Boolean.TRUE;
		}  
		return isShow;
	}
	
	/**
	 * 从CAS 获取当前系统 用户的所有权限 (统一安全管理配置的权限)
	 * @param principals
	 * @param appCode
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Set<String> getAllOperPermissionsFromCAS(PrincipalCollection principals) throws Exception{
		Set<String> permissions = new HashSet<String>();
		 
		SimplePrincipalCollection principalCollection = (SimplePrincipalCollection) principals;
        List<Object> listPrincipals = principalCollection.asList();
        Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
        String authorityStr = attributes.get(URL_PARAM_CAS_AUTHORITY);
		if (StringUtils.isNotEmpty(authorityStr)) {
			ObjectMapper objectMapper = new ObjectMapper();
			authorityStr = java.net.URLDecoder.decode(authorityStr, "UTF-8").replace("&#034;", "\"");
			List<Map<String, Object>> authorityList = objectMapper.readValue(authorityStr, List.class);
			for (Map<String, Object> auth : authorityList) {
				String appCode = auth.get(URL_PARAM_CAS_APPCODE).toString();
				if(appCode.equals(CommonUtil.getPropertyValue(PROPERTY_FILE_NAME, PROPERTY_APPLICATION_CODE))){
					permissions.add(auth.get(URL_PARAM_CAS_PERMISSION).toString());
				}
            }
		}
        return permissions;
	}
	
	/**
	 * 从CAS 获取当前系统 用户的所有角色 (统一安全管理配置的角色)
	 * @param principals
	 * @param appCode
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Set<String> getAllOperRolesFromCAS(PrincipalCollection principals) throws Exception{
		Set<String> roles = new HashSet<String>();
		 
		SimplePrincipalCollection principalCollection = (SimplePrincipalCollection) principals;
        List<Object> listPrincipals = principalCollection.asList();
        Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
        String authorityStr = attributes.get(URL_PARAM_CAS_AUTHORITY);
		if (StringUtils.isNotEmpty(authorityStr)) {
			ObjectMapper objectMapper = new ObjectMapper();
			authorityStr = java.net.URLDecoder.decode(authorityStr, "UTF-8").replace("&#034;", "\"");
			List<Map<String, Object>> authorityList = objectMapper.readValue(authorityStr, List.class);
			for (Map<String, Object> auth : authorityList) {
				String appCode = auth.get(URL_PARAM_CAS_APPCODE).toString();
				if(appCode.equals(CommonUtil.getPropertyValue(PROPERTY_FILE_NAME, PROPERTY_APPLICATION_CODE))){
					roles.add(auth.get(URL_PARAM_CAS_ROLE).toString());
				}
            }
		}
        return roles;
	}
	
	@SuppressWarnings("unchecked")
	private static String getValueByName(String name){
		String value = "";
		Subject subject = SecurityUtils.getSubject();
		if(subject!=null&&subject.getPrincipals()!=null){
			SimplePrincipalCollection principalCollection= (SimplePrincipalCollection) subject.getPrincipals();
			List<Object> listPrincipals = principalCollection.asList();
			Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
			try {
				value = URLDecoder.decode(attributes.get(name), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				logger.error("UnsupportedEncodingException"+e.toString());
			}
		}
		return value;
	}
	
	/**
	 * 获取登录用户是否为总局机关部门用户
	 * @param subject
	 * @return
	 */
	public static boolean isSenior(){
		String departmentCode = getCurrentUserDepartmentCode();
		return (inInterval(101,139,departmentCode)||"1".equals(departmentCode));
	}
	/**
	 * 判断登录用户所属部门的编码是否在指定的编码区间内
	 * @param min 编码区间最小值
	 * @param max 编码区间最大值
	 * @param subject
	 * @return
	 */
	private static boolean inInterval(Integer min,Integer max,String departmentCode){
		if(departmentCode != null ){
			int code = Integer.parseInt(departmentCode);
			if(min!=null&&max!=null){
				if(code >= min && code <= max){
					return true;
				}
			}else if(min!=null){
				if(code >= min ){
					return true;
				}
			}else if(max!=null){
				if(code <= max){
					return true;
				}
			}
			
		}
		return false;
	}
}
