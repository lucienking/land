<%@ page language="java" contentType="text/html; charset=UTF-8" language="java"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<!-- easyUI -->
<link href="${ctx}/static/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<script src="${ctx }/static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="${ctx }/static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="${ctx }/static/js/jksb.land.common.js"></script>
<style>
tr{
	line-height:30px;
}
td{
	padding:0;
	font-size:12px;
}
</style>

<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
<!-- *********************************************************左侧列表栏********************************************************* -->
	<div id="contractListDIV" data-options="region:'west',title:'合同列表',split:true" style="width:340px;">
			<!-- 	查询界面 -->
			<div id="contractSearchPanel" style="width:100%">
				<form id="contractSearchForm">
					<table id="contractSearch">
						<tr>
							<td>承包人</td>
							<td><input id="secondParty" name="secondParty" class="easyui-textbox" style="width:120px"></td>
							<td>面积</td>
							<td>
								<input id="lowA" name="lowA" class="easyui-textbox" style="width:50px"/>-<input id="highA" name="highA" class="easyui-textbox" style="width:50px"/>亩
							</td>
						</tr>
						<tr>
							<td>单价</td>
							<td>
							<input id="lowP" name="lowP" class="easyui-textbox" style="width:50px">-<input id="highP" name="highP" class="easyui-textbox" style="width:50px">元
							</td>
							<td colspan="2" align="center">
								<a href="#" class="easyui-linkbutton" id="searchContract" style="display:block;width:80px;">查&nbsp;询</a>
							</td>
						</tr>
			<!-- 	合同列表 -->
						<tr>
							<td colspan="4"><table id="contractList"></table></td>
						</tr>
						
					</table>
				</form>
			<!-- 	审核按钮 footer-->
			    <div id="ft" style="padding:2px 5px;text-align:right">
			        <a href="javascript:contractDeny()" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">不通过</a>
			        <a href="javascript:contractPass()" class="easyui-linkbutton" iconCls="icon-ok" plain="true">通过</a>
			    </div>
			</div>
    </div>
<!--*********************************************************合同详细信息********************************************************* -->
    <div data-options="region:'center',title:'合同详细信息'" style="padding:5px;background:#eee;">
	    <!-- 	合同详细界面 -->
		<div id="contractDetail" class="easyui-panel" style="width:100%;min-width:200px;height:100%">
			<!-- 	承包人详细信息 -->
			<div id="contractTable" style="display:none">
				<table id="showContractors">
				</table>
			</div>
		</div>
    </div>
<!-- 审核不通过  弹出   审议意见对话框 -->
    <div id="auditOpinion" style="display:none">
    	请填写审核意见（原因）
    	<form id="auditOpinianForm">
    		<input id="contractIds" name="contractIds" type="hidden"/>
    		<textarea id="auditOpinions" name="auditOpinions" style="width:98%;height:200px"></textarea>
    	</form>
    </div>
</div>



<script type="text/javascript">
	var ctx="${ctx}";
	/*
	*初始化合同列表
	*/
	$('#contractList').datagrid({
		url:ctx+'/contractAudit/listAuditingContract',
		method:'get',
	    pagination:true,
	    pageSize:'20',
		columns:[[
		    {field:'',checkbox:'true'},
			{field:'secondParty',title:'承包人',width:100},
			{field:'useArea',title:'面积',width:60,sortable:true},
			{field:'signingPrice',title:'单价',width:60,sortable:true}
		]],
		queryParams:$("#contractSearchForm").getFormData(),
		ctrlSelect:true,
		checkOnSelect:false,
		selectOnCheck:false,
// 		单击一条合同记录，就在合同详细面板中显示承包人信息。
		onClickRow:function(index,row){
				$('#contractTable').show();
				$('#showContractors').datagrid({
					url:ctx+'/contractAudit/showContractors',
					method:'get',
					pagination:false,
					columns:[[
					        {field:'contractorName',title:'承包人姓名',width:80},
					        {field:'contractorIDNO',title:'承包人证件号码',width:150},
					        {field:'contractArea',title:'承包面积',width:80},
					        {field:'isStaff',title:'是否职工',width:60,formatter:function(value,row,index){
					        	if(row.isStaff=='Y'){
					        		return "是";
					        	}else{
					        		return "否";
					        	}
					        }},
					        {field:'isCadres',title:'是否干部',width:60,formatter:function(value,row,index){
					        	if(row.isCadres=='Y'){
					        		return "是";
					        	}else{
					        		return "否";
					        	}
					        }},
					]],
					queryParams:{code:row.contractCode}
				});
		},
		footer:'#ft'
	});
	
// 	根据条件查询合同
	$('#searchContract').click(function(){
		$('#contractList').datagrid('load',$("#contractSearchForm").getFormData());
	});
	
// 	审核不通过
	function contractDeny(){
	// 		清除审核栏
		$('#contractIds').val('');
		$('#auditOpinions').val('');
	// 		获取所有勾选合同
		var checked = $('#contractList').datagrid('getChecked');
		var num=checked.length;
		if(checked==""){
			$.messager.alert("提示","</br>请选择合同</br>");
		}else{
			var checkedIds="";
			for(var opt in checked){
				checkedIds+=checked[opt].id;
				if(opt<(num-1)) checkedIds+=',';
			}
			$('#contractIds').val(checkedIds);
			$('#auditOpinion').show();
			$('#auditOpinion').dialog({
				title:'审核不通过',
				width: 400,
			    height: 320,
			    modal:true,
			    buttons:[{
					text:'保存',
					handler:function(){changeStatus(checkedIds,'deny');}
				},{
					text:'取消',
					handler:function(){$("#auditOpinion").dialog("close");}
				}]
			})
		}
	}
// 	审核通过
	function contractPass(){
		// 		获取所有勾选合同
		var checked = $('#contractList').datagrid('getChecked');
		var num=checked.length;
		if(checked==""){
			$.messager.alert("提示","</br>请选择合同</br>");
		}else{
			$.messager.confirm('审核通过', '确定这'+num+'项合同通过审核吗?', function(r){
				if (r){
					var checkedIds="";
					for(var opt in checked){
						checkedIds+=checked[opt].id;
						if(opt<(num-1)) checkedIds+=',';
					}
					changeStatus(checkedIds,'pass');
				}
			});
		}		
	}
// 	改变DENY合同状态，并提交审核意见。
	function changeStatus(checkedIds,audit){
		if(audit=='deny'){
			$.ajax({
				type:'POST',
				url:ctx+"/contractAudit/deny",
				asyn:false,
				data:$('#auditOpinianForm').serialize(),
				error: function(jqXHR, textStatus, errorMsg) {
			    	$.messager.alert('操作结果',""+jqXHR.responseText);
			   	 	$("#auditOpinion").dialog("close");
			   		$("#contractList").datagrid('reload');
			    },
			    success: function(data) {
			    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
				    $("#auditOpinion").dialog("close");
				    $("#contractList").datagrid('reload');
			    }				
			});
		}else{
			$.ajax({
				type:'POST',
				url:ctx+'/contractAudit/pass',
				asyn:false,
				data:{ids:checkedIds},
				error: function(jqXHR, textStatus, errorMsg) {
			    	$.messager.alert('操作结果',""+jqXHR.responseText);
		  		},
				success:function(data){
					$.messager.alert('操作结果',"审核成功！");
				    $("#contractList").datagrid('reload');
				}
			});
		}
	}
</script>