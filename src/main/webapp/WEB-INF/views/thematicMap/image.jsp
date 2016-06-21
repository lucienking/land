<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ page import="java.util.ResourceBundle"%> 
<% ResourceBundle res = ResourceBundle.getBundle("application"); 
   String serverURL = res.getString("arcgis.service.url");
   String apiUrl = res.getString("arcgis.api.url");
%> 

<c:set var="arcgisServiceUrl" value="<%=serverURL %>" />
<c:set var="arcgisapiUrl" value="<%=apiUrl %>" />
<html>
<head>
<link href="../static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<script src="../static/jquery/jquery-1.9.1.min.js"></script>
<script src="../static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="../static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<!-- arcGIS -->
<link rel="stylesheet" href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<script type="text/javascript" src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<style type="text/css">
 .grid-header{
		height:18px;
		background:url("${ctx }/static/image/map_grid_head_bg.png") repeat;
		font-size:12px;
		padding:5px;
		font-weight:bold;
		border-bottom:1px solid #95B8E7;
	}
	#HomeButton_image {
      position: absolute;
      top: 95px;
      left: 20px;
      z-index: 50;
    }     	
</style>
<script type="text/javascript" src="${ctx }/static/js/map/image.js"></script>
</head>
<body>
<div id="cc"  class="easyui-layout" data-options="fit: true">
    <div data-options="region:'east'" style="width:200px;">
    	  <div class="grid-header" style="border-top:1px solid #95B8E7;">农场变换</div>
	   	<table width="100%">
	   		<tr>
	   			<td colspan="3"></td>
	   			<td><input id="FarmName_image" name="dept" class="easyui-combobox" style="border-top:4px solid #95B8E7;">
	   			</td>
	   		</tr>	
	   		     <tr>	<td colspan="3"></td><td><div id="printButton_image"></td></div></tr>   	
	   	</table>	    	
	  
    </div>
    <div id="cmap_mango" data-options="region:'center'" style=" width: 100%; height: 100%; ">
    	<div id="mapDiv_image" style="width: 100%;height: 100%; ">
    		<div id="HomeButton_image"></div>
    	</div>
    
    </div>
</div>
<script>
var serverURL="${arcgisServiceUrl}";
</script>

<body>
</html>




