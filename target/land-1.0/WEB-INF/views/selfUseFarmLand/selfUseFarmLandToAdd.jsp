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
		width:100%;
		height:40px;
		margin-left:5px;
		margin-top:10px;
	}
	td{border:solid black; border-width:1px 0px 0px 1px;}
	table{ border:none;}
	input[type="text"]{border:0px solid #c00;color:blue;}
	#sf_span_td span,#jtrk {color:blue;}
	.inValid{
		background-color:red;
	}
</style>
<script type="text/javascript">
$(function(){
	var ctx = "${ctx}";
	
	/**
	 * 社区 居民小组联动 combox
	**/
	$("#familypeople_residentsGroup").combobox({
		url:ctx+'/group/getResidentsGroupByCommunity',
	    valueField:'id',
	    textField:'text',
	    method:'GET'
	});
	$("#familypeople_atCommunity").combobox({
		url:ctx+'/community/getCommunityByFarmCode',
	    valueField:'id',
	    textField:'text',
	    method:'GET',
	   	queryParams:{"farmCode":$("#familypeople_atFarmCode").val()},
	   	onSelect:function(value){
	   		$('#familypeople_residentsGroup').combobox('clear'); 
	   		var url = ctx+'/group/getResidentsGroupByCommunity?communityCode='+value.id;
	   		$('#familypeople_residentsGroup').combobox('reload', url); 
	   	}
	});
	
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
		$("#jtrk").html(0);
		$("#sf_span_td span").each(function(){
			$(this).html(0);
		});	
	});
	
	/**
	  表单提交
	*/
	$("#ssr_submit_btn").click(function(){
		if(!isinValid()){
			$.messager.alert('提示',"红色区域填写有误。");
			return;
		}
		$("input[type=text]").each(function(){
			if($(this).val()=="")
				$(this).attr("name","");
		});
		var formData = $('#selfUseFarmLand_form').serializeArray();
	//	var data = JSON.stringify(formData);
		$.ajax({
			url:"${ctx}/selfUseFarmLand/addSelfUseFarmLand",
			type: "POST",
			//contentType : 'application/json;charset=utf-8',
			//dataType:"json",
            data: formData,
            //asyn:false,
			//data:formData, //将Form 里的值序列化
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
		    		parent.$('#mainTabs').tabs('close',"农业用地登记");
		    	});
		   }
		});   
	});
	
	
	/**
	 校验input值
	*/
	$(".validate").change(function(){
		var enumArray = $(this).attr("valueArea");
		if(!enumValidate($(this).val(),enumArray)){
			$(this).addClass("inValid");
		}else{
			$(this).removeClass("inValid");
		}
	});
	
	/**
	校验重复
	**/
	$("#num").change(function(n,v){
			var result  = true;
			if(n != null && n != "")
			$.ajax({
				type: "GET",
				url:"${ctx}/selfUseFarmLand/getFormByNum",
				data:{"num":$("#num").val()},
				asyn:false,
			    error: function(jqXHR, textStatus, errorMsg) {
			    	$.messager.alert('操作结果',""+jqXHR.responseText);
			    },
			    success: function(data) {
			    	if(data == null||data == ""){
			    		$("#num").removeClass("inValid");
			    		$("#ssr_submit_btn").attr("disabled",false);
			    	}else{
			    		$.messager.alert('提示',"该编号已经存在");
			    		$("#num").addClass("inValid");
			    		$("#ssr_submit_btn").attr("disabled",true);
			    		result = false;
			    	} 
			    }
			}); 
			return result;
	});
});

function isinValid(){
	var result = true;
	$(".validate").each(function(){
		if($(this).attr("class").indexOf("inValid")>0)
			result = false;
	});
	return result;
}

</script>

<div id="container" style="width:99%;height:99%;">
<form id="selfUseFarmLand_form" >
<table id="selfUseFarmLand_table" class="selfsupp_search_table" border="1" cellspacing="0">
	<tr>
		<td height="12px" colspan="4" style="border:none">&nbsp;</td>
		<td height="12px" colspan="1" style="font-size:12px;border:none">编号：<input id="num" type="text"  name="num"  style="border:none;border-bottom:black solid 1px;width:50%"/></td>
	</tr>
	<tr>
		<td width="100%" height="20px" colspan="5" align="center" style="border:none;font-size:23px;font-weight:bold;">农场自用农业用地信息登记表</td>
	</tr>
	<tr>
		<td height="12px" colspan="26" style="font-size:12px;border:none;margin-top:5px;">
			土地所属社区：
			<input id="familypeople_atFarmCode" type="hidden" value="${farmCode }"/>
			<input id="familypeople_atCommunity" name="communityNum" value="${communityNum }" style="border:0;border-bottom:1 solid black;background:#000000;width:120px;"/>
		</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">宗地编号</td>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">土地面积</td>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">土地位置</td>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">现状作物</td>
		<td  height="20px" colspan="1" align="center" style="border-right:1px solid black;font-size:16px;">备注</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[0].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[0].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[0].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[0].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[0].remark" class="personStatus validate"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[1].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[1].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[1].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[1].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[1].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[2].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[2].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[2].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[2].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[2].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[3].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[3].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[3].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[3].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[3].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[4].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[4].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[4].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[4].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[4].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[5].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[5].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[5].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[5].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[5].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[6].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[6].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[6].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[6].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[6].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr><tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[7].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[7].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[7].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[7].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[7].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr><tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[8].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[8].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[8].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[8].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[8].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr><tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[9].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[9].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[9].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[9].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[9].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr><tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[10].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[10].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[10].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[10].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[10].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr><tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[11].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[11].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[11].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[11].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[11].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr><tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[12].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[12].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[12].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[12].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[12].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr><tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[13].landNum"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[13].landArea"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[13].landLocation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[13].currentCrop"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[13].remark" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[14].landNum"  style="border-bottom:1px solid black;width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[14].landArea"  style="border-bottom:1px solid black;width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[14].landLocation"  style="border-bottom:1px solid black;width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="selfUseFarmLand[14].currentCrop"  style="border-bottom:1px solid black;width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="selfUseFarmLand[14].remark"   style="border-bottom:1px solid black;width:100%" class="personStatus validate" valueArea="1,2,3,4,5,6,7"/></td>
	</tr>
	<tr>
		<td height="20px" colspan="5" style="border:none;text-align:center;"> 
			<input type="button" value="提交" id="ssr_submit_btn"/>
			<input type="button" value="重置" id="ssr_reset_btn"/>
		</td>
	</tr>
	<tr>
		<td height="12px" colspan="5" style="font-size:12px;border:none;border-left:none;padding:10px 10px 10px 10px;"> 
		&nbsp;&nbsp;<b>说明：</b>宗地编号格式：农场编号（3位）+社区编号（2位）+地块编号（4位），农场编号及社区编号由总局提供，地块编号由农场自定义编制。
		</td>
	</tr>
</table>
</form>	 
</div>

