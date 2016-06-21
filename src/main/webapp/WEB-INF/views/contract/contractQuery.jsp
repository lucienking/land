<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	.required{
		color:red;
	}
	.td_title{
		width:70px;
		display:inline-block;
		text-align:center;
	}
</style>
<div id= "contractQueryContainer">
<div id="contractQuerySearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="contractQuerySearchConditionForm">
		<table style="width:99%;height:99%;margin-buttom:10px">
			<tr>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryName">乙方法人代表</label>
					<input id="search_contractQueryName" name="contractorName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryCode">合同编码</label>
					<input id="search_contractQueryCode" name="contractNo" class="easyui-textbox" style="width:120px;"/>
				</td>
				
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQuerystartDate">承租期起</label>
					<input id="search_contractQuerystartDate" name="startDate" value="${startDate }" class="easyui-datebox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryendDate">承租期止&nbsp;</label>
					<input id="search_contractQueryendDate" name="expiredDate" value="${endDate }" class="easyui-datebox" style="width:120px;"/>
				</td>
				<td width="12%" align="center" style="min-width:150px">
						&nbsp;
				</td>
			</tr>
			<tr>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryName">乙方证件号码</label>
					<input id="search_contractQueryName" name="contractorName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryfarmName">所属农场</label>
					<input id="search_contractQueryfarm"  name="farmCode" class="easyui-combobox" style="width:120px;" />
					<input id="search_contractQueryfarmCode" type="hidden" value="${farmCode }"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQuerycommunityCode">所属社区</label>
					<input id="search_contractQuerycommunityCode" name="communityCode" class="easyui-textbox" style="width:120px;"/>
			
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryresidentsGrpCode">所属生产队</label>
					<input id="search_contractQueryresidentsGrpCode" name="residentsGrpCode" class="easyui-textbox" style="width:120px;"/>
				</td>
				
				<td width="12%" align="center" style="min-width:150px">
						&nbsp;
				</td>
			</tr>
			<tr>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryaffordableArea">是否有保障地</label>
					<jksb:diction id="search_contractQueryaffordableArea" name="affordableArea" groupId="PUB_SELECT"  cssClass="easyui-combobox" style="width:120px" defaultValue="blank">
					</jksb:diction>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryCode">是否干部</label>
					<jksb:diction id="search_contractQueryisCadres" name="isCadres" groupId="PUB_SELECT"  cssClass="easyui-combobox" style="width:120px" defaultValue="blank">
					</jksb:diction>
				</td>
				
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQuerystartDate">承租面积</label>
					<input id="search_contractQuerystartDate" name="areaStart" class="easyui-textbox" style="width:49px;"/> —
					<input id="search_contractQueryendDate" name="areaEnd" class="easyui-textbox" style="width:49px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQuerystartDate">承租年限&nbsp;</label>
					<input id="search_contractQuerytermStart" name="termStart" class="easyui-textbox" style="width:49px;"/> —
					<input id="search_contractQuerytermEnd" name="termEnd" class="easyui-textbox" style="width:49px;"/>
				</td>
				<td width="12%" align="center" style="min-width:150px">
						&nbsp; 
				</td>
			</tr>
			<tr>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_contractQueryaffordableArea">地块编号&nbsp;&nbsp;</label>
					<input id="search_contractQueryplaceCode"  class="easyui-textbox"  value="${placeCode }" name="dkbh" style="width:120px" />
				</td>
				<td width="22%" align="center" style="min-width:150px">
				</td>
				
				<td width="22%" align="center" style="min-width:150px">
				</td>
				<td width="22%" align="center" style="min-width:150px">
				</td>
				<td width="12%" align="center" style="min-width:150px">
						&nbsp; 
				</td>
			</tr>
			<tr>
				<td colspan="4"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="contractQuerySearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="contractQuerySearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="contractQueryDatagrid" style="width:100%;"></table>
</div>

<div id="contractQueryEditDialog"  style="display:none;">
</div>
<div id="contractQueryDetailInfoDialog"  style="width:70%;height:100%;display:none;">
</div>

<div id="contractQueryToolbar">
	<jksb:hasAutority authorityId="007002003">
		<a href="#"
			id="contractQueryEditButton" class="easyui-linkbutton"
			data-options="iconCls:'icon-edit',plain:true,disabled:true,">编辑合同</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002002">
		<a href="javascript:contractQueryPrint()" id="contractQueryPrint"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-print',plain:true,disabled:true,">合同打印</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002002">
		<a href="javascript:contractQueryToMapButton(this)" id="contractQueryToMapButton"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-tip',plain:true,disabled:true,">跳转地图</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002002">
		<a href="#" id="contractQueryDetailInfo"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-tip',plain:true,disabled:true,">合同详细</a>
	</jksb:hasAutority>
</div>

<script type="text/javascript">
 var farmCode = "${farmCode}" ;
 
/**
 *  datagrid 初始化 
 */
$('#contractQueryDatagrid').datagrid({
    url:"${ctx}/contract/getContractsByCondition",
    method:'get',
    pagination:true,
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
    queryParams:$('#contractQuerySearchConditionForm').getFormData(), 
    toolbar:"#contractQueryToolbar",				 
	onSelect: function(index,row){contractQuerySelectChange(index,row);},
	onUnselect: function(index,row){contractQuerySelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    } 
});

function contractQuerySelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#contractQueryDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#contractQueryEditButton").linkbutton("enable");
		$("#contractQueryDetailInfo").linkbutton("enable");
		
		$("#contractQueryDeleButton").linkbutton("enable");
		$("#contractQueryToMapButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#contractQueryDeleButton").linkbutton("disable");
		$("#contractQueryEditButton").linkbutton("disable");
		$("#contractQueryDetailInfo").linkbutton("disable");
		$("#contractQueryToMapButton").linkbutton("disable");
	}else{
		$("#contractQueryEditButton").linkbutton("disable");
		$("#contractQueryDetailInfo").linkbutton("disable");
		$("#contractQueryToMapButton").linkbutton("disable");
	}
}

$('#contractQuerySearchButton').click(function(){
	$('#contractQueryDatagrid').datagrid('load',$('#contractQuerySearchConditionForm').getFormData());
});


/**
 * 设置分页
 */
var p = $('#contractQueryDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

/**
 * 农场下拉框
 */
 $("#search_contractQueryfarm").combobox({
		url:'${ctx}/sys/org/getAllFarms',
	    valueField:'code',
	    textField:'name',
	    method:'GET',
	    onSelect:function(rec){
	    	var farmCode = rec.code == "1"?"":rec.code;
	   		$('#search_contractQuerycommunityCode').combobox('reload'
	   				,ctx+'/community/getCommunityByFarmCode?farmCode='+farmCode); 
		},
		onLoadSuccess:function(){
			$("#search_contractQueryfarm").combobox("select", farmCode);
			$('#contractQueryDatagrid').datagrid('load',$('#contractQuerySearchConditionForm').getFormData());
		}
}); 
 
/**
 * 社区 居民小组联动 combox
**/
$("#search_contractQueryresidentsGrpCode").combobox({
	url:ctx+'/group/getResidentsGroupByCommunity',
    valueField:'id',
    textField:'text',
    method:'GET'
});
$("#search_contractQuerycommunityCode").combobox({
	url:ctx+'/community/getCommunityByFarmCode',
    valueField:'id',
    textField:'text',
    method:'GET',
   	onSelect:function(value){
   		$('#search_contractQueryresidentsGrpCode').combobox('clear'); 
   		var url = ctx+'/group/getResidentsGroupByCommunity?communityCode='+value.id;
   		$('#search_contractQueryresidentsGrpCode').combobox('reload', url); 
   	},
   	onChange:function(value,old){
   		$('#search_contractQueryresidentsGrpCode').combobox('clear'); 
   		var url = ctx+'/group/getResidentsGroupByCommunity?communityCode='+value.id;
   		$('#search_contractQueryresidentsGrpCode').combobox('reload', url); 
   	}
});

/**
 * 合同编辑
 */
 $("#contractQueryEditButton").click(function(){
	 var id = $("#contractQueryDatagrid").datagrid("getSelected").id;
	 
	 $("#contractQueryEditDialog").show(); //先显示，再弹出
	 $("#contractQueryEditDialog").dialog({
	      title: "合同编辑",
	      width: 900,
	      height: 400,
	      href:"${ctx}/contract/contractEdit?id="+id,
	      modal:true
	  });
 });
 
 /**
  * 合同详细信息展示
  */
  $("#contractQueryDetailInfo").click(function(){
 	 var id = $("#contractQueryDatagrid").datagrid("getSelected").id;
 	 
 	 $("#contractQueryDetailInfoDialog").show(); //先显示，再弹出
 	 $("#contractQueryDetailInfoDialog").dialog({
 		  title:'合同详细信息',
 	      href:"${ctx}/contract/contractDetailInfo?id="+id,
 	      modal:true
 	  });
  });
 
 function contractQueryToMapButton(obj) {
		
	    // 	var str = $(obj).attr('contractId');
	    var selected = $('#contractQueryDatagrid').datagrid('getSelected');
	    var id = selected.id;
	    var strPlace = "",
	    strNc = "";

	    $.ajax({
	        url: '${ctx}/contract/ContractQuerytoselfEconomy?id=' + id,
	        async: false,
	        // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected  
	        type: "POST",
	        dataType: "json",
	        success: function(data) {
	            var str = data;
	            strPlace = str.strPlace;
	            strNc = str.farmCode;
	            //	alert("查询出的地块号"+strPlace);           
	        },
	        error: function() {
	            $.messager.alert('错误提示', '远程服务端出现错误！', 'error');
	        }
	    });

	    var url = '${ctx}/thematicMap/selfEconomy';
	    // alert(strNcName+strNc+strPlace+"p6");
	    var title = '自营经济';
	    var flag = parent.$("#mainTabs").tabs('exists', title);

	    if (flag) {
	        parent.$("#mainTabs").tabs('close', title);
	    }
	    var content = '<iframe scrolling="no" frameborder="0"  src="' + url + '?zdCode=' + strPlace + '&ncCode=' + strNc + '" style="width:99%;height:99%;"></iframe>';
	    if(strPlace.length == 0){
	    	$.messager.alert('提示', '地块号为空，不能跳转！', 'info');
	    }else{ 
		    parent.$("#mainTabs").tabs('add', {
		        title: title,
		        content: content,
		        closable: true
		    });
	    }
	} 
</script>
</div>