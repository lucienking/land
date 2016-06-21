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
</style>

<div id="container" class="easyui-layout" style="width:100%;height:100%;">
    <div id="searchPanel" data-options="region:'north',title:'查询',split:false" style="height:100px;">
    	<form id="parcelSearchForm">
    		<table style="width:100%;">
    			<tr>
    				<td class="query">地块编号：</td>
    				<td><input class="easyui-textbox" id="parcelCode" name="parcelCode"/></td>
    				<td class="query">争议对象：</td>
    				<td><input class="easyui-textbox" id="disputeObject" name="disputeObject"/></td>
    				<td class="query">面积：</td>
    				<td><input class="easyui-textbox" id="min" name="min" style="width:80px;" validType="float"/>-<input type="text" style="width:80px;" class="easyui-textbox" id="max" name="max" validType="float"/></td>
    			</tr>
    			<tr>
    				<td colspan="6" class="query">
    					<a href="#" class="easyui-linkbutton" id="searchParcel" style="display:block;width:120px;margin:0 0 0 auto">查&nbsp;询</a>
    				</td>
    			</tr>
    		</table>
    	</form>
    </div>
    <div data-options="region:'center',title:'争议地信息'" style="padding:5px;background:#eee;">
    	<table id="ownershipDatagrid"></table>
    </div>
</div>
<!-- 增删改工具栏 -->
<div id="toolbar">
		<a href="javascript:parcelAddData()" id = "parcelAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>

		<a href="javascript:parcelEditData()" id = "parcelEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>

		<a href="javascript:parcelDeleteData()" id = "parcelDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>

</div>

<!-- 增加、编辑面板 -->
<div id="ParcelDialog" style="display:none;">
	<form id="ParcelForm">
		<input id="parcelId" name="id" type="hidden">
		<input type="hidden" id="saveType" name ="saveType" value="create"></input>
		<table style="margin:0 auto;">
			<tr>
				<td class="query">地块编号:</td>
				<td>
					<input id="parcel_Code" name="parcelCode" class="easyui-textbox">
				</td>
			</tr>
			<tr>
				<td class="query">争议对象:</td>
				<td>
					<input id="dispute_Object" name="disputeObject" class="easyui-textbox">
				</td>
			</tr>
			<tr>
				<td class="query">面积:</td>
				<td>
					<input id="disputeArea" name="disputeArea" class="easyui-textbox" validType="float">
				</td>
			</tr>
		</table>
	</form>
</div>


<script>
var ctx="${ctx}";
var farmCode="${farmCode }";
//争议地信息栏
$('#ownershipDatagrid').datagrid({
    url:ctx+"/ownnership/disputeList",
    method:'get',
    pagination:true,
    pageList:[10,15,20],
    pageSize:15,
    columns:[[
        {field:'parcelCode',title:'争议地编号',width:100},
        {field:'disputeObject',title:'争议对象',width:100},
        {field:'disputeArea',title:'争议面积',width:100}
    ]],
    queryParams:$('#parcelSearchForm').getFormData(), 
    toolbar:"#toolbar",
	onSelect: function(index,row){SelectChange(index,row);},
	onUnselect: function(index,row){SelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	parcelDataDialog("菜单编辑",row);
    }
});

// 查询按钮
$('#searchParcel').click(function(){
	$('#ownershipDatagrid').datagrid('load',$("#parcelSearchForm").getFormData());
});

function SelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#ownershipDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#parcelEditButton").linkbutton("enable");
		$("#parcelDeleButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#parcelDeleButton").linkbutton("disable");
		$("#parcelEditButton").linkbutton("disable");
	}else{
		$("#parcelEditButton").linkbutton("disable");
	}
}
// 新增按钮事件
function parcelAddData(){
	parcelDataDialog("新增争议地",null);
}
// 编辑按钮事件
function parcelEditData(){
	var selected = $('#ownershipDatagrid').datagrid('getSelected');
	parcelDataDialog("编辑争议地",selected);
}
// 删除按钮事件
function parcelDeleteData(){
	var selections = $('#ownershipDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:ctx+"/ownnership/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#ownershipDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}


//显示数据编辑或保存对话框
function parcelDataDialog(title,selected){
	clearParcelForm();
	if(selected!=null)
		setParcelFormValue(selected);
	$("#ParcelDialog").show(); //先显示，再弹出
    $("#ParcelDialog").dialog({
        title: title,
        width: 300,
        height: 200,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){parcelSave();}
		},{
			text:'取消',
			handler:function(){$("#ParcelDialog").dialog("close");}
		}]
    });
}

// 保存争议地
function parcelSave(){
	var saveType =$("#saveType").val();
	if(checkNotNull('parcel_Code',"地块编号")&&checkNotNull('dispute_Object',"争议对象")&&checkNotNull('disputeArea',"面积")&&validateFloat('disputeArea')){
		$.ajax({
			type: "POST",
			url:ctx+"/ownnership/"+saveType,
			data:$('#ParcelForm').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#ParcelDialog").dialog("close");
		   		$("#ownershipDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#ParcelDialog").dialog("close");
			    $("#ownershipDatagrid").datagrid('reload');
		    }
		}); 	
	}
}
// 清除表单
function clearParcelForm(){
	$("#parcel_Code").textbox('setValue',"");
	$("#dispute_Object").textbox('setValue',"");
	$("#disputeArea").textbox('setValue',"");
	$("#saveType").val("create"); 
	$("#parcelId").val("");
}
// 获取数据项
function setParcelFormValue(selected){
	$("#parcel_Code").textbox('setValue',selected.parcelCode);
	$("#dispute_Object").textbox('setValue',selected.disputeObject);
	$("#disputeArea").textbox('setValue',selected.disputeArea);
	$("#saveType").val("update");
	$("#parcelId").val(selected.id);
}
//检测面积项提交时是否为数字
function validateFloat(id){
	if(jksbValidate(id,"isFloat")){
		return true;
	}else{
		$.messager.alert("提示：","面积：请填写数字！");
	}
}
</script>