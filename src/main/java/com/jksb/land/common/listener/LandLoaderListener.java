package com.jksb.land.common.listener;

import javax.servlet.ServletContextEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jksb.land.common.context.SpringContextHolder;
		

public class LandLoaderListener extends ContextLoaderListener{
	private final static Logger logger = LoggerFactory.getLogger(LandLoaderListener.class);

	public void contextInitialized(ServletContextEvent sce){
        super.contextInitialized(sce);
        logger.info("==============Land Listener Initialization=============");
        ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
        SpringContextHolder springContextHolder = new SpringContextHolder();
        springContextHolder.setApplicationContext(applicationContext);
        logger.info("==============Land Initialization success =============");
    }
}
