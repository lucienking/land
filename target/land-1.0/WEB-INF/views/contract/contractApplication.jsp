<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script src="${ctx }/static/js/contract/contractApplication.js"></script>
<style>
	.contractApplyBody{
		font-family:"Microsoft Yahei";
	}
	.contract_apply_href{
		text-decoration:none;
	}
	.contract_data_td{
		width:210px;
		align:left;
		min-width:130px;
		height:25px;
	}
	.contract_title_td{
		width:100%;
		align:left;
	}
	.contract_blank_td{
		width:20px;
	}
	.contract_info_panel{
		width:100%;
		margin-top:15px;
		border:none;
	}

	.contract_detail_info_table{
		width:750px;
		height:auto;
		font-size: 12px;
		cellspacing:0;
		cellpadding:0;
		border-collapse:collapse;
		/* border:1px solid #95B8E7;
		-moz-border-radius: 5px 5px 5px 5px;
  		-webkit-border-radius: 5px 5px 5px 5px;
  		border-radius: 5px 5px 5px 5px; */
	}
	
	.contract_detail_info_table tr  td{ 
		border:1px solid #95B8E7;
	}
	
	.contract_detail_info_table_head{
		text-align:center;
	}
	
	.required{
		color:red;
	}
	
	.td_title{
		width:70px;
		display:inline-block;
		text-align:center;
	}
</style>
<!-- 承包合同登记表单 -->
<div class="contractApplyBody" sytle="min-width:600px;width:100%;padding-top:10px;text-align:center;">
	<form id="contractRegisteration">
		<div id="contractRegisteDiv" class="easyui-layout" style="width:860px;margin:0 auto">
			
			<div id="contractTitleInfo" class="easyui-panel"
		    		style="width:100%;margin-top:5px;text-align:center;border:none;font-size:18px;font-weight:bold;">
		    	承包合同申请
		    </div>
		    <div id="contractNOInfo" class="easyui-panel" style="width:100%;margin-top:1px;border:none;">
		    	<table style="width:100%; ">
					<tr>
						<td width="60%" align="left" >
							<span style="font-weight:bold;">合同编码:</span>${contract.contractCode }
							<input type="hidden" value="${contract.contractCode }" name="contractCode" />
						</td>
						<td width="40%" align="right">
							<span style="font-weight:bold;">申请日期:</span>${signDate }
							<input type="hidden" value="${startDate }" name="dateOfSigning" />
						</td>
					</tr>
				</table>
			</div>
		<div id="contractApplyContainer" class="easyui-panel"	style="width:100%;margin-top:1px;border-radius: 7px;">
		    <div id="contractBaseInfo" class="easyui-panel"	style="width:100%;margin-top:1px;border:none;">
		    	<table style="width:99%;height:80px; ">
		    		<tr>
						<td class="contract_title_td" colspan="5">
							<span style="font-weight:bold;">基本信息</span>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>合同编号</span>
							<input id="contract_contractNo" name="contractNo" value="${contract.contractNo }" value="" class="easyui-textbox" style="width:120px;" 
								 validType='maxLength[30]'/>
						</td>
						<td class="contract_data_td">
							<span class="td_title">合同甲方</span>
							<input id="contract_firstParty" name="firstParty" value="${farmName }"  class="easyui-textbox" style="width:120px;" />
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>甲方法人</span>
							<input id="contract_firstPtRepresentative" name="firstPtRepresentative" value="${contract.firstPtRepresentative }" class="easyui-textbox" style="width:120px;"/>
						</td>
						<td class="contract_data_td">
							<span class="td_title" ><b class="required">*</b>保障地面积</span>
							<input id="contract_affordableArea" name="affordableArea" value="${contract.affordableArea }" class="easyui-textbox" style="width:100px;" 
								prompt="亩 " validType="float"/>  亩
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td">
							<span class="td_title">所在农场</span>
							<input id="contract_atFarm" name="farmName" value="${farmName }" readonly="true" class="easyui-textbox" style="width:120px;"/>
							<input id="contract_atFarmCode" type="hidden" value="${farmCode }"/>
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>所在社区</span>
							<input id="contract_atCommunity" name="atCommunity" value="" style="width:120px;"/>
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>居民小组</span>
							<input id="contract_residentsGroup" name="residentsGrpCode" value="${contract.residentsGroup.residentsGrpCode }" style="width:120px;"/>
						</td>
						<td class="contract_data_td">
							<span class="td_title">签订地址</span>
							<input id="contract_signingAddress" name="signingAddress" value="${contract.signingAddress }" class="easyui-textbox" style="width:120px;" /> 
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>承包期限</span>
							<input id="contract_leaseTerm"  name="leaseTerm" value="${contract.leaseTerm }" class="easyui-textbox" style="width:100px;"
								prompt="年 " validType="number" /> 年
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>起始时间</span>
							<input id="contract_startDate" name="startDate" value="${startDate }" class="easyui-datebox" style="width:120px;"/>
						</td>
						<td class="contract_data_td">
							<span class="td_title">到期时间</span>
							<input id="contract_expiredDate" name="expiredDate" value="${endDate }"
								readonly="true" class="easyui-datebox"  style="width:120px;"/>
						</td>
						<td class="contract_data_td"  colspan="1">
						</td>
					</tr>
				</table>
		    </div>
		    <div id="contractPriceInfo" class="easyui-panel contract_info_panel">
		    	<table style="width:99%;">
		    		<tr>
						<td class="contract_title_td" colspan="5" >
							<span style="font-weight:bold;">租金信息</span>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>签订单价</span>
							<input id="contract_signingPrice" name="signingPrice" value="${contract.signingPrice }" class="easyui-textbox" style="width:80px;"
							 prompt="元/亩" validType="float" /> 元/亩
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>阶梯计价</span>
							<jksb:diction id="contract_isStepedCount" name="isStepedCount" groupId="PUB_SELECT"  cssClass="easyui-combobox" style="width:120px" defaultValue="Y">
							</jksb:diction>
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>定期递增</span>
							<jksb:diction id="contract_isRegularlyRaise" name="isRegularlyRaise" groupId="PUB_SELECT"  style="width:120px" defaultValue="Y">
							</jksb:diction>
						</td>
						<td class="contract_data_td">
							<span class="td_title">5年上涨率</span>
							<input id="contract_ratePerFiveYear" name="ratePerFiveYear" value="${contract.ratePerFiveYear }" class="easyui-textbox" style="width:100px;"
								prompt="%" validType="float"/> %
						</td>
					</tr>
				</table>
		    </div>
		    <div id="contractLandInfo" class="easyui-panel contract_info_panel" >
		    	<table style="width:99%;">
		    		<tr>
						<td class="contract_title_td" colspan="5" >
							<span style="font-weight:bold;">地块概括信息</span>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>土地等级</span>
							<jksb:diction id="contract_landLevel" name="landLevel" groupId="CONTRACT_LAND_LEVEL"  cssClass="easyui-combobox" style="width:120px" defaultValue="2">
							</jksb:diction>
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>土地类型</span>
							<jksb:diction id="contract_landType" name="landType" groupId="CONTRACT_LAND_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="2">
							</jksb:diction>
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>承包面积</span>
							<input id="contract_useArea" name="useArea" value="0.0" class="easyui-textbox" style="width:100px;" prompt="亩"/> 亩
							<input type="hidden" id="contractArea_left" value="0"/>
						</td>
						<td class="contract_data_td">
							<span class="td_title">土地座落</span>
							<input id="contract_landLocation" name="landLocation" value="${contract.landLocation }" class="easyui-textbox" style="width:120px;"/>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td" width="840px" align="left"  colspan="4">
							<span class="td_title">土地四至</span>
							<input id="contract_landExtend" name="landExtend" value="${contract.landExtend }" class="easyui-textbox" style="width:738px;"
								prompt="东至 西至 南至 北至 "/>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td width="840px" align="left"  colspan="4">
							<a href="#" class="contract_apply_href" onclick="javascript:addDetailLandInfo();">添加详细地块</a>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td width="840px" align="left"  colspan="4">
							<table id="contract_landInfo_detail" class="contract_detail_info_table" style="display:none">
								<tr>
								   <td width="80px" class="contract_detail_info_table_head">地块编号</td>
								   <td width="80px" class="contract_detail_info_table_head" >地块类型</td>
								   <td width="80px" class="contract_detail_info_table_head" >地块等级</td>
								   <td width="100px" class="contract_detail_info_table_head" >地块面积(亩)</td>
								   <td width="80px" class="contract_detail_info_table_head" >种植作物</td>
								   <td width="180px" class="contract_detail_info_table_head" >地块座落</td>
								   <td width="300px" class="contract_detail_info_table_head" >地块四至</td>
								   <td width="40px" class="contract_detail_info_table_head" >
								   		操作<input type="hidden" id="contract_landInfo_detail_num" value="0"/>
								   </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		    </div>
		    <div id="contractRenterInfo" class="easyui-panel contract_info_panel" >
		    	<table style="width:99%;">
		    		<tr>
						<td class="contract_title_td" colspan="5">
							<span style="font-weight:bold;">承包法人信息</span>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>承包方类型</span>
							<jksb:diction id="contractor_contractorType" name="contractorInfo_contractorType" groupId="CONTRACT_COTRACTOR_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="PERSONAL">
							</jksb:diction>
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>证件类型</span>
							<jksb:diction id="contractor_contractorIdType" name="contractorPersonal[0].contractorIdType" groupId="PUB_ID_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="IC">
							</jksb:diction>
						</td>
						<td class="contract_data_td">
							<span class="td_title"><b class="required">*</b>证件号码</span>
							<input id="contractor_contractorIDNO" name="contractorPersonal[0].contractorIDNO" value="${contractorPersonal[0].contractorIDNO }" class="easyui-textbox" style="width:120px;" 
								   />
						</td>
						<td class="contract_data_td">
							<span class="td_title">承包面积</span>
							<input id="contractor_contractArea" name="contractorPersonal[0].contractArea" value="0.0" class="easyui-textbox" style="width:100px;" 
								prompt="亩 " validType="float"/>  亩
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td class="contract_data_td">
							<span class="td_title">承包人姓名</span>
							<input type="hidden" value="" />
							<input id="contractor_contractorName" name="contractorPersonal[0].contractorName" value="${contractorPersonal[0].contractorName }" class="easyui-textbox" style="width:120px;"/>
							<input type="hidden" value="" name="secondParty" id="contract_secondParty"/>
							<input type="hidden" value="" name="secondPtRepresentative" id="contract_secondPtRepresentative"/>
						</td>
						<td class="contract_data_td">
							<span class="td_title">是否职工</span>
							<jksb:diction id="contractor_isStaff" name="contractorPersonal[0].isStaff" groupId="PUB_SELECT"  cssClass="easyui-combobox" style="width:120px" defaultValue="Y">
							</jksb:diction>
						</td>
						<td class="contract_data_td">
							<span class="td_title">工作单位</span>
							<input id="contractor_contractorDepartment" name="contractorPersonal[0].contractorDepartment" value="${contractorPersonal[0].contractorDepartment }" class="easyui-textbox" style="width:120px;"/>
						</td>
						<td width="210px" align="left" colspan="1" class="contract_data_td">
							<span class="td_title">居住地址</span>
							<input id="contractor_contractorAddr" name="contractorPersonal[0].contractorAddr" value="${contractorPersonal[0].contractorAddr }" class="easyui-textbox" style="width:120px;"/>
							
							<input  id="contractor_residentTypeCode" type="hidden" name="contractorPersonal[0].residentTypeCode" value=""/>
							<input  id="contractor_residentTypeName" type="hidden" name="contractorPersonal[0].residentTypeName" value=""/>
							<input  type="hidden" name="contractorPersonal[0].isRespOfSecPt" value="Y"/>
							
							<input id="contractor_contractorPhoneNumber" type='hidden' name='contractorPersonal[0].contractorPhoneNumber' value=''/>
							<input id="contractor_huhao" type='hidden' name='contractorPersonal[0].huhao' value=''/>
							<input id="contractor_isCadres" type='hidden' name='contractorPersonal[0].isCadres' value=''/>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td width="840px" align="left"  colspan="4">
							 <a href="#" onclick="javascript:addContractorInfo()" class="contract_apply_href">添加其他承包人 </a>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
						<td width="840px" align="left"  colspan="4">
							<table id="contract_contractorInfo_detail" class="contract_detail_info_table" style="display:none">
								<tr>
								   <td width="80px" class="contract_detail_info_table_head">承包人姓名</td>
								   <td width="80px" class="contract_detail_info_table_head" >证件类型</td>
								   <td width="230px" class="contract_detail_info_table_head" >证件号码</td>
								   <td width="230px" class="contract_detail_info_table_head" >工作单位</td>
								   <td width="80px" class="contract_detail_info_table_head" >是否职工</td>
								   <td width="150px" class="contract_detail_info_table_head" >联系电话</td>
								   <td width="100px" class="contract_detail_info_table_head" >承包面积(亩)</td>
								   <td width="40px" class="contract_detail_info_table_head" >
								   		操作<input type="hidden" id="contract_contractorInfo_detail_num" value="1"/>
								   </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		    </div>
		    <div id="contractRenterInfo" class="easyui-panel contract_info_panel" >
		    	<table style="width:99%;">
		    		<tr>
						<td class="contract_title_td" colspan="5"> 
							<span style="font-weight:bold;">补充附加信息</span>
						</td>
					</tr>
			    	<tr>
			    		<td class="contract_blank_td">
						</td>
		    			<td width="840px" align="left"  colspan="4" >
							<span class="td_title">补充条款</span>
							<input id="contract_supplementaryProvisions" name="supplementaryProvisions" value="${contract.supplementaryProvisions }" class="easyui-textbox" data-options="multiline:true" style="width:738px;height:100px;"/>
						</td>
					</tr>
					<tr>
						<td class="contract_blank_td">
						</td>
		    			<td width="48px" align="left"  colspan="1" >
							<a href="#" class="contract_apply_href" onclick="javascript:addContractAttachment();">添加附件</a>
						</td>
						<td width="696px" align="left"  colspan="3">
							<table id="contract_attachment_detail" class="contract_detail_info_table" style="width:696px;display:none;margin-left:2px;">
								<tr>
								   <td width="576px" class="contract_detail_info_table_head" >附件名称</td>
								   <td width="80px" class="contract_detail_info_table_head" >附件大小</td>
								   <td width="40px" class="contract_detail_info_table_head" >
								   		操作<input type="hidden" id="contract_attachment_num" value="0"/>
								   </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		    <div id="contractRenterInfo" class="easyui-panel" style="width:100%;height:40px;margin-top:15px;text-align:center;border:none;">
		    	 <a class="easyui-linkbutton" href="#" id="contractApplyButton" onclick="javascript:contractApplySubmit();">&nbsp;<b>提交申请</b>&nbsp;</a>
		    </div>
		 </div>
		</div>
	</form>
	<div id="contract_add_land_div" style="display:none;">
		<div class="line-div">
			<span class="td_title">地块编号</span>
			<input id="add_land_landCode" name="add_land_landCode" class="easyui-textbox" style="width:120px;"/>
			<span class="td_title">土地等级</span>
			<jksb:diction id="add_land_landLevel" name="add_land_landLevel" groupId="CONTRACT_LAND_LEVEL"  cssClass="easyui-combobox" style="width:120px" defaultValue="2">
			</jksb:diction>
		</div>
		<div class="line-div">
			<span class="td_title">土地类型</span>
			<jksb:diction id="add_land_landType" name="add_land_landType" groupId="CONTRACT_LAND_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="2">
			</jksb:diction>
			<span class="td_title">地块面积</span>
			<input id="add_land_landArea" name="add_land_landArea" class="easyui-textbox" style="width:100px;" prompt="亩 " /> 亩
		</div>
		<div class="line-div">
			<span class="td_title">种植作物</span>
			<input id="add_land_plantCrops" name="add_land_plantCrops" class="easyui-textbox" style="width:120px;"/>
			<span class="td_title">土地座落</span>
			<input id="add_land_landLocation" name="add_land_landLocation" class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			<span class="td_title">土地四至</span>
			<input id="add_land_land4direction" name="add_land_land4direction" class="easyui-textbox" style="width:318px;"/>
		</div>
	</div>
	<div id="contract_add_attachment_div" style="display:none">
		<div class="line-div">
			<jksb:upload name="contract_add_attachmentdirection" id="contract_add_attachmentdirection" buttonText="点击选择上传附件" savePath="contractAttachment">
			</jksb:upload> 
		</div>
	</div>
	
	
	<div id="contract_add_contractor_div" style="display:none">
	<form id="contract_add_contractor_form">
		<div class="line-div">
			<span class="td_title">证件类型</span>
			<jksb:diction id="add_contractor_contractorIdType" name="add_contractor_contractorIdType" groupId="PUB_ID_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="IC">
			</jksb:diction>
			<span class="td_title">证件号码</span>
			<input id="add_contractor_contractorIDNO" value="" class="easyui-textbox" style="width:180px;"/>
		</div>
		<div class="line-div">
			<span class="td_title">人员姓名</span>
			<input id="add_contractor_contractorName"  value="" class="easyui-textbox" style="width:120px;"/>
			<span class="td_title">工作单位</span>
			<input id="add_contractor_contractorDepartment"  class="easyui-textbox" style="width:180px;"/>
		</div>
		<div class="line-div">
			<span class="td_title">是否职工</span>
			<jksb:diction id="add_contractor_isStaff" name="add_contractor_isStaff"  groupId="PUB_SELECT"  cssClass="easyui-combobox" style="width:120px" defaultValue="Y">
			</jksb:diction>
			<span class="td_title">居住地址</span>
			<input id="add_contractor_contractorAddr"  class="easyui-textbox" style="width:180px;"/>
		</div>
		<div class="line-div">
			<span class="td_title">承包面积</span>
			<input id="add_contractor_useArea" class="easyui-textbox" style="width:100px;" validType="float" prompt="亩 " /> 亩
			<input type="hidden" id="add_contractor_residentTypeCode" />
			<input type="hidden" id="add_contractor_residentTypeName" />
			
			<input type="hidden" id="add_contractor_huhao" />
			<input type="hidden" id="add_contractor_isCadres" />
			
			<span class="td_title">联系电话</span>
			<input id="add_contractor_contractorPhoneNumber"  class="easyui-textbox" style="width:180px;"/>
		
		</div>
		
		</form>
	</div>
	
	<script type="text/javascript">
		var ctx = "${ctx}";
		
		$("#contract_contractNo").textbox({
			onChange:function(newV,oldV){
				validateContractNo(newV);
			}
		});
		
		function validateContractNo(contractNo){	
			var result  = true;
			if(contractNo != null && contractNo != "")
			$.ajax({
				type: "GET",
				url:"${ctx}/contract/validateContractNo",
				data:{"farmCode":$("#contract_atFarmCode").val(),"contractNo":contractNo},
				asyn:false,
			    error: function(jqXHR, textStatus, errorMsg) {
			    	$.messager.alert('操作结果',""+jqXHR.responseText);
			    },
			    success: function(data) {
			    	if(data.exist == "Y"){
			    		$.messager.alert('提示',"该合同编号已经存在");
			    		setInvalidStyle("contract_contractNo");
			    		result =false;
			    	} 
			    }
			}); 
			return result;
		}
		
		/**
		 *	承包期和起始时间的变化都将影响截止日期的变化。
		 **/
		$("#contract_leaseTerm").textbox({
			onChange:function(newV,oldV){
				if(newV >30){
					$.messager.alert('提示',"承租年限超过最大限制。");
					$("#contract_leaseTerm").textbox("setValue","");
				}else
					calcuExpired();
			}
		});
		$("#contract_startDate").datebox({onChange:function(){calcuExpired();}});
		
		/**
		 *	计算租期到期时间
		**/
		function calcuExpired(){
			var start = $('#contract_startDate').datebox('getValue');
			var term = parseInt($("#contract_leaseTerm").textbox('getValue'));
			var year = parseInt(start.substr(0,4));
			var mmdd = start.substr(4);
			var expired = year+term + mmdd;
			$('#contract_expiredDate').datebox('setValue', expired);
		}
		
		/**
		 *  是否递增联动设置,如果是，填写增长率，如果不是，默认设为0，且不可编辑。
		**/		
		$("#contract_isRegularlyRaise").combobox({
			onSelect:function(){
				if($("#contract_isRegularlyRaise").combobox("getValue")!="Y"){
					$("#contract_ratePerFiveYear").textbox("setValue","0.0");
					$("#contract_ratePerFiveYear").textbox("disable");
				}else
					$("#contract_ratePerFiveYear").textbox("enable");
			}
		});
		
		/* $("input",$("#contract_leaseTerm").next("span")).keydown(function(){ 
				alert("11");
		}); */
		
		
		/**
		 * 社区 居民小组联动 combox
		**/
		$("#contract_residentsGroup").combobox({
			url:ctx+'/group/getResidentsGroupByCommunity',
		    valueField:'id',
		    textField:'text',
		    method:'GET'
		});
		$("#contract_atCommunity").combobox({
			url:ctx+'/community/getCommunityByFarmCode',
		    valueField:'id',
		    textField:'text',
		    method:'GET',
		   	queryParams:{"farmCode":$("#contract_atFarmCode").val()},
		   	onSelect:function(value){
		   		$('#contract_residentsGroup').combobox('clear'); 
		   		var url = ctx+'/group/getResidentsGroupByCommunity?communityCode='+value.id;
		   		$('#contract_residentsGroup').combobox('reload', url); 
		   	}
		});
		
		/**
		* 其他类型证件不校验
		*/
		/* $("input[name='contractorPersonal[0].contractorIdType']").change(function(){
			var value =  $("input[name='contractorPersonal[0].contractorIdType']").val(); 
			alert(value);
	   		if(value == "IC")
	   			$('#contractor_contractorIDNO').textbox("enableValidation");
	   		else 
	   			$('#contractor_contractorIDNO').textbox("disableValidation");
		});
		
		$("#add_contractor_contractorIdType").combobox({
			onChange:function(newV,oldV){
				var value =  $("input[name='add_contractor_contractorIdType']").val(); 
		   		if(value == "IC")
		   			$('#add_contractor_contractorIDNO').textbox("enableValidation");
		   		else 
		   			$('#add_contractor_contractorIDNO').textbox("disableValidation");
			}
	   	}); */
		
		$("#contractor_contractorIDNO").textbox({
		   	onChange:function(newV,oldV){
		   		var isIDNO = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		   		var value =  $("input[name='contractorPersonal[0].contractorIdType']").val(); 
		   		if(newV != null && newV !="" &&value == "IC"){
		   			var reg = new RegExp(isIDNO);
		        	if(reg.test(newV))
			   			$.ajax({
							type: "GET",
							url:"${ctx}/contract/getPeopleInfo",
							data:{idNo:newV},
							asyn:false,
						    error: function(jqXHR, textStatus, errorMsg) {
						    	$.messager.alert('操作结果',""+jqXHR.responseText);
						    },
						    success: function(data) {
						    	if(data.contractorPersonal == null){
						    		$.messager.alert('操作结果',"该人口信息不存在，请先在社区登记人口信息。");
						    		$('#contractor_contractorIDNO').textbox("setValue",null);
						    	}else{
							    	$("#contractor_contractorName").textbox("setValue",data.contractorPersonal.contractorName);
							    	$("#contractor_contractorDepartment").textbox("setValue",data.contractorPersonal.contractorDepartment);
							    	$("#contractor_contractorAddr").textbox("setValue",data.contractorPersonal.contractorAddr);
							    	$("#contractor_residentTypeCode").val(data.contractorPersonal.residentTypeCode);
							    	$("#contractor_residentTypeName").val(data.contractorPersonal.residentTypeName);
							    	$("#contract_secondParty").val(data.contractorPersonal.contractorName);
							    	$("#contract_secondPtRepresentative").val(data.contractorPersonal.contractorName);
						    		
							    	$("#contractor_contractorPhoneNumber").val(data.contractorPersonal.contractorPhoneNumber);
							    	$("#contractor_huhao").val(data.contractorPersonal.huhao);
							    	$("#contractor_isCadres").val(data.contractorPersonal.isCadres);
						    	}
						    }
						});
		        	else{
		        		$.messager.alert('提示',"请输入有效的身份证号");
		        		$("#contractor_contractorIDNO").textbox("setValue","");
		        		setInvalidStyle("contractor_contractorIDNO");
		        	}
		   		}
		   	}
		});
		
		/**
		 * 合同申请提交
		**/
		function contractApplySubmit(){
			var formmat = $("#contractRegisteration").form("validate");
			if(validateContractNo($("#contract_contractNo").textbox("getValue"))
					&&validateContractApplyRequired()&&formmat){
				$.ajax({
					type: "POST",
					url:"${ctx}/contract/create",
					data:$('#contractRegisteration').serialize(), //将Form 里的值序列化
					asyn:false,
				    error: function(jqXHR, textStatus, errorMsg) {
				    	$.messager.alert('操作结果',""+jqXHR.responseText);
				    },
				    success: function(data) {
				    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
				    		$('#mainTabs').tabs('close', "承包合同申请");
				    	});
				   }
				});   
			}
		}
		
		/**
		 * 校验必填项
		**/
		function validateContractApplyRequired(){
			var inputs = new Array("contract_contractNo",
									"contract_firstParty",
									"contract_firstPtRepresentative",
									"contract_firstPtRepresentative",
									"contract_leaseTerm",
									"contract_startDate",
									"contract_signingPrice",
									"contractor_contractorIDNO");
			var selects = new Array("contract_atCommunity",
									"contract_residentsGroup");
			if(!validateInputGroup(inputs,selects))
				$.messager.alert('提示',"请填写带*的必填项");
			return validateInputGroup(inputs,selects);
		}
		
		/**
		*承包面积校验
		**/
		
		$("#add_contractor_useArea").textbox({
			onChange:function(newV,oldV){
				if(newV == ""|| newV== null) 
		   			return ;
				var left = getCurrLeftArea(0);
				if((left - newV)<0){
					$.messager.alert('提示',"承包人承包总面积超过合同签订面积");
					$("#add_contractor_useArea").textbox("setValue","");
				}
				return;
			}
		});
		$("#contractor_contractArea").textbox({
			
			onChange:function(newV,oldV){
				if(newV == ""|| newV== null) 
		   			return ;
				var left = getCurrLeftArea(1);
				if((left - newV)<0){
					$.messager.alert('提示',"承包人承包总面积超过合同签订面积");
					$("#contractor_contractArea").textbox("setValue",""); 
				}
				return;
			}
		});
		 
		function getCurrLeftArea(k){
			var hav = 0;
			for(var i=$("#contract_contractorInfo_detail_num").val();i>=k;i--){
				if($("input[name='contractorPersonal["+i+"].contractArea").val()!=undefined)
				 hav = hav + parseFloat($("input[name='contractorPersonal["+i+"].contractArea").val());
			}
			var total = $("#contract_useArea").textbox("getValue");
			return (total - hav);
		}
		
		
		//校验详细地块面积和
		$("#add_land_landArea").textbox({
			onChange:function(newV,oldV){
				if(newV == ""|| newV== null) 
		   			return ;
				var left = getDetailAreaLeft();
				if((left - newV)<0){
					$.messager.alert('提示',"详细地块总面积超过合同签订总面积");
					$("#add_land_landArea").textbox("setValue",""); 
				}
				return;
			}
		});
		function getDetailAreaLeft(){
			var hav = 0;
			for(var i=$("#contract_landInfo_detail_num").val();i>=0;i--){
				if($("input[name='contractParcelInfo["+i+"].contractParcellArea").val()!=undefined)
				 hav = hav + parseFloat($("input[name='contractParcelInfo["+i+"].contractParcellArea").val());
			}
			var total = $("#contract_useArea").textbox("getValue");
			return (total - hav);
		}
		
		
		/**
		 * 添加地块信息
		**/
		function addDetailLandInfo(){
			$("#contract_add_land_div").show(); //先显示，再弹出
			clearLandDetailInfoDialog();
		    $("#contract_add_land_div").dialog({
		        title: "添加详细地块", 
		        width: 450, 
		        height: 200,
		        modal:true,
		        buttons:[{
					text:'添加',
					handler:function(){ 
						if(validateLandDetailInfo()){
							var map = new Map();
							map.put("code",$("#add_land_landCode").textbox("getValue"));
							map.put("typeName", $("#add_land_landType").combobox("getText"));  
							map.put("typeCode", $("input[name='add_land_landType']").val()); 
							map.put("levelCode", $("input[name='add_land_landLevel']").val()); 
							map.put("levelName", $("#add_land_landLevel").combobox("getText"));  
							map.put("area",$("#add_land_landArea").textbox("getValue"));
							map.put("plantCrops",$("#add_land_plantCrops").textbox("getValue"));
							map.put("location",$("#add_land_landLocation").textbox("getValue"));
							map.put("shiz",$("#add_land_land4direction").textbox("getValue"));
							createDetailLandInfoTd(map);
							$("#contract_add_land_div").dialog("close");
						}
					}
				},{
					text:'取消',
					handler:function(){$("#contract_add_land_div").dialog("close");}
				}]
		    });
		}
		
		function clearLandDetailInfoDialog(){
			$("#add_land_landCode").textbox("setValue","");
			$("#add_land_landLocation").textbox("setValue","");
			$("#add_land_land4direction").textbox("setValue","");
		}
		
		/**
		 *  校验地块信息必填
		 **/
		 function validateLandDetailInfo(){
			var inputs = new Array("add_land_landCode","add_land_landArea");
			var selects = new Array();
			return validateInputGroup(inputs,selects);
		}
		
		/**
		 * 生成地块信息行
		**/
		function createDetailLandInfoTd(map){
			var index = parseInt($("#contract_landInfo_detail_num").val());
			$("#contract_landInfo_detail").css("display","block");
			var newRow = "<tr>"+
					 "<td align='center'>"+map.get("code")+ 
					 	"<input type='hidden' name='contractParcelInfo["+index+"].contractParcelCode' value='"+map.get("code")+"'> </td>" +
					 "<td align='center'>"+map.get("typeName")+
					 	"<input type='hidden' name='contractParcelInfo["+index+"].contractParcelType' value='"+map.get("typeCode")+"'></td>" +
					 "<td align='center'>"+map.get("levelName")+
					 	"<input type='hidden' name='contractParcelInfo["+index+"].contractParcelLevel' value='"+map.get("levelCode")+"'></td>" +
					 "<td align='center'>"+map.get("area")+ 
						"<input type='hidden' name='contractParcelInfo["+index+"].contractParcellArea' value='"+map.get("area")+"'></td>" +
					 "<td align='center'>"+map.get("plantCrops")+ 
						"<input type='hidden' name='contractParcelInfo["+index+"].plantCrops' value='"+map.get("plantCrops")+"'></td>" +
					 "<td align='center'>"+map.get("location")+
						"<input type='hidden' name='contractParcelInfo["+index+"].contractLocation' value='"+map.get("location")+"'></td>" +
					 "<td align='center'>"+map.get("shiz")+ 
					 	"<input type='hidden' name='contractParcelInfo["+index+"].contractShiz' value='"+map.get("shiz")+"'></td>" +
					 "<td align='center'><a href='#' class='contract_apply_href' onclick='javascript:deleteCurrentObjTR(this);'>删除</a></td>"+
					 "</tr>";
			$("#contract_landInfo_detail tr:last").after(newRow);	
			$("#contract_landInfo_detail_num").val(index+1);
		}
		
		/**
		 * 删除当前行
		**/
		function deleteCurrentObjTR(obj){
			$(obj).parent().parent().remove(); 
		}
		
		/**
		 * 添加附件信息
		**/
		function addContractAttachment(){
			$("#contract_add_attachment_div").show(); //先显示，再弹出
			var id = $("input[name ='file']").attr("id");
			jksbFileUploadClear(id);
		    $("#contract_add_attachment_div").dialog({
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
						$("#contract_add_attachment_div").dialog("close");
					}
				},{
					text:'取消',
					handler:function(){$("#contract_add_attachment_div").dialog("close");}
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
				var index = parseInt($("#contract_attachment_num").val());
				$("#contract_attachment_detail").css("display","block");
				var newRow = "<tr>"+
						 "<td align='center'>"+map.get("name")+ 
						 "<input type='hidden' name='contractAttachment["+index+"].attachmentName' value='"+map.get("name")+"'>"+
						 "<input type='hidden' name='contractAttachment["+index+"].attachmentSize' value='"+map.get("size")+"'>"+
						 "<input type='hidden' name='contractAttachment["+index+"].attachmentType' value='"+map.get("type")+"'>"+
						 "<input type='hidden' name='contractAttachment["+index+"].attachmentdirection' value='"+map.get("direction")+"'></td>" +
						 "<td align='center'>"+map.get("size")+ "</td>" +
						 "<td align='center'><a href='#' class='contract_apply_href' onclick='javascript:deleteCurrentObjTR(this);'>删除</a></td>"+
						 "</tr>";
				$("#contract_attachment_detail tr:last").after(newRow);	
				$("#contract_attachment_num").val(index+1);
		}}
		
		
		/**
		 * 添加承包人信息
		**/
		function addContractorInfo(){
			$("#contract_add_contractor_div").show(); //先显示，再弹出
			clearContractorAddInfo();
		    $("#contract_add_contractor_div").dialog({
		        title: "添加承包人信息",
		        width: 500,
		        height: 200,
		        modal:true,
		        buttons:[{
					text:'添加',
					handler:function(){ 
						if(!contractorValidate($("#add_contractor_contractorIDNO").val())){
							$.messager.alert('提示',"本合同已存在该承包人。");
						}else if(contractorValidate($("#add_contractor_contractorIDNO").val())
								&&validateInputGroup(new Array("add_contractor_contractorIDNO","add_contractor_useArea"),null)){
							var map = new Map();
							map.put("typeName", $("#add_contractor_contractorIdType  option:selected").text());
							map.put("typeCode",$("input[name ='add_contractor_contractorIdType']").val());
							map.put("isStaff",$("input[name ='add_contractor_isStaff']").val()=="Y"?"是":"否");
							map.put("idNO",$("#add_contractor_contractorIDNO").val());
							map.put("name",$("#add_contractor_contractorName").val());
							map.put("area",$("#add_contractor_useArea").val());
							map.put("department",$("#add_contractor_contractorDepartment").val());
							
							map.put("addr",$("#add_contractor_contractorAddr").val());
							map.put("phone",$("#add_contractor_contractorPhoneNumber").val());
							map.put("huhao",$("#add_contractor_huhao").val());
							map.put("isCadres",$("#add_contractor_isCadres").val());
							createContractorInfoTd(map);
							$("#contract_add_contractor_div").dialog("close");
						}
					}
				},{
					text:'取消',
					handler:function(){$("#contract_add_contractor_div").dialog("close");}
				}]
		    });
		}
		
		/**
		 * 添加承包人信息展示表格
		**/
		function createContractorInfoTd(map){
			var index = parseInt($("#contract_contractorInfo_detail_num").val());
			$("#contract_contractorInfo_detail").css("display","block");
			var newRow = "<tr>"+
					 "<td align='center'>"+map.get("name")+ 
					 	"<input type='hidden' name='contractorPersonal["+index+"].contractorName' value='"+map.get("name")+"'> </td>" +
					 "<td align='center'>"+map.get("typeName")+
					 	"<input type='hidden' name='contractorPersonal["+index+"].contractParcelType' value='"+map.get("typeCode")+"'></td>" +
					 "<td align='center'>"+map.get("idNO")+
					 	"<input type='hidden' name='contractorPersonal["+index+"].contractorIDNO' value='"+map.get("idNO")+"'></td>" +
					 "<td align='center'>"+map.get("department")+ 
						"<input type='hidden' name='contractorPersonal["+index+"].contractorDepartment' value='"+map.get("department")+"'></td>" +
					 "<td align='center'>"+map.get("isStaff")+
						"<input type='hidden' name='contractorPersonal["+index+"].isStaff' value='"+map.get("isStaff")+"'></td>" +
					"<td align='center'>"+map.get("phone")+
						"<input type='hidden' name='contractorPersonal["+index+"].contractorPhoneNumber' value='"+map.get("phone")+"'></td>" +
					 "<td align='center'>"+map.get("area")+ 
						"<input type='hidden' name='contractorPersonal["+index+"].isRespOfSecPt' value='N'/>"+
						"<input type='hidden' name='contractorPersonal["+index+"].contractorAddr' value='"+map.get("addr")+"'/>"+
						"<input type='hidden' name='contractorPersonal["+index+"].huhao' value='"+map.get("huhao")+"'/>"+
						"<input type='hidden' name='contractorPersonal["+index+"].isCadres' value='"+map.get("isCadres")+"'/>"+
					 	"<input type='hidden' name='contractorPersonal["+index+"].contractArea' value='"+map.get("area")+"'></td>" +
					 	
					 "<td align='center'><a href='#' class='contract_apply_href' onclick='javascript:deleteCurrentObjTR(this);'>删除</a></td>"+
					 "</tr>";
			$("#contract_contractorInfo_detail tr:last").after(newRow);	
			$("#contract_contractorInfo_detail_num").val(index+1);
		}
		
		/**
		*添加承包人对话框 身份证号校验
		*/
		$("#add_contractor_contractorIDNO").textbox({
		   	onChange:function(newV,oldV){
		   		var isIDNO = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		   		var value =  $("input[name='add_contractor_contractorIdType']").val(); 
		   		if(newV != ""&&newV != null &&value == "IC") {
		   			var reg = new RegExp(isIDNO);
		        	if(reg.test(newV))
				   		$.ajax({
							type: "GET",
							url:"${ctx}/contract/getPeopleInfo",
							data:{idNo:newV},
							asyn:false,
						    error: function(jqXHR, textStatus, errorMsg) {
						    	$.messager.alert('操作结果',""+jqXHR.responseText);
						    },
						    success: function(data) {
						    	if(data.contractorPersonal == null){
						    		$.messager.alert('操作结果',"该人口信息不存在，请先在社区系统登记人口信息。");
						    		$('#add_contractor_contractorIDNO').textbox("setValue","");
						    	}
						    	else{
							    	$("#add_contractor_contractorName").textbox("setValue",data.contractorPersonal.contractorName);
							    	$("#add_contractor_contractorDepartment").textbox("setValue",data.contractorPersonal.contractorDepartment);
							    	$("#add_contractor_contractorAddr").textbox("setValue",data.contractorPersonal.contractorAddr);
							    	$("#add_contractor_isStaff").combobox("setValue",data.contractorPersonal.isStaff);
							    	$("#add_contractor_residentTypeCode").val(data.contractorPersonal.residentTypeCode);
							    	$("#add_contractor_residentTypeName").val(data.contractorPersonal.residentTypeName);
							    	
							    	$("#add_contractor_contractorPhoneNumber").val(data.contractorPersonal.contractorPhoneNumber);
							    	$("#add_contractor_huhao").val(data.contractorPersonal.huhao);
							    	$("#add_contractor_isCadres").val(data.contractorPersonal.isCadres);
		 				    	}
						    }
						});
		        	else{
		        		$.messager.alert('提示',"请输入有效的身份证号");
		        		$("#add_contractor_contractorIDNO").textbox("setValue","");
		        		setInvalidStyle("add_contractor_contractorIDNO");
		        	}
		   		}
		   	}
		});
		
		/**
		*清除承包人信息
		*/
		function clearContractorAddInfo(){
			$("#add_contractor_contractorIDNO").textbox("setValue","");
			$("#add_contractor_contractorName").textbox("setValue","");
			$("#add_contractor_useArea").textbox("setValue","");
			$("#add_contractor_contractorDepartment").textbox("setValue","");
			$("#add_contractor_contractorAddr").textbox("setValue","");
			
			$("#add_contractor_contractorPhoneNumber").val("");
			$("#add_contractor_huhao").val("");
			$("#add_contractor_isCadres").val("");
		}
		
		/**
		*承包人重复校验
		*/
		function contractorValidate(idNO){
			var result = true;
			if(idNO.length>0)
				for(var i=$("#contract_contractorInfo_detail_num").val();i>=0;i--)
					if( idNO == $("input[name='contractorPersonal["+i+"].contractorIDNO").val())
						result = false;
			return result;
		}
	</script>
</div>