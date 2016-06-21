<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div id= "agriParcelQueryContainer">
<div id="agriParcelQuerySearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="agriParcelQuerySearchConditionForm">
		<table style="width:99%;margin-buttom:10px;font-size:12px;">
			<tr>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_agriParcelQueryendDate">选择农场</label>
					<input id="search_agriParcelQuery_farmCode" style="width:120px;" name="farmCode"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_agriParcelQueryName">身份证号</label>
					<input id="search_agriParcelQueryName" name="IDcardNo" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_agriParcelQuerystartDate">户主姓名</label>
					<input id="search_agriParcelQueryCode" name="familyHost" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_agriParcelQueryendDate">地块编号</label>
					<input id="search_agriParcelQueryCode" name="zdCode" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="12%" colspan="1"  align="center" style="min-width:150px">
						&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="4"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="agriParcelQuerySearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="agriParcelQuerySearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="agriParcelQueryDatagrid" style="width:100%;"></table>
</div>

<div id="agriParcelQueryEditDialog"  style="width:99%;height:99%;display:none;">
</div>
<div id="agriParcelQueryDetailInfoDialog"  style="width:99%;height:99%;display:none;">
</div>

<div id="agriParcelQueryToolbar">
	<jksb:hasAutority authorityId="009002">
		<a href="#"
			id="agriParcelPrintButton" class="easyui-linkbutton"
			data-options="iconCls:'icon-print',plain:true,disabled:true,">打印地块信息</a>
	</jksb:hasAutority>
</div>

<script type="text/javascript">
 var farmCode = "${farmCode}" ;
 
/**
 *  datagrid 初始化 
 */
$('#agriParcelQueryDatagrid').datagrid({
    url:"${ctx}/agriRes/selfSupport/getAgriSelfParcel",
    method:'get',
    pagination:true,
    columns:[[
		{checkbox:true,field:'',title:'' },      
        {field:'id',title:'序号',width:'5%',sortable:true},
        {field:'parcelCode',title:'地块编号',width:'6%'},
        {field:'contractorName',title:'户主',width:'8%',align:'center'},
        {field:'actualArea',title:'实际面积',width:'8%',align:'center'},
        {field:'theySaidArea',title:'自报面积',width:'8%',align:'center'},
        {field:'plant',title:'种植作物',width:'10%',align:'center'},
        {field:'farmName',title:'所在农场',width:'10%',align:'center'},
        {field:'communityName',title:'所在社区',width:'10%',align:'center'},
        {field:'residentsGrpName',title:'所在生产队',width:'10%',align:'center'},
        {field:'location',title:'所在位置',width:'15%',align:'center'},
        {field:'farmCode',hidden:true},
        {field:'residentsGrpName',hidden:true}
    ]] ,
    queryParams:$('#agriParcelQuerySearchConditionForm').getFormData(), 
    toolbar:"#agriParcelQueryToolbar",				 
	onSelect: function(index,row){agriParcelQuerySelectChange(index,row);},
	onUnselect: function(index,row){agriParcelQuerySelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    } 
});

function agriParcelQuerySelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#agriParcelQueryDatagrid').datagrid('getSelections').length;
	if(selectedNum==0 ){
		$("#agriParcelPrintButton").linkbutton("disable");
	}else{
		$("#agriParcelPrintButton").linkbutton("enable");
	}
}

$('#agriParcelQuerySearchButton').click(function(){
	$('#agriParcelQueryDatagrid').datagrid('load',$('#agriParcelQuerySearchConditionForm').getFormData());
});

$('#agriParcelPrintButton').click(function(){
	var selections = $('#agriParcelQueryDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('打印确认','确定打印这 '+num+' 项吗?',function(r){
		var flag = true;
	    if (r){
	    	var farmCode = "";
	    	var zdCode = "";
	    	var groupName = "";
	    	var farmName = "";
	    	var contractorName = selections[0].contractorName;
	    	for(sele in selections){
	    		if(selections[sele].farmCode!=selections[0].farmCode){
	    			flag = false;
	    		}
	    		farmName = selections[sele].farmName;
	    		groupName += selections[sele].residentsGrpName;
	    		if(sele<(num-1)) groupName += ",";
	    		zdCode += selections[sele].parcelCode;
	    		if(sele<(num-1)) zdCode += ",";
	    		farmCode += selections[sele].farmCode;
	    		if(sele<(num-1)) farmCode += ",";
	    	}
	    	if(flag){
		    	var url = "${ctx}/agriRes/selfSupport/forwardToMap?farmCode="+farmCode+"&zdCode="+zdCode+"&groupName="+groupName+"&farmName="+farmName+"&contractorName="+contractorName;
		    	forwardToTabPage(url,"地块地图");  
	    	}else{
	    		$.messager.alert("提示","请选择同一农场地块进行打印。");
	    	}
	    }
	});
});

/**
 * 设置分页
 */
var p = $('#agriParcelQueryDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

 $("#search_agriParcelQuery_farmCode").combobox({
 	url:'${ctx}/sys/org/getAllFarms',
     valueField:'code',
     textField:'name',
     method:'GET',
     readonly:true,
 	onLoadSuccess:function(){
 		$("#search_agriParcelQuery_farmCode").combobox("select","${farmCode}");
 		if("${farmCode}" == "1"){ 
 			$(this).combobox("readonly",false);
 		}
 		$('#agriParcelQueryDatagrid').datagrid('reload',$('#agriParcelQuerySearchConditionForm').getFormData());
 	}
 }); 
 
 function forwardToTabPage(url,title){
	    if (parent.$("#mainTabs").tabs('exists', title)) {
	        parent.$("#mainTabs").tabs('close', title);
	    }
	    var content = '<iframe scrolling="no" frameborder="0"  src="' + url + '" style="width:99%;height:99%;"></iframe>';
        parent.$("#mainTabs").tabs('add', {
            title: title,
            content: content,
            closable: true
        });
 }
  
</script>
</div>

