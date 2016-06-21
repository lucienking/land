<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	.container{
		width:900px;
		margin:10px auto 0px auto;
	}
	.title{
		text-align:center;
		font-size:23px;
		font-weight:bold;
		margin-top:20px;
		margin-bottom:20px;
	}
	.btn_group{
		margin-top:20px;
		margin-bottom:15px;
		text-align:center;
	}
	.table_container{
		border:1px solid #95B8E7;
		padding:10px 0px 10px 0px;
		border-radius: 10px;
	}
	
	.data_td{
		width:200px;
		align:left;
		min-width:130px;
		height:25px;
		font-size: 12px;
	}
	.data_td_split{
		height:10px;
	}
	
	.title_td{
		width:100%;
		align:left;
	}
	.blank_td{
		width:20px;
	}
	.required{
		color:red;
	}
	.attachment_href{
		font-size: 12px;
		text-decoration:none;
	}
	.detail_info_table{
		width:750px;
		height:auto;
		font-size: 12px;
		cellspacing:0;
		cellpadding:0;
		border-collapse:collapse;
		border-radius: 5px;
		-moz-border-radius: 5px;
		-webkit-border-radius: 5px;
	}
	.detail_info_table tr  td{ 
		border:1px solid #95B8E7;
	}
	
	.detail_info_table_head{
		text-align:center;
		font-weight:bold;
	}
	.disable_background{
		background:red;
	}
</style>
<div id="application_detail_container" class="container" >
<form id="application_detail_form" >
		<div class="title">
			土地流转申请单
		</div>
		<table style="width:99%;height:80px;">
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转编号</span>
					<input id="circulNo" name="circulNo" class="easyui-textbox" style="width:120px;" value="${circul.circulNo}"/>
					<input id="circulId" name="id" type="hidden"  value="${circul.id}"/>
				</td>
				<td class="data_td">
					<span class="td_title">所在农场</span>
					<input id="application_atFarm" name="farmName" value="${circul.residentsGroup.communityEntity.organizationEntity.name }" readonly="true" class="easyui-textbox" style="width:120px;"/>
					<input id="application_atFarmCode" type="hidden" value="${circul.residentsGroup.communityEntity.farmCode }"/>
				</td>
				<td class="data_td">
					<span class="td_title">所在社区</span>
					<input id="application_atCommunity" class="easyui-combobox" name="atCommunity" value="${circul.residentsGroup.communityEntity.communityName}" style="width:120px;"/>
				</td>
				<td class="data_td">
					<span class="td_title">居民小组</span>
					<input id="application_residentsGroup" class="easyui-combobox" name="residentsGrpCode" value="${circul.residentsGroup.residentsGrpName }" style="width:120px;"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转方式</span>
					<jksb:diction id="circulMethod" name="circulMethod" groupId="LAND_TRANSFER" cssClass="easyui-combobox" style="width:120px" defaultValue="${circul.circulMethod}">
					</jksb:diction> 
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转面积 </span>
					<input id="circulArea" name="circulArea" class="easyui-textbox" style="width:120px;" value="${circul.circulArea}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转年限</span>
					<input name="circulYear" class="easyui-textbox" style="width:120px;" validType="float" value="${circul.circulYear}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转价格</span>
					<input name="circulPrice" class="easyui-textbox" style="width:120px;" validType="float" value="${circul.circulPrice}"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转时间</span>
					<input name="circulDate"  class="easyui-datebox" style="width:120px;" value="${circul.circulDate}" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">地块编号</span>
					<input id="landNo" name="landNo" class="easyui-textbox" style="width:120px;" value="${circul.landNo}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">地块类型 </span>
					<input name="landType" class="easyui-textbox" style="width:120px;" value="${circul.landType}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">地块地址</span>
					<input name="landLocation" class="easyui-textbox" style="width:120px;" value="${circul.landLocation}"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">总局批准</span>
					<input name="isZjPermit" class="easyui-textbox" style="width:120px;" value="${circul.isZjPermit}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">附着物补偿费</span>
					<input name="qmfzwPay" class="easyui-textbox" style="width:96px;" validType="float" value="${circul.qmfzwPay}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">劳动力安置费 </span>
					<input name="ldlPay" class="easyui-textbox" style="width:96px;" validType="float" value="${circul.ldlPay}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">基础设施补偿费</span>
					<input name="jcssPay" class="easyui-textbox" style="width:83px;" validType="float" value="${circul.jcssPay}"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">偿付方式</span>
					<input name="repayMethod" class="easyui-textbox" style="width:120px;" value="${circul.repayMethod}"/>
				</td>
				<td class="data_td" colspan="3">
					<span class="td_title">流转类型</span>
					<input name="circulType" class="easyui-textbox" style="width:120px;" value="${circul.circulType}"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td_split" colspan="4">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转甲方</span>
					<input id="originContractor" name="originContractor" class="easyui-textbox" style="width:120px;" value="${circul.originContractor}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">甲方类型</span>
					<input name="originContractorType" class="easyui-textbox" style="width:120px;" value="${circul.originContractorType}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">证件号码</span>
					<input id="originContractorId" name="originContractorId" class="easyui-textbox" style="width:120px;" value="${circul.originContractorId}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">电话号码</span>
					<input name="originContractorTele" class="easyui-textbox" style="width:120px;" value="${circul.originContractorTele}"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转乙方</span>
					<input id="currentContractor" name="currentContractor" class="easyui-textbox" style="width:120px;" value="${circul.currentContractor}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">乙方类型</span>
					<input name="currentContractorType" class="easyui-textbox" style="width:120px;" value="${circul.currentContractorType}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">证件号码</span>
					<input id="currentContractorId" name="currentContractorId" class="easyui-textbox" style="width:120px;" value="${circul.currentContractorId}"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">电话号码</span>
					<input name="currentContractorTele" class="easyui-textbox" style="width:120px;" value="${circul.currentContractorTele}"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td_split" colspan="4">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="4">
					<span class="td_title">附加描述</span>
					<input name="detailDescrip"  class="easyui-textbox" data-options="multiline:true" 
					style="width:765px;height:100px;" value="${circul.detailDescrip}"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td width="48px" align="left"  colspan="4" class="data_td" >
					<span class="td_title">
						附件列表
					</span>
					<c:if test="${circul.attachment.size() != 0 }">
					<table id="attachment_detail" class="detail_info_table" style="width:740px;margin-left:60px;">
						<tr>
						   <td width="600px" class="detail_info_table_head" >附件名称</td>
						   <td width="90px" class="detail_info_table_head" >附件大小</td>
						   <td width="50px" class="detail_info_table_head" >
						   		操作<input type="hidden" id="attachment_num" value="0"/>
						   </td>
						</tr>
						<c:forEach items="${circul.attachment }" var="att">
							 <tr>
								 <td align='center'>${att.attachmentName }</td>
								 <td align='center'>${att.attachmentLong }</td>
								 <td align='center'>
								 	<jksb:download fileName="${att.attachmentName}" hrefText="下载" filePath="${att.attachmentDirection}"></jksb:download>
								 </td>
							 </tr>
						</c:forEach>
					</table>
					</c:if>
					<c:if test="${circul.attachment.size() == 0 }">
						<table id="attachment_detail" class="detail_info_table" style="width:740px;margin-left:60px;">
						<tr>
						   <td width="740px" align='center' >无附件</td>
						</tr>
						</table>
					</c:if>
				</td>
			</tr>
			<c:if test="${circul.circulStatus == 'CHECKING' }">
				<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="4">
					<span class="td_title">审批意见</span>
					<input id="opinionInput" name="opinion"  class="easyui-textbox" data-options="multiline:true" 
					style="width:765px;height:100px;" value="${opinion}" disable="false"/>
				</td>
			</tr>
			</c:if>
		</table>
		
		<div class="btn_group">
			<c:if test="${circul.circulStatus == 'DRAFT' || circul.circulStatus == 'RETURN' }">
				<div id="reEdit_btn_div" style="display:inline;">
					<a id="reEdit_btn" href="#" class="easyui-linkbutton" style="width:60px;height:25px;" >重新编辑</a>
				</div>
			</c:if>
			<c:if test="${circul.circulStatus == 'CHECKING' }">
				<div id="success_btn_div" style="display:inline;">
					<a id="detail_successButton" href="#" class="easyui-linkbutton" data-options="iconCls:'pic_17'" style="width:80px;height:25px;" >通过</a>
				</div>
				<div id="fail_btn_div" style="display:inline;">
					<a id="detail_failButton" href="#" class="easyui-linkbutton" data-options="iconCls:'pic_18'"  style="width:80px;height:25px;" >不通过</a>
				</div>
			</c:if>
			<div id="saveDraft_btn_div" style="display:none;">
				<a id="saveDraft_btn" href="#" class="easyui-linkbutton" style="width:60px;height:25px;" >保存草稿</a>
			</div>
			<div id="submit_btn_div" style="display:none;">
				<a id="submit_btn" href="#" class="easyui-linkbutton" style="width:60px;height:25px;" >提交申请</a>
			</div>
			<div style="display:inline;">
				<a id="cancel_btn" href="#" class="easyui-linkbutton" style="width:60px;height:25px;" >关闭取消</a>
			</div>
		</div>
</form>	 
</div>
<script type="text/javascript">
$(function(){
	var ctx = "${ctx}";
	
	/**
	 * 社区 居民小组联动 combox
	**/
	$("#application_residentsGroup").combobox({
		url:ctx+'/group/getResidentsGroupByCommunity',
	    valueField:'id',
	    textField:'text',
	    method:'GET'
	});
	$("#application_atCommunity").combobox({
		url:ctx+'/community/getCommunityByFarmCode',
	    valueField:'id',
	    textField:'text',
	    method:'GET',
	   	queryParams:{"farmCode":$("#application_atFarmCode").val()},
	   	onSelect:function(value){
	   		$('#application_residentsGroup').combobox('clear'); 
	   		var url = ctx+'/group/getResidentsGroupByCommunity?communityCode='+value.id;
	   		$('#application_residentsGroup').combobox('reload', url); 
	   	}
	});
	
	/**
		input绑定回车事件 跳下一个
	*/
	 var inputAry = $("#application_detail_form").find("input[type=text]");
	$("input[type=text]:not(:disabled)").bind('keypress',function(event){
	    if(event.keyCode == "13"){
	    	  var nxtIdx = inputAry.index(this) + 1;
              $("input[type=text]:not(:disabled)").eq(nxtIdx).focus();
	    }
	});
	
	
	/**
	   input 重置
	*/
	$("#reset_btn").click(function(){
		$("input[type=text]").val("");
	});
	
	/**
	   取消 关闭页面
	*/
	$("#cancel_btn").click(function(){
		$("#applDetailDialog").dialog('close');
	});
	
	/**
	   重新编辑按钮
	*/
	$("#reEdit_btn").click(function(){
	//	$("#application_detail_container .easyui-combobox").combobox({ disabled: false});
		$("#application_detail_container .easyui-textbox").textbox({ disabled: false});
		$("#saveDraft_btn_div").css("display","inline");
		$("#submit_btn_div").css("display","inline");
		$("#reEdit_btn").css("display","none");
	});
	
	$("#submit_btn_div").click(function(){
		submitApplication("PENDING");
	});
	$("#saveDraft_btn_div").click(function(){
		submitApplication("DRAFT");
	});
	
	$("#detail_successButton").click(function(){
		check("CHECKEDSUCCESS",$("#circulId").val());
	});
	$("#detail_failButton").click(function(){
		check("CHECKEDFAIL",$("#circulId").val());
	});
	
//	$("#application_detail_container .easyui-combobox").combobox({ editable: false});
	$("#application_detail_container .easyui-textbox").textbox({ editable: false});
	$("#application_detail_container .easyui-textbox").addClass("disable_background");
	$("#opinionInput").textbox({ disabled: false});
});

/**
 * 添加附件信息
**/
function addAttachment(){
	$("#add_attachment_div").show(); //先显示，再弹出
	var id = $("input[name ='file']").attr("id");
	jksbFileUploadClear(id);
    $("#add_attachment_div").dialog({
        title: "添加附件信息",
        width: 300,
        height: 150,
        modal:true,
        buttons:[{
			text:'添加',
			handler:function(){ 
				var map = new Map();
				map.put("name",$("input[name ='fileName']").val());
				map.put("size",$("input[name ='fileSize']").val());
				map.put("type",$("input[name ='fileType']").val());
				map.put("direction",$("input[name ='filePath']").val());
				createAttachmentInfoTd(map);
				$("#add_attachment_div").dialog("close");
			}
		},{
			text:'取消',
			handler:function(){$("#add_attachment_div").dialog("close");}
		}]
    });
}
 
/**
 * 生成附件信息行
**/
function createAttachmentInfoTd(map){
	if(map.get("name") == "" || map.get("name") == undefined){ 
		return ;
	}else{
		var index = parseInt($("#attachment_num").val());
		$("#attachment_detail").css("display","block");
		var newRow = "<tr>"+
				 "<td align='center'>"+map.get("name")+ 
				 "<input type='hidden' name='attachment["+index+"].attachmentName' value='"+map.get("name")+"'>"+
				 "<input type='hidden' name='attachment["+index+"].attachmentLong' value='"+map.get("size")+"'>"+
				 "<input type='hidden' name='attachment["+index+"].attachmentType' value='"+map.get("type")+"'>"+
				 "<input type='hidden' name='attachment["+index+"].attachmentModule' value='landCircul'>"+
				 "<input type='hidden' name='attachment["+index+"].attachmentDsirection' value='"+map.get("direction")+"'></td>" +
				 "<td align='center'>"+map.get("size")+ "b</td>" +
				 "<td align='center'><a href='#' class='apply_href' onclick='javascript:deleteCurrentObjTR(this);'>删除</a></td>"+
				 "</tr>";
		$("#attachment_detail tr:last").after(newRow);	
		$("#attachment_num").val(index+1);
}}

/**
表单提交
*/
function submitApplication(status){
	var inputs = new Array("circulNo",
							"circulArea",
							"currentContractor",
							"currentContractorId",
							"originContractor",
							"originContractorId",
							"landNo");
	var selects = new Array("application_atCommunity",
							"application_residentsGroup");
	if(validateInputGroup(inputs,selects))
		$.ajax({
			type: "POST",
			url:"${ctx}/landCirculation/edit/"+status,
			data:$('#application_detail_form').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
		    		$("#applDetailDialog").dialog('close');
		    	});
		   }
		}); 
	else $.messager.alert('提示',"红色项为必填项");
}


function check(status,id){
	var inputs = new Array("opinionInput");
	if(validateInputGroup(inputs,null)) 
		$.ajax({
			type: "POST",
			url:"${ctx}/landCirculation/update/"+status,
			data:{'id':id,'opinion':$("#opinionInput").textbox("getValue")},
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
		    		window.parent.$('#applDatagrid').datagrid('reload');
		    		$("#applDetailDialog").dialog('close');
		    	});
		   }
		});  
	else $.messager.alert('提示',"请填写审批意见");
}
</script>
