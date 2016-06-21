<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<script type="text/javascript" src="${ctx }/static/js/gridmonitor/gridmonitor.js"></script>
<div id="inputor">
<form>
手机号:<input type="text" id="phone"/>
日期:<input type="text" id="date"/>
<input type="button" value="路线监控" onclick="drawLocations();"/>
<!-- <input type="button" value="实时监控" onclick="startListen();"/> -->
</form>
</div>
<div id="map" style="height:100%;width:100%;"></div>
<!-- <div id="cordination"> -->
<!-- </div> -->

<script type="text/javascript">
 	gridMonitor();
</script>
