<%@ page language="java"  language="java"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	*{
		font-size:14px;
	}
	table{
		width:500px;
		margin:0 auto;
	}
	.left{
		width:250px;
		text-align:center;
	}
	.right{
		width:350px;
		text-align:right;
	}
	tr{
		background-color:#f1f8ff;
		height:50px;
	}
</style>
<div>
	<form>
		<table border="1" bordercolor="#a0c6e5"  style="border-collapse:collapse;">
			<tr>
				<th class="left" style="background-color:#DCEAF5;">文件名称</th>
				<th style="text-align:center;background-color:#DCEAF5;">文件路径</th>
			</tr>
			<tr>
				<td class="left">合同表</td>
				<td class="right"><jksb:upload name="batchUpload_contract" id="batchUpload_contract" buttonText="选择文件" savePath="${farmName}" cssClass="right"></jksb:upload>
			</tr>
			<tr>
				<td class="left">租金表</td>
				<td class="right"><jksb:upload name="batchUpload_rent" id="batchUpload_rent" buttonText="选择文件" savePath="${farmName}" cssClass="right"></jksb:upload>
			</tr>
			<tr>
				<td colspan="2" class="right" style="background-color:#DCEAF5;"><a style="margin:0 5px;width:100px;" href="javascript:submitFile()" class="easyui-linkbutton">提交</a></td>
			</tr>
		</table>
	</form>
</div>

<script>
function submitFile(){
	$.messager.confirm('提交结果','提交成功！',function(r){
		if(r){
			location.reload();
		}
	});
	
}
</script>