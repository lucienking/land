<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.ResourceBundle"%> 
<% ResourceBundle res = ResourceBundle.getBundle("application"); 
   String changPwdUrl = res.getString("usm.changepwd.url");
   String logoutUrl = res.getString("usm.logout.url");
   String serverURL = res.getString("arcgis.service.url");
   String apiUrl = res.getString("arcgis.api.url");
   String server151URL = res.getString("arcgis151.service.url");
%> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="changPwdUrl" value="<%=changPwdUrl %>" />
<c:set var="logoutUrl" value="<%=logoutUrl %>" />
<c:set var="arcgisServiceUrl" value="<%=serverURL %>" />
<c:set var="arcgisapiUrl" value="<%=apiUrl %>" />
<c:set var="arcgisService151Url" value="<%=server151URL%>" />
<html>
<head>
<link href="../static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<script src="../static/jquery/jquery-1.9.1.min.js"></script>
<script src="../static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="../static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<!-- arcGIS -->
<script type="text/javascript" src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script>
<!-- 自定义JS,css引用 -->
<script src="../static/js/jksb.land.common.js"></script>
<script type="text/javascript" src="../static/js/landuse/landuse.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>无标题文档</title>

<style type="text/css">
	.grid-header{
		height:18px;
		background:url("${ctx }/static/image/map_grid_head_bg.png") repeat;
		font-size:12px;
		padding:5px;
		font-weight:bold;
		border-bottom:1px solid #95B8E7;
	}
	.grid_td{
		border-right:1px dotted #CCC;
		border-bottom:1px dotted #CCC;
		font-size:12px;
		padding:5px;
	}
	.grid_td_right {
		border-bottom:1px dotted #CCC;
		font-size:12px;
		padding:5px;
	}
	.selfLegend{
		display:none;
		margin:0;
		padding:0;
		width:100%;
		height:320px;
		background:url(<spring:url value="/resources/image/legend-dilei2.jpg"/>) no-repeat;
	}
	#HomeButton {
      position: absolute;
      top: 95px;
      left: 25px;
      z-index: 50;
    }
     #LocateButton {
      position: absolute;
      top: 135px;
      left: 25px;
      z-index: 50;
    }
    .dijitReset{
		display:block;
		padding:1px;
	}
	.conditions{
		width:100px;
	}
	.clazz1{
		border: 1px solid #CCC;
		
		background:#73B273;
	}
	.clazz2{
		border: 1px solid #CCC;
		background:red;
	}
	.clazz3{
		border: 1px solid #CCC;
		background:yellow;
	}
</style>

</head>
<script>
var serverURL="${arcgisServiceUrl}";
var server151URL = "${arcgisService151Url}";
</script>
</head>
<body>
<div id="cc" class="easyui-layout" class="easyui-layout" data-options="fit: true">
    <div data-options="region:'east'" style="width:340px;">
    	<div class="grid-header">操作</div>
    	<table width="100%">
    		<tr>
    			<td colspan="3"><div id="printButton"></div></td>
    		</tr>
    		<tr><td style="text-align:center;" colspan="4"><b>1:50000 以上比例</b></td></tr>
    		<tr>
    			<!-- <td colspan="3">
    				<div id="selfLegend" style="height:300px;overflow-y:auto;"></div>	
    			</td> -->
    		</tr>
    	</table>
		<div class="grid-header" style="border-top:1px solid #95B8E7;">地块统计信息</div>
		<table width="100%" id="show_grid">
		
		<!-- <div id="printButton" style="position:absolute;right:15px;top:10px;"></div> -->
		</table>
		<div class="grid-header" style="border-top:1px solid #95B8E7;">地块类型统计信息</div>
		<table width="100%" id="show_grid0">
		
		<!-- <div id="printButton" style="position:absolute;right:15px;top:10px;"></div> -->
		</table>
		
		<div class="grid-header" style="border-top:1px solid #95B8E7;">地块搜索</div>
		<table id="search" width="100%">
			<tr>
				<td>地类名称</td>
				<td><input type="text" id="DLMC" name="DLMC" class="easyui-combobox" " required/></td>
				<td><a href="#" class="easyui-linkbutton" onClick="landSearch();" id="searchBt">搜索</a></td>
			</tr>
		</table>
		
    </div>
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
    	<div id="mapDiv" style="height:100%;width:100%;">
    		<div id="HomeButton"></div>
    	</div>
    </div>
</div>
</body>
</html>

