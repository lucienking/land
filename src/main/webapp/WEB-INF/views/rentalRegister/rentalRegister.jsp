<%@ page language="java"  language="java"
    pageEncoding="UTF-8"%>
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
	.addPaid{
		margin:0 auto;
		display:block;
		overflow:hidden;
		width:16px;
		height:16px;
		padding:0;
		background:url('/land/static/images/edit_add.png');
	}
</style>

<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
    <div data-options="region:'west',title:'选择合同',split:false" style="width:400px;">
    <!-- ****************************************	查询界面 **********************************************-->
			<div id="contractSearchPanel" style="width:100%">
				<form id="contractSearchForm">
					<table id="contractSearch">
						<tr>
							<td class="query">
								<span class="td_title">社区</span>
							</td>
							<td class="query">
								<input id="contract_atCommunity" name="atCommunity" value="" style="width:120px;"/>
								<input id="communityCode" name="communityCode" type="hidden">
							</td >
							<td class="query">
								<span class="td_title">居民小组</span>
							</td>
							<td class="query">
								<input id="contract_residentsGroup" name="residentsGroup.residentsGrpCode" value="${contract.residentsGroup.residentsGrpCode }" style="width:120px;"/>
								<input id="residentsGrpCode" name="residentsGrpCode" type="hidden">
							</td>
						</tr>
						<tr>
							<td class="query">承包人</td>
							<td class="query"><input id="secondParty" name="secondParty" class="easyui-textbox" style="width:120px"></td>
							<td colspan="2" align="center" class="query">
								<a href="#" class="easyui-linkbutton" id="searchContract" style="display:block;width:120px;margin:0 auto">查&nbsp;询</a>
							</td>
						</tr>
			<!-- 	合同列表 -->
						<tr>
							<td colspan="4"><table id="contractList"></table></td>
						</tr>
						
					</table>
					<input type="hidden" name="farmCode" id="farmCode" value="${farmCode }"/>
				</form>
			</div>
	</div>
    <!-- ***************************************	~查询界面~  *********************************************-->

    <!-- ****************************************	租金明细  **********************************************-->    
    
    <div data-options="region:'center',title:'租金明细'" style="padding:0;background:#eee;">
<!--     	每年应缴金额 -->
    	<div style="width:100%;height:48%；float:left; margin:0 0 5px 0;">
			<table id="budgetList"></table>    	
    	</div>
<!--     	交租记录 -->
    	<div style="width:100%;height:48%;float:left;">
			<table id="rentalRecordsDatagrid"></table>    	
    	</div>
    </div>
    
    <!-- ****************************************	~租金明细~  **********************************************--> 
</div>
<!--**************************************** 交租面板 ****************************************-->
<div id="registerDialog" style="display:none;width:300px;">
	<form id="registerForm">
		<input type="hidden" name="prePayingBudget.id" id="prePayingBudgetID">
		<table>
			<tr>
				<td class="payBuild">缴费年度</td>
				<td class="payBuild">
					<input id="specificYear"  class="easyui-textbox" style="width:114px" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td class="payBuild">实缴金额</td>
				<td class="payBuild">
					<input id="actualAmount" name="actualAmount" class="easyui-textbox" style="width:140px" validType="float"/>
				</td>
			</tr>
			<tr>
				<td class="payBuild">票据号</td>
				<td class="payBuild">
					<input id="rentReceive" name="rentReceive" class="easyui-textbox"/>
				</td>
			</tr>
			<tr>
				<td class="payBuild">缴费人</td>
				<td class="payBuild">
					<input id="rentPayerName" name="rentPayerName" class="easyui-textbox"/>
				</td>
			</tr>
			<tr>
				<td class="payBuild">缴费人证件号</td>
				<td class="payBuild">
					<input id="rentPayerIdNO" name="rentPayerIdNO" class="easyui-textbox"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<!--**************************************** ~交租面板~ ****************************************-->


<script>	
	var ctx="${ctx}";
	var farmCode="${farmCode }";
// 	获取社区编码和名称
	$("#contract_atCommunity").combobox({
		url:ctx+'/community/getCommunityByFarmCode',
	    valueField:'id',
	    textField:'text',
	    method:'GET',
	   	queryParams:{"farmCode":farmCode},
	   	onSelect:function(value){
	   		$('#communityCode').val(value.id);
	   		$('#contract_residentsGroup').combobox('clear'); 
	   		var url = ctx+'/group/getResidentsGroupByCommunity?communityCode='+value.id;
	   		$('#contract_residentsGroup').combobox('reload', url); 
	   	}
	});
	
	$("#contract_residentsGroup").combobox({
		url:ctx+'/group/getResidentsGroupByCommunity',
	    valueField:'id',
	    textField:'text',
	    method:'GET',
	   	onSelect:function(value){
	   		$('#residentsGrpCode').val(value.id);
	   	}
	});
	
//合同列表datagrid
	$('#contractList').datagrid({
		url:ctx+"/rentalRegister/getcontractList",
		method:'get',
	    pagination:true,
	    pageSize:'15',
	    width:394,
	    singleSelect:true,
		columns:[[
		    {field:'contractNo',title:'合同编号',width:100},
			{field:'secondParty',title:'承包人',width:80},
			{field:'useArea',title:'面积',width:60,sortable:true},
			{field:'residentsGrpName',title:'生产队',width:120,formatter:function(value,row,index){
				if(row.residentsGroup){
					return row.residentsGroup.residentsGrpName;
				}
			}}
		]],
		queryParams:$("#contractSearchForm").getFormData(),
		onSelect:function(index,row){
			if(row.contractCode){
				showBudget(row.contractCode);
				showRentalRecords(row.contractCode);
			}
		}
	});
	
// 	根据条件查询合同
	$('#searchContract').click(function(){
		$('#contractList').datagrid('load',$("#contractSearchForm").getFormData());
	});
	
// 	显示选中合同的每年金额
	function showBudget(contractCode){
		$('#budgetList').datagrid({
			url:ctx+'/rentalRegister/getBudget',
			method:'post',
			singleSelect:true,
			columns:[[
				{field:'specificYear',title:'指定年份',width:100,align:'center',sortable:true},
				{field:'payingRental',title:'应缴金额',width:100,align:'center'},
				{field:'paidRental',title:'已缴金额',width:100,align:'center'},
				{field:'ownshipRental',title:'欠缴金额',width:100,align:'center'},
				{field:'operator',title:'缴费',width:50,align:'center',formatter:function(value,row,index){
					if(row.id){		
						return '<a href="javascript:addPay('+row.id+',\''+row.specificYear+'\',\''+row.payingRental+'\');" class="pay"></a>';
					}
				}}
			]],
			queryParams:{contractCode:contractCode},
			onLoadSuccess:function(){
				$('.pay').addClass('addPaid');
			}
		});
	};
	
// 	显示合同缴费记录
	function showRentalRecords(contractCode){
		$('#rentalRecordsDatagrid').datagrid({
			url:ctx+'/rentalRegister/getRecordsByContract',
			method:'post',
			singleSelect:true,
			columns:[[
				{field:'prePayingBudget',title:'年度',width:100,align:'center',sortable:true,formatter:function(value,row,index){
					if(row.prePayingBudget){
						return row.prePayingBudget.specificYear;
					}
				}},
				{field:'actualAmount',title:'缴纳金额',width:100,align:'center'},
				{field:'payDate',title:'缴纳日期',width:100,align:'center',formatter:function(value,row,index){
					if(row.payDate){
						return row.payDate.substring(0,10);
					}
				}},
				{field:'rentReceive',title:'票据号',width:100,align:'center'},
				{field:'rentPayerName',title:'缴纳人',width:100,align:'center'},
				{field:'rentPayerIdNO',title:'缴纳人证件号',width:200,align:'center'},
			]],
			queryParams:{contractCode:contractCode}
		});
	};
	
// 	登记租金面板，参数：
// 	id：某年度应缴金额记录的id
// 	specificYear：显示打开的缴费年度
	function addPay(id,specificYear,payingRental){
		if(payingRental>0){
			clearForm();
			$('#prePayingBudgetID').val(id);
			$('#specificYear').textbox('setValue',specificYear);
			$('#registerDialog').show();
			$('#registerDialog').dialog({
				title:'缴纳租金',
				width: 300,
			    height: 220,
			    modal:true,
			    buttons:[{
					text:'确定',
					handler:function(){pay();}
				},{
					text:'取消',
					handler:function(){$("#registerDialog").dialog("close");}
				}]
			});
		}else{
			$.messager.confirm('未设应缴金额','该年度尚未设置应缴金额，请先设置该年度应缴金额。',function(r){});
		}
	}
	
// 清空登记租金面板表单
	function clearForm(){
		$('#prePayingBudgetID').val('');	//这个清空跟其他不一样，是因为这个是普通HTML控件，使用jQuery赋值方法，下面那几个是easyui的控件。
		$('#actualAmount').textbox('setValue','');
		$('#rentReceive').textbox('setValue','');
		$('#rentPayerName').textbox('setValue','');
		$('#rentPayerIdNO').textbox('setValue','');
	}
	
// 	提交登记,保存一个租金记录
	function pay(){
		if(validateInputGroup(['actualAmount'])){
			$.ajax({
				url:ctx+'/rentalRegister/pay',
				method:'post',
				asyn:false,
				error: function(jqXHR, textStatus, errorMsg) {
			    	$.messager.alert('操作结果',""+jqXHR.responseText);
		  		},
				success:function(data){
					$.messager.alert('操作结果',"登记成功！");
					$('#registerDialog').dialog('close');
					$('#budgetList').datagrid('reload');
					$('#rentalRecordsDatagrid').datagrid('reload');
				},
		  		data:$('#registerForm').serialize()
			})
		}
	}
	

</script>