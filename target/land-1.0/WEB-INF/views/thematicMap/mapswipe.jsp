<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.ResourceBundle"%> 
<% ResourceBundle res = ResourceBundle.getBundle("application"); 
  /*  String serverURL = res.getString("arcgis.service.url"); */
   String apiUrl = res.getString("arcgis.api.url");
%> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%-- 
<c:set var="arcgisServiceUrl" value="<%=serverURL %>" /> --%>
<c:set var="arcgisapiUrl" value="<%=apiUrl %>" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
  <!--   <link rel="stylesheet" href="http://js.arcgis.com/3.13/esri/css/esri.css">
<script src="http://js.arcgis.com/3.13"></script> -->
<link rel="stylesheet" href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<script type="text/javascript" src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script>
    <style> 
      html,body,#map {
        width: 100%;
        height:100%;
        margin: 0;
        padding: 0;
        margin-bottom: 20px;
        background-color: #FFFFFF;
        font-family: "Trebuchet MS";
      }

      header {
        width: 100%;
        margin: 0 auto;
      }

      .operationtip {
        position: absolute;
        margin: auto 10px;
        margin-left: 30px;
        color: white;
      }

      #map1{
        position: relative;
        width:100%;
        height: 800px;
        margin: 0 auto;
      }
      .mapheader {
        width: 100%;
        position: absolute;
        z-index: 10;
        color: black;
      }
    </style>
    
    <script type="text/javascript" src="../static/js/map/mapswipe.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>mapswipe</title>
</head>
<body>
<div id="map1">
    <div class='mapheader'>
    <input id='verticalswipe'   type="checkbox"/><label for='verticalswipe'>垂直分割 </label>
    <input id='horizontalswipe' type="checkbox"/><label for='horizontalswipe'> 水平分割</label>
    </div> 
  </div>

</body>
</html>