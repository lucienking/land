<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.ResourceBundle"%>
<%
	ResourceBundle res = ResourceBundle.getBundle("application");
	String changPwdUrl = res.getString("usm.changepwd.url");
	String logoutUrl = res.getString("usm.logout.url");
	String serverURL = res.getString("arcgis.service.url");
	String apiUrl = res.getString("arcgis.api.url");
	String server151URL = res.getString("arcgis151.service.url");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="changPwdUrl" value="<%=changPwdUrl%>" />
<c:set var="logoutUrl" value="<%=logoutUrl%>" />
<c:set var="arcgisService151Url" value="<%=server151URL%>" />
<c:set var="arcgisServiceUrl" value="<%=serverURL%>" />
<c:set var="arcgisapiUrl" value="<%=apiUrl%>" />
<html>
<head>
<link href="${ctx}/static/jquery-easyui/themes/default/easyui.css"
	type="text/css" rel="stylesheet" />
<%-- <link rel="stylesheet"  href="${ctx }/static/js/map/Toc/css/agsjs.css">  --%>
<link rel="stylesheet" href="${arcgisapiUrl}/3.12/dijit/themes/tundra/tundra.css">
<link rel="stylesheet" href="${arcgisapiUrl}/3.12/esri/css/esri.css">
<!-- <link rel="stylesheet" href="http://jsapi.thinkgis.cn/dijit/themes/tundra/tundra.css">
<link rel="stylesheet" href="http://jsapi.thinkgis.cn/esri/css/esri.css"> -->
<%-- <link rel="stylesheet"	href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<link rel="stylesheet"	href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/dojo/dijit/themes/tundra/tundra.css"> --%>
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js"></script>
<script src="${ctx}/static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="${ctx}/static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${arcgisapiUrl}/3.12/init.js"></script>
<!-- <script src="http://jsapi.thinkgis.cn/init.js"></script> -->
<%-- <script type="text/javascript"	src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script> --%>
<script type="text/javascript"	src="${ctx }/static/js/map/esri.symbol.MultiLineTextSymbol.js"></script>
<!-- 自定义JS,css引用 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>农用地调查</title>
<style type="text/css">
.grid-header {
	height: 18px;
	background: url("${ctx }/static/image/map_grid_head_bg.png") repeat;
	font-size: 12px;
	padding: 5px;
	font-weight: bold;
	border-bottom: 1px solid #95B8E7;
}

.grid_td {
	border-right: 1px dotted #CCC;
	border-bottom: 1px dotted #CCC;
	font-size: 12px;
	padding: 1px;
}

.grid_td_right {
	border-bottom: 1px dotted #CCC;
	font-size: 12px;
	padding: 5px;
}

#homeButton {
	position: absolute;
	top: 95px;
	left: 20px;
	z-index: 50;
}

.conditions {
	width: 100px;
}
input{
}
</style>
<script type="text/javascript" src="${ctx }/static/js/map/Map.js"></script>
<script type="text/javascript"
	src="${ctx }/static/js/map/agrisurveyPrint.js"></script>

</head>
<script>
	var serverURL = "${arcgisServiceUrl}";
	var server151URL = "${arcgisService151Url}";
</script>
</head>
<body class="tundra">
	<div id="cc" class="easyui-layout" class="easyui-layout"
		data-options="fit: true">
		<div data-options="region:'east'" style="width: 340px;">
			<div class="grid-header" style="border-top: 1px solid #95B8E7;">操作</div>
			<table width="100%">
				<tr>
					<td>
						<input type="hidden" value="${farmCode}" id="farmCode" />
						<input type="hidden" value="${zdCode}" id="zdCode" /> 
						<input type="hidden" value="${groupName}" id="groupName" /> 
						<label for="title">图&nbsp;&nbsp;名</label>
						<input type="text" id="title" value="${contractorName }承包（租赁）宗地图"/></br>
						<label for="title">制作单位</label> 
						<input type="text" id="author" value="海南农垦${farmName }国土科"/></br>
					</td>
					
				</tr>
				<tr>
				<tr>
					<td><a href="#"  id="printbutton"class="easyui-linkbutton"> 生成打印信息</a></td></tr>
				</tr>
			</table>
		</div>
		<div id="cmap" data-options="region:'center'"	style="width: 100%; height: 100%;">
				<div id="mapDiv" style="width: 100%; height: 100%;">
					<div id="homeButton"></div>
				</div>
		</div>
		</div>
</body>
</html>

