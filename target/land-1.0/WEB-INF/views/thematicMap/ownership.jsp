<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ page import="java.util.ResourceBundle"%> 
<% ResourceBundle res = ResourceBundle.getBundle("application"); 
   String serverURL = res.getString("arcgis.service.url");
   String apiUrl = res.getString("arcgis.api.url");
%> 

<c:set var="arcgisServiceUrl" value="<%=serverURL %>" />
<c:set var="arcgisapiUrl" value="<%=apiUrl %>" />
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
		padding:1px;
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
		
		background:url("${ctx }/static/image/legend-dilei2.jpg") no-repeat;
	}
	#HomeButton_ownership {
      position: absolute;
      top: 95px;
      left: 20px;
      z-index: 50;
    }
     #LocateButton_ownership {
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
	#messages{
        background-color: #fff;
        box-shadow: 0 0 5px #888;
        font-size: 1.1em;
        max-width: 15em;
        padding: 0.5em;
       
        
      }
</style>
<script type="text/javascript" src="${ctx }/static/js/map/ownership.js"></script>

<div id="cc_ownership"  class="easyui-layout" data-options="fit: true">
    <div data-options="region:'east'" style="width:340px;">
    <div class="grid-header" style="border-top:1px solid #95B8E7;">农场变换</div>
	   	<table width="100%">
	   		<tr>
	   			<td colspan="3"></td>
	   			<td><input id="FarmName_ownership" name="dept" class="easyui-combobox" style="border-top:4px solid #95B8E7;">
	   			</td>
	   		</tr>
	   	</table>
	  
		
    	<div class="grid-header" style="border-top:1px solid #95B8E7;">操作</div>
    	<table width="100%" >
    		<tr>
    			<td ><div id="printButton_ownership"></div></td>
    		</tr>
    		<tr>
    			
	   			
	   			<td >
	   			<div  >图层控制</div>
    			 <ul id="toc_ownership" class="easyui-tree">	 </ul>
	   			
	   			</td>
	   			
    		</tr>
    		<tr>
    			<td colspan="3">
    				<div id="legend_ownership" style="padding-left:10px;"></div>
    			</td>
    		</tr>
    	</table>
    	
       
		<div class="grid-header" style="border-top:1px solid #95B8E7;">地块统计信息</div>
		<table width="100%" id="show_grid_ownership">
		<!-- <div id="printButton" style="position:absolute;right:15px;top:10px;"></div> -->
		</table>
		<div class="grid-header" style="border-top:1px solid #95B8E7;">地块搜索</div>
		<table id="search_ownership" width="100%">
			
			<tr>
				<td>地块编号</td>
				<td colspan="2"><input type="text" name="DKBH" class="conditions"/></td>
			</tr>
			<tr>
				<td>户主</td>
				<td colspan="2"><input type="text" name="HZ" class="conditions"/></td>
			</tr>
			<tr>
				<td>面积大于</td>
				<td colspan="2"><input type="text" name="minmj" class="conditions"/></td>
			</tr>
			<tr>
				<td>面积小于</td>
				<td><input type="text" name="maxmj" class="conditions"/></td>
				
			</tr>
			<tr>
			<td>   </td>
			<td><a href="#" onClick="landSearch();" id = "search_ownership" class="easyui-linkbutton">搜索</a></td></tr>
		</table>
		
    </div>
    <div id="cmap_ownership" data-options="region:'center'" style=" width: 100%; height: 100%; ">
    	<div id="mapDiv_ownership" >
    		<div id="HomeButton_ownership"></div>
    		
    	</div>
    
    </div>
</div>
<script>
var serverURL="${arcgisServiceUrl}";

main_ownership();

</script>




