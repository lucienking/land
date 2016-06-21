<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	.required{
		color:red;
	}
	.td_title{
		width:70px;
		display:inline-block;
		text-align:center;
	}
	.contract_edit_table{
		width:100%;
		font-size: 12px;
		cellspacing:0;
		cellpadding:0;
		border-collapse:collapse;
	}
	
	.contract_edit_table tr  td{ 
		border:1px solid #95B8E7;
	}
	
	.contract_edit_table_head{
		text-align:center;
	}
</style>
<div  class="easyui-tabs" style="width:886px;height:auto;">
    <div title="基本信息" data-options="fit:true" style="padding-bottom:20px;">
   		<form id="contractEdit_baseInfo_form">
   		<table style="width:99%;height:80px; ">
   			<tr>
				<td class="contractQueryEdit_blank_td">
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>合同编号</span>
					<input type="hidden" name="id" value="${contract.id}">
					<input id="contractQueryEdit_contractNo" name="contractNo" value="${contract.contractNo }" value="" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title">合同甲方</span>
					<input id="contractQueryEdit_firstParty" name="firstParty" value="${contract.firstParty }" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title">甲方法人</span>
					<input id="contractQueryEdit_firstPtRepresentative" name="firstPtRepresentative" value="${contract.firstPtRepresentative }" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title" ><b class="required">*</b>保障地面积</span>
					<input id="contractQueryEdit_affordableArea" name="affordableArea" value="${contract.affordableArea }" class="easyui-textbox" style="width:120px;" 
						validType="float"/>
				</td>
			</tr>
			<tr>
				<td class="contractQueryEdit_blank_td">
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title">所在农场</span>
					<input id="contractQueryEdit_atFarm" name="farmName" value="${contract.residentsGroup.communityEntity.organizationEntity.name }" readonly="true" class="easyui-textbox" style="width:120px;"/>
					<input id="contractQueryEdit_atFarmCode" type="hidden" value="${contract.residentsGroup.communityEntity.organizationEntity.orgCode }"/>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>所在社区</span>
					<input id="contractQueryEdit_atCommunity" name="atCommunity" value="${contract.residentsGroup.communityEntity.communityCode }" style="width:120px;"/>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>居民小组</span>
					<input id="contractQueryEdit_residentsGroup" name="residentsGrpCode" value="${contract.residentsGroup.residentsGrpCode }" style="width:120px;"/>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title">签订地址</span>
					<input id="contractQueryEdit_signingAddress" name="signingAddress" value="${contract.signingAddress }" class="easyui-textbox" style="width:120px;" /> 
				</td>
			</tr>
			<tr>
				<td class="contractQueryEdit_blank_td">
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>承包期限</span>
					<input id="contractQueryEdit_leaseTerm"  name="leaseTerm" value="${contract.leaseTerm }" class="easyui-textbox" style="width:120px;"
						validType="number" />
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>起始时间</span>
					<input id="contractQueryEdit_startDate" name="startDate" value="${contract.startDate }" class="easyui-datebox" style="width:120px;"/>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title">到期时间</span>
					<input id="contractQueryEdit_expiredDate" name="expiredDate" value="${contract.expiredDate }"
						readonly="true" class="easyui-datebox"  style="width:120px;"/>
				</td>
				<td class="contractQueryEdit_data_td"  colspan="1">
				</td>
			</tr>
			<tr>
				<td class="contractQueryEdit_blank_td">
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>签订单价</span>
					<input id="contractQueryEdit_signingPrice" name="signingPrice" value="${contract.signingPrice }" class="easyui-textbox" style="width:120px;"
					validType="float" />
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>阶梯计价</span>
					<jksb:diction id="contractQueryEdit_isStepedCount" name="isStepedCount" groupId="PUB_SELECT" 
						 cssClass="easyui-combobox" style="width:120px" defaultValue="${contract.isStepedCount }">
					</jksb:diction>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>定期递增</span>
					<jksb:diction id="contractQueryEdit_isRegularlyRaise" name="isRegularlyRaise" groupId="PUB_SELECT"
						 cssClass="easyui-combobox" style="width:120px" defaultValue="${contract.isRegularlyRaise }">
					</jksb:diction>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title">5年上涨率</span>
					<input id="contractQueryEdit_ratePerFiveYear" name="ratePerFiveYear" value="${contract.ratePerFiveYear }" class="easyui-textbox" style="width:120px;"
						validType="float"/>
				</td>
			</tr>
			<tr>
				<td class="contractQueryEdit_blank_td">
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>土地等级</span>
					<jksb:diction id="contractQueryEdit_landLevel" name="landLevel" groupId="CONTRACT_LAND_LEVEL" 
						 cssClass="easyui-combobox" style="width:120px" defaultValue="${contract.landLevel }">
					</jksb:diction>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>土地类型</span>
					<jksb:diction id="contractQueryEdit_landType" name="landType" 
						groupId="CONTRACT_LAND_TYPE"  cssClass="easyui-combobox" 
						style="width:120px" defaultValue="${contract.landType }">
					</jksb:diction>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title"><b class="required">*</b>承包面积</span>
					<input id="contractQueryEdit_useArea" name="useArea" value="${contract.useArea }" class="easyui-textbox" style="width:120px;" />
					<input type="hidden" id="contractArea_left" value="0"/>
				</td>
				<td class="contractQueryEdit_data_td">
					<span class="td_title">土地座落</span>
					<input id="contractQueryEdit_landLocation" name="landLocation" value="${contract.landLocation }" class="easyui-textbox" style="width:120px;"/>
				</td>
			</tr>
			<tr>
				<td class="contractQueryEdit_blank_td">
				</td>
				<td class="contractQueryEdit_data_td" width="840px" align="left"  colspan="4">
					<span class="td_title">土地四至</span>
					<input id="contractQueryEdit_landExtend" name="landExtend" value="${contract.landExtend }" class="easyui-textbox" style="width:772px;"
						prompt="东至 西至 南至 北至 "/>
				</td>
			</tr>
			<tr>
	    		<td class="contractQueryEdit_blank_td">
				</td>
    			<td width="840px" align="left"  colspan="4" >
					<span class="td_title">补充条款</span>
					<input id="contractQueryEdit_supplementaryProvisions" name="supplementaryProvisions" value="${contract.supplementaryProvisions }" class="easyui-textbox" data-options="multiline:true" style="width:772px;height:100px;"/>
				</td>
			</tr>
   		</table>
   		<div style="margin-top:20px;text-align:center;">
   			<a class="easyui-linkbutton" href="#" id="contractBaseInfo_edit_saveBtn" onclick="">保存</a>&nbsp;
   			<a class="easyui-linkbutton" href="#" id="" onclick="contractDialogClose()">取消</a>
   		</div>
   		</form>
    </div>
    <div title="地块信息" style="padding-bottom:20px;" data-options="fit:true">
    <form id="contractEdit_landInfo_form">
    <table id="contractQueryEdit_landInfo" class="contract_edit_table">
		<tr>
		   <td width="80px" class="contract_edit_table_head">编号</td>
		   <td width="80px" class="contract_edit_table_head" >类型</td>
		   <td width="80px" class="contract_edit_table_head" >等级</td>
		   <td width="80px" class="contract_edit_table_head" >面积(亩)</td>
		   <td width="80px" class="contract_edit_table_head" >种植作物</td>
		   <td width="120px" class="contract_edit_table_head" >座落</td>
		   <td width="300px" class="contract_edit_table_head" >四至</td>
		</tr>
		
    	<c:forEach items="${contract.contractParcelInfo}" var="contractParcelInfo" varStatus="status"> 
    	<tr>
		   <td class="contract_edit_table_head">
			<%-- ${contractParcelInfo.id}  --%>
			<input type="hidden" name="contractParcelInfo[${status.index }].id" value="${contractParcelInfo.id}"/>
			${contractParcelInfo.contractParcelCode} 
		   </td>
		   <td class="contract_edit_table_head">
			<jksb:diction name="contractParcelInfo[${status.index }].landType" groupId="CONTRACT_LAND_TYPE"  
				cssClass="easyui-combobox" style="width:80px" defaultValue="${contractParcelInfo.contractParcelType}">
			</jksb:diction>
		   </td>
		   <td class="contract_edit_table_head">
		    <jksb:diction name="contractParcelInfo[${status.index }].landLevel" groupId="CONTRACT_LAND_LEVEL"  
		    	cssClass="easyui-combobox" style="width:80px" defaultValue="${contractParcelInfo.contractParcelLevel}">
			</jksb:diction>
		   </td>
		   <td class="contract_edit_table_head">
		   	 <input name="contractParcelInfo[${status.index }].contractParcellArea" class="easyui-textbox" style="width:80px;" value="${contractParcelInfo.contractParcellArea} "/>
			
		   </td>
		   <td class="contract_edit_table_head">
		  	   <input name="contractParcelInfo[${status.index }].plantCrops" class="easyui-textbox" style="width:120px;" value="${contractParcelInfo.plantCrops} "/>
		   </td>
		   <td class="contract_edit_table_head">
		       <input name="contractParcelInfo[${status.index }].contractLocation" class="easyui-textbox" style="width:120px;" value="${contractParcelInfo.contractLocation} "/>
		   </td>
		   <td class="contract_edit_table_head">
		   	   <input name="contractParcelInfo[${status.index }].contractShiz" class="easyui-textbox" style="width:300px;" value="${contractParcelInfo.contractShiz} "/>
		   </td>
		</tr>
		</c:forEach> 
		</table>
		<div style="margin-top:20px;text-align:center;">
   			<a class="easyui-linkbutton" href="#" id="contractEdit_parcelInfo_saveBtn" onclick="">保存</a>&nbsp;
   			<a class="easyui-linkbutton" href="#" id="" onclick="contractDialogClose()">取消</a>
   		</div>
   		</form>
    </div>
    <div title="承包人信息" style="padding-bottom:20px;">
    	<table id="contract_contractorInfo_detail" class="contract_edit_table" >
			<tr>
			   <td width="80px" class="contract_edit_table_head">承包人姓名</td>
			   <td width="120px" class="contract_edit_table_head" >证件号码</td>
			   <td width="230px" class="contract_edit_table_head" >工作单位</td>
			   <td width="230px" class="contract_edit_table_head" >家庭住址</td>
			   <td width="100px" class="contract_edit_table_head" >联系电话</td>
			   <td width="100px" class="contract_edit_table_head" >承包面积(亩)</td>
			</tr>
		<c:forEach items="${contract.contractorPersonal}" var="contractorPersonal"> 
			<tr>
				<td class="contract_edit_table_head">
					<input type="hidden" name="edit_contractor_id" value="${contractorPersonal.id}">
					${contractorPersonal.contractorName} 
				</td>
				<td class="contract_edit_table_head">
					${contractorPersonal.contractorIDNO} 
				</td>
				<td class="contract_edit_table_head">
					<input name="edit_contractorDepartment" value="${contractorPersonal.contractorDepartment}" class="easyui-textbox" style="width:240px;"/>
				</td>
				<td class="contract_edit_table_head">
					<input name="edit_contractorAddr" value="${contractorPersonal.contractorAddr} " class="easyui-textbox" style="width:240px;"/>
				</td>
				<td class="contract_edit_table_head">
					<input name="edit_contractorPhoneNumber" value="${contractorPersonal.contractorPhoneNumber} " class="easyui-textbox" style="width:100px;"/>
				</td>
				<td class="contract_edit_table_head">
					${contractorPersonal.contractArea} 
				</td>
			</tr>
		</c:forEach> 
		</table>
		<div style="margin-top:20px;text-align:center;">
   			<a class="easyui-linkbutton" href="#" id="contractor_edit_saveBtn" onclick="">保存</a>&nbsp;
   			<a class="easyui-linkbutton" href="#" id="" onclick="contractDialogClose()">取消</a>
   		</div>
    </div>
    <div title="附件信息" style="padding-bottom:20px;">
    	<table class="contract_edit_table" >
			<tr>
			   <td width="160px" class="contract_edit_table_head" >附件名称</td>
			   <td width="80px" class="contract_edit_table_head" >附件大小</td>
			   <td width="40px" class="contract_edit_table_head" >
			   		操作 
			   </td>
			</tr>
			<c:forEach items="${contract.contractAttachment}" var="contractAttachment"> 
			<tr>
			   <td>
				${contractAttachment.attachmentName} 
			   </td>
			   <td>
			    ${contractAttachment.attachmentLong}
			   </td>
			   <td>
			   	删除
			   </td>
			</tr>
			</c:forEach> 
		</table>
    	
		<div style="margin-top:20px;text-align:center;">
   			<a class="easyui-linkbutton" href="#" id="" onclick="">保存</a>&nbsp;
   			<a class="easyui-linkbutton" href="#" id="" onclick="contractDialogClose()">取消</a>
   		</div>
    </div>
</div>
</div>
<script type="text/javascript">
/**
 * 社区 居民小组联动 combox
**/
$("#contractQueryEdit_atCommunity").combobox({
	url:ctx+'/community/getCommunityByFarmCode',
    valueField:'id',
    textField:'text',
    method:'GET', 
   	queryParams:{"farmCode":$("#contractQueryEdit_atFarmCode").val()},
   	onSelect:function(value){
   		$('#contractQueryEdit_residentsGroup').combobox('clear'); 
   		var url = ctx+'/group/getResidentsGroupByCommunity?communityCode='+value.id;
   		$('#contractQueryEdit_residentsGroup').combobox('reload', url); 
   	},
    onLoadSuccess: function () {
    	var defaultValue = "${contract.residentsGroup.communityEntity.communityCode }";
    	$("#contractQueryEdit_atCommunity").combobox("setValue",defaultValue);
    }
});
$("#contractQueryEdit_residentsGroup").combobox({
	url:ctx+'/group/getResidentsGroupByCommunity',
    valueField:'id',
    textField:'text',
    method:'GET',
	queryParams:{"communityCode":$("#contractQueryEdit_atCommunity").combobox("getValue")},
    onLoadSuccess: function () {
    	var defaultValue = "${contract.residentsGroup.residentsGrpCode }";
    	$("#contractQueryEdit_residentsGroup").combobox("setValue",defaultValue);
    }
});
$("#contractor_edit_saveBtn").click(function(){
	var ids =  $("input[name='edit_contractor_id']");
	var addrs = $("input[name='edit_contractorAddr']");
	var depts = $("input[name='edit_contractorDepartment']");
	var teles = $("input[name='edit_contractorPhoneNumber']");
	
	for(var i= 0;i<ids.length;i++){
		var id = $(ids[i]).val();
		var addr = $(addrs[i]).val();
		var dept = $(depts[i]).val();
		var tele = $(teles[i]).val();
		$.ajax({
    		url:"${ctx}/contract/updateContractor",
    		type:'GET',
    		asyn:false,
    		data: { "id": id,"contractorAddr":addr,"contractorDepartment":dept,"contractorPhoneNumber":tele },  
    		success:function(data){
    		},
    		error:function(XMLHttpRequest, textStatus, errorThrown){
    		}
    	});
	}
	$.messager.alert('操作失败',"保存成功");
});

$("#contractBaseInfo_edit_saveBtn").click(function(){
	$.ajax({
		url:"${ctx}/contract/updateContract",
		type:'POST',
		data:  $("#contractEdit_baseInfo_form").getFormData(),  
		success:function(data){
			$.messager.alert('提示信息',"保存成功");
			contractDialogClose();
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
		}
	});
});
function contractDialogClose(){
	$("#contractQueryEditDialog").dialog('close');
}


/**
 *	承包期和起始时间的变化都将影响截止日期的变化。
 **/
$("#contractQueryEdit_leaseTerm").textbox({
	onChange:function(newV,oldV){
		if(newV >30){
			$.messager.alert('提示',"承租年限超过最大限制。");
			$("#contractQueryEdit_leaseTerm").textbox("setValue","");
		}else
			calcuExpired();
	}
});
$("#contractQueryEdit_startDate").datebox({onChange:function(){calcuExpired();}});

/**
 *	计算租期到期时间
**/
function calcuExpired(){
	var start = $('#contractQueryEdit_startDate').datebox('getValue');
	var term = parseInt($("#contractQueryEdit_leaseTerm").textbox('getValue'));
	var year = parseInt(start.substr(0,4));
	var mmdd = start.substr(4);
	var expired = year+term + mmdd;
	$('#contractQueryEdit_expiredDate').datebox('setValue', expired);
}


$("#contractEdit_parcelInfo_saveBtn").click(function(){
	var size = 0 ;
	var json = $("#contractEdit_landInfo_form").getFormData();
/* 	alert(obj2string(json));
	for (var key in json) {
		if (json.hasOwnProperty(key)){ 
			alert(json[contractParcelInfo[0]]);
			size++;
		}
	}  */
	/* $.ajax({
		url:"${ctx}/contract/updateContractParcelInfo",
		type:'POST',
		data:  $("#contractEdit_landInfo_form").getFormData(),  
		success:function(data){
			$.messager.alert('提示信息',"保存成功");
			contractDialogClose();
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
		}
	}); */
});
</script>
</div>