<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ResourceBundle"%> 
<% ResourceBundle res = ResourceBundle.getBundle("application"); 
   String changPwdUrl = res.getString("usm.changepwd.url");
   String logoutUrl = res.getString("usm.logout.url");
   String arcgisapiUrl=res.getString("arcgis.api.url");
%> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="changPwdUrl" value="<%=changPwdUrl %>" />
<c:set var="logoutUrl" value="<%=logoutUrl %>" />
<c:set var="arcgisapiUrl" value="<%=arcgisapiUrl %>" />
<link type="image/x-icon" href="${ctx}/static/images/logo.ico" rel="shortcut icon">
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<!-- easyUI -->
<link href="${ctx}/static/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<script src="${ctx }/static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="${ctx }/static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>

<!-- arcGIS -->
<link rel="stylesheet" href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<script src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script>
<!-- <link rel="stylesheet" href="http://js.arcgis.com/3.13/esri/css/esri.css"> -->
<!-- <script src="http://js.arcgis.com/3.13/"></script> -->


<!-- 自定义JS,css引用 -->
<script src="${ctx }/static/js/jksb.land.common.js"></script>
<script src="${ctx }/static/js/jksb.land.validate.js"></script>
<link href="${ctx }/static/styles/default.css" type="text/css" rel="stylesheet" />
<link href="${ctx }/static/styles/iconstyle.css" type="text/css" rel="stylesheet" />
<link href="${ctx }/static/styles/echarts-land.css" type="text/css" rel="stylesheet" />

<script src="${ctx }/static/js/jksb.land.fileupload.js"></script>

<!-- 统计图表插件 使用单一文件引入方式
<script src="${ctx }/static/eCharts/dist/echarts.js"></script> -->
<script src="${ctx }/static/echarts/dist/echarts-all.js"></script>
