

/**
 * 初始化加载数据
 */
$("#conVersionDatagrid").datagrid({
		url: ctx+"/contractVersion/getContractVersions",
		method:"get",
		pagination:true,
		toolbar: '#conVtoolbar',
		columns:[[
			{checkbox:true,field:'',title:'' },
			{field:'contractVersionNo',title:'合同模板编号',width:'20%',sortable:true},
			{field:'contractName',title:'合同模板名称',width:'30%'},
			{field:'publishDept',title:'发布部门',width:'20%'},
			{field:'createDate',title:'创建时间',width:'15%'},
			{field : 'operations',title:'下载模板',width:'10%',
				formatter: function(value,row,index){
					var edit="<a class='edit' href='javascript:void(0);'></a>";
					return edit;
				}
			},
		]], 
		onSelect: function(index,row){selectCVChange(index,row);},
		onUnselect: function(index,row){selectCVChange(index,row);},    
		onDblClickRow:function (index,row){	   //双击行事件 
			contractVersionDialog("菜单编辑",row);
	    } 
});

/**
 * 工具栏增删改按钮可用控制
 */
function selectCVChange(index,row){
	var selectNum=$('#conVersionDatagrid').datagrid('getSelections').length;
	if(selectNum==1){
		$('#editCVButton').linkbutton('enable');
		$('#deleCVButton').linkbutton('enable');
	}else if(selectNum==0){
		$('#editCVButton').linkbutton('disable');
		$('#deleCVButton').linkbutton('disable');
	}else{
		$('#editCVButton').linkbutton('disable');
	}
}

/**
 * 添加合同模板按钮单击事件
 * 权限编码：005001006001
 */
function addCVData(){
	contractVersionDialog("新增合同版本",null);
}

/**
 * 编辑合同模板按钮单击事件
 * 权限编码：005001006003
 */
function editCVData(){
	var selected=$('#conVersionDatagrid').datagrid('getSelected');
	contractVersionDialog("编辑合同版本",selected);
}

/**
 * 删除合同模板
 * 权限编码：005001006002
 */
function deleCVData(){
	var selections=$('#conVersionDatagrid').datagrid('getSelections');
	var selectNum=selections.length;
	$.messager.confirm("删除确认", '确定删除这'+selectNum+'项吗？', function(r){
		if(r){
			var ids="";
			for(sele in selections){
				ids+=selections[sele].id;
				if(sele<(selectNum-1)) ids+=',';
			}
			$.ajax({
				url:ctx+'/contractVersion/deleteContractVersion',
				tyep:'GET',
				data:{'ids':ids},
				success:function(data){
					$.messager.alert('操作结果', "<div style='text-align:center;width:100%'>"+data.data+"</div>");
					$('#conVersionDatagrid').datagrid('reload');
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					$.messager.alert('操作失败','失败原因'+XMLHttpRequest.responseText);
				}
			});
		}
	});
}

/**
 * 本页面内DIV Dialog
 */
function contractVersionDialog(title,selected){
	clearCVForm();
	if(selected!=null)
		setCVFormValue(selected);
	$("#conVersionDialog").show(); //先显示，再弹出
    $("#conVersionDialog").dialog({
    	id:'conVersionDialog',
        title: title,
        width: 350,
        modal:true,
        cache: false,
        buttons:[{
			text:'保存',
			handler:function(){saveCV();}
		},{
			text:'取消',
			handler:function(){$("#conVersionDialog").dialog("close");}
		}]
    });
}

/**
 * 编辑合同时，填充该选项的各项数据到对话框中
 */
function setCVFormValue(selected){
	$('#conVersionId').val(selected.id);
	$('#contractVersionNo').textbox('setValue',selected.contractVersionNo);
	$('#contractName').textbox('setValue',selected.contractName);
	$('#contractDesc').textbox('setValue',selected.contractDesc);
	$('#publishDept').textbox('setValue',selected.publishDept);
	$('#CVsaveType').val('update');
}

/**
 * 保存合同版本数据
 */
function saveCV(){
	var saveType=$('#CVsaveType').val();
	
	$.ajaxFileUpload({ 
		url:ctx+"/contractVersion/"+saveType,
		method:'POST',
		secureuri : false,  
		fileElementId : fileElemId,// 上传控件的id  
		data:$('#conVersionForm').serialize(),
		asyn:false,
		error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   	 	$("#conVersionDialog").dialog("close");
	   		$("#conVersionDatagrid").datagrid('reload');
	    },
	    success: function(data,status) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#conVersionDialog").dialog("close");
		    $("#conVersionDatagrid").datagrid('reload');
	    }
	});
}
/**
 * 清空表单
 */
function clearCVForm(){
	 $("#contractVersionNo").textbox('setValue',"");
	 $("#contractName").textbox('setValue',"");
	 $("#contractDesc").textbox('setValue',"");
	 $("#publishDept").textbox('setValue',"");
//	 $("#contractTemplate").textbox('setValue',"");
	 $("#conVersionId").val("");
	 $("#CVsaveType").val("create"); 
}