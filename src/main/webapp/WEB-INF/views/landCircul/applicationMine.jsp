<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id="applSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;" data-options="collapsible:true">
	<form id="applSearchConditionForm">
		<table style="width:99%;height:80px;margin-buttom:10px;font-size:14px;">
			<tr>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_circulNo">流转编号</label>
					<input id="search_circulNo" name="circulNo" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_circulMethod">流转方式</label>
					<input id="search_circulMethod" name="circulMethod" class="easyui-textbox" style="width:120px;" />
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_circulStatus">申请状态</label>
					<input id="search_circulStatus" name="circulStatus" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_circulDate">流转时间</label>
					<input name="circulDate"  class="easyui-datebox" style="width:120px;" value="${currentDate}" />
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_userId">申请人</label>
					<input id="search_userId" name="userId" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="10%" align="center"  style="min-width:150px">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="5"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="applSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				   <a class="easyui-linkbutton" href="#" id="resetButton">&nbsp;重&nbsp;置&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="applSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="applDatagrid" style="width:100%;"></table>
</div>
<div id="toolbar">
	<jksb:hasAutority authorityId="011">
		<a href="#" id ="submitButton" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true,disabled:true" >提交申请</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="011">
		<a href="#" id ="applDetailButton" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true,disabled:true," >查看详细</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="011">
		<a href="#" id ="applTrackButton" class="easyui-linkbutton" data-options="iconCls:'pic_74',plain:true,disabled:true," >操作记录</a>
	</jksb:hasAutority>
</div>
<div id="applDetailDialog"  style="width:70%;height:99%;display:none;">
</div>
<div id="applTrackDialog"  style="width:50%;display:none;">
</div>
<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#applDatagrid').datagrid({
    url:"${ctx}/landCirculation/getAllApplication/Mine",
    method:'get',
    pagination:true,
    singleSelect:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'circulNo',title:'流转编号',width:'10%'},
        {field:'circulStatus',title:'申请状态',width:'10%',formatter:function(value,rec){
        	return getDictName(value,"BPM_STATUS");
        }},
        {field:'originContractor',title:'原承包人',width:'10%'},
        {field:'currentContractor',title:'现承包人',width:'10%'},
        {field:'landNo',title:'地块编号',width:'10%'},
        {field:'userId',title:'操作人',width:'10%'} 
    ]],
    queryParams:$('#applSearchConditionForm').getFormData(), 
    toolbar:"#toolbar",					//根据权限动态生成按钮
	onSelect: function(index,row){applSelectChange(index,row);},
	onUnselect: function(index,row){applSelectChange(index,row);}, 
	onLoadSuccess:function(){$("#toolbar .easyui-linkbutton").linkbutton("disable");} 
});

function applSelectChange(index,row){ 		// 选择行事件 通用。
	var selected = $("#applDatagrid").datagrid("getSelected");
	if(selected.circulStatus =="DRAFT")
		$("#submitButton").linkbutton("enable");
	else $("#submitButton").linkbutton("disable");
	$("#applDetailButton").linkbutton("enable");
}

$('#applSearchButton').click(function(){
	$('#applDatagrid').datagrid('load',$('#applSearchConditionForm').getFormData());
});

$("#submitButton").click(function(){
	if($(this).attr("data-options").indexOf("disabled:true")>0) return false;
});

/**
 * 设置分页
 */
var p = $('#applDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

/**
	申请单操作
*/
function submitApplication(status,id){
	var data;
	if(id==null ||id==""){
		data = $('#application_form').serialize();
	}else {
		data = {'id':id};
	}
	$.ajax({
		type: "POST",
		url:"${ctx}/landCirculation/update/"+status,
		asyn:false,
		data:data, //将Form 里的值序列化
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
	    		$('#applDatagrid').datagrid('reload');
	    	});
	   }
	});   
}
/**
 * 申请详细信息展示
 */
 $("#applDetailButton").click(function(){
	 var id = $("#applDatagrid").datagrid("getSelected").id;
	 
	 $("#applDetailDialog").show(); //先显示，再弹出
	 $("#applDetailDialog").dialog({
		  title:'申请表详细信息',
	      href:"${ctx}/landCirculation/applicationDetail?id="+id,
	      modal:true
	  });
 });
 
 /**
  * 申请操作历史展示
  */
  $("#applTrackButton").click(function(){
 	 var id = $("#applDatagrid").datagrid("getSelected").id;
 	 
 	 $("#applTrackDialog").show(); //先显示，再弹出
 	 $("#applTrackDialog").dialog({
 		  title:'申请单操作记录',
 	      href:"${ctx}//bpm/track/trackDisplay?id="+id+"&orderName=circulation",
 	      modal:true
 	  });
  });
</script>
