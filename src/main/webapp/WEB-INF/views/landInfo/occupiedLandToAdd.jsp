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

.occupiedLand_table {
	width: 60%;
	height: 40px;
	margin-left: 250px;
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
		var inputAry = $("#occupiedLand_search_form").find("input[type=text]");
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
					var formData = $('#occupiedLand_search_form').serializeArray();
					$.ajax({
						type : "POST",
						url : "${ctx}/occupiedLand/addOccupiedLand",
						data : formData, //将Form 里的值序列化
						asyn : false,
						error : function(jqXHR, textStatus, errorMsg) {
							$.messager.alert('操作结果', "" + jqXHR.responseText);
						},
						success : function(data) {
							$.messager.alert('操作结果', "" + data.message + "",
									"info", function(r) {
										parent.$('#mainTabs').tabs('close', "农场被侵占土地信息登记表");
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
					url : "${ctx}/occupiedLand/getFormByNum",
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

		$('#occupyPeopleIdentityNo').change(function(n,v) {
			if (n != null && n != ""){
			var identityNo = $('#occupyPeopleIdentityNo').val();
			if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(identityNo))) {
				$.messager.alert('提示', "输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。");
				$("#occupyPeopleIdentityNo").addClass("inValid");
				$("#ssr_submit_btn").attr('disabled', true);
				return false;
			}else{
				$("#occupyPeopleIdentityNo").removeClass("inValid");
				$("#ssr_submit_btn").attr('disabled', false);
			}
			}
		});
	});

	function isinValid() {
		var result = true;
		$(".validate").each(function() {
			if ($(this).attr("class").indexOf("inValid") > 0)
				result = false;
		});
		return result;
	}
	
	function checkOccupiedTime(obj) {
		// 只有当选中的时候才会去掉其他已经勾选的checkbox，所以这里只判断选中的情况
		    if (obj.is(":checked")) {
		         // 先把所有的checkbox 都设置为不选种
		        $('.occupiedTime').prop('checked', false);
		        // 把自己设置为选中
		        obj.prop('checked',true);
		    }
		}
	function checkLandType(obj) {
		// 只有当选中的时候才会去掉其他已经勾选的checkbox，所以这里只判断选中的情况
		    if (obj.is(":checked")) {
		         // 先把所有的checkbox 都设置为不选种
		        $('.landUseOverallPlaning').prop('checked', false);
		        // 把自己设置为选中
		        obj.prop('checked',true);
		    }
		}
</script>

<div id="container" style="width: 99%; height: 99%;">
	<form id="occupiedLand_search_form">
		<table id="occupiedLand_table" class="occupiedLand_table" border="1" aligen="center"
			cellspacing="0">
			<tr>
				<td height="12px" colspan="4" style="border: none">&nbsp;</td>
				<td height="12px" colspan="2" style="font-size: 12px; border: none">编号：<input
					id="num" type="text" name="num"
					style="border: none; border-bottom: black solid 1px; width: 50%" /></td>
			</tr>
			<tr>
				<td width="100%" height="20px" colspan="6" align="center"
					style="border: none; font-size: 23px; font-weight: bold;">农场被侵占土地信息登记表</td>
			</tr>
			<tr>
				<td width="100%" height="12px" colspan="3"
					style="font-size: 12px; border: none; margin-top: 5px;">
					土地所属社区： <input id="familypeople_atFarmCode" type="hidden"
					value="${farmCode }" /> <input id="familypeople_atCommunity"
					name="communityNum" value="" style="width: 120px;" />
				</td>
				<td width="100%" height="12px" colspan="3"
					style="font-size: 12px; border: none; margin-top: 5px;">
					土地证书编号： <input id="landCertificate" type="text" name="landCertificate"
					style="border: none; border-bottom: black solid 1px; width: 180px;" />
				</td>
			</tr>
			<tr>
				<td height="20px" colspan="3" align="center"
					style="font-size: 15px;">被占土地所在市县（按行政区域）</td>
				<td height="20px" colspan="3" align="center"
					style="font-size: 15px;border-right: 1px solid black;">
					<input type="text" name="occupiedLandLocation"
					style="font-size: 15px; width: 100%;" /></td>
			</tr>
			<tr>
				<td height="20px" colspan="1" align="center"
					style="font-size: 15px;">面积（亩）</td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="landArea"
					style="font-size: 15px; width: 100%;" /></td>
				<td height="20px" colspan="1" align="center"
					style="font-size: 15px;">地块编号</td>
				<td height="20px" colspan="3" align="center"
					style="font-size: 15px; border-right: 1px solid black;"><input
					type="text" name="landPracelNo" style="font-size: 15px; width: 100%;" /></td>
			</tr>
			<tr>
				<td height="15px" colspan="1" align="center"
					style="font-size: 15px;">位置</td>
				<td height="20px" colspan="5" align="center"
					style="font-size: 15px;border-right: 1px solid black;"><input type="text" name="position"
					style="font-size: 15px; width: 100%;" /></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" rowspan="3" align="center"
					style="font-size: 15px;">占地时间</td>
				<td height="20px" colspan="1" rowspan="3" align="center"
					style="font-size: 15px;"><input name="occupiedLandTime" type="text"
					class="easyui-datebox" 
					style="font-size: 15px; height: 26px; width: 100%;" /></td>
				<td height="20px" colspan="4" align="left"
					style="font-size: 15px;border-right: 1px solid black;border-bottom: none;">
					<input type="checkbox" name="occupiedLandExplain" class="occupiedTime" value="1982年5月14日《征用土地条例》发布前" onclick="checkOccupiedTime($(this))"/>1982年5月14日《征用土地条例》发布前
				</td>
			</tr>
			<tr>
				<td  height="20px" colspan="4" align="left"
					style="font-size: 15px;border-right: 1px solid black;border-top: none;border-bottom: none;">
					<input name="" type="checkbox" class="occupiedTime" name="occupiedLandExplain" 
					style="font-size: 15px;" onclick="checkOccupiedTime($(this))" value="1982年5月14日《征用土地条例》发布后"/>1982年5月14日《征用土地条例》发布后
				</td>
			</tr>
			<tr>
				<td  height="10px" colspan="4" align="left"
					style="font-size: 15px;border-top : none;border-right: 1px solid black;">
				<input type="checkbox" name="occupiedLandExplain" value="登记发证后" class="occupiedTime" onclick="checkOccupiedTime($(this))"/>登记发证后
				</td>
			</tr>
			<tr>
			<tr>
				<td height="10px" colspan="2" align="center"
					style="font-size: 15px;">土地利用总体规划用途</td>
				<td height="10px" colspan="4" align="center"
					style="font-size: 15px;border-right: 1px solid black;">
					<input type="checkbox" name="landUseOverallPlaning" class="landUseOverallPlaning" onclick="checkLandType($(this))" value="林地" />林地
					<input type="checkbox" name="landUseOverallPlaning" class="landUseOverallPlaning" onclick="checkLandType($(this))" value="非林地"/>非林地</td>
			</tr>
			<tr>
				<td height="10px" colspan="2" align="center"
					style="font-size: 15px;">登记发证情形</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="registerCertificate" style="width: 100%;font-size: 15px;"/></td>
				<td height="10px" colspan="2" align="center"
					style="font-size: 15px;">农场土地登记发证时间（年月日）</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;">
					<input type="text" class="easyui-datebox" name="landRegisterCertificateTime" style="width: 100%;font-size: 15px;"/></td>
			</tr>
			<tr>
				<td width="8%" height="10px" colspan="1" rowspan="7" align="center"
					style="font-size: 15px;">被占土地原地类</td>
				<td width="5%" height="10px" colspan="1" align="center"
					style="font-size: 15px;">地类</td>
				<td width="10%" height="10px" colspan="1" align="center"
					style="font-size: 15px;">面积</td>
				<td width="10%" height="10px" colspan="1" rowspan="7" align="center"
					style="font-size: 15px;">被占后用途</td>
				<td width="15%" height="10px" colspan="1" align="center"
					style="font-size: 15px;">作物类型</td>
				<td width="5%" height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;">面积</td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">橡胶更新地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="occupiedLandBlataUpdateArea" style="width: 100%;font-size: 15px;"/></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">造林</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;"><input type="text" name="occupiedLandUseToAfforestation" style="width: 100%;font-size: 15px;"/></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">林地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="occupiedLandForestLandArea" style="width: 100%;font-size: 15px;"/></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">种橡胶</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;"><input type="text" name="occupiedLandUseToPlantBalata" style="width: 100%;font-size: 15px;"/></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">荒地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="occupiedLandDesertArea" style="width: 100%;font-size: 15px;"/></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">种热带作物</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;"><input type="text" name="occupiedLandUseToPlantTropicalCrop" style="width: 100%;font-size: 15px;"/></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">热作地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="occupiedLandTropicalCropArea" style="width: 100%;font-size: 15px;"/></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">水田、瓜菜地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;">
					<input type="text" name="occupiedLandUseToPaddyField" style="width: 100%;font-size: 15px;"/></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">耕地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="occupiedLandPlough" style="width: 100%;font-size: 15px;"/></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">宅基地、其他建设用地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;">
					<input type="text" name="occupiedLandUseToUseToHouseTead" style="width: 100%;font-size: 15px;"/></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">其他土地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input type="text" name="occupiedLandOtherLand" /></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">其他用途</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;"><input type="text" name="occupiedLandUseToOtherUsage" style="width: 100%;font-size: 15px;"/></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">占地主体</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input name="occupiedLandOwner" type="text" /></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">占地形式</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input name="occupiedLandForm" type="text" /></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">做过何种处理</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-right: 1px solid black;"><input name="Dispose" type="text" /></td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">占用人姓名</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">
					<input name="occupyPeopleName" type="text" />
				</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">占用人证件号码</td>
				<td height="10px" colspan="3" align="center"
					style="font-size: 15px;border-right: 1px solid black;">
					<input id="occupyPeopleIdentityNo" name="occupyPeopleIdentityNo" type="text" style="width: 100%;font-size: 15px;"/>
				</td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">是否划转土地</td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;"><input name="isTransferredLand" type="text" style="width: 100%;font-size: 15px;"/></td>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;">现土地权利人</td>
				<td height="10px" colspan="3" align="center"
					style="font-size: 15px;border-right: 1px solid black;width: 100%;">
					<input name="nowLandPowerPeople" type="text"  style="width: 100%;font-size: 15px;"/>
				</td>
			</tr>
			<tr>
				<td height="10px" colspan="1" align="center"
					style="font-size: 15px;border-bottom: 1px solid black;">备注</td>
				<td height="20px" colspan="5" align="center"
					style="font-size: 15px; border-right: 1px solid black; border-bottom: 1px solid black">
					<textarea
						style="width: 100%; height: 80px; resize: none; overflow: auto; border: none;"
						name="remark"></textarea>
				</td>
			</tr>
			<tr>
				<td height="20px" colspan="6"
					style="border: none; text-align: center;"><input type="button"
					value="提交" id="ssr_submit_btn" /> <input type="button" value="重置"
					id="ssr_reset_btn" /></td>
			</tr>
			<tr>
				<td height="12px" colspan="42"
					style="font-size: 15px; border: none; border-left: none; padding: 10px 10px 10px 10px;">
					&nbsp;&nbsp;<b>填表说明：</b>
					<p style = "margin:10px;">一、登记发证情形，填写数字：1、市县政府已登记农场已领取《国有土地使用证》的；2、市县政府已登记但农场未领取《国有土地使用证》的；3、《国有土地使用证》被收回但市县政府未注销的；4、市县未登记国有土地使用权但核发了具有林地使用权的《林权证》的。</p>
					<p style = "margin:10px;">二、占地主体，填写数字：1、周边农村个体；2、村委会、村民集体；3、乡镇；4、其他。</p>
					<p style = "margin:10px;">三、占地形式，填写数字：1、自用；2、占地发包；3、强占不准农场使用；4、其他方式。</p>
					<p style = "margin:10px;">四、作过何种处理，填写数字：1、农场出面制止未果；2、农场上报政府，等待处理；3、政府已作过处理决定，但未确实收回；4、法院以做出判决，但未执行；5、其他处理方式。</p>
					<p style = "margin:10px;">六、林地是市县土地利用总体规划中，确定为林业用途的土地。非林地，除规划为林地以外的其他用途土地。</p>
					<p style = "margin:10px;">七、如果是个人占用，填写占用人姓名及占用人证件号码</p>
				</td>
			</tr>
			<tr>
				<td width="50%" height="20px" colspan="3" style="border: none;">被调查人签名：<input
					type="text" name="researchName"
					style="border: none; border-bottom: black solid 1px; width: 150px;" /></td>
				<td height="20px" colspan="3" style="border: none;">信息采集人签名：<input
					type="text" name="gatherName"
					style="border: none; border-bottom: black solid 1px; width: 150px;" /></td>
			</tr>
		</table>
	</form>
</div>

