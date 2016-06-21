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
		$.ajax({
			type: "POST",
			url:"${ctx}/agriRes/selfSupport/createForm",
			data:$('#selfsupp_search_form').serializeArray(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
		    		$('#mainTabs').tabs('close', "家庭人口信息调查");
		    	});
		   }
		});   
	});
	
	/**
	 * 统计家庭人口
	 */
	 $(".personStatus").change(function(){
		var total = 0;
		$("#sf_span_td span").each(function(){
			$(this).html(0);
		});	 
	 	$(".personStatus").each(function(){
			var num = parseInt($("#sf"+$(this).val()).html());
			$("#sf"+$(this).val()).html(num+1);
		});
	 	$("#sf_span_td span").each(function(){
	 		var num = parseInt($(this).html());
	 		total += num;
		});	
	 	$("#jtrk").html(total);
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
	$("#cardNo").change(function(n,v){
			var result  = true;
			if(n != null && n != "")
			$.ajax({
				type: "GET",
				url:"${ctx}/agriRes/selfSupport/getFormBycardNo",
				data:{"cardNo":$("#cardNo").val()},
				asyn:false,
			    error: function(jqXHR, textStatus, errorMsg) {
			    	$.messager.alert('操作结果',""+jqXHR.responseText);
			    },
			    success: function(data) {
			    	if(data == null||data == ""){
			    		$("#cardNo").removeClass("inValid");
			    	}else{
			    		$.messager.alert('提示',"该编号已经存在");
			    		$("#cardNo").addClass("inValid");
			    		result =false;
			    		
			    	} 
			    }
			}); 
			return result;
	});
	
	$(".persionId").change(function(){
		    var newV = $(this).val();
		    
		    alert($(this).attr("name").replace(/[^0-9]+/g,''));
	   		var isIDNO = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	   		if(newV != null && newV !=""){
	   			var reg = new RegExp(isIDNO);
	        	if(reg.test(newV))
		   			$.ajax({
						type: "GET",
						url:"${ctx}/agriRes/selfSupport/getPeopleInfo",
						data:{idNo:newV},
						asyn:false,
					    error: function(jqXHR, textStatus, errorMsg) {
					    	$.messager.alert('操作结果',""+jqXHR.responseText);
					    },
					    success: function(data) {
					    	if(data.contractorPersonal == null){
					    		$.messager.alert('操作结果',"该人口信息不存在，请先在社区登记人口信息。");
					    		$(this).val("");
					    	}else{
						    	$("#agriPerson[0].personName").val(data.person.personName);
					    	}
					    }
					});
	        	else{
	        		$.messager.alert('提示',"请输入有效的身份证号");
	        		$(this).val("");
	        	}
	   		}
	   	}
	);
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
<form id="selfsupp_search_form" >
<table id="selfsupp_search_table" class="selfsupp_search_table" border="1" cellspacing="0">
	<tr>
		<td height="12px" colspan="15" style="border:none">&nbsp;</td>
		<td height="12px" colspan="3" style="font-size:12px;border:none">编号：<input id="cardNo" type="text"  name="cardNo"  style="width:50%"/></td>
	</tr>
	<tr>
		<td width="100%" height="20px" colspan="18" align="center" style="border:none;font-size:23px;font-weight:bold;">农场职工居民家庭人口信息调查表</td>
	</tr>
	<tr>
		<td height="12px" colspan="6" style="font-size:12px;border:none;margin-top:5px;">
			生产队（□并场队：□难侨队）：<!-- <input type="text"  name="isCombined"  style="width:50%"/> -->
			<input id="familypeople_atFarmCode" type="hidden" value="${farmCode }"/>
			<input id="familypeople_atCommunity" name="atCommunity" value="" style="width:80px;"/>
			<input id="familypeople_residentsGroup" name="residentsGrpCode" value="${residentsGrpCode }" style="width:80px;"/> 
		</td>
		<td height="12px" colspan="9" style="font-size:12px;border:none;margin-top:5px;">居住地址：<input type="text"  name="houseLocation"  style="width:50%"/></td>
		<td height="12px" colspan="3" style="font-size:10px;font-weight:bold;border:none;margin-top:5px;" align="center">单位：人、M²、亩</td>
	</tr>
	<tr>
		<td width="100%" height="20px" colspan="18" align="center" style="font-size:16px;border-right:1px solid black;">家庭信息</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">户主</td>
		<td  height="20px" colspan="2" align="center" style="font-size:16px;"><input type="text"  name="familyHost"  style="width:100%"/></td>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">户号</td>
		<td  height="20px" colspan="2" align="center" style="font-size:16px;"><input type="text"  name="familyNo"  style="width:100%"/></td>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">家庭电话</td>
		<td  height="20px" colspan="2" align="center" style="font-size:16px;"><input type="text"  name="telephoneNumber"  style="width:100%"/></td>
		<td  height="20px" colspan="4" align="center" style="font-size:16px;">户口所在派出所</td>
		<td  height="20px" colspan="5" align="center" style="font-size:16px;border-right:1px solid black;"><input type="text"  name="familyLocation"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="18" align="center" style="font-size:16px;border-right:1px solid black;">家庭成员信息（含户主）</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" align="center" style="font-size:14px;">
			家庭人口 <span id="jtrk">0</span> 人
		</td>
		<td id="sf_span_td" height="40px" colspan="17" align="left" style="font-size:14px;border-right:1px solid black;">
			在册在岗（管理人员）<span id="sf1">0</span>人；在册在岗（工人）<span id="sf2">0</span>人；
			在册不在岗（领取生活费）<span id="sf3">0</span>人；在册不在岗（不领生活费用）<span id="sf4">0</span>人；
			离退休<span id="sf5">0</span>人；非职工居民（18岁以下）<span id="sf6">0</span>人；
			非职工居民（女的49岁、男的59岁以下）<span id="sf7">0</span>人；
			非职工居民（女的50岁、男的60岁以上）<span id="sf8">0</span>人 
		</td>
	</tr>
	<tr>
		<td width="15%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">姓名</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">性别</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">民族</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">年龄</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">身份</td>
		<td width="30%" height="20px" colspan="6" rowspan="2" align="center" style="font-size:16px;">身份证号码</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">与户主关系</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">学历</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">婚姻状况</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">现居住地</td>
		<td width="10%" height="20px" colspan="2" rowspan="1" align="center" style="font-size:16px;">是否长期居住农场</td>
		<td width="5%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;border-right:1px solid black;">是否使用土地</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1"  rowspan="1" align="center" style="font-size:16px;">&nbsp;是&nbsp;</td>
		<td  height="20px" colspan="1"  rowspan="1" align="center" style="font-size:16px;">离场时间</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].personStatus" class="personStatus validate" valueArea="1,2,3,4,5,6,7" style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[0].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].familyRelationship" class="validate" valueArea="1,2,3,4,5,6,7,8,9,10" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].education"  class="validate" valueArea="1,2,3,4" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].married"  class="validate" valueArea="1,2,3,4" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].currentResident" class="validate" valueArea="1,2,3,4,5,6" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].isLiveInFarm" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[0].leaveTime"  class="validate" valueArea="1,2,3" style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[0].hasLand"  class="validate" valueArea="1,2,3,4,5" style="width:100%"/></td>
	</tr>
    <tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[1].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[1].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[1].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[2].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[2].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[2].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[3].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[3].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[3].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[4].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[4].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[4].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[5].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[5].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[5].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[6].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[6].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[6].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[7].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[7].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[7].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text"  name="agriPerson[8].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text"  name="agriPerson[8].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text"  name="agriPerson[8].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].personName"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].personSex"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].personNation"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].personAge"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].personStatus" class="personStatus"    style="width:100%"/></td>
		<td  height="20px" colspan="6" style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].persionId" class="persionId"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].familyRelationship"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].education"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].married"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].currentResident"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].isLiveInFarm"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].leaveTime"  style="width:100%"/></td>
		<td  height="20px" colspan="1"  style="border-right:1px solid black;border-bottom:1px solid black;"><input type="text"  name="agriPerson[9].hasLand"  style="width:100%"/></td>
	</tr>
	<tr>
		<td height="20px" colspan="6" style="border:none;">调查时间：<input name="researchDate"  class="easyui-datebox" style="width:120px;" value="${date }"/></td>
		<td height="20px" colspan="6" style="border:none;">被调查人：<input type="text"  name="researchObject"  style="width:50%"/></td>
		<td height="20px" colspan="6" style="border:none;">信息采集人：<input type="text"  name="investigator"  style="width:50%"/></td>
	</tr>
	<tr>
		<td height="20px" colspan="18" style="border:none;text-align:center;"> 
			<input type="button" value="提交" id="ssr_submit_btn"/>
			<input type="button" value="重置" id="ssr_reset_btn"/>
		</td>
	</tr>
	<tr>
		<td height="12px" colspan="18" style="font-size:12px;border:none;border-left:none;padding:10px 10px 10px 10px;"> 
		&nbsp;&nbsp;<b>填报说明：</b>一、已故人员不列入调查对象；户主已故的，由配偶或子女作为户主。
	         二、 居住情况①.房屋类型填写数字：1.钢混、2.砖混、3.砖木、4.简易、5.其他；②.房屋面积填写具体；③.占地面积填写具体面积。
	         三、身份栏填写数字；1.在册在岗（管理人员）；2.在册在岗（工人）；3.在册不在岗（领生活费用）；4.在册不在岗（不领生活费用）；4.离退休；5.非职工居民（18岁以下）；6.非职工居民（女的50岁、男的60岁以下）；7.非职工居民（女的50岁、男的60岁以上）。
	         四、户主关系栏填写数字；1.户主；2.配偶；3.子；4.女；5.孙子、孙女或外孙子、外孙女；6.父母；7.祖父母或外祖父母；8.兄弟姐妹；9.儿媳；10.其它。
	         五、学历栏填写数字；1.本科以上；2.专科；3.中专、技校、高中；4.初中以下。
	         六、婚姻状况填写数字；1.已婚；2.未婚；3.离异；4.丧偶。
	         七、现居住地栏填写数字；1.本场；2.本市县；3.本省；4.省外；5.境外；6国外。
	         八、是否长期居住农场栏，长期居住农场的，填写是，长期不居住农场的，填写数字；1.离场时间达2-5年；2.6-10年；3.超过10年。
	         九、是否使用土地栏填写数字；1.使用本农场土地；2.使用外农场土地；3.使用海胶基地分公司土地；4.垦区外土地；5.没有使用土地。
		</td>
	</tr>
</table>
</form>	 
</div>

