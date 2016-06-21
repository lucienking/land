<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link href="${ctx}/static/styles/contract/common.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<!-- easyUI -->
<link href="${ctx}/static/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<script src="${ctx }/static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="${ctx }/static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="${ctx }/static/js/jksb.land.common.js"></script>
<script src="${ctx }/static/js/jksb.land.fileupload.js"></script>
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
	.prjInfo>div{
	padding:5px 0 5px 0;
	display:inline;
	line-height:40px;
	}
	label{
		font-size:14px;
		display:inline-block;
		padding-right:5px;
		margin:auto 0;
		width:100px;
		text-align:center;
		line-height:1em;
	}
</style>
<div id="container">
	<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	    <div data-options="region:'north',title:'查询项目',split:true" style="min-height:100px;">
	    	<form id='searchForm'>
	    		<div class="s_item">
		    		<div class="s_item_name">项目名称</div>
		    		<div class="s_item_inpue">
						<input id="s_projectName" name="projectName" class="easyui-textbox" style="width:143px;">    			
		    		</div>
    			</div>
    			<div class="s_item">
		    		<div class="s_item_name">项目编码</div>
		    		<div class="s_item_inpue">
						<input id="s_projectCode" name="projectCode" class="easyui-textbox" style="width:143px;">    			
		    		</div>
    			</div>
    			<div class="s_item">
		    		<div class="s_item_name">用地面积</div>
		    		<div class="s_item_inpue">
						<input id="s_useTotalArea_low" name="useTotalArea_low" class="easyui-textbox" style="width:60px;" validType="float">
						—
						<input id="s_useTotalArea_high" name="useTotalArea_high" class="easyui-textbox" style="width:60px" validType="float"> 		
		    		</div>
		    	</div>
		    	<div class="s_item" style="display:block;float:right;">
		    		<a href="#" class="easyui-linkbutton" id="searchMyPrj" data-options="iconCls:'icon-search'" 
		    		style="display:inline-block;width:80px;height:29px;margin:0 auto">查&nbsp;询</a>
<!-- 		    		<a href="#" class="easyui-linkbutton" id="clearSearch" data-options="iconCls:'icon-undo'"  -->
<!-- 		    		style="display:inline-block;width:80px;height:29px;margin:0 15px 0 auto">清&nbsp;空</a> -->
		    	</div>
	    	</form>
	    </div>
	    <div data-options="region:'center',title:'项目列表'" style="padding:5px;background:#eee;">
	    	<table id="prjList"></table>
	    </div>
	</div>
</div>
<!-- ***********************************************************项目信息对话框****************************************************** -->
<div id="prjInfoDialog" style="display:none;">
<form id="application" method="post">
	<div id="tt" class="easyui-tabs" style="width:600px;">
			<div title="项目信息" class="prjInfo" style="padding:20px;">
				<div>
					<label for="projectCode">项目编号</label>
					<input id="projectCode" type="text" name="projectCode" class="easyui-textbox" style="height:30px;" data-options="required:true" />
				</div>
				
				<div>
					<label for="projectName">项目名称</label>
					<input id="projectName" type="text" name="projectName" class="easyui-textbox" style="height:30px;" data-options="required:true"/>
				</div>
				
				<div>
					<label for="applyCompany" style="fontSize:8px;">申请单位</label>
					<input id="applyCompany" type="text" name="applyCompany" class="easyui-textbox" style="width:398px;height:30px;" data-options="required:true"/>
				</div>
				
				<div>
					<label for="projectLocation">项目选址</label>
					<input id="projectLocation" type="text" name="projectLocation" class="easyui-textbox" style="width:398px;height:30px;" data-options="required:true"/>
				</div>
				
				<div>
					<label for="useTotalArea">用地总面积</label>
					<input id="useTotalArea" type="text" name="useTotalArea" class="easyui-textbox" style="height:30px;" data-options="required:true,validType:'float'"/>
				</div>
				
				<div>
					<label for="cultivatedArea">农用地面积</label>
					<input id="cultivatedArea" type="text" name="cultivatedArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div>
					<label for="agriLandArea">耕地面积</label>
					<input id="agriLandArea" type="text" name="agriLandArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div>
					<label for="constructionArea">建设用地面积</label>
					<input id="constructionArea" type="text" name="constructionArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div>
					<label for="unuseArea">未利用地面积</label>
					<input id="unuseArea" type="text" name="unuseArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div>
					<label for="PlanningArea">符合规划面积</label>
					<input id="PlanningArea" type="text" name="PlanningArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div>
					<label for="PlanAdjustArea">规划调整面积</label>
					<input id="PlanAdjustArea" type="text" name="PlanAdjustArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div style="display:block;">
					<label for="functinalDistribution">项目各功能区用地情况</label>
					<textarea id="functinalDistribution" type="text" name="functinalDistribution" class="easyui-validatebox" readonly="readonly" rows="5" style="width:398px;height:100px;font-size:12px;
					font-family:微软雅黑;"></textarea>
				</div>
				
				<div>
					<label for="supCulCompany" style="fontSize:8px;">补充耕地责任承担单位</label>
					<input id="supCulCompany" type="text" name="supCulCompany" class="easyui-textbox" style="width:398px;height:30px;"/>
				</div>
				
				<div>
					<label for="supCulDepartment" style="fontSize:8px;">补充耕地承担单位</label>
					<input id="supCulDepartment" type="text" name="supCulDepartment" class="easyui-textbox" style="width:398px;height:30px;"/>
				</div>
				
				<div>
					<label for="supCulArea">补充耕地面积</label>
					<input id="supCulArea" type="text" name="supCulArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div>
					<label for="AgriToConArea">农转用面积</label>
					<input id="AgriToConArea" type="text" name="AgriToConArea" class="easyui-textbox" style="height:30px;" data-options="validType:'float'"/>
				</div>
				
				<div>
					<label for="contactCompany" style="fontSize:8px;">联系单位</label>
					<input id="contactCompany" type="text" name="contactCompany" class="easyui-textbox" style="width:398px;height:30px;"/>
				</div>
				
				<div>
					<label for="contactor">联系人</label>
					<input id="contactor" type="text" name="contactor" class="easyui-textbox" style="height:30px;" />
				</div>
				
				<div>
					<label for="phone">联系电话</label>
					<input id="phone" type="text" name="phone" class="easyui-textbox" style="height:30px;" />
				</div>
				
				<div>
					<label for="prjAddr" style="fontSize:8px;">通讯地址</label>
					<input id="prjAddr" type="text" name="prjAddr" class="easyui-textbox" style="width:398px;height:30px;"/>
				</div>
				
				<div>
					<label for="remark" style="fontSize:8px;">备注</label>
					<input id="remark" type="text" name="remark" class="easyui-textbox" style="width:398px;height:30px;"/>
				</div>
				
				<div>
					<label for="applyDate">申请日期</label>
					<input id="applyDate" type="text" name="applyDate" class="easyui-datebox" required="required" style="height:30px;">
				</div>
				
				<div style="display:block;">
					<label for="auditOpinion">审核意见</label>
					<textarea id="auditOpinion" type="text" name="auditOpinion" class="easyui-validatebox" rows="5" style="width:398px;height:100px;font-size:12px;
					font-family:微软雅黑;" readonly="readonly"></textarea>
				</div>
				
				<div>
					<label for="auditer">审核人</label>
					<input id="auditer" type="text" name="auditer" class="easyui-textbox" style="height:30px;" data-options="readonly:true"/>
				</div>
				<input id="id" name="id" type="hidden">
			</div>
			
			
	<!-- 		*****************************************附件操作****************************************** -->
			<div title="附件" style="padding:20px;">
				<div id='attachments'>
					<a href="#" class="add-attachment" onclick="javascript:addPRJAttachment();">添加附件</a>
				</div>
				
				<input type='hidden' name='prjStatus' value='0'>
				
				<div id="prj_add_attachment_div" style="display:none">
					<div class="line-div">
						<jksb:upload name="prj_add_attachmentdirection" id="prj_add_attachmentdirection" buttonText="点击选择上传附件" savePath="prjAttachment">
						</jksb:upload> 
					</div>
				</div>
				
				<div>
						<table id="prj_attachment_detail" class="contract_detail_info_table" style="width:696px;margin-left:2px;">
							<tr>
								<td width="100px" class="contract_detail_info_table_head" >附件名称</td>
								<td width="10px" class="contract_detail_info_table_head" >附件大小</td>
								<td width="10px" class="contract_detail_info_table_head" >
								操作<input type="hidden" id="prj_attachment_num" value="0"/>
								</td>
							</tr>
						</table>			
				</div>
			</div>
	</div>
</form>
	<div id='bb' style="display:block;margin:10px auto;width:320px;">
			<div style="display:inline;padding-right:10px;">
				<a id="acceptAudit" href="javascript:acceptAudit()" class="easyui-linkbutton" style="width:90px;height:30px;" data-options="iconCls:'icon-ok'">受&nbsp;理</a>
			</div>
			<div style="display:inline;padding-right:10px;">
				<a id="prjPass" href="javascript:prjAuditing('pass')" class="easyui-linkbutton" style="width:90px;height:30px;" data-options="iconCls:'icon-ok'">审核通过</a>
			</div>
			<div style="display:inline;padding-right:10px;">
				<a id="prjDeny" href="javascript:prjAuditing('deny')" class="easyui-linkbutton" style="width:90px;height:30px;" data-options="iconCls:'icon-undo'">审核不通过</a>
			</div>
			<div style="display:inline;">
				<a id="closeDialog" href="javascript:closeDialog()" class="easyui-linkbutton" style="width:80px;height:30px;" data-options="iconCls:'icon-no'">关闭</a>
			</div>
	</div>
</div>
<!-- ***************************************************工具栏************************************************** -->
<div id="prjManage_toolbar">
		<a href="javascript:prjEdit()" id = "prjEditButton" 
		class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >审核</a>
</div>
<script>
// 显示项目列表内容
$('#prjList').datagrid({
	url:'${ctx}/projectManage/listAuditPrj',
	method:'get',
    rownumbers: true,
    pagination: true,
    pageList:[10,15,20],
    pageSize:10,
    singleSelect:true,
	columns:[[
		{field:'projectCode',title:'项目编号',width:100},
		{field:'projectName',title:'项目名称',width:300},
		{field:'applyCompany',title:'申请单位',width:200},
		{field:'useTotalArea',title:'用地面积',width:80},
		{field:'agriLandArea',title:'农用地面积',width:80},
		{field:'cultivatedArea',title:'耕地面积',width:80},
		{field:'constructionArea',title:'建设用地面积',width:90},
		{field:'prjStatus',title:'状态',width:50,formatter: function(value,row,index){
			if (value){
				return getDictValue(value,"PRJ_STATUS");
			}
		}},
		{field:'applyDate',title:'申请日期',width:100,formatter:function(value,row,index){
	        	if(value){
	        		return value.substring(0,10);
	        	}
        	}
		}
	]],
	toolbar:'#prjManage_toolbar',
    onSelect: function(index,row){$('#prjEditButton').linkbutton('enable');},
	onDblClickRow:function (index,row){prjDataDialog("编辑建设项目",row);}
});

// 单击编辑按钮
function prjEdit(){
	var selected = $('#prjList').datagrid('getSelected');
	prjDataDialog("审核建设项目",selected);	
}
// 打开对话框
function prjDataDialog(title,selected){
	clearForm();
 	if(selected!=null){
 		setPrjFormValue(selected);
 		setReadonly(selected);
 	}
	$("#prjInfoDialog").show(); //先显示，再弹出
    $("#prjInfoDialog").dialog({
        title: title,
        modal:true,
        width:631,
        height:600,
        buttons:'#bb'
    });
    if(selected.prjStatus=='2'){
		$('#acceptAudit').linkbutton('enable');
		$('#prjPass').linkbutton('disable');
		$('#prjDeny').linkbutton('disable');		
	}else{
		$('#acceptAudit').linkbutton('disable');
		$('#prjPass').linkbutton('enable');
		$('#prjDeny').linkbutton('enable');		
	}
}

//取得返回项目对象的各个属性值，并在项目对话框中显示
function setPrjFormValue(selected){
	$("#projectName").textbox('setValue',selected.projectName);
	$("#projectCode").textbox('setValue',selected.projectCode);
	$("#applyCompany").textbox('setValue',selected.applyCompany);
	$("#projectLocation").textbox('setValue',selected.projectLocation);
	$("#useTotalArea").textbox('setValue',selected.useTotalArea);
	$("#cultivatedArea").textbox('setValue',selected.cultivatedArea);
	$("#agriLandArea").textbox('setValue',selected.agriLandArea);
	$("#constructionArea").textbox('setValue',selected.constructionArea);
	$("#unuseArea").textbox('setValue',selected.unuseArea);
	$("#PlanningArea").textbox('setValue',selected.planningArea);
	$("#PlanAdjustArea").textbox('setValue',selected.planAdjustArea);
	$("#functinalDistribution").val(selected.functinalDistribution);
	$("#supCulCompany").textbox('setValue',selected.supCulCompany);
	$("#supCulDepartment").textbox('setValue',selected.supCulDepartment);
	$("#supCulArea").textbox('setValue',selected.supCulArea);
	$("#AgriToConArea").textbox('setValue',selected.agriToConArea);
	$("#contactCompany").textbox('setValue',selected.contactCompany);
	$("#contactor").textbox('setValue',selected.contactor);
	$("#phone").textbox('setValue',selected.phone);
	$("#prjAddr").textbox('setValue',selected.prjAddr);
	$("#remark").textbox('setValue',selected.remark);
	$("#auditer").textbox('setValue',selected.auditer);
	$("#applyDate").datebox('setValue',selected.applyDate);
	$("#id").val(selected.id);
	$("#auditOpinion").val(selected.auditOpinion);
	attachmentShow(selected.prjAttachmentEntitis);
}

// 设置不可编辑
function setReadonly(selected){
	$("#projectName").textbox({readonly:true});
	$("#projectCode").textbox({readonly:true});
	$("#applyCompany").textbox({readonly:true});
	$("#projectLocation").textbox({readonly:true});
	$("#useTotalArea").textbox({readonly:true});
	$("#cultivatedArea").textbox({readonly:true});
	$("#agriLandArea").textbox({readonly:true});
	$("#constructionArea").textbox({readonly:true});
	$("#unuseArea").textbox({readonly:true});
	$("#PlanningArea").textbox({readonly:true});
	$("#PlanAdjustArea").textbox({readonly:true});
	$("#supCulCompany").textbox({readonly:true});
	$("#supCulDepartment").textbox({readonly:true});
	$("#supCulArea").textbox({readonly:true});
	$("#AgriToConArea").textbox({readonly:true});
	$("#contactCompany").textbox({readonly:true});
	$("#contactor").textbox({readonly:true});
	$("#phone").textbox({readonly:true});
	$("#prjAddr").textbox({readonly:true});
	$("#remark").textbox({readonly:true});
	$("#auditer").textbox({readonly:true});
}

// 查询我的项目建设
$('#searchMyPrj').click(function(){
	$('#prjList').datagrid('load',$('#searchForm').getFormData());
});

/* 
	添加项目附件
	*/
	function addPRJAttachment(){
		$("#prj_add_attachment_div").show(); //先显示，再弹出
		var id = $("input[name ='file']").attr("id");
		jksbFileUploadClear(id);
	    $("#prj_add_attachment_div").dialog({
	        title: "添加附件信息",
	        width: 300,
	        height: 150,
	        modal:true,
	        buttons:[{
				text:'添加',
				handler:function(){ 
					var map = new Map();
					map.put("name",$("input[name ='fileName']").val());
					map.put("size",$("input[name ='fileSize']").val());
					map.put("type",$("input[name ='fileType']").val());
					map.put("direction",$("input[name ='filePath']").val());
					createAttachmentInfoTd(map);
					$("#prj_add_attachment_div").dialog("close");
				}
			},{
				text:'取消',
				handler:function(){$("#prj_add_attachment_div").dialog("close");}
			}]
	    });
	    
		/**
		 * 生成附件信息行
		**/
		function createAttachmentInfoTd(map){
			if(map.get("name") == "" || map.get("name") == undefined){ 
				return ;
			}else{
				var index = parseInt($("#prj_attachment_num").val());
				$("#prj_attachment_detail").css("display","block");
				var newRow = "<tr class='content'>"+
						 "<td align='center'>"+map.get("name")+ 
						 "<input type='hidden' name='prjAttachmentEntitis["+index+"].attachmentName' value='"+map.get("name")+"'>"+
						 "<input type='hidden' name='prjAttachmentEntitis["+index+"].attachmentSize' value='"+map.get("size")+"'>"+
						 "<input type='hidden' name='prjAttachmentEntitis["+index+"].attachmentType' value='"+map.get("type")+"'>"+
						 "<input type='hidden' name='prjAttachmentEntitis["+index+"].attachmentdirection' value='"+map.get("direction")+"'></td>" +
						 "<td align='center'>"+map.get("size")+ "</td>" +
						 "<td align='center'><a href='#' class='contract_apply_href' onclick='javascript:deleteCurrentObjTR(this);'>删除</a></td>"+
						 "</tr>";
				$("#prj_attachment_detail tr:last").after(newRow);	
				$("#prj_attachment_num").val(index+1);
			}
		}
	}
	
// 	编辑框中显示附件信息
	function attachmentShow(attaches){
		var table=$('#prj_attachment_detail');
		var i=0
		if(attaches==null){
			$('#prj_attachment_num').val(i);
			return;
		}
		for(i;i<attaches.length;i++){
			var tr='<tr class="content"><td>'+attaches[i].attachmentName+'</td>';
			tr+='<td>'+attaches[i].attachmentLong+'</td>';
			tr+='<td><a href=“#” class=“contract_apply_href” onclick=“javascript:deleteCurrentObjTR(this);”>删除</a></td></tr>';
		}
		table.append(tr);
		$('#prj_attachment_num').val(i);
	}
	
// 	清空表单
	function clearForm(){
		var inputs=['projectCode','projectName','applyCompany','projectLocation',
		            'applyDate','useTotalArea','cultivatedArea','agriLandArea',
		            'constructionArea','unuseArea','PlanningArea',
	                 'PlanAdjustArea','supCulArea','AgriToConArea',
	                 'supCulCompany','supCulDepartment','contactCompany',
	                 'contactor','phone','prjAddr','remark','auditer'];
		for(var i in inputs){
			$('#'+inputs[i]).textbox('setValue','');
		}
// 		清除文本框
		$('#functinalDistribution').val('');
		$('#auditOpinion').val('');
		$('#id').val('');
		
// 		清除附件
		var temp=$('#prj_attachment_detail').find('tr.content').remove();
		$('#prj_attachment_num').val('0');
	}
	
	/**
	 * 删除当前行
	**/
	function deleteCurrentObjTR(obj){
		$(obj).parent().parent().remove(); 
	}
	
	//在datagrid中显示指定的数据字典值
	//参数：dictCode,数据字典编码；dictGroup,数据字典组
	//返回：dictValue,数据字典值；
	//该函数主要用于在datagrid中某列(column)的值在展示时，输出数据字典中的名字值，而不是直接输出数据库中的编码值，OK？
	function getDictValue(dictValue,dictGroup){
		var rt="";
		$.ajax({
			url:"${ctx}/sys/dict/findValueByCodeAndeGroup",
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
	
// *************************************************************审核按钮操作*************************************************************	
// 	var projectCodeFlag=false;
// 	var projectNameFlag=false;
// 	var hasNonFlaotFlag=false;
// 	var isNonNegatedRealNumber2 = /^[0-9]+(.[0-9]{1,2})?$/;
// 	var requiredInputs=new Array(['projectCode','项目编号'],
// 			['projectName','项目名称'],
// 			['applyCompany','申请单位'],
// 			['projectLocation','项目选址'],
// 			['useTotalArea','用地总面积'],
// 			['applyDate','申请日期']);
// 	var floatNumber=['useTotalArea','cultivatedArea','agriLandArea','constructionArea','unuseArea','PlanningArea',
// 	                 'PlanAdjustArea','supCulArea','AgriToConArea'];
	
	
	//关闭窗口
	function closeDialog(){
		$("#prjInfoDialog").dialog('close');
	}
	
	function acceptAudit(){
		$.messager.confirm('受理该项目', '确认受理该项目吗？', function(r){
			var selected=$('#prjList').datagrid('getSelected');
			$.ajax({
				url:"${ctx}/projectManage/acceptAudit",
				type:'POST',
				async:true,
				data:{'id':selected.id},
				success:function(data){
					$.messager.alert('提示信息',"<div style='text-align:center;width:100%;'>"+data.message+"！</div>",
							'info',function(){
								closeDialog();
								$('#prjList').datagrid('reload');
							});
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					$.messager.alert('显示出错',"错误提示:"+XMLHttpRequest.responseText);
				}
			});
		});
	}
	
// 	审核决定
	function prjAuditing(decision){
		$.messager.prompt('审核意见', '请填写审核意见', function(r){
			if(r||r==''){
				var selected=$('#prjList').datagrid('getSelected');
				$.ajax({
					url:"${ctx}/projectManage/prj"+decision,
					type:'POST',
					async:true,
					data:{'id':selected.id,'auditOpinion':r},
					success:function(data){
						$.messager.alert('提示信息',"<div style='text-align:center;width:100%;'>"+data.message+"！</div>",
								'info',function(){
									closeDialog();
									$('#prjList').datagrid('reload');
								});
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						$.messager.alert('显示出错',"错误提示:"+XMLHttpRequest.responseText);
					}
				});
			}
		});
	}

</script>