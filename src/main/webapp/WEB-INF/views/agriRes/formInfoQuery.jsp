<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div id= "formInfoQueryContainer">
<div id="formInfoQuerySearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="formInfoQuerySearchConditionForm">
		<table style="width:99%;margin-buttom:10px;font-size:12px;">
			<tr>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_formInfoQueryName">调查表编号</label>
					<input id="search_formInfoQueryName" name="cardNo" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_formInfoQueryCode">家庭户号</label>
					<input id="search_formInfoQueryCode" name="familyNo" class="easyui-textbox" style="width:120px;"/>
				</td>
				
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_formInfoQuerystartDate">户主姓名</label>
					<input id="search_formInfoQueryCode" name="familyHost" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_formInfoQueryendDate">家庭电话</label>
					<input id="search_formInfoQueryCode" name="telephoneNumber" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="12%" align="center" style="min-width:150px">
						&nbsp;
						<input type="hidden" name="farmCode" value="${queryfarmCode }">
						<input type="hidden" name="zdCode" value="${zdCode }">
				</td>
			</tr>
			<tr>
				<td colspan="4"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="formInfoQuerySearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="formInfoQuerySearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="formInfoQueryDatagrid" style="width:100%;"></table>
</div>

<div id="formInfoQueryEditDialog"  style="width:99%;height:99%;display:none;">
</div>
<div id="formInfoQueryDetailInfoDialog"  style="width:99%;height:99%;display:none;">
</div>

<div id="formInfoQueryToolbar">
	<jksb:hasAutority authorityId="009002">
		<a href="#"
			id="formInfoQueryEditButton" class="easyui-linkbutton"
			data-options="iconCls:'icon-edit',plain:true,disabled:true,">编辑调查表</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="009002">
		<a href="#" id="formInfoQueryDetailInfo"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-tip',plain:true,disabled:true,">调查表详细</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="009002">
		<a href="#" id="formInfoQueryDeleButton"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true,disabled:true,">删除</a>
	</jksb:hasAutority>
</div>

<script type="text/javascript">
 var farmCode = "${farmCode}" ;
 
/**
 *  datagrid 初始化 
 */
$('#formInfoQueryDatagrid').datagrid({
    url:"${ctx}/agriRes/selfSupport/getFormInfoByCondition",
    method:'get',
    pagination:true,
    singleSelect:true,
    columns:[[
		{checkbox:true,field:'',title:'' },      
        {field:'id',title:'序号',width:'5%',sortable:true},
        {field:'cardNo',title:'调查表编号',width:'10%'},
        {field:'familyNo',title:'户号',width:'10%',align:'center'},
        {field:'familyHost',title:'户主',width:'10%',align:'center'},
        {field:'researchObject',title:'调查对象',width:'10%',align:'center'},
        {field:'investigator',title:'调查人',width:'10%',align:'center'},
        {field:'telephoneNumber',title:'家庭电话',width:'15%',align:'center'},
        {field:'familyLocation',title:'家庭地址',width:'20%',align:'center'} 
    ]] ,
    queryParams:$('#formInfoQuerySearchConditionForm').getFormData(), 
    toolbar:"#formInfoQueryToolbar",				 
	onSelect: function(index,row){formInfoQuerySelectChange(index,row);},
	onUnselect: function(index,row){formInfoQuerySelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    } 
});

function formInfoQuerySelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#formInfoQueryDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#formInfoQueryEditButton").linkbutton("enable");
		$("#formInfoQueryDetailInfo").linkbutton("enable");
		$("#formInfoQueryDeleButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#formInfoQueryDeleButton").linkbutton("disable");
		$("#formInfoQueryEditButton").linkbutton("disable");
		$("#formInfoQueryDetailInfo").linkbutton("disable");
	}else{
		$("#formInfoQueryEditButton").linkbutton("disable");
		$("#formInfoQueryDetailInfo").linkbutton("disable");
	}
}

$('#formInfoQuerySearchButton').click(function(){
	$('#formInfoQueryDatagrid').datagrid('load',$('#formInfoQuerySearchConditionForm').getFormData());
});


/**
 * 设置分页
 */
var p = $('#formInfoQueryDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

  
 /**
  * 调查表详细信息展示
  */
  $("#formInfoQueryDetailInfo").click(function(){
 	 var id = $("#formInfoQueryDatagrid").datagrid("getSelected").id;
 	 
 	 $("#formInfoQueryDetailInfoDialog").show(); //先显示，再弹出
 	 $("#formInfoQueryDetailInfoDialog").dialog({
 		  title:'调查表详细信息',
 	      href:"${ctx}//agriRes/selfSupport/formDetailInfo?id="+id,
 	      modal:true
 	  });
  });
 
  /**
   * 调查表详细信息编辑
   */
   $("#formInfoQueryEditButton").click(function(){
  	 var id = $("#formInfoQueryDatagrid").datagrid("getSelected").id;
  	 
  	 $("#formInfoQueryEditDialog").show(); //先显示，再弹出
  	 $("#formInfoQueryEditDialog").dialog({
  		  title:'编辑调查表信息',
  	      href:"${ctx}/agriRes/selfSupport/formDetailEdit?id="+id,
  	      modal:true
  	  });
   });
  
   /**
    * 调查表详细信息编辑
    */
    $("#formInfoQueryDeleButton").click(function(){
   	 	var id = $("#formInfoQueryDatagrid").datagrid("getSelected").id;
   	 	var cardNo = $("#formInfoQueryDatagrid").datagrid("getSelected").cardNo;
   		$.messager.confirm('删除确认','确定删除编号为 '+cardNo+' 的调查吗?',function(r){
		    if (r){
		   	$.ajax({
				url:"${ctx}/agriRes/selfSupport/formdelete",
				type:'GET',
				data: { 'id': id },  
				success:function(data){
					$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
					$("#formInfoQueryDatagrid").datagrid('reload');
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
				}
			});
		    }
	    });
    });
   
</script>
</div>

