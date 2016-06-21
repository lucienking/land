<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script src="${ctx }/static/js/contract/contractVersion.js"></script>
<script type="text/javascript">
	var ctx = "${ctx}";
</script>
<div id=container>

<!-- 	合同模板列表单 -->
	<div id="conVersionsearchResult" class="easyui-panel" title="查询结果" style="width:100%;">
		<table id="conVersionDatagrid" style="width:100%"></table>
	</div>
	
<!-- 	添加合同版本对话框 -->
	<div id="conVersionDialog" style="width:400px;padding:10px;display:none">
		<form id="conVersionForm" method="post">
			<input type="hidden" id="conVersionId" name="id">
			<input type="hidden" id="CVsaveType" name="CVsaveType" value="create"></tr>
			<table style="width:320px;">
				<tr>
					<td width="30%">合同版本编号：</td>
					<td width="70%"><input id="contractVersionNo" name="contractVersionNo" class="easyui-textbox" style="width:100%"></td>
				</tr>
				<tr>
					<td width="30%">合同版本名称：</td>
					<td width="70%"><input id="contractName" name="contractName" class="easyui-textbox" style="width:100%"></td>
				</tr>
				<tr>
					<td width="30%">合同版本描述：</td>
					<td width="70%"><input id="contractDesc" name="contractDesc" class="easyui-textbox" style="width:100%" data-option="height:220px,multiline:true;"></td>
				</tr>
				<tr>
					<td width="30%">合同版本发行部门：</td>
					<td width="70%"><input id="publishDept" name="publishDept" class="easyui-textbox" style="width:100%" ></td>
				</tr> 
				<tr>
					<td width="40%">合同版本模板：</td>
					<td width="60%">
						<jksb:upload name="contractVersionTemplate" id="cvTemplate" buttonText="选择合同版本附件" savePath="contractVersion">
						</jksb:upload> 
					</td>
				</tr>
			</table>
		</form>
	</div>
	
<!-- 	列表工具条 -->
	<div id="conVtoolbar">
	<jksb:hasAutority authorityId="005001006001">
		<a href="javascript:addCVData()"  id = "addCVButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="005001006003">
		<a href="javascript:editCVData()" id = "editCVButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="005001006002">
		<a href="javascript:deleCVData()" id = "deleCVButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
</div>
</div>