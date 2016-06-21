package com.jksb.land.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.cas.CasFilter;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.common.util.SystemLogUtil;


public class CasFilterClient extends CasFilter {
	
	private final static Logger logger = LoggerFactory.getLogger(CasFilterClient.class);

	 /**
     * If login has been successful, redirect user to the original protected url.
     * 
     * @param token the token representing the current authentication
     * @param subject the current authenticated subjet
     * @param request the incoming request
     * @param response the outgoing response
     * @throws Exception if there is an error processing the request.
     */
    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request,
                                     ServletResponse response) throws Exception {
    	
		logger.info("----------------用户[{}] 单点登录成功---------------",PrincipalUtil.getCurrentUserAccount());
		for (String key : PrincipalUtil.getPrincipalInfo(subject).keySet()) {
			logger.info(key+":"+PrincipalUtil.getPrincipalInfo(subject).get(key));
		}
		SystemLogUtil.saveSysLog((HttpServletRequest) request, "用户单点登录");
        return super.onLoginSuccess(token, subject, request, response);
    }
}
