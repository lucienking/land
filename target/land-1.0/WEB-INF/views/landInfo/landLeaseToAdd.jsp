<%@ page language="java" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
html, body, div {
	margin: 0;
	padding: 0;
}

td.query {
	font-size: 12px;
	padding: 0 2px;
	text-align: center;
}

.red-line-border {
	border: 1px solid red;
}

.landLease_table {
	width: 100%;
	height: 40px;
	margin-left: 150px;
	margin-top: 10px;
}

td {
	border: solid black;
	border-width: 1px 0px 0px 1px;
}

table {
	border: none;
}

input[type="text"] {
	border: 0px solid #c00;
	color: blue;
}

#sf_span_td span, #jtrk {
	color: blue;
}

.inValid {
	background-color: red;
}
</style>
<script type="text/javascript">
	$(function() {
		var ctx = "${ctx}";

		/**
		 * 社区 居民小组联动 combox
		 **/
		$("#familypeople_residentsGroup").combobox({
			url : ctx + '/group/getResidentsGroupByCommunity',
			valueField : 'id',
			textField : 'text',
			method : 'GET'
		});
		$("#familypeople_atCommunity")
				.combobox(
						{
							url : ctx + '/community/getCommunityByFarmCode',
							valueField : 'id',
							textField : 'text',
							method : 'GET',
							queryParams : {
								"farmCode" : $("#familypeople_atFarmCode")
										.val()
							},
							onSelect : function(value) {
								$('#familypeople_residentsGroup').combobox(
										'clear');
								var url = ctx
										+ '/group/getResidentsGroupByCommunity?communityCode='
										+ value.id;
								$('#familypeople_residentsGroup').combobox(
										'reload', url);
							}
						});

		/**
			input绑定回车事件 跳下一个
		 */
		var inputAry = $("#selfsupp_search_form").find("input[type=text]");
		$("input[type=text]:not(:disabled)").bind('keypress', function(event) {
			if (event.keyCode == "13") {
				var nxtIdx = inputAry.index(this) + 1;
				$("input[type=text]:not(:disabled)").eq(nxtIdx).focus();
			}
		});

		/**
		   input 重置
		 */
		$("#ssr_reset_btn").click(function() {
			$("input[type=text]").val("");
			$("#jtrk").html(0);
			$("#sf_span_td span").each(function() {
				$(this).html(0);
			});
		});

		/**
		  表单提交
		 */
		$("#ssr_submit_btn").click(
				function() {
					if (!isinValid()) {
						$.messager.alert('提示', "红色区域填写有误。");
						return;
					}
					if($('#num').val()==""){
						$.messager.alert('提示', "请输入编号！！！");
						return 
					}
					$("input[type=text]").each(function() {
						if ($(this).val() == ""){
							$(this).attr("name", "");
						}
					});
					var formData = $('#landLease_search_form').serializeArray();
					$.ajax({
						type : "POST",
						url : "${ctx}/LandLease/addLandLease",
						data : formData, //将Form 里的值序列化
						asyn : false,
						error : function(jqXHR, textStatus, errorMsg) {
							$.messager.alert('操作结果', "" + jqXHR.responseText);
						},
						success : function(data) {
							$.messager.alert('操作结果', "" + data.message + "",
									"info", function(r) {
										parent.$('#mainTabs')
												.tabs('close', "外单位（个人）土地租赁信息登记表");
									});
						}
					});
				});

		/**
		 校验input值
		 */
		$(".validate").change(function() {
			var enumArray = $(this).attr("valueArea");
			if (!enumValidate($(this).val(), enumArray)) {
				$(this).addClass("inValid");
			} else {
				$(this).removeClass("inValid");
			}
		});

		/**
		校验重复
		 **/
		$("#num").change(function(n, v) {
			var result = true;
			if (n != null && n != "")
				$.ajax({
					type : "GET",
					url : "${ctx}/LandLease/getFormByNum",
					data : {
						"num" : $("#num").val()
					},
					asyn : false,
					error : function(jqXHR, textStatus, errorMsg) {
						$.messager.alert('操作结果', "" + jqXHR.responseText);
					},
					success : function(data) {
						if (data == null || data == "") {
							$("#ssr_submit_btn").attr('disabled', false);
							$("#num").removeClass("inValid");
						} else {
							$.messager.alert('提示', "该编号已经存在");
							$("#ssr_submit_btn").attr('disabled', true);
							$("#num").addClass("inValid");
							result = false;

						}
					}
				});
			return result;
		});

		$('#identityNo').change(function(n,v) {
			if (n != null && n != ""){
			var identityNo = $('#identityNo').val();
			if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(identityNo))) {
				alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。');
				$("#identityNo").addClass("inValid");
				$("#ssr_submit_btn").attr('disabled', true);
				return false;
			}else{
				$("#identityNo").removeClass("inValid");
				}
			}
		});
	});
		function keyPress(){
			var keyCode = event.keyCode;    
		     if ((keyCode >= 48 && keyCode <= 57))    
		    {    
		         event.returnValue = true;    
		     } else {    
		           event.returnValue = false;    
		    }    
		}

	function isinValid() {
		var result = true;
		$(".validate").each(function() {
			if ($(this).attr("class").indexOf("inValid") > 0)
				result = false;
		});
		return result;
	}
</script>

<div id="container" style="width: 80%; height: 99%;">
	<form id="landLease_search_form">
		<table id="landLease_table" class="landLease_table" border="1"
			cellspacing="0">
			<tr>
				<td height="12px" colspan="6" style="border: none">&nbsp;</td>
				<td height="12px" colspan="2" style="font-size: 12px; border: none">编号：<input
					id="num" type="text" name="num"
					style="border: none; border-bottom: black solid 1px; width: 50%" /></td>
			</tr>
			<tr>
				<td width="100%" height="20px" colspan="8" align="center"
					style="border: none; font-size: 23px; font-weight: bold;">外单位（个人）土地租赁信息登记表</td>
			</tr>
			<tr>
				<td width="100%" height="12px" colspan="6"
					style="font-size: 12px; border: none; margin-top: 5px;">
					土地所属社区： <input id="familypeople_atFarmCode" type="hidden"
					value="${farmCode }" /> <input id="familypeople_atCommunity"
					name="communityNum" value="" style="width: 120px;" />
				</td>
			</tr>
			<tr>
				<td width="100%" height="12px" colspan="6"
					style="font-size: 12px; border: none; margin-top: 5px;">
					单位(居住)地址： <input id="orgAddress " type="text" name="orgAddress"
					style="border: none; border-bottom: black solid 1px; width: 50%" />
				</td>
			</tr>
			<tr>
				<td height="20px" colspan="2" align="center"
					style="font-size: 16px;">姓名</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">性别</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">民族</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">年龄</td>
				<td height="20px" colspan="3" align="center"
					style="font-size: 16px; border-right: 1px solid black;">身份证号码</td>
			</tr>
			<tr>
				<td height="20px" colspan="2" align="center"
					style="font-size: 16px;"><input type="text" name="name"
					style="font-size: 16px; width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text" name="sex"
					id="sex" style="font-size: 16px; width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text" name="nation"
					id="nation" style="font-size: 16px; width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text" name="age"
					style="font-size: 16px; width: 100%;ime-mode:disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /></td>
				<td height="20px" colspan="3" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input id="identityNo"
					type="text" name="identityNo" style="font-size: 16px; width: 100%;" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="2" align="center"
					style="font-size: 14px;">单位名称</td>
				<td height="20px" colspan="3" align="center"
					style="font-size: 14px;"><input type="text" name="companyName"
					style="font-size: 14px; width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;">组织机构代码</td>
				<td height="20px" colspan="2" align="center"
					style="font-size: 14px; border-right: 1px solid black;"><input
					type="text" name="orgCode" style="font-size: 14px; width: 100%;" /></td>
			</tr>
			<tr>
				<td height="14px" colspan="2" align="center"
					style="font-size: 14px;">合同签订面积</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;"><input type="text"
					name="contractArea" style="font-size: 14px; width: 80%;" />亩</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;">租赁单价</td>
				<td height="14px" colspan="2" align="center"
					style="font-size: 14px;"><input type="text"
					name="contractPrice" style="font-size: 14px; width: 80%;" />/元/亩/年</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;">年缴租金</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px; border-right: 1px solid black;"><input
					type="text" name="payRentByYear"
					style="font-size: 14px; width: 90%" />元</td>
			</tr>
			<tr>
				<td height="10px" colspan="2" align="center"
					style="font-size: 14px;">合同签订时间</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;"><input name="contractSignTime" type="text"
					class="easyui-datebox"
					style="font-size: 14px; width: 50%; height: 26px; width: 80%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;">合同约定年限</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;"><input type="text"
					name="contractPromiseTime" style="font-size: 14px; width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px;">是否经总局批准</td>
				<td height="20px" colspan="2" align="center"
					style="font-size: 14px; border-right: 1px solid black;"><input
					type="text" name="isApprove" style="font-size: 14px; width: 100%" /></td>
			</tr>
			<tr>
				<td width="5%" height="20px" colspan="1" rowspan="14" align="center"
					style="font-size: 16px;">土<br>地<br>基<br>本<br>情<br>况
				</td>
				<td width="5%" height="20px" colspan="1" rowspan="6" align="center"
					style="font-size: 16px;">使<br>用<br>情<br>况
				</td>
				<td width="5%" height="20px" colspan="1" align="center"
					style="font-size: 14px;">地块编号</td>
				<td width="10%" height="20px" colspan="1" align="center"
					style="font-size: 14px;"><input type="text"
					name="BasicSituationOfLands[0].landNo" style="width: 100%;" /></td>
				<td width="5%" height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].landNo" style="width: 100%;" /></td>
				<td width="10%" height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].landNo" style="width: 100%;" /></td>
				<td width="10%" height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].landNo" style="width: 100%;" /></td>
				<td width="5%" height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].landNo"
					style="width: 100%;" "/></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">实际使用面积</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].actualArea" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].actualArea" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].actualArea" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].actualArea" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].actualArea"
					style="width: 100%;" "/></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">起始使用面积</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].beginUseArea" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].beginUseArea" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].beginUseArea" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].beginUseArea" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].beginUseArea" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">地块所在地</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].landLocation" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].landLocation" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].landLocation" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].landLocation" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].landLocation" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">种植作物</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].growPlant" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].growPlant" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].growPlant" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].growPlant" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].growPlant"
					style="width: 100%;" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">是否违约使用</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].isBreakContractUse"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].isBreakContractUse"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].isBreakContractUse"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].isBreakContractUse"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].isBreakContractUse"
					style="width: 100%;" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" rowspan="8" align="center"
					style="font-size: 16px;">转<br>包<br>情<br>况
				</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">土地是否转包</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].isLandSubContract"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].isLandSubContract"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].isLandSubContract"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].isLandSubContract"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].isLandSubContract"
					style="width: 100%;" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">是否经农场同意</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].isAgreeByFarm" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].isAgreeByFarm" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].isAgreeByFarm" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].isAgreeByFarm" style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].isAgreeByFarm"
					style="width: 100%;" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">转包面积</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].subContractArea"
					style="width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].subContractArea" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].subContractArea" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].subContractArea" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].subContractArea" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">转包时间</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input id="subContractTime_0"
					name="BasicSituationOfLands[0].subContractTime" type="text"
					class="easyui-datebox" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input id="subContractTime_1"
					name="BasicSituationOfLands[1].subContractTime" type="text"
					class="easyui-datebox" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input id="subContractTime_2"
					name="BasicSituationOfLands[2].subContractTime" type="text"
					class="easyui-datebox" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input id="subContractTime_3"
					name="BasicSituationOfLands[3].subContractTime" type="text"
					class="easyui-datebox" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input id="subContractTime_4"
					type="text" name="BasicSituationOfLands[4].subContractTime" type="text"
					class="easyui-datebox" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">转包租金</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].subContractRent" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].subContractRent" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].subContractRent" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].subContractRent" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].subContractRent" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">现使用人姓名</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].currentUseName" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].currentUseName" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].currentUseName" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].currentUseName" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].currentUseName" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">现使用人单位</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].currentUseCompany" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].currentUseCompany" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].currentUseCompany" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].currentUseCompany" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text" name="BasicSituationOfLands[4].currentUseCompany" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;">是否违约使用</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[0].isBreakContractSubContract" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[1].isBreakContractSubContract" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[2].isBreakContractSubContract" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px;"><input type="text"
					name="BasicSituationOfLands[3].isBreakContractSubContract" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 16px; border-right: 1px solid black;"><input
					type="text"
					name="BasicSituationOfLands[4].isBreakContractSubContract" /></td>
			</tr>
			<tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 14px; border-bottom: 1px solid black">备注</td>
				<td height="20px" colspan="7" align="center"
					style="font-size: 16px; border-right: 1px solid black; border-bottom: 1px solid black">
					<textarea
						style="width: 100%; height: 80px; resize: none; overflow: auto; border: none;" name="remark"></textarea>
				</td>
			</tr>
			<tr>
				<td width="50%" height="20px" colspan="3" style="border: none;">被调查人：<input
					type="text" name="researchName"
					style="border: none; border-bottom: black solid 1px; width: 50%" /></td>
				<td colspan="3" style="border: none;">&nbsp;</td>
				<td height="20px" colspan="2" style="border: none;">信息采集人：<input
					type="text" name="gatherName"
					style="border: none; border-bottom: black solid 1px; width: 50%" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="8"
					style="border: none; text-align: center;"><input type="button"
					value="提交" id="ssr_submit_btn" /> <input type="button" value="重置"
					id="ssr_reset_btn" /></td>
			</tr>
			<tr>
				<td height="12px" colspan="42"
					style="font-size: 14px; border: none; border-left: none; padding: 10px 10px 10px 10px;">
					&nbsp;&nbsp;<b>填表说明：</b>
					本表填写一个项目合同信息，土地基本情况中一列表示该项目合同的一宗地，若超过各宗，请重新填写另一张表单，租赁人信息与本表单一致。姓名栏填写土地使用人，如是外单位，填写法人代表及组织机构代码。特殊情况在备注栏中作说明。是否违约使用填写数字：1、擅自改变土地用途；2、连续两年未足额缴纳租金；3、其他，特殊情况在备注栏中作说明。
				</td>
			</tr>
		</table>
	</form>
</div>

