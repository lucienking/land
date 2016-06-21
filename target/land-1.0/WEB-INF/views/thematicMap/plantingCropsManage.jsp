<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@ page import="java.util.ResourceBundle"%>
<%
	ResourceBundle res = ResourceBundle.getBundle("application");
	String serverURL = res.getString("arcgis.service.url");
	String apiUrl = res.getString("arcgis.api.url");
	String server151URL = res.getString("arcgis151.service.url");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<c:set var="arcgisService151Url" value="<%=server151URL%>" />
<c:set var="arcgisServiceUrl" value="<%=serverURL%>" />
<c:set var="arcgisapiUrl" value="<%=apiUrl%>" />

<!-- easyUI -->
<link href="${ctx}/static/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<!-- arcGIS -->
<link rel="stylesheet"
	href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/esri/css/esri.css">
<link rel="stylesheet"
	href="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/js/dojo/dijit/themes/tundra/tundra.css">
<link rel="stylesheet" type="text/css" href="${ctx }/static/js/map/Toc/css/agsjs.css">

<script src="${ctx }/static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="${ctx }/static/jquery-easyui/datagrid-groupview.js"></script>
<script src="${ctx }/static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="${ctx }/static/js/jksb.land.common.js"></script>
<script src="${ctx }/static/js/jksb.land.validate.js"></script>
<script type="text/javascript">
	// helpful for understanding dojoConfig.packages vs. dojoConfig.paths:
	// http://www.sitepen.com/blog/2013/06/20/dojo-faq-what-is-the-difference-packages-vs-paths-vs-aliases/
	var dojoConfig = {
		paths : {
			//if you want to host on your own server, download and put in folders then use path like: 
			agsjs : location.pathname.replace(/\/[^/]+$/, '')
					+ '/../static/js/map/Toc'
		}
	};
</script>

<script type="text/javascript"
	src="${arcgisapiUrl}/arcgis_js_api/library/3.9/3.9/init.js"></script>
<!-- 自定义JS,css引用 -->
<link href="../static/styles/default.css" type="text/css"
	rel="stylesheet" />
<link href="../static/styles/iconstyle.css" type="text/css"
	rel="stylesheet" />
	
<script type="text/javascript" src="${ctx }/static/js/map/Map.js"></script>
<script type="text/javascript" src="${ctx }/static/js/map/plantingCrops_map.js"></script>
<script>
	var serverURL = "${arcgisServiceUrl}";
	var server151URL = "${arcgisService151Url}";
</script>	
<style>
#searchForm>div{
	padding:5px 0 5px 0;
	display:inline;
	line-height:40px;
}
#ll{
	text-align:center;
}
#ll label{
	display:inline-block;
	width:50px;
}
</style>
<div>
	<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	    <div id="searchForm" data-options="region:'north',title:'查询地块',split:true" style="position:relative;min-height:120px;">
	    		<div>
					<label for="farmName">所在农场</label>
					<input id="farmName" type="text" name="farmName" value="${farmName }" class="easyui-combobox" style="height:30px;" />
					<input id="farmCode" type="hidden" value="${farmCode }"/>
				</div>
				
				<div>
					<label for="atCommunity">所在社区</label>
					<input id="atCommunity" name="atCommunity" class="easyui-combobox"  style="height:30px;" />
				</div>
				
				<div>
					<label for="residentsGrpCode">居民小组</label>
					<input id="residentsGrpCode" name="residentsGrpCode" class="easyui-combobox" value="" style="height:30px;"/>
				</div>
				
				<div>
					<label for="contractParcelCode">地块编号</label>
					<input id="contractParcelCode" name="contractParcelCode" class="easyui-textbox" value="" style="height:30px;"/>
				</div>
				
				<div style="width:140px;display:block;position:absolute;right:10px;">
					<a data-options="iconCls:'icon-search'" id="search" class="easyui-linkbutton">查&nbsp;询</a>
				</div>
	    </div>
	    <div id="map" data-options="region:'east',title:'地图',split:true" style="width:500px;">
	    	<div id="mapDiv" style="width:100%;height:100%"></div>
	    </div>
	    <div id="managePanel" data-options="region:'center',title:'地块信息'" style="padding:5px;background:#eee;">
	    	<table id="parcelList"></table>
	    </div>
	</div>
	
	 <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存修改</a>
        <a href="javascript:void(0)" title="注意，保存后的数据将无法撤销" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="addPlant()">添加作物</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removePlant()">删除作物</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="locateParcel()">定&nbsp;&nbsp;位</a>
    </div>
</div>

<div id="addPlantDialog" style="display:none;">
	<form id="ll">
		<div>
			<label for="add_contractParcelCode">地块编号</label>
			<input id="add_contractParcelCode" name="contractParcelCode" class="easyui-textbox" style="height:30px;" readonly="readonly"/>
		</div>
		
		<div>
			<label for="add_pcName">种植作物</label>
			<input id="add_pcName" name="pcName" class="easyui-combobox" style="height:30px;width:140px;"/>
		</div>
		
		<div>
			<label for="add_plantedArea">面积</label>
			<input id="add_plantedArea" type="text" name="plantedArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
		</div>
		
		<div>
			<label for="add_plantedAcount">株数</label>
			<input id="add_plantedAcount" type="text" name="plantedAcount" class="easyui-textbox" style="height:30px;" data-options="validType:'number'"/>
		</div>
		
		<div>
			<label for="add_plantedYear">定植年度</label>
			<input id="add_plantedYear" type="text" name="plantedYear" class="easyui-datebox" style="height:30px;"/>
		</div>
	</form>
</div>

<script>
// ******************************************************地块-种植作物列表*******************************************************
$('#parcelList').datagrid({
	url:'${ctx}/plantingCrops/getParcelListBySQL',
	method:'get',
    pagination: true,
    toolbar: '#tb',
    pageSize:10,
    singleSelect:true,
    view:groupview,
    groupField:'contract_parcel_code',
    queryParams:{
    	contract_code:('${farmCode}'.indexOf('1')==0)?'':'${farmCode}'
    },
    onClickRow: function(index,row){
    	onClickRow(index);
    },
    groupFormatter:function(value,rows){
        return '地块编号'+value + ' - 共' + rows.length + '种作物';
    },
	columns:[[
		{field:'contract_parcel_code',title:'地块编号',width:100
// 			,formatter:function(value,row){
// 				if(value){
// 					return value.contractParcelCode;
// 				}
// 			}
		},
		{	
			field:'pc_name',
			title:'种植作物',
			width:200,
			editor:{	//combobox编辑，种植作物
	            type:'combobox',
	            options:{
	                valueField:'pcName',
	                textField:'pcName',
	                groupField:'scdClassName',
	                groupFormatter: function(group){
	            		return '<span style="color:red">' + group + '</span>';
	            	},
	                method:'get',
	                url:'${ctx}/plantingCrops/getAllPlantingCrops',
                    required:true
	            }
	        }
		},
		{field:'planted_area',title:'面积（亩）',width:100,editor:{type:'numberbox',options:{precision:2}}},
		{field:'planted_acount',title:'株数',width:100,editor:{type:'numberbox'}},
		{field:'planted_year',title:'定植年度',width:100,formatter:function(value,row,index){
	        	if(value){
	        		return value.substring(0,10);
	        	}
        	},
        	editor:{
        		type:'datebox'
        	}
		}
	]],
	onLoadSuccess:function(data){
		//这里如果编辑标识不设undefined，刷新列表的时候，重新编辑会发现找不到编辑器，因为上回的编辑标识没设undefined，
		//程序以为这不是一次新的开始编辑，读取不到editors
		editIndex=undefined;	
	}
});

// *********************************************************************查询面板*******************************************************************
/**
 * 社区 居民小组联动 combox
**/

$('#farmName').combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
	onLoadSuccess:function(){
		$("#farmName").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false); 
			getCommunity("1");
		}
	},
	onSelect:function(rec){
		getCommunity(rec.code);
	}
});

// 选择社区
function getCommunity(farmCode){
	if(farmCode=='1'){
		$('#atCommunity').combobox('setValue','');
	}else{
		$('#atCommunity').combobox({readonly:false});
		$("#atCommunity").combobox({
			url:'${ctx}/community/getCommunityByFarmCode',
		    valueField:'id',
		    textField:'text',
		    method:'GET',
		   	queryParams:{"farmCode":farmCode},
		   	onSelect:function(value){
		   		$('#residentsGrpCode').combobox('clear'); 
		   		var url = '${ctx}/group/getResidentsGroupByCommunity?communityCode='+value.id;
		   		$('#residentsGrpCode').combobox({
		   			url:url,
		   			valueField:'id',
		   		    textField:'text',
		   			method:'get'
		   		}); 
		   	}
		});
	}
}

$('#search').bind('click',function(){
	var datam='';
	if($('#residentsGrpCode').combobox('getValue')!=''){
		datam=$('#residentsGrpCode').combobox('getValue');
	}else if($('#atCommunity').combobox('getValue')!=''){
		datam=$('#atCommunity').combobox('getValue');
	}else if($('#farmName').combobox('getValue')!=''){
		datam=$('#farmName').combobox('getValue');
	}else {
		datam='';
	}
	
	var contractParcelCode=$('#contractParcelCode').textbox('getValue');
	
	$('#parcelList').datagrid('reload',{
		'contract_code':datam,
		'contractParcelCode':contractParcelCode
	});
});

// *********************************************************增减种植作物**********************************************
function addPlant(){
	clearAddForm();
	var addedPlant=$('#parcelList').datagrid('getSelected');
	if(addedPlant!=null&&addedPlant!=''){
		$('#addPlantDialog').show();
		$('#add_pcName').combobox({
			valueField:'pcName',
		    textField:'pcName',
		    groupField:'scdClassName',
		    groupFormatter: function(group){
				return '<span style="color:red">' + group + '</span>';
			},
		    method:'get',
		    url:'${ctx}/plantingCrops/getAllPlantingCrops',
		    required:true
		    });
		$("#addPlantDialog").dialog({
	        title: '为地块'+addedPlant.contract_parcel_code+'添加种植作物：',
	        modal:true,
	        width:280,
	        height:300,
	        buttons:[{
				text:'增&nbsp;加',
				handler:function(){
					if(validContent()){
						$.ajax({
							url:'${ctx}/plantingCrops/savePlantRelationship',
		                	method:'POST',
		                	data:$('#ll').getFormData(),
			                success:function(data){
			                	$.messager.alert('操作结果',data.message);
								$('#addPlantDialog').dialog('close');
			    			},
			    			error:function(XMLHttpRequest, textStatus, errorThrown){
			    				$.messager.alert('操作结果',"第"+wrong+"行填写错误！"+XMLHttpRequest.responseText);
			    				return;
			    			}
						})
					}else{
						
					}
				}
			},{
				text:'关&nbsp;闭',
				handler:function(){
					$('#addPlantDialog').dialog('close');
				}
			}]
	    });
		$('#add_contractParcelCode').textbox('setValue',addedPlant.contract_parcel_code);
		
	}else{
		$.messager.alert('提示','请选择一条信息');
	}
}

function clearAddForm(){
	$('#add_contractParcelCode').textbox('setValue','');
	$('#add_pcName').combobox('setValue','');
	$('#add_plantedArea').textbox('setValue','');
	$('#add_plantedAcount').textbox('setValue','');
	$('#add_plantedYear').datebox('setValue','');
	
}

// 校验填写内容正确性
function validContent(){
	if($('#add_pcName').combobox('getValue')==''||$('#add_pcName').combobox('getValue')==null){
		$.messager.alert('操作','请填写种植作物');
		return false;
	}
	else if(!checkNotNull('add_plantedArea','面积')){
		return false;
	}
	else if(!validFloat()){
		$.messager.alert('操作','请填写两位小数');
		return false;
	}else if(!validInt()){
		$.messager.alert('操作','请填写正整数');
		return false;
	}else{
		return true;
	}
}

//校验小数项
function validFloat(){
	var t=$('#add_plantedArea').textbox('getValue');
	var reg=new RegExp(isNonNegatedRealNumber2);
	if(reg.test(t)){
		return true;
	}else{
		return false;
	}
}

//校验整数项
function validInt(){
	var t=$('#add_plantedAcount').textbox('getValue');
	var reg=new RegExp(isNumber);
	if(reg.test(t)){
		return true;
	}else{
		return false;
	}
}
//删除作物
function removePlant(){
	var delePlant=$('#parcelList').datagrid('getSelected');
	$.messager.confirm('删除地物', '确认删除该地块的此项种植作物吗？', function(r){
		if(r){
			if(delePlant!=''&&delePlant!=null){
				$.ajax({
					url:'${ctx}/plantingCrops/deletePlantRelationship',
                	method:'POST',
                	data:{'id':delePlant.id},
                	success:function(data){
	                	$.messager.alert('操作结果',data.message);
	                	$('#parcelList').datagrid('reload');
	    			},
	    			error:function(XMLHttpRequest, textStatus, errorThrown){
	    				$.messager.alert('操作结果',"出错："+XMLHttpRequest.responseText);
	    				return;
	    			}
				});
			}
		}
	});
}
</script>
<!--*********************************************************** 表格编辑器 ************************************************************-->
    <script type="text/javascript">
        var editIndex = undefined;
        function endEditing(){
            if (editIndex == undefined){return true;}
            if ($('#parcelList').datagrid('validateRow', editIndex)){
                var ed = $('#parcelList').datagrid('getEditor', {index:editIndex,field:'pc_name'});
                var pcName = $(ed.target).combobox('getText');
                $('#parcelList').datagrid('getRows')[editIndex]['pc_name'] = pcName;
                $('#parcelList').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true; 
            } else {
                return false;
            }
        }
        function onClickRow(index){
            if (editIndex != index){
                if (endEditing()){
                    $('#parcelList').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#parcelList').datagrid('selectRow', editIndex);
                }
            }
        }
        function accept(){
            var updateItems=0,wrong=0;
            if (endEditing()){
                var rows = $('#parcelList').datagrid('getChanges');
                $('#parcelList').datagrid('acceptChanges');
                for(var i=0;i<rows.length;i++){
	                $.ajax({
	                	url:'${ctx}/plantingCrops/saveChangedParcels',
	                	method:'POST',
	                	data:rows[i],
		                success:function(data){
		                	if(data){
		                		updateItems++;
		                	}
		    			},
		    			error:function(XMLHttpRequest, textStatus, errorThrown){
		    				$.messager.alert('操作结果',"第"+wrong+"行填写错误！"+XMLHttpRequest.responseText);
		    				return;
		    			}
	                });
                }
                $.messager.alert('提示信息',"<div style='text-align:left;width:100%;'>修改成功</div>");
            }
            editIndex = undefined;
        }
        function reject(){
            $('#parcelList').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges(){
            var rows = $('#parcelList').datagrid('getChanges');
            alert(rows.length+' rows are changed!');
        }
 </script>