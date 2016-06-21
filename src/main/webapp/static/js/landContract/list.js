$(document).ready(function(){
	
	$.extend($.fn.window.methods , {  
		move: function(jq, param){
			return jq.each(function(){
				moveWindow(this, param);
			});
		} 
	});
	
	$("#search").click(function(){
		var queryParams = getLandContractQueryParams();
		$("#landContractList").datagrid('load', queryParams);
	});
	
	$("#cancelStates").click(function(){
		cancelStates(this);
	});
	
	$("#delete").click(function(){
		deleteLandContracts(this);
	});
	
	if($("#farmCode").val() !== "1" && $("#farmCode").val() != ""){
		initLandContractList();
	}else{
		$('#ncmc').combobox({ 
			url : '../sys/org/getAllFarms',
			valueField : 'code',
			textField : 'name',
			method:'GET',
			onLoadSuccess : function() {
				//var firstRow = $(this).combobox('getData')[0];
				//('#ncmc').combobox('setValue', firstRow.code);
					initLandContractList();
				},
		});
	}
	
	
	/*if($("#farmCode").val() !== "1" && $("#farmCode").val() != ""){
		 $(".span1").children("span").css("display", "none");
		 $(".span2").children("span").css("display", "inline");
	}else{
		$(".span2").children("span").css("display", "none");
		$(".span1").children("span").css("display", "inline");
	};*/
	
});


function initLandContractList(){
	var queryParams = getLandContractQueryParams();
	$("#landContractList").datagrid({
		idField:"id",
		fitColumns:true,
		fit:true,
		rownumbers:true,
		url:'ajaxTable',
		toolbar:"#landContractToolDiv",
		columns:[[
		          {field:'ck',checkbox:true},
		          {field:"contractNumber", title:"<b>合同编号</b>", align:'left', width:100}, 
		          {field:"state", title:"<b>状态</b>", align:'left', width:80,formatter:function(value,row,index){
		        	  if(row.state){
		        		  return (row.state==0?"草稿":(row.state==1?"正式":(row.state==2?"注销":"")));
		        	  }else{
		        		  return "草稿";
		        	  }
		          }},
		          {field:"partyB", title:"<b>承包人</b>", align:'left', width:100},
		          {field:"contractType", title:"<b>合同类型</b>", align:'left', width:100,formatter:function(value,row,index){
		        	  if(row.contractType){
			        	  return row.contractType=="1"?"对内承包":row.contractType=="2"?"对外承包":row.contractType=="3"?"临时租地":(row.contractType=="4"?"农民占地":"");
			        	  }
		          }},
		          {field:"timeLimit", title:"<b>租期（年）</b>", align:'left', width:100},
		          {field:"areaOfLand", title:"<b>面积（亩）</b>", align:'left', width:100},
		          {field:"signingDate", title:"<b>签订日期</b>", align:'left', width:100,formatter:function formatterdate(val, row) {
		        	  if (val != null) {
		        		  var date = new Date(val);
		        		  return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		        		  + date.getDate();
		        		  }
		          }},
		          
		          {field:"operate", title:"<b>操作</b>", align:'left', width:40, formatter:function(value,row,index){
		        	  var button = '';
		        	  button = '<a title="合同('+row.contractNumber+')" class="icon-edit" width="800" height="400" style="cursor: pointer;display: inline-block;width: 20px;height:20px;" onclick="openIframeWindow(\'contractEdit\',this)" maximized="true" url="editInner/'+row.id+'" ></a>';
					  button += '<a title="查看合同信息" class="tree-icon tree-file" width="666" height="520" style="cursor: pointer;display: inline-block;width: 16px;height:20px;margin-left:6px;" onclick="showWindow(this)" url="contractDetail?contractId='+row.id+'" ></a>';
		        	  return button;
		          }}
		]],
		singleSelect:false,
		queryParams:queryParams,
		pagination:true,
		autoRowHeight:true,
		onLoadSuccess:function(data){
			if(!data.ifException){
				
			}else{
				$.messager.alert('提示', '查询异常', 'info');
			}
		},
		onLoadError:function(arguments){
			
		}
	});
}

function showWindow(obj){
	var title = $(obj).attr("title");
	var href = $(obj).attr("url");
	var width = $(obj).attr("width");
	var height = $(obj).attr("height");
	$iframeWindow.show({
		id:"win",
		title:title,
		href:href,
		width:width,
        height:height,
        modal:true,
        cache:true,
        inline:true,
        collapsible:false,
        minimizable:false,
        resizable:false
    });
}

function cancelStates(obj){
	var rows = $("#landContractList").datagrid('getChecked');
	if(rows == null || rows.length == 0){
		$.messager.alert('提示', '未选中注销项！', 'info');
		return;
	}
	
	var url = $(obj).attr('url');
	var rowIds = "";
	for(var i=0;i<rows.length;i++){
		rowIds += rows[i].id;
		if(i+1 != rows.length){
			rowIds += ",";
		}
	}
	
	$.messager.confirm('提示','确定注销选中项？',function(r){
		if (r){
			$.ajax({
				type:'POST',
				url:url, 
				dataType:'json',
				async: false,
				cache: false,
				data: 'ids='+rowIds,
				success: function(data){
					if(data.code == 1){
						$("#landContractList").datagrid('clearChecked');
						var queryParams = getLandContractQueryParams();
		    			$("#landContractList").datagrid('load', queryParams);
		    		}
					$.messager.alert('提示', data.message, 'info');
				},
				error: function(){
					$.messager.alert('提示', '操作失败', 'error');
				}
			});
		}
	});
}

function resetSearch(){
	$("#contractNumber").val("");
	$("#timeLimit").val("");
	$("#state").val("");
	$("#contractType").val("");
	$("#partyB").val("");
	$("#contractYear").val("");
	$("#areaOfLandGe").val("");
	$("#areaOfLandLe").val("");
	var queryParams = getLandContractQueryParams();
	$("#landContractList").datagrid('load', queryParams);
}


function deleteLandContracts(obj){
	var rows = $("#landContractList").datagrid('getChecked');
	if(rows == null || rows.length == 0){
		$.messager.alert('提示', '未选中删除项！', 'info');
		return;
	}
	
	var url = $(obj).attr('url');
	var rowIds = "";
	for(var i=0;i<rows.length;i++){
		rowIds += rows[i].id;
		if(i+1 != rows.length){
			rowIds += ",";
		}
	}
	
	$.messager.confirm('提示','确定删除选中项？',function(r){
		if (r){
			$.ajax({
				type:'POST',
				url:url, 
				dataType:'json',
				async: false,
				cache: false,
				data: 'ids='+rowIds,
				success: function(data){
					if(data.code == 1){
						$("#landContractList").datagrid('clearChecked');
						var queryParams = getLandContractQueryParams();
		    			$("#landContractList").datagrid('load', queryParams);
		    		}
					$.messager.alert('提示', data.message, 'info');
				},
				error: function(){
					$.messager.alert('提示', '操作失败', 'error');
				}
			});
		}
	});
}

function getLandContractQueryParams(){
	if($("#farmCode").val() !== "1"){
		var queryParams = {
				'code':$("#farmCode").val(),
				'contractNumber':$("#contractNumber").val(),
				'timeLimit':$("#timeLimit").val(),
				'state':$('#state option:selected').val(),
				'contractType':$('#contractType option:selected').val(),
				'partyB':$("#partyB").val(),
				'contractYear':$("#contractYear").val(),
				'areaOfLandGe':$("#areaOfLandGe").val(),
				'areaOfLandLe':$("#areaOfLandLe").val(),
		};
		return queryParams;
	}else{
		var queryParams = {
				'code':$("#ncmc").combobox("getValue"),
				'contractNumber':$("#contractNumber").val(),
				'timeLimit':$("#timeLimit").val(),
				'state':$('#state option:selected').val(),
				'contractType':$('#contractType option:selected').val(),
				'partyB':$("#partyB").val(),
				'contractYear':$("#contractYear").val(),
				'areaOfLandGe':$("#areaOfLandGe").val(),
				'areaOfLandLe':$("#areaOfLandLe").val(),
		};
		return queryParams;
	}
}

function addTab(title, url){
	var $mainTabs=$('#mainTabs', parent.document);
    if ($mainTabs.tabs('exists', title)){
    	$mainTabs.tabs('select', title);
    } else {
    	var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
    	$mainTabs.tabs('add',{
            title:title,
            content:content,
            closable:true
        });
    }
}

function openIframeWindow(winId,element){
	var length = $("#"+winId).length;
	var url=$(element).attr("url");
	if(length == 0){
		var win = $('<div id="'+winId+'" ><iframe style="width:100%;height:100%;border:0;" src="'+url+'"></iframe></div>');
		$("body").append(win);
	}
	var _window = $('#'+winId).window({title: $(element).attr("title"),
		id:winId,
	    width: $(element).attr("width")||600,
	    height: $(element).attr("height")||500,
	    maximized:$(element).attr("maximized")==='true'?true:false,
	    closed: false,
	    cache: false,
	    collapsible:false,
        minimizable:false,
	    modal: true,
	    url: $(element).attr("url"),
	    cache:false,
		onClose:function(){
        	$("#"+winId).window('destroy');
        }});
	var ev =arguments.callee.caller.arguments[0] || window.event;  
	if (ev.stopPropagation) {
		ev.stopPropagation();
	}else{
		ev.cancelBubble = true;
	}
	return _window;
}
