<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.contractDetailInfoBody{
		font-family:"Microsoft Yahei";
	}
	.contractDetailInfo_data_td{
		width:210px;
		align:left;
		min-width:130px;
		height:25px;
	}
	.contractDetailInfo_title_td{
		width:100%;
		align:left;
	}
	.contractDetailInfo_blank_td{
		width:20px;
		BORDER-BOTTOM:none;
	}
	.contractDetailInfo_info_panel{
		width:100%;
		margin-top:15px;
		border:none;
	}

	.contractDetailInfo_table{
		width:100%;
		height:auto;
		font-size: 12px;
		cellspacing:0;
		cellpadding:0;
		border-collapse:collapse; 
	}
	
	.contractDetailInfo_table tr  td{ 
		border:1px solid #95B8E7;
	}
	
	.contractDetailInfo_table tr  td{ 
		border:1px solid #95B8E7;
	}
	
	.contractDetailInfo_table_head{
		text-align:center;
	}
	
	.required{
		color:red;
	}
	
	.td_title{
		width:70px;
		text-align:center;
	}
	.contractDetailInfo_td_title{
		width:120px;
		text-align:center;
	}
</style>
<div class="contractDetailInfoBody" sytle="min-width:600px;width:100%;padding-top:10px;text-align:center;">
		<div id="contractDetailInfoDiv" class="easyui-layout" style="width:860px;margin:0 auto">
			<div class="easyui-panel"
		    		style="width:100%;margin-top:5px;text-align:center;border:none;font-size:18px;font-weight:bold;">
		    	承包合同
		    </div>
		    <div class="easyui-panel" style="width:100%;margin-top:1px;border:none;">
		    	<table style="width:100%; ">
					<tr>
						<td width="60%" align="left" >
							<span style="font-weight:bold;">合同编码:</span>${contract.contractCode }
						</td>
						<td width="40%" align="right">
							<span style="font-weight:bold;">申请日期:</span>
							<fmt:parseDate value="${contract.dateOfSigning }" var="signDate" type="date"/>  
							 <fmt:formatDate value="${signDate }" type="date"/> 
						</td>
					</tr>
				</table>
			</div>
		<div id="contractDetailInfoContainer" class="easyui-panel"	style="width:100%;margin-top:1px;border:none;">
		    <div  class="easyui-panel contractDetailInfo_info_panel"	style="width:100%;margin-top:1px;">
		    	<table  class="contractDetailInfo_table">
		    		<tr>
						<td class="contractDetailInfo_title_td" colspan="8">
							<span style="font-weight:bold;">基本信息</span>
						</td>
					</tr>
					<tr>
						<td class="contractDetailInfo_td_title">
							<b class="required">*</b>合同编号
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.contractNo } 
						</td>
						<td class="contractDetailInfo_td_title">
							合同甲方
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.firstParty } 
						</td>
						<td class="contractDetailInfo_td_title">
							<b class="required">*</b>甲方法人
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.firstPtRepresentative } 
						</td>
						<td class="contractDetailInfo_td_title">
							<b class="required">*</b>保障地面积
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.affordableArea } 
						</td>
					</tr>
					<tr>
						<td class="contractDetailInfo_td_title">
							所在农场
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.firstParty  } 
						</td>
						<td class="contractDetailInfo_td_title">
							<b class="required">*</b>所在社区
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.residentsGroup.communityEntity.communityName } 
						</td>
						<td class="contractDetailInfo_td_title">
							<b class="required">*</b>居民小组
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.residentsGroup.residentsGrpName } 
						</td>
						<td class="contractDetailInfo_td_title">
							签订地址
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.signingAddress } 
						</td>
					</tr>
					<tr>
						<td class="contractDetailInfo_td_title">
						<b class="required">*</b>承包期限
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.leaseTerm } 
						</td>
						<td class="contractDetailInfo_td_title">
							<b class="required">*</b>起始时间
						</td>
						<td class="contractDetailInfo_data_td">
							 <fmt:parseDate value="${contract.startDate }" var="startDate" type="date"/>  
							 <fmt:formatDate value="${startDate }" type="date"/> 
						</td>
						<td class="contractDetailInfo_td_title">
							到期时间
						</td>
						<td class="contractDetailInfo_data_td">
							 <fmt:parseDate value=" ${contract.expiredDate  }" var="expiredDate" type="date"/>
							  <fmt:formatDate value="${expiredDate }" type="date"/> 
						</td>
						<td class="contractDetailInfo_data_td"  colspan="2">
						</td>
					</tr>
				</table>
		    </div>
		    <div  class="easyui-panel contractDetailInfo_info_panel">
		    	<table class="contractDetailInfo_table" >
		    		<tr>
						<td class="contractDetailInfo_title_td" colspan="8" >
							<span style="font-weight:bold;">租金信息</span>
						</td>
					</tr>
					<tr>
						<td class="contractDetailInfo_td_title">
							<span class="contractDetailInfo_td_title"><b class="required">*</b>签订单价</span>
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.signingPrice } 元/亩
						</td>
						<td class="contractDetailInfo_td_title">
							<span class="contractDetailInfo_td_title"><b class="required">*</b>阶梯计价</span>
						</td>
						<td class="contractDetailInfo_data_td">
								<jksb:diction id="contractDetailInfo_isStepedCount" name="isStepedCount" groupId="PUB_SELECT" display="Y" dictValue="${contract.isStepedCount }">
								</jksb:diction>
						</td>
						<td class="contractDetailInfo_td_title">
							<span class="contractDetailInfo_td_title"><b class="required">*</b>定期递增</span>
						</td>
						<td class="contractDetailInfo_data_td">
								<jksb:diction id="contractDetailInfo_isRegularlyRaise" name="isRegularlyRaise" groupId="PUB_SELECT"  style="width:120px" dictValue="${contract.isRegularlyRaise }"  display="Y"  >
								</jksb:diction>
						</td>
						<td class="contractDetailInfo_td_title">
							<span class="contractDetailInfo_td_title">5年上涨率</span>
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.ratePerFiveYear }%
						</td>
					</tr>
				</table>
		    </div>
		    <div  class="easyui-panel contractDetailInfo_info_panel" >
		    	<table class="contractDetailInfo_table" >
		    		<tr>
						<td class="contractDetailInfo_title_td" colspan="8" >
							 <span style="font-weight:bold;">地块概括信息 </span>
						</td>
					</tr>
					<tr>
						<td class="contractDetailInfo_td_title">
							 <b class="required">*</b>土地等级 
						</td>
						<td class="contractDetailInfo_data_td">
							<jksb:diction id="contractDetailInfo_landLevel" name="landLevel" groupId="CONTRACT_LAND_LEVEL"  display="Y"  dictValue="${contract.landLevel }">
							</jksb:diction>
						</td>
						<td class="contractDetailInfo_td_title">
							 <b class="required">*</b>土地类型 
						</td>
						<td class="contractDetailInfo_data_td">
							<jksb:diction id="contractDetailInfo_landType" name="landType" groupId="CONTRACT_LAND_TYPE"   display="Y"  dictValue="${contract.landType }">
							</jksb:diction>
						</td>
						<td class="contractDetailInfo_td_title">
							 <b class="required">*</b>承包面积 
						</td>
						<td class="contractDetailInfo_data_td">
							  ${contract.useArea }  亩
						</td>
						<td class="contractDetailInfo_td_title">
							 土地座落 
						</td>
						<td class="contractDetailInfo_data_td">
							 ${contract.landLocation } 
						</td>
					</tr>
					<tr>
						<td class="contractDetailInfo_td_title" >
							 土地四至 
						</td>
						<td class="contractDetailInfo_data_td"  align="left"  colspan="7">
							 ${contract.landExtend } 
						</td>
					</tr>
					<tr>
						<td align="left"  colspan="8">
							  <span style="font-weight:bold;"> 详细地块信息</span>
						</td>
					</tr>
					<tr>
						<td align="left"  colspan="8">
							<table id="contractDetailInfo_landInfo_detail" class="contractDetailInfo_table" >
								<tr>
								   <td width="80px" class="contractDetailInfo_table_head">地块编号</td>
								   <td width="80px" class="contractDetailInfo_table_head" >地块类型</td>
								   <td width="80px" class="contractDetailInfo_table_head" >地块等级</td>
								   <td width="100px" class="contractDetailInfo_table_head" >地块面积(亩)</td>
								   <td width="80px" class="contractDetailInfo_table_head" >种植作物</td>
								   <td width="180px" class="contractDetailInfo_table_head" >地块座落</td>
								   <td width="300px" class="contractDetailInfo_table_head" >地块四至</td>
								</tr>
								<c:forEach items="${contract.contractParcelInfo}" var="contractParcelInfo"> 
							    	<tr>
									   <td class="contractDetailInfo_table_head">
										${contractParcelInfo.contractParcelCode} 
									   </td>
									   <td class="contractDetailInfo_table_head">
										<jksb:diction name="landType" groupId="CONTRACT_LAND_TYPE" display="Y"  dictValue="${contractParcelInfo.contractParcelType == null?'null': (contractParcelInfo.contractParcelType)}" >
										</jksb:diction>
									   </td>
									   <td class="contractDetailInfo_table_head">
									    <jksb:diction name="landLevel" groupId="CONTRACT_LAND_LEVEL"  display="Y"  dictValue="${contractParcelInfo.contractParcelLevel == null?'null': contractParcelInfo.contractParcelLevel}">
										</jksb:diction>
									   </td>
									   <td class="contractDetailInfo_table_head">
									   	  ${contractParcelInfo.contractParcellArea} 
										
									   </td>
									   <td class="contractDetailInfo_table_head">
									  	  ${contractParcelInfo.plantCrops} 
									   </td>
									   <td class="contractDetailInfo_table_head">
									       ${contractParcelInfo.contractLocation} 
									   </td>
									   <td class="contractDetailInfo_table_head">
									   	  ${contractParcelInfo.contractShiz} 
									   </td>
									</tr>
									</c:forEach> 
							</table>
						</td>
					</tr>
				</table>
		    </div>
		    <div class="easyui-panel contractDetailInfo_info_panel" >
		    	<table class="contractDetailInfo_table" >
		    		<tr>
						<td class="contractDetailInfo_title_td" colspan="4">
							<span style="font-weight:bold;">承包人信息</span>
						</td>
					</tr>
					<tr>
						<td width="840px" align="left"  colspan="3">
							<table id="contractDetailInfo_contractorInfo_detail" class="contractDetailInfo_table"  >
								<tr>
								   <td width="100px" class="contractDetailInfo_table_head">承包人姓名</td>
								   <td width="80px" class="contractDetailInfo_table_head" >证件类型</td>
								   <td width="230px" class="contractDetailInfo_table_head" >证件号码</td>
								   <td width="230px" class="contractDetailInfo_table_head" >工作单位</td>
								   <td width="80px" class="contractDetailInfo_table_head" >是否职工</td>
								   <td width="150px" class="contractDetailInfo_table_head" >联系电话</td>
								   <td width="100px" class="contractDetailInfo_table_head" >承包面积(亩)</td>
								</tr>
									<c:forEach items="${contract.contractorPersonal}" var="contractorPersonal"> 
									<tr>
										<td class="contractDetailInfo_table_head">
											${contractorPersonal.contractorName} 
										</td>
										<td class="contractDetailInfo_table_head">
											<jksb:diction name="idType" groupId="PUB_ID_TYPE"  display="Y" dictValue="${contractorPersonal.contractorIdType}">
											</jksb:diction>
										</td>
										<td class="contractDetailInfo_table_head">
											${contractorPersonal.contractorIDNO} 
										</td>
										<td class="contractDetailInfo_table_head">
											 ${contractorPersonal.contractorDepartment} 
										</td>
										<td class="contractDetailInfo_table_head">
											 <jksb:diction  name="isStaff" groupId="PUB_SELECT"  display="Y"  dictValue="${contractorPersonal.isStaff}">
											 </jksb:diction>
										</td>
										<td class="contractDetailInfo_table_head">
											 ${contractorPersonal.contractorPhoneNumber} 
										</td>
										<td class="contractDetailInfo_table_head">
											${contractorPersonal.contractArea} 
										</td>
									</tr>
								</c:forEach> 
							</table>
						</td>
					</tr>
				</table>
		    </div>
		    <div  class="easyui-panel contractDetailInfo_info_panel" style="margin-bottom:25px;">
		    	<table class="contractDetailInfo_table" >
		    		<tr>
						<td class="contractDetailInfo_title_td" colspan="5"> 
							<span style="font-weight:bold;">补充附加信息</span>
						</td>
					</tr>
			    	<tr>
		    			<td class="contractDetailInfo_td_title" >
							 补充条款 
						</td>
						<td class="contractDetailInfo_blank_td" colspan="4">
							 ${contract.supplementaryProvisions } 
						</td>
					</tr>
					<tr>
		    			<td class="contractDetailInfo_td_title" >
							 附件信息 
						</td>
						<td width="696px" align="left"  colspan="4">
							<table class="contractDetailInfo_table"  >
								<tr>
								   <td width="80%" class="contractDetailInfo_table_head" >附件名称</td>
								   <td width="20%" class="contractDetailInfo_table_head" >附件大小</td>
								</tr>
									<c:forEach items="${contract.contractAttachment}" var="contractAttachment"> 
										<tr>
										   <td>
											${contractAttachment.attachmentName} 
										   </td>
										   <td>
										    ${contractAttachment.attachmentLong}
										   </td>
										</tr>
									</c:forEach> 
							</table>
						</td>
					</tr>
				</table>
			</div>
		    
		 </div>
		 <div  class="easyui-panel" style="width:100%;height:40px;margin-top:15px;text-align:center;border:none;">
	    	 <a class="easyui-linkbutton" href="#" id="contractDetailInfoPageCloseButton"  >&nbsp;关&nbsp;闭&nbsp;</a>
	     </div>
		</div> 
	 
	<script type="text/javascript">
		$("#contractDetailInfoPageCloseButton").click(function(){
			$("#contractQueryDetailInfoDialog").dialog("close");
		});
		$(function(){
			$('#contractDetailInfoDiv input').attr("disabled","disabled");
		});
	</script>
	</div>
