<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script src="${ctx }/static/js/contract/contractApplication.js"></script>


<div id= "rentalContainer">
<div id="rentalSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="rentalSearchConditionForm">
		<table style="width:99%;height:99%;margin-buttom:10px">
			<tr>
				<td width="18%" align="center" style="min-width:150px">
					<label for="rental_search_farmName">所属农场</label>
					<input id="rental_search_farmName"  name="farmCode" class="easyui-combobox" style="width:120px;" />
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="rental_search_contractorName">乙方法人代表</label>
					<input id="rental_search_contractorName" name="contractorName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="rental_search_contractNo">合同编号</label>
					<input id="rental_search_contractNo" name="contractNo" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="rental_search_startDate">承包起始时间</label>
					<input id="rental_search_startDate" name="startDate" value="${startDate }" class="easyui-datebox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="rental_search_endDate">承包结束时间</label>
					<input id="rental_search_endDate" name="endDate" value="${endDate }" class="easyui-datebox" style="width:120px;"/>
				</td>
				<td width="10%" align="center" style="min-width:150px">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="5"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="rentalSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="rentalSearchResultPanel" title="合同列表" class="easyui-panel" style="width:100%;">
	<table id="rentalDatagrid" style="width:100%;"></table>
</div>
<div id="rentalDetailDataDialog"  style="display:none">
	<table id="rentalDetailDatagrid" style="width:100%;"></table>
</div>
<div id="rentalSetDialog" style="display:none">
	<form id="retalTotalSetForm">
		<input type="hidden" id="rentalSet_contractId" name="id"></input>
		<div class="line-div">
			合同编号：&nbsp;
			<input id="rentalSet_contractNo" name="contractNo"  class="easyui-textbox" style="width:120px;"/>&nbsp;&nbsp;
			乙方法人：&nbsp;
			<input id="rentalSet_secondPtRepresentative" name="secondPtRepresentative" class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			签订单价：&nbsp;
			<input id="rentalSet_signingPrice"  validType="float" name="signingPrice" class="easyui-textbox" style="width:120px;" />&nbsp;&nbsp;
			阶梯计价：&nbsp;
			<input id="rentalSet_isStepedCount" name="isStepedCount" class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			五年递增：&nbsp;
			<input id="rentalSet_ratePerFiveYear" validType="float" name="ratePerFiveYear"  class="easyui-textbox" style="width:120px;"/>&nbsp;&nbsp;
			保障地面积：
			<input id="rentalSet_affordableArea" validType="float" name="affordableArea"  class="easyui-textbox" style="width:120px;"/>
		</div>
	</form>
</div>

<div id="rentalDetailSetDialog" style="display:none">
	<form id="rentalDetailSetForm">
		<input type="hidden" id="rentalDetailSet_budgetId" name="id"  ></input>
		<div class="line-div">
			租金年份：&nbsp;
			<input id="rentalDetailSet_specificYear" name="specificYear"  class="easyui-textbox" style="width:120px;"/>&nbsp;&nbsp;
			参考应缴：&nbsp;
			<input id="rentalDetailSet_paidBudget"  validType="float" name="paidBudget" class="easyui-textbox" style="width:120px;" />&nbsp;&nbsp;
			
		</div>
		<div class="line-div">
			应缴金额：&nbsp;
			<input id="rentalDetailSet_payingRental" name="payingRental" class="easyui-textbox" style="width:120px;"  validType="float" />&nbsp;&nbsp;
			已缴金额：&nbsp;
			<input id="rentalDetailSet_paidRental" name="paidRental" class="easyui-textbox" style="width:120px;"  validType="float" />&nbsp;&nbsp;
		</div>
		<div class="line-div">
			欠缴金额：&nbsp;
			<input id="rentalDetailSet_ownshipRental" class="easyui-textbox" style="width:120px;"/>&nbsp;&nbsp;
			<input type="hidden" name="ownshipRental" id="rentalDetailSet_ownshipRental_hidden"/>
			减免面积：&nbsp;
			<input id="rentalDetailSet_partialAreaFree" validType="float" name="partialAreaFree"  class="easyui-textbox" style="width:120px;"/>&nbsp;&nbsp;
		</div>
		<div class="line-div">
			优惠金额：&nbsp;
			<input id="rentalDetailSet_partialRentFree" validType="float" name="partialRentFree"  class="easyui-textbox" style="width:120px;"/>&nbsp;&nbsp;
			折扣：&nbsp;&nbsp;&nbsp;
			<input id="rentalDetailSet_disCount" validType="float" name="disCount"  class="easyui-textbox" style="width:120px;"/>&nbsp;&nbsp;
		</div>
	</form>
</div>
<div id="rentalToolbar">
	<jksb:hasAutority authorityId="007002003">
		<a href="#" id = "rentalEditButton" class="easyui-linkbutton" data-options="iconCls:'pic_90',plain:true,disabled:true" >租金设置</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002003">
		<a href="#" id = "rentalDetailEditButton" class="easyui-linkbutton" data-options="iconCls:'pic_90',plain:true,disabled:true" >租金明细设置</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002003">
		<!-- <a href="#" id="initialRentl" class="easyui-linkbutton" data-options="iconCls:'pic_90',plain:true" >初始化租金</a> -->
	</jksb:hasAutority>
</div>

<div id="rentalDetailToolbar">
	<jksb:hasAutority authorityId="007002003">
		<a href="#" id = "rentalDetailSetButton" class="easyui-linkbutton" data-options="iconCls:'pic_90',plain:true,disabled:true" >租金明细设置</a>
	</jksb:hasAutority>
</div>
<script type="text/javascript">

/**
 *  datagrid 初始化 
 */
$('#rentalDatagrid').datagrid({
   // url:"${ctx}/rental/getContractByStatus",
    url:"${ctx}/contract/getContractsByCondition",
    method:'get',
    pagination:true,
    singleSelect:true,
    columns:[[
		{checkbox:true,field:'',title:'' },      
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'contractNo',title:'合同编号',width:'10%'},
        {field:'firstParty',title:'甲方',width:'10%',align:'center'},
        {field:'secondParty',title:'乙方',width:'10%',align:'center'},
        {field:'secondPtRepresentative',title:'乙方法人',width:'10%',align:'center'},
        {field:'contractStatus',title:'合同状态',width:'5%',align:'center'},
        {field:'useArea',title:'承租总面积',width:'5%',align:'center',sortable:true},
        {field:'leaseTerm',title:'承租期',width:'5%',align:'center',sortable:true},
        {field:'startDate',title:'承租起始',width:'10%',align:'center'},
        {field:'expiredDate',title:'承租结束',width:'10%',align:'center'},
        {field:'createTime',title:'创建日期',width:'10%',align:'center'}
    ]] ,
    toolbar:"#rentalToolbar" ,
    onSelect: function(index,row){rentalSelectChange(index,row);},
	onUnselect: function(index,row){rentalSelectChange(index,row);}
});

function rentalSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#rentalDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#rentalEditButton").linkbutton("enable");
		$("#rentalDetailEditButton").linkbutton("enable");
	}else{
		$("#rentalEditButton").linkbutton("disable");
		$("#rentalDetailEditButton").linkbutton("disable");
	} 
}

function rentalDetailSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#rentalDetailDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#rentalDetailSetButton").linkbutton("enable");
	}else{
		$("#rentalDetailSetButton").linkbutton("disable");
	} 
}

$('#rentalEditButton').click(function(){
	var row = $('#rentalDatagrid').datagrid('getSelected');
	rentalSetDialog("租金设置",row);
});

$('#rentalDetailEditButton').click(function(){
	var row = $('#rentalDatagrid').datagrid('getSelected');
	rentalDetailDataDialog("租金明细",row);
});

$('#rentalDetailSetButton').click(function(){
	var row = $('#rentalDetailDatagrid').datagrid('getSelected');
	rentalDetailSetDialog("租金明细设置",row);
});

function rentalSetDialog(title,selected){
	initRentalSetDialogValue(selected.id);
	$("#rentalSetDialog").show(); //先显示，再弹出
    $("#rentalSetDialog").dialog({
        title: title,
        width: 500,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){rentalSetSave();}
		},{
			text:'取消',
			handler:function(){$("#rentalSetDialog").dialog("close");}
		}]
    });
}

function rentalDetailSetDialog(title,selected){
	initRentalDetailSetDialogValue(selected.id);
	$("#rentalDetailSetDialog").show(); //先显示，再弹出
    $("#rentalDetailSetDialog").dialog({
        title: title,
        width: 500,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){rentalDetailSetSave();}
		},{
			text:'取消',
			handler:function(){$("#rentalDetailSetDialog").dialog("close");}
		}]
    });
}

function initRentalSetDialogValue(id){
	$.ajax({
		type: "GET",
		url:"${ctx}/rental/getContractById",
		data:{"id":id}, //将Form 里的值序列化
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	return;
	    },
	    success: function(data) {
	    	if(data.contract.contractCode == null){
	    		return;
	    	}else{
	    		$("#rentalSet_contractId").val(id);
	    		$("#rentalSet_contractNo").textbox("setValue",data.contract.contractNo);
	    		$("#rentalSet_contractNo").textbox("disable");
	    		$("#rentalSet_secondPtRepresentative").textbox("setValue",data.contract.secondPtRepresentative);
	    		$("#rentalSet_secondPtRepresentative").textbox("disable");
	    		$("#rentalSet_signingPrice").textbox("setValue",data.contract.signingPrice);
	    		$("#rentalSet_isStepedCount").textbox("setValue",data.contract.isStepedCount);
	    		$("#rentalSet_ratePerFiveYear").textbox("setValue",data.contract.ratePerFiveYear);
	    		$("#rentalSet_affordableArea").textbox("setValue",data.contract.affordableArea);
	    	}
	    }
	}); 	
}

function initRentalDetailSetDialogValue(id){
	$.ajax({
		type: "GET",
		url:"${ctx}/rental/getRentalById",
		data:{"id":id}, //将Form 里的值序列化
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	return;
	    },
	    success: function(data) {
	    	if(data.budget.specificYear == null)
	    		return;
	    	else{
	    		$("#rentalDetailSet_budgetId").val(id);
	    		$("#rentalDetailSet_specificYear").textbox("setValue",data.budget.specificYear);
	    		$("#rentalDetailSet_specificYear").textbox("disable");
	    		$("#rentalDetailSet_payingRental").textbox("setValue",data.budget.payingRental+"");
	    		$("#rentalDetailSet_paidRental").textbox("setValue",data.budget.paidRental+"");
	    		$("#rentalDetailSet_paidBudget").textbox("setValue",data.budget.paidBudget+"");
	    		$("#rentalDetailSet_paidBudget").textbox("disable");
	    		$("#rentalDetailSet_ownshipRental").textbox("setValue",data.budget.ownshipRental+"");
	    		$("#rentalDetailSet_ownshipRental_hidden").val(data.budget.ownshipRental+"");
	    		$("#rentalDetailSet_ownshipRental").textbox("disable");
	    		$("#rentalDetailSet_partialAreaFree").textbox("setValue",data.budget.partialAreaFree+"");
	    		$("#rentalDetailSet_partialRentFree").textbox("setValue",data.budget.partialRentFree+"");
	    		$("#rentalDetailSet_disCount").textbox("setValue",data.budget.disCount+"");
	    	}
	    }
	}); 	
}

function rentalDetailDataDialog(title,selected){
	$("#rentalDetailDataDialog").show(); //先显示，再弹出
    $("#rentalDetailDataDialog").dialog({
        title: title,
        width: 700,
        modal:true,
        buttons:[{
			text:'取消',
			handler:function(){$("#rentalDetailDataDialog").dialog("close");}
		}]
    });
   $("#rentalDetailDatagrid").datagrid("reload",{"id":selected.id});
}

function rentalSetSave(){
	$.ajax({
		type: "POST",
		url:"${ctx}/rental/editRental",
		data:$('#retalTotalSetForm').serialize(), //将Form 里的值序列化
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   	 	$("#rentalSetDialog").dialog("close");
	   		$("#rentalDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#rentalSetDialog").dialog("close");
		    $("#rentalDatagrid").datagrid('reload');
	    }
	}); 
}


function rentalDetailSetSave(){
	$.ajax({
		type: "POST",
		url:"${ctx}/rental/editRentalDetail",
		data:$('#rentalDetailSetForm').serialize(), //将Form 里的值序列化
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   	 	$("#rentalDetailSetDialog").dialog("close");
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#rentalDetailSetDialog").dialog("close");
		    $("#rentalDetailDatagrid").datagrid('reload');
	    }
	}); 
}

/**
 * 租金信息
 */
$('#rentalDetailDatagrid').datagrid({
    url:"${ctx}/rental/getRentalByContractId",
    method:'get',
    pagination:true,
    singleSelect:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'specificYear',title:'租金年份',width:'16%'},
        {field:'payingRental',title:'应缴金额',width:'10%'},
        {field:'paidRental',title:'已缴金额',width:'10%'},
        {field:'paidBudget',title:'参考应缴',width:'10%'},
        {field:'ownshipRental',title:'欠缴金额',width:'10%'}
    ]],
    toolbar:"#rentalDetailToolbar" ,
    onSelect: function(index,row){rentalDetailSelectChange(index,row);},
	onUnselect: function(index,row){rentalDetailSelectChange(index,row);}
});

/**
 * 查询
 */
$('#rentalSearchButton').click(function(){
	$('#rentalDatagrid').datagrid('load',$('#rentalSearchConditionForm').getFormData());
});

/**
 * 设置分页
 */
var p = $('#rentalDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});


/**
 * 更改应缴金额
 */
 function changePayingRental(value){
	var oldValue = $("#rentalDetailSet_payingRental").textbox("getValue") == ""?0:
					$("#rentalDetailSet_payingRental").textbox("getValue");
	$("#rentalDetailSet_payingRental").textbox("setValue",oldValue+(value==""?0:value));
}

 /**
  * 计算欠缴金额
  */
  function calcuOwnshipRental(){
 	var paidValue = $("#rentalDetailSet_paidRental").textbox("getValue") == ""?0:
 					$("#rentalDetailSet_paidRental").textbox("getValue");
 	var payingValue = $("#rentalDetailSet_payingRental").textbox("getValue") == ""?0:
					$("#rentalDetailSet_payingRental").textbox("getValue");
 	$("#rentalDetailSet_ownshipRental").textbox("setValue",(payingValue-paidValue)+"");
	$("#rentalDetailSet_ownshipRental_hidden").val(payingValue-paidValue);
 }
 
  $("#rentalDetailSet_paidRental").textbox({
	  onChange:function(nV,oV){
		  calcuOwnshipRental();
	  }
  });
  $("#rentalDetailSet_payingRental").textbox({
	  onChange:function(nV,oV){
		  calcuOwnshipRental();
	  }
  });
  
  /**
   * 农场下拉框
   */
   var farmCode = "${farmCode}" ;
   $("#rental_search_farmName").combobox({
  		url:'${ctx}/sys/org/getAllFarms',
  	    valueField:'code',
  	    textField:'name',
  	    method:'GET', 
  		onLoadSuccess:function(){
  			$("#rental_search_farmName").combobox("select", farmCode);
  			$('#rentalDatagrid').datagrid('reload',$('#rentalSearchConditionForm').getFormData());
  		}
  }); 
   
   /**
    * 初始化租金
    */
      $(function(){
   	    $('#initialRentl').bind('click', function(){
    	   	 $.ajax({
    				type: "GET",
    				url:"${ctx}/contract/initialPrepayingBudget",
    				data:{farmCode:"302",contractCode:""}, //将Form 里的值序列化
    				asyn:false,
    			    error: function(jqXHR, textStatus, errorMsg) {
    			    	$.messager.alert('操作结果',""+jqXHR.responseText);
    			   	 	$("#rentalDetailSetDialog").dialog("close");
    			    },
    			    success: function(data) {
    			    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
    				    $("#rentalDetailSetDialog").dialog("close");
   				    $("#rentalDetailDatagrid").datagrid('reload');
    			    }
   			});
    	    });
    	});
   
</script>
</div>