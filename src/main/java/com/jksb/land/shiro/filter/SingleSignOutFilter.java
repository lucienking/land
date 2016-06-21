package com.jksb.land.shiro.filter;


import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.jasig.cas.client.session.SingleSignOutHandler;
import org.jasig.cas.client.util.CommonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 实现单点登出，参照CAS client官方的SingleSignOutFilter源码
 * @author liuxin
 *
 */
public final class SingleSignOutFilter extends PathMatchingFilter {

	private final static Logger logger = LoggerFactory.getLogger(SingleSignOutFilter.class);
	
    private static final SingleSignOutHandler handler = new SingleSignOutHandler();
    
    /** Parameter name that stores logout request */
    private String logoutParameterName = "logoutRequest";
    
    public SingleSignOutFilter(){
         handler.init();
    }
    
    @Override
	protected boolean onPreHandle(ServletRequest request,
			ServletResponse response, Object mappedValue) throws Exception {
    	
    	final HttpServletRequest httpServletrequest = (HttpServletRequest) request;

    	logger.info("------------------logoutFilter{}-------------------",httpServletrequest.getMethod());
        if (handler.isTokenRequest(httpServletrequest)) {
            try {
				handler.recordSession(httpServletrequest);
			} catch (Exception e) {
				return false;
			}
        } else if ( "POST".equals(httpServletrequest.getMethod())&&!isMultipartRequest(httpServletrequest) &&
                CommonUtils.isNotBlank(CommonUtils.safeGetParameter(httpServletrequest,this.logoutParameterName ))) {
            try {
            	Subject subject=SecurityUtils.getSubject();
				subject.logout();
				handler.destroySession(httpServletrequest);
				handler.getSessionMappingStorage().removeBySessionById(httpServletrequest.getSession().getId());
			} catch (Exception e) {
				return false;
			}
            // Do not continue up filter chain
            return false;
        } 
        return true;
    }
    
    protected static SingleSignOutHandler getSingleSignOutHandler() {
        return handler;
    }
    private boolean isMultipartRequest(final HttpServletRequest request) {
        return request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart");
    }
}
