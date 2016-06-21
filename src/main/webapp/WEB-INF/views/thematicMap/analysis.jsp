<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ page import="java.util.ResourceBundle"%>
<%
	ResourceBundle res = ResourceBundle.getBundle("application");
	String serverURL = res.getString("arcgis.service.url");
	String server151URL = res.getString("arcgis151.service.url");
	String apiUrl = res.getString("arcgis.api.url");
%>
<c:set var="arcgisServiceUrl" value="<%=serverURL%>" />
<c:set var="arcgisService151Url" value="<%=server151URL%>" />
<c:set var="arcgisapiUrl" value="<%=apiUrl%>" />
<html>
<head>
<link href="../static/jquery-easyui/themes/default/easyui.css"	type="text/css" rel="stylesheet" />
<link rel="stylesheet"	href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<link rel="stylesheet" href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/dojo/dijit/themes/tundra/tundra.css">
<script src="../static/jquery/jquery-1.9.1.min.js"></script>
<script src="../static/jquery/jquery-form.js"></script>
<script src="../static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="../static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<!-- arcGIS -->
<script type="text/javascript"	src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script>
<!-- 自定义JS,css引用 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>在线套图</title>
<style type="text/css">
.file-upload span {
	display: none;
}

.file-upload-status {
	vertical-align: middle;
	padding: 5px 11px;
	font-size: 6px;
	color: #888;
	background: #F8F8F8;
	padding: 0px; 
	margin: 0px;
}

/*File upload form styling */
.field {
	padding: 4px 4px;
}

.file-upload {
	overflow: hidden;
	display: inline-block;
	position: relative;
	vertical-align: middle;
	text-align: center;
	border: 2px solid #666666;
	background: #444444;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	color: #fff;
	text-shadow: 0px 2px 3px #555;
	cursor: pointer;
	font-size: 0.5em;
}

.file-upload input {
	position: absolute;
	top: 0;
	left: 0;
	margin: 0;
	font-size: 30px;
	opacity: 0;
	filter: alpha(opacity = 0);
	z-index: 2;
}

.file-upload strong {
	font: normal 1.75em arial, sans-serif;
}

.file-upload span {
	position: absolute;
	top: 0;
	left: 0;
	display: inline-block;
	padding-top: .45rem;
}
.introduce{
	font-size:0.5rem;
	margin: 0px;
}
.file-upload {
	height: 1.5rem;
}

.file-upload,.file-upload span {
	width: 5rem;
}
.dijitToggleButton, .dijitButton, .dijitDropDownButton, .dijitComboButton {
    width: 76px;
}

.grid_td{
		border-right:1px dotted #CCC;
		border-bottom:1px dotted #CCC;
		font-size:12px;
		padding:1px;
	}
.grid-header {
	height: 18px;
	background: url("${ctx }/static/image/map_grid_head_bg.png") repeat;
	font-size: 12px;
	padding: 5px;
	font-weight: bold;
	border-bottom: 1px solid #95B8E7;
}

#homeButton {
	position: absolute;
	top: 95px;
	left: 20px;
	z-index: 50;
}

.dijitReset {
	display: block;
	padding: 1px;
}
</style>

<script>
var serverURL = "${arcgisServiceUrl}";
var server151URL = "${arcgisService151Url}";
</script>
<script type="text/javascript" src="${ctx }/static/js/jksb.land.fileupload.js"></script>
<script type="text/javascript" src="${ctx }/static/js/map/analysis.js"></script>
</script>
</head>
<body class="claro">
	<div id="cc" class="easyui-layout" class="easyui-layout"
		data-options="fit: true">
		<div data-options="region:'east'" style="width: 340px;">
			<div class="grid-header" style="border-top: 1px solid #95B8E7;">操作</div>
			<p class="introduce">上传的zip内只有三个同名的.shp,.shx,.dbf文件或者只有五个同名的.shp,.shx,.dbf,.prj,.shp.xml
			</p>
			<form enctype="multipart/form-data"
				action="http://10.215.201.151:6080/arcgis/rest/services/Data/GPServer/uploads/upload"
				method="post" id="uploadForm">
				<div class="field">
					<label class="file-upload"> <span><strong>添加zip文件</strong></span>
						<input type="file" name="file" id="inFile" /> <input name="f"
						value="pjson" id="inJson" type="hidden" />
					</label>
				</div>
			</form>
			<span class="file-upload-status" style="opacity: 1;"
				id="upload-status"></span>
			<div class="grid-header">打印</div>
			<div id="printButton"></div>
			<div id="statistics" class="grid-header"
				style="border-top: 1px solid #95B8E7;">字段选择</div>
			<table id="infor_select" title="属性表" class="easyui-datagrid"
				style="width: 100%%; height: 200px" rownumbers="true"
				>
				<thead>
					<tr>
						<th field="ck" checkbox="true" width="10%"></th>
						<th field="itemid" width="84%">字段名称</th>
					</tr>
				</thead>
			</table>
<!-- 			<div class="grid-header" style="border-top: 1px solid #95B8E7;">地块搜索</div> -->
		</div>
		<div id="cmap" data-options="region:'center'"
			style="width: 100%; height: 100%;">
			<div id="mapCanvas" style="width: 100%; height: 100%;">
				<div id="homeButton"></div>
			</div>
		</div>
	</div>
	</div>
</body>

</html>
