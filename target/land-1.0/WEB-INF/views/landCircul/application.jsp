<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
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
</style>
<div class="container" >
<form id="application_form" >
	<div class="table_container">
		<div class="title">
			土地流转申请单
		</div>
		<table style="width:99%;height:80px;">
			<!-- <tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="4">
					<span class="td_title">流转标题</span>
					<input name="circulTitle" class="easyui-textbox" style="width:765px;" />
					<span class="required">* </span>
				</td>
			</tr> -->
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转编号</span>
					<input id="circulNo" name="circulNo" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td">
					<span class="td_title">所在农场</span>
					<input id="application_atFarm" name="farmName" value="${farmName }" readonly="true" class="easyui-textbox" style="width:120px;"/>
					<input id="application_atFarmCode" type="hidden" value="${farmCode }"/>
				</td>
				<td class="data_td">
					<span class="td_title">所在社区</span>
					<input id="application_atCommunity" name="atCommunity" value="" style="width:120px;"/>
				</td>
				<td class="data_td">
					<span class="td_title">居民小组</span>
					<input id="application_residentsGroup" name="residentsGrpCode" value="${contract.residentsGroup.residentsGrpCode }" style="width:120px;"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转方式</span>
					<jksb:diction id="circulMethod" name="circulMethod" groupId="LAND_TRANSFER" cssClass="easyui-combobox" style="width:120px" defaultValue="1">
					</jksb:diction> 
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转面积 </span>
					<input id="circulArea" name="circulArea" class="easyui-textbox" style="width:120px;"  value="0"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转年限</span>
					<input name="circulYear" class="easyui-textbox" style="width:120px;" validType="float"  value="0"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转价格</span>
					<input name="circulPrice" class="easyui-textbox" style="width:70px;" validType="float"  value="0"/>元/年/亩
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转时间</span>
					<input name="circulDate"  class="easyui-datebox" style="width:120px;" value="${currentDate}" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">地块编号</span>
					<input id="landNo" name="landNo" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">地块类型 </span>
					<input name="landType" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">地块地址</span>
					<input name="landLocation" class="easyui-textbox" style="width:120px;" />
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">总局批准</span>
					<jksb:diction id="isZjPermit" name="isZjPermit" groupId="PUB_SELECT" cssClass="easyui-combobox" style="width:120px" defaultValue="Y">
					</jksb:diction> 
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">青苗及附着物补偿费</span>
					<input name="qmfzwPay" class="easyui-textbox" style="width:57px;" validType="float"  value="0"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">劳动力安置费 </span>
					<input name="ldlPay" class="easyui-textbox" style="width:96px;" validType="float"  value="0"/>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">基础设施补偿费</span>
					<input name="jcssPay" class="easyui-textbox" style="width:83px;" validType="float"  value="0"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">偿付方式</span>
					<input name="repayMethod" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="3">
					<span class="td_title">流转类型</span>
					<select id="application_circulType" name="circulType" style="width:120px;">
						<option value="OUT" selected>对外流转</option>
						<option value="IN">对内流转</option>
					</select>
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
					<input id="originContractor" name="originContractor" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">甲方类型</span>
					<jksb:diction id="originContractorType" name="originContractorType" groupId="CONTRACT_COTRACTOR_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="ENTERPRISE">
					</jksb:diction>
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">证件号码</span>
					<input id="originContractorId" name="originContractorId" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">联系电话</span>
					<input id="originContractorTele" name="originContractorTele" class="easyui-textbox" style="width:120px;" />
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td class="data_td" colspan="1">
					<span class="td_title">流转乙方</span>
					<input id="currentContractor" name="currentContractor" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">乙方类型</span>
					<input id="currentContractorType" name="currentContractorType" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">证件号码</span>
					<input id="currentContractorId" name="currentContractorId" class="easyui-textbox" style="width:120px;" />
				</td>
				<td class="data_td" colspan="1">
					<span class="td_title">联系电话</span>
					<input id="currentContractorTele" name="currentContractorTele" class="easyui-textbox" style="width:120px;" />
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
					<input name="detailDescrip"  class="easyui-textbox" data-options="multiline:true" style="width:765px;height:100px;"/>
				</td>
			</tr>
			<tr>
				<td class="blank_td"></td>
				<td width="48px" align="left"  colspan="4" >
					<span class="td_title">
						<a href="#" class="attachment_href" onclick="javascript:addAttachment();">添加附件</a>
					</span>
					<div id="add_attachment_div" style="display:none">
						<div class="line-div">
							<jksb:upload name="add_attachmentdirection" id="add_attachmentdirection" buttonText="点击选择上传附件" savePath="landCirculAttachment">
							</jksb:upload> 
						</div>
					</div>
					<table id="attachment_detail" class="detail_info_table" style="width:740px;display:none;margin-left:60px;">
						<tr>
						   <td width="600px" class="detail_info_table_head" >附件名称</td>
						   <td width="90px" class="detail_info_table_head" >附件大小</td>
						   <td width="50px" class="detail_info_table_head" >
						   		操作<input type="hidden" id="attachment_num" value="0"/>
						   </td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="btn_group">
			<div style="display:inline;padding-right:20px;">
				<a href="#" onclick="submitApplication('DRAFT')" class="easyui-linkbutton" style="width:60px;height:25px;">保存草稿</a>
			</div>
			<div style="display:inline;padding-right:20px;">
				<a href="#" onclick="submitApplication('PENDING')" class="easyui-linkbutton" style="width:60px;height:25px;" >提交申请</a>
			</div>
			<div style="display:inline;">
				<a id="cancel_btn" href="#" class="easyui-linkbutton" style="width:60px;height:25px;" >关闭取消</a>
			</div>
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
	 var inputAry = $("#application_form").find("input[type=text]");
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
		window.parent.$('#mainTabs').tabs('close', "土地流转申请");
	});
	
	/**
	 * 对内对外流转
	 */
	$("#application_circulType").combobox({
		onChange:function(n,o){
			if(n=="OUT"){
				$("#originContractor").textbox("setValue","海南农垦控股集团");
				$("#originContractorType").textbox("setValue","企业");
				$("#originContractorId").textbox("setValue","---");
				$("#originContractorTele").textbox("setValue","0898-31666610");
				
				$("#currentContractor").textbox("setValue","");
				$("#currentContractorType").textbox("setValue","");
				$("#currentContractorId").textbox("setValue","");
				$("#currentContractorTele").textbox("setValue","");
				
				$("#originContractor").textbox("readonly",true);
				$("#originContractorType").textbox("readonly",true);
				$("#originContractorId").textbox("readonly",true);
				$("#originContractorTele").textbox("readonly",true);
				
				$("#currentContractor").textbox("readonly",false);
				$("#currentContractorType").textbox("readonly",false);
				$("#currentContractorId").textbox("readonly",false);
				$("#currentContractorTele").textbox("readonly",false);
				
			}else if(n=="IN"){
				$("#currentContractor").textbox("setValue","海南农垦控股集团");
				$("#currentContractorType").textbox("setValue","企业");
				$("#currentContractorId").textbox("setValue","---");
				$("#currentContractorTele").textbox("setValue","0898-31666610");
				
				$("#originContractor").textbox("setValue","");
				$("#originContractorType").textbox("setValue","");
				$("#originContractorId").textbox("setValue","");
				$("#originContractorTele").textbox("setValue","");
				
				$("#currentContractor").textbox("readonly",true);
				$("#currentContractorType").textbox("readonly",true);
				$("#currentContractorId").textbox("readonly",true);
				$("#currentContractorTele").textbox("readonly",true);
				
				$("#originContractor").textbox("readonly",false);
				$("#originContractorType").textbox("readonly",false);
				$("#originContractorId").textbox("readonly",false);
				$("#originContractorTele").textbox("readonly",false);
			}
		}
	});
	$("#application_circulType").combobox("select","IN");
	$("#application_circulType").combobox("select","OUT");
	
	
	/**
		校验重复
	**/
	$("#circulNo").textbox({
		onChange:function(n,v){
		var result  = true;
		if(n != null && n != "")
		$.ajax({
			type: "GET",
			url:"${ctx}/landCirculation/validateCirculNo",
			data:{"circulNo":n},
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	if(data.exist == "Y"){
		    		$.messager.alert('提示',"该编号已经存在");
		    		setInvalidStyle("circulNo");
		    		result =false;
		    	} 
		    }
		}); 
		return result;
	}
	});
});

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
			url:"${ctx}/landCirculation/create/"+status,
			data:$('#application_form').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
		    		window.parent.$('#mainTabs').tabs('close', "土地流转申请");
		    	});
		   }
		}); 
	else $.messager.alert('提示',"红色项为必填项");
}
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
				 "<input type='hidden' name='attachment["+index+"].attachmentDirection' value='"+map.get("direction")+"'></td>" +
				 "<td align='center'>"+map.get("size")+ "b</td>" +
				 "<td align='center'><a href='#' class='apply_href' onclick='javascript:deleteCurrentObjTR(this);'>删除</a></td>"+
				 "</tr>";
		$("#attachment_detail tr:last").after(newRow);	
		$("#attachment_num").val(index+1);
}}

/**
 * 删除当前行
**/
function deleteCurrentObjTR(obj){
	$(obj).parent().parent().remove(); 
}
</script>
