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
<link href="../static/jquery-easyui/themes/default/easyui.css"	type="text/css" rel="stylesheet" />
<%-- <link rel="stylesheet"  href="${ctx }/static/js/map/Toc/css/agsjs.css">  --%>
<link rel="stylesheet"	href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<script src="../static/jquery/jquery-1.9.1.min.js"></script>
<script src="../static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="../static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<!-- arcGIS -->
<script type="text/javascript">
	// helpful for understanding dojoConfig.packages vs. dojoConfig.paths:
	// http://www.sitepen.com/blog/2013/06/20/dojo-faq-what-is-the-difference-packages-vs-paths-vs-aliases/
	var dojoConfig = {
		paths : {
			//if you want to host on your own server, download and put in folders then use path like: 
			agsjs : location.pathname.replace(/\/[^/]+$/, '')+ '/../static/js/map/Toc'
		}
	};
</script>
<script type="text/javascript"
	src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script>
<!-- 自定义JS,css引用 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>被占地</title>
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

</style>
<script type="text/javascript" src="${ctx }/static/js/map/Map.js"></script>
<script type="text/javascript" src="${ctx }/static/js/map/agrisurvey.js"></script>
</head>
<script>
	var serverURL = "${arcgisServiceUrl}";
	var server151URL = "${arcgisService151Url}";
</script>
</head>
<body>
	<div id="cc" class="easyui-layout" class="easyui-layout"
		data-options="fit: true">
		<div data-options="region:'east'" style="width: 340px;">
			<div class="grid-header" style="border-top: 1px solid #95B8E7;">选择农场</div>
			<table width="100%">
				<tr>
					<td colspan="3"></td>
					<td><input id="farmName" name="dept" class="easyui-combobox"
						style="border-top: 4px solid #95B8E7;"></td>
				</tr>
			</table>
			<div class="grid-header">操作</div>
			<table width="100%">
				<tr>
					<td>
						<div>图层控制</div>
						<ul id="tocDiv" class="easyui-tree">
						</ul>
					</td>
				</tr>
			</table>
			<div id="statistics" class="grid-header"
				style="border-top: 1px solid #95B8E7;">地块统计信息</div>
				<table width="100%" id="show_grid">
				
				</table>
			<div class="grid-header" style="border-top: 1px solid #95B8E7;">地块搜索</div>
			<table id="search" width="100%">
				<tr>
					<td>地块号</td>
					<td><input required type="text" id="DKBH" name="编号" class="conditions" /></td>
				</tr>
				<tr>
					<td>户主</td>
					<td ><input required type="text" name="户主" class="conditions" /></td>
				</tr>
				<tr>
					<td>农场编号</td>
					<td ><input required type="text" name="farmcode" class="conditions" /></td>
				</tr>
				<tr>	
					<td></td>				
					<td><a href="#" colspan="2" class="easyui-linkbutton"  id="searchBt">搜索</a></td>
				</tr>
			</table>
		</div>
		<div id="cmap" data-options="region:'center'"
			style="width: 100%; height: 100%;">
			<div id="mapDiv" style="width: 100%; height: 100%;">
				<div id="homeButton"></div>
			</div>
		</div>
	</div>
</body>
</html>

