package com.jksb.land.shiro;

import java.util.Set;

import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cas.CasRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jksb.land.common.util.PrincipalUtil;



/**
 * 自定义授权过程，预留系统本地接口<br/>
 * 角色信息 中文?
 * 
 * @author wangxj
 *
 */

public class CasRealmClient extends CasRealm {

	private final static Logger logger = LoggerFactory.getLogger(CasRealmClient.class);
	
	/**
	 * 获取登录信息，进行授权
	 */
	@Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
    	
		String username = PrincipalUtil.getCurrentUserName(principals);
		logger.info(" 对用户[{}] 进行授权。",username);
		
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		
		try {
			Set<String> permissions = PrincipalUtil.getAllOperPermissionsFromCAS(principals);
            Set<String> roles = PrincipalUtil.getAllOperRolesFromCAS(principals);
            /*
             * 本地权限预留
             */
			addRoles(simpleAuthorizationInfo,roles);
			addPermissions(simpleAuthorizationInfo,permissions);
		}catch (Exception e) {
			logger.error("授权出错，权限或角色参数不合法。<br/>{}",e);
		} 
		
        return simpleAuthorizationInfo;
	}
	
    private void addRoles(SimpleAuthorizationInfo simpleAuthorizationInfo, Set<String> roles) {
        for (String role : roles) {
            simpleAuthorizationInfo.addRole(role);
        }
    }
    
    private void addPermissions(SimpleAuthorizationInfo simpleAuthorizationInfo, Set<String> permissions) {
        for (String permission : permissions) {
            simpleAuthorizationInfo.addStringPermission(permission);
        }
    }
}
