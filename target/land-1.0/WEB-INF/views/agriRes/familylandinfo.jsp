<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	html,body,div{
		margin:0;
		padding:0;
	}
	td.query{
		font-size:12px;
		padding:0 2px;
 		text-align:center; 
	}
	.red-line-border{
		border:1px solid red;
	}
	.selfsupp_search_table{
		width:70%;
		height:40px;
		margin-left:25px;
		margin-top:10px;
	}
	td{border:solid black; border-width:1px 0px 0px 1px;}
	table{ border:none;width:70%;}
	input[type="text"]{border:0px solid #c00;color:blue;}
</style>
<script type="text/javascript">
$(function(){
	/**
		input绑定回车事件 跳下一个
	*/
	 var inputAry = $("#selfsupp_search_form").find("input[type=text]");
	$("input[type=text]:not(:disabled)").bind('keypress',function(event){
	    if(event.keyCode == "13"){
	    	  var nxtIdx = inputAry.index(this) + 1;
              $("input[type=text]:not(:disabled)").eq(nxtIdx).focus();
	    }
	});
	
	/**
	   input 重置
	*/
	$("#ssr_reset_btn").click(function(){
		$("input[type=text]").val("");
	});
	
	/**
	  表单提交
	*/
	$("#ssr_submit_btn").click(function(){
		$("input[type=text]").each(function(){
			if($(this).val()=="")
				$(this).attr("name","");
		});
		
		$.ajax({
			type: "POST",
			url:"${ctx}/agriRes/selfSupport/addLandInfo",
			data:$('#selfsupp_landInfo_form').serializeArray(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
		    		$('#mainTabs').tabs('close', "家庭用地信息调查");
		    	});
		   }
		});   
	});
	
	/*
	 * 查询调查表
	 */
	$("#landInfo_cardNo").change(function(){
		$.ajax({
			type: "GET",
			url:"${ctx}/agriRes/selfSupport/getFormBycardNo",
			data:{cardNo:$("#landInfo_cardNo").val()},
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	if(data == null||data == ""){
		    		$.messager.alert('操作结果',"该调查表信息不存在。");
		    	}else{
		    		$("#landInfo_formId").val(data.id);
		    		$("#form_isCombined").val(data.isCombined);
		    		$("#form_houseLocation").val(data.houseLocation);
		    		$("#form_researchDate").val(data.researchDate);
		    		$("#form_researchObject").val(data.researchObject);
		    		$("#form_investigator").val(data.investigator);
		    	}
		    }
		});
	});
});
</script>

<div id="container" style="width:99%;height:99%;">
<form id="selfsupp_landInfo_form">
<table id="selfsupp_search_table" class="selfsupp_search_table" border="1" cellspacing="0">
	<tr>
		<td height="12px" colspan="7" style="border:none">&nbsp;</td>
		<td height="12px" colspan="2" style="font-size:12px;border:none">
		编号：<input type="text" id="landInfo_cardNo" name="cardNo" value="" style="width:50%"/>
			 <input type="hidden" name="id" value="" id="landInfo_formId"/>
		</td>
	</tr>
	<tr>
		<td height="30px" colspan="9" align="center" style="border:none;font-size:23px;font-weight:bold;">农场职工居民家庭用地信息调查表</td>
	</tr>
	<tr>
		<td height="12px" colspan="4" style="font-size:12px;border:none;margin-top:5px;">生产队（□并场队：□难侨队）：<input type="text" id="form_isCombined" readonly="readonly"  value="" style="width:50%"/></td>
		<td height="12px" colspan="4" style="font-size:12px;border:none;margin-top:5px;">居住地址：<input type="text" id="form_houseLocation" readonly="readonly"  value="" style="width:50%"/></td>
		<td height="12px" colspan="1" style="font-size:10px;font-weight:bold;border:none;margin-top:5px;" align="center">单位：人、M²、亩</td>
	</tr>
	<tr>
		<td height="30px" colspan="9" align="center" style="font-size:16px;border-right:1px solid black;">自用土地情况</td>
	</tr>
	<tr>
		<td width="8%" height="30px" colspan="1" >土地使用人</td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].contractorName" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].contractorName" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].contractorName" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].contractorName" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].contractorName" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].contractorName" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].contractorName" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].contractorName" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td width="8%" height="30px" colspan="1" >土地来源</td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].parcelOrigin" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].parcelOrigin" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].parcelOrigin" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].parcelOrigin" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].parcelOrigin" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].parcelOrigin" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].parcelOrigin" value="" style="width:100%"/></td>
		<td width="8%"  height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].parcelOrigin" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >用地类型</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].landType" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].landType" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].landType" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].landType" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].landType" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].landType" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].landType" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].landType" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >地块编号</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].parcelCode" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >地块子号</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].subParcelCode" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >地块位置</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].location" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].location" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].location" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].location" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].location" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].location" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].location" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].location" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >自报面积</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].theySaidArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].theySaidArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].theySaidArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].theySaidArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].theySaidArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].theySaidArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].theySaidArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].theySaidArea" value="" style="width:100%;"/></td>
	</tr><tr>
		<td height="30px" colspan="1" >起始使用年份</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].startY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].startY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].startY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].startY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].startY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].startY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].startY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].startY" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >是否签订合同</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].isSigned" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].isSigned" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].isSigned" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].isSigned" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].isSigned" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].isSigned" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].isSigned" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].isSigned" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >合同约定年限</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].leaseTerm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].leaseTerm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].leaseTerm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].leaseTerm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].leaseTerm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].leaseTerm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].leaseTerm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].leaseTerm" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >合同签订面积</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].signingArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].signingArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].signingArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].signingArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].signingArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].signingArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].signingArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].signingArea" value="" style="width:100%;"/></td>
	</tr><tr>
		<td height="30px" colspan="1" >土地承包租金</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].rentalPrice" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].rentalPrice" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].rentalPrice" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].rentalPrice" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].rentalPrice" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].rentalPrice" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].rentalPrice" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].rentalPrice" value="" style="width:100%;"/></td>
	</tr><tr>
		<td height="30px" colspan="1" >核实面积</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].actualArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].actualArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].actualArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].actualArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].actualArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].actualArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].actualArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].actualArea" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >种植作物</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].plant" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].plant" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].plant" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].plant" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].plant" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].plant" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].plant" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].plant" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >是否违约使用</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[0].isBreakRule" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[1].isBreakRule" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[2].isBreakRule" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[3].isBreakRule" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[4].isBreakRule" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[5].isBreakRule" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSelfParcel[6].isBreakRule" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].isBreakRule" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="9" align="center" style="font-size:16px;border-right:1px solid black;">转包土地情况</td>
	</tr>
	<tr>
		<td height="30px" colspan="1" >原土地承包人</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].oldContrator" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].oldContrator" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].oldContrator" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].oldContrator" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].oldContrator" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].oldContrator" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].oldContrator" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].oldContrator" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >转包是否经农场同意</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].isAgreeByFarm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].isAgreeByFarm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].isAgreeByFarm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].isAgreeByFarm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].isAgreeByFarm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].isAgreeByFarm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].isAgreeByFarm" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].isAgreeByFarm" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >地块编号</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].parcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].parcelCode" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >地块子号</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].subParcelCode" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].subParcelCode" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >地块位置</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].loacation" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].loacation" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].loacation" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].loacation" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].loacation" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].loacation" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].loacation" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].loacation" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >转包面积</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].subcontractArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].subcontractArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].subcontractArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].subcontractArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].subcontractArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].subcontractArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].subcontractArea" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].subcontractArea" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >转包年份</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].subcontractY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].subcontractY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].subcontractY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].subcontractY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].subcontractY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].subcontractY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].subcontractY" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].subcontractY" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >转包租金</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].subcontractRental" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].subcontractRental" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].subcontractRental" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].subcontractRental" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].subcontractRental" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].subcontractRental" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].subcontractRental" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].subcontractRental" value="" style="width:100%;"/></td>
	</tr>
		<tr>
		<td height="30px" colspan="1" >现使用人姓名</td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[0].presentContractor" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[1].presentContractor" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[2].presentContractor" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[3].presentContractor" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[4].presentContractor" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[5].presentContractor" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" ><input type="text" id="" name="agriSubContract[6].presentContractor" value="" style="width:100%"/></td>
		<td height="30px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSubContract[7].presentContractor" value="" style="width:100%;"/></td>
	</tr>
	<tr>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;">现使用人单位</td>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[0].presentEnterprise" value="" style="width:100%"/></td>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[1].presentEnterprise" value="" style="width:100%"/></td>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[2].presentEnterprise" value="" style="width:100%"/></td>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[3].presentEnterprise" value="" style="width:100%"/></td>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[4].presentEnterprise" value="" style="width:100%"/></td>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[5].presentEnterprise" value="" style="width:100%"/></td>
		<td  height="30px" colspan="1" style="border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[6].presentEnterprise" value="" style="width:100%"/></td>
		<td  height="30px" colspan="1" style="border-right:1px solid black;border-bottom:1px solid black;"><input type="text" id="" name="agriSubContract[7].presentEnterprise" value="" style="width:100%"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="3" style="border:none;">  调查时间：<input type="text" id="form_researchDate" readonly="readonly" value="" style="width:50%"/></td>
		<td height="30px" colspan="3" style="border:none;"> 被调查人：<input type="text" id="form_researchObject" readonly="readonly" value="" style="width:50%"/></td>
		<td height="30px" colspan="3" style="border:none;">信息采集人：<input type="text" id="form_investigator" readonly="readonly"  value="" style="width:50%"/></td>
	</tr>
	<tr>
		<td height="30px" colspan="9" style="border:none;text-align:center;"> 
			<input type="button" value="提交" id="ssr_submit_btn"/>
			<input type="button" value="重置" id="ssr_reset_btn"/>
		</td>
	</tr>
	<tr>
		<td height="12px" colspan="9" style="font-size:12px;border:none;border-left:none;padding:10px 10px 10px 10px;"> 
			注：一、土地来源栏填写数字：1.自己开荒；2.与农场承包；3.转包他人土地。二、用地类型栏填写数字；1.保障用地；2.经营用地。三、地块位置栏填写生产队。四、是否签订合同栏填写数字；1.是；2.否。五、土地承包金栏填写当年土地租金单价，实物分成的，按当年应收实物折成现金。六、核实面积栏填写图解面积。七、是否违约使用填写数字；1.擅自改变土地用途；2.连续两年未足额缴交租金；3.其他；4.否。八、是否经农场同意栏填写数字；1.是；2.否。
		</td>
	</tr>
</table>
</form>	 
</div>

