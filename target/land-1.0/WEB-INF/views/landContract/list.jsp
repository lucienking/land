<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- <%@ taglib prefix="jksb" uri="http://www.jksb.com/shiro-extend/tags"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
	<head>
		<jsp:include page="/public/common.jsp"/>
		<script type="text/javascript" src="<spring:url value="/static/js/landContract/list.js?r=2" />"></script>
		<%-- <script type="text/javascript" src="<spring:url value="/public/My97DatePicker/WdatePicker.js" />" ></script> --%>
	</head>
	<style type="text/css">
	</style>
	<body>
	<div class="easyui-layout" data-options="fit: true" >
		<div data-options="region:'north'"style="height:95px">
		<fieldset>
		<legend>查询</legend>
		<table>
		<tr>
			<td><input id="farmCode" type="hidden" value="${farmCode }" />
			所在范围：<c:if test="${farmCode eq 1 }"><input id="ncmc" type="text" class="easyui-combobox" style="width:138px;"/></c:if><c:if test="${farmCode ne 1 }"><input id="ncmc2" type="text" value="${farmName }" class="easyui-combobox" readonly="readonly" style="width:138px;"/></c:if>
			合同编号：<input id="contractNumber" name="contractNumber" style="width:135px;" type="text" class="easyui-validatebox" value="">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			租期：<input id="timeLimit" name="timeLimit" style="width:135px;" type="text" class="easyui-validatebox" value="">
			&nbsp;&nbsp;合同状态：<select style="height:22px;width:138px;" id="state">
    		<option value=""></option>
    		<option value="0">草稿</option>
    		<option value="1">正式</option>
   			<option value="2">注销</option>
    		</select>
			</td>
		</tr><tr>	
			<td>
			合同类型：<select style="height:22px;width:138px;" id="contractType">
    		<option value=""></option>
    		<option value="1">对内承包</option>
    		<option value="2">对外承包</option>
   			<option value="3">临时租地</option>
   			<option value="4">农民占地</option>
    		</select>
			&nbsp;&nbsp;&nbsp;承包人：<input id="partyB" name="partyB" style="width:135px;" type="text" class="easyui-validatebox" value="">
			签订年份：<input id="contractYear" name="contractYear" style="width:135px;" type="text" class="easyui-validatebox" value="">
			总面积(亩)：<input id="areaOfLandGe" name="areaOfLandGe" style="width:90px;" type="text" class="easyui-validatebox" value="">
			—— <input id="areaOfLandLe" name="areaOfLandLe" style="width:90px;" type="text" class="easyui-validatebox" value="">
			
			&nbsp;&nbsp;&nbsp;
			<a id="search" iconCls="icon-search" class="easyui-linkbutton" >查询</a>
			<a id="resetSearch" iconCls="icon-reload" class="easyui-linkbutton" title="重置" 
				 onclick="resetSearch(this)">重置</a>
		
			</td></tr>
			</table>
		</fieldset>
		</div>	
			
		<div data-options="region:'center',title:'列表'">	
		<div id="landContractToolDiv">
		<a id="cancelStates" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" url="<spring:url value="cancelStates"/>">注销</a>
		<a id="delete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" url="<spring:url value="delete"/>">删除</a>
		</div>
		<table id="landContractList">
		
		</table>
	</div>
	</div>
	</body>
</html>
