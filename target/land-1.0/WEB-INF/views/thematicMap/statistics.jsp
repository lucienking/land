<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ page import="java.util.ResourceBundle"%> 
<% ResourceBundle res = ResourceBundle.getBundle("application"); 
   String changPwdUrl = res.getString("usm.changepwd.url");
   String logoutUrl = res.getString("usm.logout.url");
   String serverURL = res.getString("arcgis.service.url");
   String apiUrl = res.getString("arcgis.api.url");
%> 

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="changPwdUrl" value="<%=changPwdUrl %>" />
<c:set var="logoutUrl" value="<%=logoutUrl %>" />
<c:set var="arcgisServiceUrl" value="<%=serverURL %>" />
<c:set var="arcgisapiUrl" value="<%=apiUrl %>" />
<html>
<head>
<link href="../static/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet" />
<link href="../static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<script src="../static/jquery/jquery-1.9.1.min.js"></script>
<script src="../static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="../static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>  
    

   <title>Popup</title>

  <!--  <link rel="stylesheet" href="http://js.arcgis.com/3.13/dijit/themes/claro/claro.css">
    <link rel="stylesheet" href="http://js.arcgis.com/3.13/esri/css/esri.css">   -->
<link rel="stylesheet" href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/dojo/dijit/themes/claro/claro.css">
<link rel="stylesheet" href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<script type="text/javascript" src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script> 
    <style>
      html, body, #map {
        padding: 0;
        margin: 0;
        height: 100%;
      }

      /* Change color of icons to match bar chart and selection symbol */
      .esriPopup.dark div.titleButton, 
      .esriPopup.dark div.titlePane .title,
      .esriPopup.dark div.actionsPane .action {
        color: #A4CE67;
      }
      /* Additional customizations */
      .esriPopup.dark .esriPopupWrapper {
        border: none;
      }
      .esriPopup .contentPane {
        text-align: center;
      }
      .esriViewPopup .gallery {
        margin: 0 auto;
      }
    </style>
    
     <script src="../static/js/jksb.land.common.js"></script>
         <script>
 var serverURL="${arcgisServiceUrl}";
 </script>
  <script type="text/javascript" src="../static/js/map/statistics.js" ></script></head>
<!--  <script src="http://js.arcgis.com/3.13/"></script>  -->
 
  </head>
  
  <body class="claro">
    <div id="map"></div>
  </body>

</html>
