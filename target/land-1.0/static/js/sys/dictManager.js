/**
 *  datagrid 初始化 
 */
function dictManager(){
$('#dictDatagrid').datagrid({
    url:"${ctx}/sys/dict/getDictsPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'dictCode',title:'字典编码',width:'16%'},
        {field:'dictName',title:'字典名称',width:'10%'},
        {field:'dictValue',title:'字典值',width:'10%'},
        {field:'dictGroup',title:'字典组',width:'10%'}
    ]],
    queryParams:$('#dictSearchConditionForm').getFormData(), 
    toolbar:"#dictToolbar",				 
	onSelect: function(index,row){selectChange(index,row);},
	onUnselect: function(index,row){selectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	dataDialog("数据字典编辑",row);
    }
});

function selectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#dictDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#dictEditButton").linkbutton("enable");
		$("#dictDeleButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#dictDeleButton").linkbutton("disable");
		$("#dictEditButton").linkbutton("disable");
	}else{
		$("#dictEditButton").linkbutton("disable");
	}
}

$('#dictSearchButton').click(function(){
	$('#dictDatagrid').datagrid('load',$('#dictSearchConditionForm').getFormData());
});

function addData(){
	dataDialog("数据字典新增",null);		 
}
function editData(){
	var selected = $('#dictDatagrid').datagrid('getSelected');
	dataDialog("数据字典编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  dict对象由DataGrid 传送 
}
function deleData(){
	var selections = $('#dictDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/sys/dict/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.data+"</div>");
	    			$("#dictDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function save(){
	var saveType =$("#dictSaveType").val();
	$.ajax({
		type: "POST",
		url:"${ctx}/sys/dict/"+saveType,
		data:$('#dictDataForm').serialize(), //将Form 里的值序列化
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   	 	$("#dictDataDialog").dialog("close");
	   		$("#dictDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.data+"</div>");
		    $("#dictDataDialog").dialog("close");
		    $("#dictDatagrid").datagrid('reload');
	    }
	}); 
}

/**
 * 本页面内DIV Dialog
 */
function dataDialog(title,selected){
	clearForm();
	if(selected!=null)
		setFormValue(selected);
	$("#dictDataDialog").show(); //先显示，再弹出
    $("#dictDataDialog").dialog({
        title: title,
        width: 450,
        height: 220,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){save();}
		},{
			text:'取消',
			handler:function(){$("#dictDataDialog").dialog("close");}
		}]
    });
}

function setFormValue(selected){
	 $("#dictName").textbox('setValue',selected.dictName);
	 $("#dictCode").textbox('setValue',selected.dictCode);
	 $("#dictGroup").textbox('setValue',selected.dictGroup);
	 $("#dictId").textbox('setValue',selected.id);
}
function clearForm(){
	 $("#dictDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
}

/**
 * 设置分页
 */
var p = $('#dictDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});
}