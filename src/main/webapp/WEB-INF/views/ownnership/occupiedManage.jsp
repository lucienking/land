<%@ page language="java"  language="java"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	*{
		font-size:12px;
	}
	html,body,div{
		margin:0;
		padding:0;
	}
	td.query{
		font-size:12px;
		padding:0 2px;
 		text-align:center; 
	}
	.title_td{
		text-align:center;
	}
	.s_item{
		width:279px;
		margin:3px;
		display:inline-block;
	}
	.s_item_name{
		width:134px;
		float:left;
		text-align:center;
	}
	.s_item_inpue{
		width:145px;
		float:left;
	}
</style>

<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
<!-- 	*************************************************  地块查询界面 *************************************************-->
    <div id="searchPanel" data-options="region:'north',title:'查询',split:false" style="height:195px;min-width:600px;">
    <form id="searchForm">
    	<div class="s_item">
    		<div class="s_item_name">地块编号</div>
    		<div class="s_item_inpue">
				<input id="s_occupiedNO" name="occupiedNO" class="easyui-textbox" style="width:143px;">    			
    		</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">占地面积</div>
    		<div class="s_item_inpue">
				<input id="s_occupiedArea_low" name="occupiedArea_low" class="easyui-textbox" style="width:60px;" validType="float">
				—
				<input id="s_occupiedArea_high" name="occupiedArea_high" class="easyui-textbox" style="width:60px" validType="float"> 		
    		</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">是否林地</div>
    		<div class="s_item_inpue">
				<select id="s_isWoodland" class="easyui-combobox" name="isWoodland" style="width:143px;">
						<option value="" selected="selected"></option>
					    <option value="1">是</option>
					    <option value="0">否</option>
				</select>    			
    		</div>
    	</div>
    	<div class="s_item" id="showtip">
    		<div class="s_item_name">确权情形</div>
    		<div class="s_item_inpue">
				<jksb:diction id="s_issueSituation" name="issueSituation" groupId="ISSUE_SITUATION" cssClass="easyui-combobox" style="width:143px"></jksb:diction> 			
    		</div>
    	</div>
		<div class="s_item">
    		<div class="s_item_name">证书编号</div>
    		<div class="s_item_inpue">
				<input id="s_certificateNO" name="certificateNO" class="easyui-textbox" style="width:143px;">    			
    		</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">原地类</div>
    		<div class="s_item_inpue">
					<jksb:diction id="s_originalType" name="originalType" groupId="BEFORE_OCCUPIED" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
    		</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">占后用途</div>
    		<div class="s_item_inpue">
					<jksb:diction id="s_currentUse" name="currentUse" groupId="AFTER_OCCUPIED" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
    		</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">占地主体</div>
    		<div class="s_item_inpue">
					<jksb:diction id="s_occupiedObject" name="occupiedObject" groupId="OCCUPIED_OBJECT" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
			</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">占地形式</div>
    		<div class="s_item_inpue">
					<jksb:diction id="s_occupiedForm" name="occupiedForm" groupId="OCCUPIED_FORM" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
			</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">何种处理</div>
    		<div class="s_item_inpue">
					<jksb:diction id="s_processingMeans" name="processingMeans" groupId="PROCESSING_MEANS" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
			</div>
    	</div>
    	<div class="s_item">
    		<div class="s_item_name">是否属于土地划转</div>
    		<div class="s_item_inpue">
				<select id="s_isTransfer" class="easyui-combobox" name="isTransfer" style="width:143px;">
						<option value="" selected="selected"></option>
					    <option value="1">是</option>
					    <option value="0">否</option>
				</select>    			
    		</div>
    	</div>
    	<div class="s_item" style="width:424px;">
    		<div class="s_item_name">占地时间</div>
    		<div class="s_item_inpue" style="width:284px;">
				<input id="s_occupiedDate_low" name="occupiedDate_low" class="easyui-datebox" style="width:120px;">
				—
				<input id="s_occupiedDate_high" name="occupiedDate_high" class="easyui-datebox" style="width:120px"> 		
    		</div>
    	</div>
    	<div class="s_item" style="width:424px;">
    		<div class="s_item_name">发证时间</div>
    		<div class="s_item_inpue" style="width:284px;">
				<input id="s_issueingDate_low" name="issueingDate_low" class="easyui-datebox" style="width:120px;">
				—
				<input id="s_issueingDate_high" name="issueingDate_high" class="easyui-datebox" style="width:120px"> 		
    		</div>
    	</div>
    	<div style="display:block;"></div>
    	<div class="s_item" style="display:block;float:right;">
    		<a href="#" class="easyui-linkbutton" id="clearSearch" data-options="iconCls:'icon-undo'" style="display:inline-block;width:80px;height:29px;margin:0 15px 0 auto">清&nbsp;空</a>
    		<a href="#" class="easyui-linkbutton" id="searchOccupied" data-options="iconCls:'icon-search'" style="display:inline-block;width:80px;height:29px;margin:0 auto">查&nbsp;询</a>
    	</div>
    	</form>
    </div>
<!-- 	************************************************* ~地块查询界面~ *************************************************-->
<!-- 	*************************************************  被占地信息列表 *************************************************-->
    <div data-options="region:'center',title:'被占地信息'" style="background:#eee;">
    	<table id="occupiedCDatagrid"></table>
    </div>
<!-- 	*************************************************  ~被占地信息列表~ *************************************************-->
</div>

<!-- 	*************************************************  地块详细对话框  *************************************************-->
<div id="occupiedInfoDialog" style="display:none;">
	<form id="occupiedInfoForm">
		<input id="id" name="id" type="hidden">
		<input type="hidden" id="saveType" name ="saveType" value="create"></input>
		<table style="margin:0 auto;">
			<tr>
				<td class="title_td">地块编号</td>
				<td>
					<input id="occupiedNO" name="occupiedNO" class="easyui-textbox" style="width:143px;">
				</td>
				<td class="title_td">占地面积</td>
				<td>
					<input id="occupiedArea" name="occupiedArea" class="easyui-textbox" style="width:143px;">
				</td>
			</tr>
			<tr>
				<td class="title_td">所在市县</td>
				<td>
					<jksb:diction id="city" name="city" groupId="CITY_CODE" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
				</td>
				<td class="title_td">是否林地</td>
				<td>
					<select id="isWoodland" class="easyui-combobox" name="isWoodland" style="width:143px;">
					    <option value="1">是</option>
					    <option value="0">否</option>
					</select>
				</td>
			</tr>
			
			<tr style="">
				<td class="title_td">占地时间</td>
				<td>
					<input id="occupiedDate" name="occupiedDate" class="easyui-datebox">
				</td>
				<td class="title_td">发证时间</td>
				<td>
					<input id="issueingDate" name="issueingDate" class="easyui-datebox" style="width:143px">
				</td>
			</tr>
			<tr>
				<td class="title_td">占地时段</td>
				<td colspan="3">
					<jksb:diction id="occupiedStage" name="occupiedStage" groupId="OCCUPIED_STAGE" cssClass="easyui-combobox" style="width:370px"></jksb:diction>
				</td>
			</tr>
			<tr>
				<td class="title_td">确权情形</td>
				<td style="width:243px;color:red;font-size:11px;" colspan="3">
					<jksb:diction id="issueSituation" name="issueSituation" groupId="ISSUE_SITUATION" cssClass="easyui-combobox" style="width:60px"></jksb:diction>
					<br>确权情形分4种：1、市县政府已登记农场已领取《国有土地使用证》的；2、市县政府已登记但农场未领证取《国有土地使用证》的；3、《国有土地使用证》被收回但市县政府未注销的；4、市县未登记国有土地使用权但核发了具有林地使用权的《林权证》的。 
				</td>
			</tr>
			<tr>
				<td class="title_td">证书编号</td>
				<td>
					<input id="certificateNO" name="certificateNO" class="easyui-textbox" style="width:143px;">
				</td>
				<td class="title_td">原地类</td>
				<td>
					<jksb:diction id="originalType" name="originalType" groupId="BEFORE_OCCUPIED" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
				</td>							
			</tr>
			<tr>
				<td class="title_td">占后用途</td>
				<td>
					<jksb:diction id="currentUse" name="currentUse" groupId="AFTER_OCCUPIED" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
				</td>		
				<td class="title_td">占地主体</td>
				<td>
					<jksb:diction id="occupiedObject" name="occupiedObject" groupId="OCCUPIED_OBJECT" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
				</td>										
			</tr>
			<tr>
				<td class="title_td">占地形式</td>
				<td colspan="3">
					<jksb:diction id="occupiedForm" name="occupiedForm" groupId="OCCUPIED_FORM" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
				</td>	
			</tr>
			<tr>	
				<td class="title_td">何种处理</td>
				<td colspan="3">
					<jksb:diction id="processingMeans" name="processingMeans" groupId="PROCESSING_MEANS" cssClass="easyui-combobox" style="width:143px"></jksb:diction>
				</td>										
			</tr>
			<tr>	
				<td class="title_td">是否属于土地划转</td>
				<td>
					<input id="isTransfer" class="easyui-combobox" name="isTransfer">
				</td>	
				<td class="title_td">现土地权利人</td>
				<td>
					<input id="currentOwner" name="currentOwner" class="easyui-textbox" style="width:143px;">
				</td>									
			</tr>	
			<tr>	
				<td class="title_td">现土地权利人证书编号</td>
				<td colspan="3">
					<input id="curOwnerCertificate" name="curOwnerCertificate" class="easyui-textbox" style="width:143px;">
				</td>										
			</tr>		
		</table>
	</form>
</div>
<!-- 	*************************************************  ~地块详细对话框~ *************************************************-->
<!-- 增删改工具栏 -->
<div id="occupied_toolbar">
		<a href="javascript:parcelAddData()" id = "parcelAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>

		<a href="javascript:parcelEditData()" id = "parcelEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>

		<a href="javascript:parcelDeleteData()" id = "parcelDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>

</div>

<script>
var ctx="${ctx}";
var farmCode="${farmCode }";

//显示被占地datagrid,在属性的formatter格式化过程中，需要将返回的dictCode值展示为数据字典里的dictName值，所以需要使用
//getDictValue方法，通过dictCode和dictGroup字典所在组进行查询。
$('#occupiedCDatagrid').datagrid({
	url:ctx+"/ownnership/occupiedList",
    method:'get',
    striped:true,
    pagination:true,
    pageList:[10,15,20],
    pageSize:10,
    columns:[[
        {field:'occupiedNO',title:'被占地编号',width:100},
        {field:'occupiedArea',title:'占有面积',width:100},
        {field:'occupiedDate',title:'占地时间',width:100,formatter:function(value,row,index){
        	if(value){
        		return value.substring(0,10);
        	}
        }},
        {field:'originalType',title:'被占土地原地类',width:100,formatter: function(value,row,index){
			if (value){
				return getDictValue(value,"BEFORE_OCCUPIED");
			}
		}},
        {field:'currentUse',title:'占地后用途',width:100,formatter:function(value,row,index){
        	if(value){
        		return getDictValue(value,"AFTER_OCCUPIED");
           	}
        }},
        {field:'occupiedObject',title:'占地主体',width:100,formatter:function(value,row,index){
        	if(value){
        		return getDictValue(value,"OCCUPIED_OBJECT");
           	}
        }},
        {field:'processingMeans',title:'作过何种处理',width:150,formatter:function(value,row,index){
        	if(value){
        		return getDictValue(value,"PROCESSING_MEANS");
           	}
        }}
    ]],
    toolbar:"#occupied_toolbar",
    onSelect: function(index,row){SelectChange(index,row);},
	onUnselect: function(index,row){SelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	parcelDataDialog("被占地编辑",row);
    }
});

//在datagrid中显示指定的数据字典值
//参数：dictCode,数据字典编码；dictGroup,数据字典组
//返回：dictValue,数据字典值；
//该函数主要用于在datagrid中某列(column)的值在展示时，输出数据字典中的名字值，而不是直接输出数据库中的编码值，OK？
function getDictValue(dictValue,dictGroup){
	var rt="";
	$.ajax({
		url:ctx+"/sys/dict/findValueByCodeAndeGroup",
		type:'GET',
		async:false,
		data:{'dictValue':dictValue,'dictGroup':dictGroup},
		success:function(data){
			rt=data.dictName;
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert('显示出错',"错误提示:"+XMLHttpRequest.responseText);
		}
	});
	return rt;
}

//选择行事件 通用。
function SelectChange(index,row){ 		
	var selectedNum = $('#occupiedCDatagrid').datagrid('getSelections').length;
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

//新增按钮事件
function parcelAddData(){
	parcelDataDialog("新增被占地",null);
}

//编辑按钮事件
function parcelEditData(){
	var selected = $('#occupiedCDatagrid').datagrid('getSelected');
	parcelDataDialog("编辑被占地",selected);
}

//删除按钮事件
function parcelDeleteData(){
	var selections = $('#occupiedCDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:ctx+"/ownnership/occupieddelete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#occupiedCDatagrid").datagrid('reload');
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
	if(selected!=null){
		setParcelFormValue(selected);
	}
	$("#occupiedInfoDialog").show(); //先显示，再弹出
    $("#occupiedInfoDialog").dialog({
        title: title,
        width: 600,
        height: 440,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){parcelSave();}
		},{
			text:'取消',
			handler:function(){$("#occupiedInfoDialog").dialog("close");}
		}]
    });
}

//保存被占地
function parcelSave(){
	var saveType =$("#saveType").val();
	if(validateRequired()&&validateFloat('occupiedArea')){
		$.ajax({
			type: "POST",
			url:ctx+"/ownnership/occupied"+saveType,
			data:$('#occupiedInfoForm').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#occupiedInfoDialog").dialog("close");
		   		$("#occupiedCDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#occupiedInfoDialog").dialog("close");
			    $("#occupiedCDatagrid").datagrid('reload');
		    }
		}); 	
	}
}

// 检测必填项是否为空
function validateRequired(){
	var inputs = new Array("occupiedNO",
							"occupiedArea");
	var selects = new Array("city",
							"occupiedDate",
							"issueingDate",
							"isWoodland",
							"issueSituation",
							"originalType",
							"currentUse",
							"occupiedObject",
							"occupiedForm",
							"processingMeans",
							"isTransfer");
	return validateInputGroup(inputs,selects);
}
// 清除编辑或新增的表单
function clearParcelForm(){
	$("#occupiedNO").textbox('setValue','');
	$("#city").combobox('setValue','');
	$("#occupiedArea").textbox('setValue','');
	$("#occupiedDate").datebox('setValue', '');
	$("#issueingDate").datebox('setValue', '');
	$("#occupiedStage").combobox('setValue','');
	$("#isWoodland").combobox('setValue','1');
	$("#issueSituation").combobox('setValue','1');
	$("#certificateNO").textbox('setValue','');
	$("#originalType").combobox('setValue','1');
	$("#currentUse").combobox('setValue','1');
	$("#occupiedObject").combobox('setValue','1');
	$("#occupiedForm").combobox('setValue','1');
	$("#processingMeans").combobox('setValue','1');
	$("#isTransfer").combobox('setValue','0');
	$("#currentOwner").textbox('setValue','');
	$("#curOwnerCertificate").textbox('setValue','');
	$("#id").val('');
	$("#saveType").val('create');
}
// 编辑时设置表单各项值
function setParcelFormValue(selected){
	$("#occupiedNO").textbox('setValue',selected.occupiedNO);
	$("#city").combobox('setValue',selected.city);
	$("#occupiedArea").textbox('setValue',selected.occupiedArea);
	$("#occupiedDate").datebox('setValue', selected.occupiedDate);
	$("#issueingDate").datebox('setValue', selected.issueingDate);
	$("#occupiedStage").combobox('setValue',selected.occupiedStage);
	$("#isWoodland").combobox('setValue',selected.isWoodland);
	$("#issueSituation").combobox('setValue',selected.issueSituation);
	$("#certificateNO").textbox('setValue',selected.certificateNO);
	$("#originalType").combobox('setValue',selected.originalType);
	$("#currentUse").combobox('setValue',selected.currentUse);
	$("#occupiedObject").combobox('setValue',selected.occupiedObject);
	$("#occupiedForm").combobox('setValue',selected.occupiedForm);
	$("#processingMeans").combobox('setValue',selected.processingMeans);
	$("#isTransfer").combobox('setValue',selected.isTransfer);
	$("#currentOwner").textbox('setValue',selected.currentOwner);
	$("#curOwnerCertificate").textbox('setValue',selected.curOwnerCertificate);
	$("#id").val(selected.id);
	$("#saveType").val('update');
}
//清除查询面板各项值
function clearSearchForm(){
	$("#s_occupiedNO").textbox('setValue','');
	$("#s_occupiedArea_low").textbox('setValue','');
	$("#s_occupiedArea_high").textbox('setValue','');
	$("#s_issueSituation").combobox('setValue', '');
	$("#s_certificateNO").textbox('setValue', '');
	$("#s_originalType").combobox('setValue','');
	$("#s_currentUse").combobox('setValue','');
	$("#s_occupiedObject").combobox('setValue','');
	$("#s_occupiedForm").combobox('setValue','');
	$("#s_processingMeans").combobox('setValue','');
	$("#s_occupiedDate_low").datebox('setValue', '');
	$("#s_occupiedDate_high").datebox('setValue', '');
	$("#s_issueingDate_low").datebox('setValue', '');
	$("#s_issueingDate_high").datebox('setValue', '');
	$("#s_isTransfer").combobox('setValue','');
};
// 占地时间、发证时间及占地阶段的联动设置
$("#occupiedStage").combobox({
	readonly:true,
	hasDownArrow:false
});
$("#occupiedDate").datebox({
	width:143,
	onChange:function(newValue, oldValue){
		var issueingDate=$("#issueingDate").datebox('getValue');
		var occupiedDate=$("#occupiedDate").datebox('getValue');
		if(issueingDate!="" && issueingDate!= null && issueingDate!= undefined ){
			if(occupiedDate<"1982-05-14"){
				$("#occupiedStage").combobox('setValue',"0");
			}else if("1982-05-14"<occupiedDate&&occupiedDate<issueingDate){
				$("#occupiedStage").combobox('setValue',"1");
			}else{
				$("#occupiedStage").combobox('setValue',"2");
			}
		}
	}
});
$("#issueingDate").datebox({
	onChange:function(newValue, oldValue){
		var issueingDate=$("#issueingDate").datebox('getValue');
		var occupiedDate=$("#occupiedDate").datebox('getValue');
		if(occupiedDate!="" && occupiedDate!= null && occupiedDate!= undefined ){
			if(occupiedDate<"1982-05-14"){
				$("#occupiedStage").combobox('setValue',"0");
			}else if("1982-05-14"<occupiedDate&&occupiedDate<issueingDate){
				$("#occupiedStage").combobox('setValue',"1");
			}else{
				$("#occupiedStage").combobox('setValue',"2");
			}
		}
	}
});
//是否划转土地联动相关填写项，是或否决定现权利人和现权利人证件是否有值且可编辑
$('#isTransfer').combobox({
	width:143,
	valueField:'label',
	textField:'text',
	data:[{
		label:'1',
		text:'是'
	},{
		label:'0',
		text:'否'
	}],
	onChange:function(newValue, oldValue){
		if(newValue=="0"){
			$('#currentOwner').textbox({
				editable:false
			});
			$('#currentOwner').textbox('setValue','');
			$('#curOwnerCertificate').textbox({
				editable:false
			});
			$('#curOwnerCertificate').textbox('setValue','');
		}else{
			$('#currentOwner').textbox({
				editable:true
			});
			$('#curOwnerCertificate').textbox({
				editable:true
			});
		}
	}
});
//检测面积项提交时是否为数字
function validateFloat(id){
	if(jksbValidate(id,"isFloat")){
		return true;
	}else{
		$.messager.alert("提示：","面积：请填写数字！");
	}
};

//确权情形提示框
$('#showtip').tooltip({
    position: 'bottom',
    content: '<span style="color:#fff">1、市县政府已登记农场已领取《国有土地使用证》的；<br>2、市县政府已登记但农场未领证取《国有土地使用证》的；<br>3、《国有土地使用证》被收回但市县政府未注销的；<br>4、市县未登记国有土地使用权但核发了具有林地使用权的《林权证》的。 </span>',
    onShow: function(){
        $(this).tooltip('tip').css({
            backgroundColor: '#666',
            borderColor: '#666'
        });
    }
});
//查询按钮
$('#searchOccupied').click(function(){
	$('#occupiedCDatagrid').datagrid('load',$("#searchForm").getFormData());
});
//清楚按钮
$('#clearSearch').click(function(){
	clearSearchForm();
});
//文件加载完后设置查询面板默认值为空，否则加载时，会带着个选项的默认值进行查询被占地
$(document).ready(function(){ 
	clearSearchForm();
}); 
</script>