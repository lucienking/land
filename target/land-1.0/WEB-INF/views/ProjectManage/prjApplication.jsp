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
.container{
	min-width:700px;
}
form{
	margin:auto;
	width: 600px;
}
form>div{
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
<div id="container" style="width:100%;height:100%;">
	<form id="application" method="post" style="border:1px solid #95b8e7;padding-left:50px">
		<div>
			<h3 style="text-align:center;">建设项目申请表</h3>
		</div>
		
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
			<textarea id="functinalDistribution" type="text" name="functinalDistribution" class="easyui-validatebox" rows="5" style="width:398px;height:100px;font-size:12px;
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
		
		<div style="display:block;margin:10px auto;width:320px;">
			<div style="display:inline;padding-right:20px;">
				<a id="saveDraft" href="#" class="easyui-linkbutton" style="width:120px;height:30px;" data-options="iconCls:'icon-save'">保存草稿</a>
			</div>
			<div style="display:inline;">
				<a id="cancel" href="#" class="easyui-linkbutton" style="width:120px;height:30px;" data-options="iconCls:'icon-remove'">取消</a>
			</div>
		</div>
		
		<div id='attachments'>
			<a href="#" class="add-attachment" onclick="javascript:addPRJAttachment();">添加附件</a>
		</div>
		
		<input type='hidden' name='prjStatus' value='1'>
		
		<div id="prj_add_attachment_div" style="display:none">
			<div class="line-div">
				<jksb:upload name="prj_add_attachmentdirection" id="prj_add_attachmentdirection" buttonText="点击选择上传附件" savePath="prjAttachment">
				</jksb:upload> 
			</div>
		</div>
		
		<div>
				<table id="prj_attachment_detail" class="contract_detail_info_table" style="width:696px;display:none;margin-left:2px;">
					<tr>
						<td width="576px" class="contract_detail_info_table_head" >附件名称</td>
						<td width="80px" class="contract_detail_info_table_head" >附件大小</td>
						<td width="40px" class="contract_detail_info_table_head" >
						操作<input type="hidden" id="prj_attachment_num" value="0"/>
						</td>
					</tr>
				</table>			
		</div>
	</form>
</div>

<script>
	var projectCodeFlag=false;
	var projectNameFlag=false;
	var hasNonFlaotFlag=false;
	var isNonNegatedRealNumber2 = /^[0-9]+(.[0-9]{1,2})?$/;
	var requiredInputs=new Array(['projectCode','项目编号'],
			['projectName','项目名称'],
			['applyCompany','申请单位'],
			['projectLocation','项目选址'],
			['useTotalArea','用地总面积'],
			['applyDate','申请日期']);
	var floatNumber=['useTotalArea','cultivatedArea','agriLandArea','constructionArea','unuseArea','PlanningArea',
	                 'PlanAdjustArea','supCulArea','AgriToConArea'];
	/*	
	保存项目信息
	*/
	$('#saveDraft').click(function(){
		if(!checking()) return;	//检验必填项
// 		检查有没有数字项填写了非数字内容
		var typo=isFloat(floatNumber);
		if(hasNonFlaotFlag){
			floatTips(typo);
			return;
		}
		//数值表单自动填零，不填后台将报错！
		for(var i in floatNumber){
			if($('#'+floatNumber[i]).textbox('getValue')==''){
				$('#'+floatNumber[i]).textbox('setValue','0.0');
			}
		}
		//校验项目编号和名称不与已有项目冲突
		projectCodeFlag=validExsiting('projectCode');
		projectNameFlag=validExsiting('projectName');
		if(projectCodeFlag){
			$.messager.alert('提示信息',"<div style='text-align:left;width:100%;'>项目编号已存在</div>",'error',function(r){
				$('#projectCode').textbox('textbox').focus();
			});
		}else if(projectNameFlag){
			$.messager.alert('提示信息',"<div style='text-align:left;width:100%;'>项目名称已存在</div>",'error',function(r){
				$('#porjectName').textbox('textbox').focus();
			});
		}else{
			$.ajax({
				url:"${ctx}/projectManage/savePCM",
				type:'POST',
				data:  $("#application").serialize(),  //获取表单的各项值，并将其序列化
				success:function(data){
					$.messager.alert('提示信息',"<div style='text-align:center;width:100%;'>"+data.message+",请在我的项目建设申请中查看！</div>",
					'info',function(){
						clearForm();
					});
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
				}
			});
		}
	});
// 	校验非空
	function checking(){
		var flag=false;
		for(var i=0;i<requiredInputs.length;i++){
			if(!checkNotEmpty(requiredInputs[i][0],requiredInputs[i][1])){
				flag=false;
				return;
			}else{
				flag=true;
			}
		}
		return flag;
	}
// 	校验非空函数
	function checkNotEmpty(ID,idName){
		var refId=$('#'+ID);
		if(refId.textbox('getValue')==""){
			$.messager.alert("出错！","请填写"+idName,'info',function(r){
				refId.textbox().next('span').find('input').focus();
			});
			return false;
		}else{
			return true;
		}
	}; 
// 	校验某项是否已存在
	function validExsiting(id){
		var value=$('#'+id).textbox('getValue');
		var flag=false;
		$.ajax({
			url:'${ctx}/projectManage/valid'+id,
			type:'GET',
			async:false,
			data:{id:value},
			success:function(data){
				if(data.exist=='true'){
					flag=true;
				}else{
					flag=false;
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				$.messager.alert('操作结果',""+XMLHttpRequest.responseText);
				flag=true;
			}
		});
		return flag;
	}
	
// 	校验所有数字项是否为数字，返回第一个不是数字的项
	function isFloat(floatNumber){
		var reg=new RegExp(isNonNegatedRealNumber2);
		var sign=0;
		for(var n in floatNumber){
			var t=$('#'+floatNumber[n]).textbox('getValue');
			if(!reg.test(t)&&t!=''){
				sign=n;
				hasNonFlaotFlag=true;
				return floatNumber[sign];
			}
		}
		hasNonFlaotFlag=false;
		return null;
	}
	
	function floatTips(t){
		var target=$('#'+t);
		var tt=target.prev();
		$.messager.alert('错误', '<div>请在'+target.prev().text()+'中填写两位小数数值（不包含空格）</div>', 'error', function(){
			target.textbox('textbox').focus();
		});
	}
	
// 	校验非空表单函数
	function validateInputGroup(inputs,selects){
		var validateResult = true;
		for(i in inputs){
			if(isNullOrEmpty($("#"+inputs[i]).textbox("getValue"))){
				setInvalidStyle(inputs[i]);
				validateResult = false;
			}
		}
		for(i in selects){
			if(isNullOrEmpty($("#"+selects[i]).combobox("getValue"))){
				setInvalidStyle(selects[i]);
				validateResult = false;
			}
		}
		return validateResult;
	}
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
	/**
	 * 删除当前行
	**/
	function deleteCurrentObjTR(obj){
		$(obj).parent().parent().remove(); 
	}
	
// 	取消提交，清空表单
	$('#cancel').bind('click',function(){
		clearForm();
	});
	
// 	清空表单
	function clearForm(){
		var inputs=['projectCode','projectName','applyCompany','projectLocation',
		            'applyDate','useTotalArea','cultivatedArea','agriLandArea',
		            'constructionArea','unuseArea','PlanningArea',
	                 'PlanAdjustArea','supCulArea','AgriToConArea',
	                 'supCulCompany','supCulDepartment','contactCompany',
	                 'contactor','phone','prjAddr','remark'];
		for(var i in inputs){
			$('#'+inputs[i]).textbox('setValue','');
		}
// 		清除文本框
		$('#functinalDistribution').val('');
// 		清除附件
		var temp=$('#prj_attachment_detail').find('tr.content').remove();
		$('#prj_attachment_num').val('0');
		$("#prj_attachment_detail").css("display","none");
	}
</script>