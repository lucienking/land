<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<% String zd="";
   String nc="";
  if(request.getParameter("zdCode")!=null)
	{
	  zd = request.getParameter("zdCode").toString();
	}
  if(request.getParameter("ncCode")!=null)
   { 
	  nc = request.getParameter("ncCode").toString();
   }
%>

<c:set var="zd" value="<%=zd%>" />
<c:set var="nc" value="<%=nc%>" />
<div id="contractInfoContainer" style="height: 100%">
	<div id="cc" class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'north',title:'查询条件'"
			id="dictSearchConditionPanel" style="height: 200px;">
			<form id="contractInfoSearchConditionForm">
				<table style="width: 99%; height: 99%; margin-buttom: 10px">
					<tr>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_contractorName">承包人名称</label> <input
							id="search_contractorName" name="contractorName"
							class="easyui-textbox" style="width: 160px;" /></td>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_contractorIDNO">承包人证件号</label> <input
							id="search_contractorIDNO" name="contractorIDNO"
							class="easyui-textbox" style="width: 150px;" /></td>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_contractCode">合同编号</label> <input
							id="search_contractCode" name="contractCode"
							class="easyui-textbox" style="width: 190px;" /></td>
					</tr>
					<tr>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_contractStartDate">合同起始时间</label> <input
							id="search_contractStartDate" name="startDate"
							class="easyui-datebox" style="width: 150px;" /></td>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_contractExpiredDate">合同结束时间</label> <input
							id="search_contractExpiredDate" name="expiredDate"
							class="easyui-datebox" style="width: 150px;" /></td>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_useArea">承包面积</label> <select name="compare_userArea"
							class="selector">
								<option selected="selected" value="null">请选择</option>
								<option value="GT">大于</option>
								<option value="LT">小于</option>
								<option value="EQ">等于</option>
						</select> <input id="search_useArea" name="useArea" class="easyui-textbox"
							style="width: 120px;" /></td>
					</tr>
					<tr>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_contractLeaseTerm">承包期</label> <select
							class="selector" name="compare_leaseTerm">
								<option selected="selected" value="null">请选择</option>
								<option value="GT">大于</option>
								<option value="LT">小于</option>
								<option value="EQ">等于</option>
						</select> <input id="search_contractTime" name="leaseTerm"
							class="easyui-textbox" style="width: 120px;" /></td>
						<td width="30%" align="left" style="min-width: 150px"><label
							for="search_contractorType">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;承包方类型</label>
							<select name="contractorType" class="selector">
								<option selected="selected" value="null">请选择</option>
								<option value="ENTERPRISE">企业</option>
								<option value="PERSONAL">个人</option>
						</select></td>
						<td width="30%" align="center" style="min-width: 150px"><label
							for="search_contractPrice">签订单价</label> <select
							name="compare_contractPrice" class="selector">
								<option selected="selected" value="null">请选择</option>
								<option value="GT">大于</option>
								<option value="LT">小于</option>
								<option value="EQ">等于</option>
						</select><input id="search_contractPrice" name="contractPrice"
							class="easyui-textbox" style="width: 120px;" /></td>
					</tr>
					<tr>
						<td width="30%" align="left" style="min-width: 120px"><label
							for="search_contractorAffordableArea">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;有无保障性用地</label>
							<select name="affordableArea" class="selector">
								<option selected="selected" value="null">请选择</option>
								<option value="Y">有</option>
								<option value="N">没有</option>
						</select></td>
						<td width="30%" align="center" style="min-width: 60px"><label
							for="search_community">所在社区</label><input id="com_community"
							name="community" class="easyui-combobox" style="width: 180px;">
							<input id="FarmCode" type="hidden" value="${farmCode }" /></td>
						<td width="30%" align="left" style="min-width: 60px"><label
							for="search_group">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所在生产队</label><input
							name="residentsGroup" id="contract_residentsGroup"
							class="easyui-combobox"
							data-options="valueField:'id',textField:'text'"
							style="width: 180px;" /></td>
					</tr>
					<tr>
						<td width="30%" align="left" style="min-width: 120px"><label
							for="search_contractorisCadres">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是否干部承包</label>
							<select name="isCadres" class="selector">
								<option selected="selected" value="null">请选择</option>
								<option value="Y">是</option>
								<option value="N">否</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="3" width="90%">&nbsp;</td>
						<td colspan="1" width="10%" align="left"><a
							class="easyui-linkbutton" href="#" id="contractInfoSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
							<a class="easyui-linkbutton" id="contractInfoResetButton">&nbsp;重&nbsp;置&nbsp;</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',title:'查询结果'"
			id="contractInfoSearchResultPanel" style="width: 100%; height: 400px">
			<table id="contractInfoDatagrid" style="width: 100%; height: 100%"></table>
		</div>
	</div>
	<div id="contractInfoToolbar">
		<jksb:hasAutority authorityId="007002003">
			<a href="javascript:contractInfoEditData(this)"
				id="contractInfoEditButton" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true,disabled:true,">编辑合同</a>
		</jksb:hasAutority>
		<jksb:hasAutority authorityId="007002002">
			<a href="javascript:dictDeleData()" id="contractInfoPrint"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-print',plain:true,disabled:true,">打印</a>
		</jksb:hasAutority>
		<jksb:hasAutority authorityId="007002002">
			<a href="javascript:maplandData(this)" id="contractInfoToMapButton"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-tip',plain:true,disabled:true,">跳转地图</a>
		</jksb:hasAutority>
		<jksb:hasAutority authorityId="007002002">
			<a href="javascript:dictDeleData()" id="contractInfoRentButton"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-tip',plain:true,disabled:true,">租金记录</a>
		</jksb:hasAutority>
		<jksb:hasAutority authorityId="007002002">
			<a href="javascript:dictDeleData()" id="contractInfoDeleButton"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true,disabled:true,">删除</a>
		</jksb:hasAutority>
	</div>
	<script type="text/javascript">
	var zdCode="${zd}";var ncCode="${nc}";
	/**
	 *  根据合同查询自营经济地块 
	 */
	function maplandData(obj) {
	    /* 	var str = $(obj).attr('contractId'); */
	    var selected = $('#contractInfoDatagrid').datagrid('getSelected');

	    var str = selected.contractCode;
	  //  alert(str);
	    if (str.length == 0) {
	        alert("合同编号为空，不能跳转。");
	        return;
	    }
	    var strPlace = "",
	    strNc = "",
	    strNcName = "";

	    $.ajax({
	        url: '../land/contractInfo/getContractInfoByContractCodeMAP?code=' + str,
	        async: false,
	        // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected  
	        type: "POST",
	        dataType: "json",
	        success: function(data) {
	            //alert(data);
	            var str = data;

	            var f = strNcName;
	            f = escape(f);
	            f = escape(f);

	            strPlace = str[2];
	            strNc = str[0];
	            strNcName = str[1];
	            //	alert("查询出的地块号"+strPlace);           
	        },
	        error: function() {
	            $.messager.alert('错误提示', '远程服务端出现错误！', 'error');
	            return;
	        }
	    });

	    var url = '../land/thematicMap/selfEconomy';
	    // alert(strNcName+strNc+strPlace+"p6");
	    var title = '自营经济';
	    var flag = parent.$("#mainTabs").tabs('exists', title);

	    if (flag) {
	        parent.$("#mainTabs").tabs('close', title);
	    }
	    var content = '<iframe scrolling="no" frameborder="0"  src="' + url + '?f=' + strNcName + '&zdCode=' + strPlace + '&ncCode=' + strNc + '" style="width:99%;height:99%;"></iframe>';
	    parent.$("#mainTabs").tabs('add', {
	        title: title,
	        content: content,
	        closable: true
	    });

	    return;

	}
	
	$(function() {
	//    alert(zdCode + ncCode+"555asdf");
	    var url = location.search;

	    var Request = new Object();

	    //判断是否是自营经济跳转过来
	    if (zdCode != ""&&ncCode!="") {
	         if (zdCode.length > 0) {
	            $('#contractInfoDatagrid').datagrid({
	                url: '../land/contractInfo/getContractByMAP?ncCode='+ncCode +'&zdCode=' + zdCode,
	             
	                rownumbers: true,
	                pagination: true,
	                fitColumns: true,
	                fit: true,
	                queryParams: $('#contractInfoSearchConditionForm').getFormData(),
	                columns: [[{
	                    checkbox: true,
	                    field: '',
	                    title: ''
	                },
	                {
	                    field: 'contractCode',
	                    title: '合同编码',
	                    width: 160
	                },
	                {
	                    field: 'contractArea',
	                    title: '签订面积',
	                    width: 100
	                },
	                {
	                    field: 'contractTime',
	                    title: '承包期',
	                    width: 100
	                },
	                {
	                    field: 'contractor',
	                    title: '承包人名称',
	                    width: 100,
	                    formatter: function(value, row, index) {
	                        return value == 'null' || value == 'undefind' ? "": value;
	                    }

	                },
	                {
	                    field: 'Arrears',
	                    title: '欠缴金额',
	                    width: '100'
	                },
	                {
	                    field: 'flag',
	                    title: '合同状态',
	                    width: '100'
	                }]],
	                toolbar: "#contractInfoToolbar",
	                onSelect: function(index, row) {
	                    contractInfoSelectChange(index, row);
	                },
	                onUnselect: function(index, row) {
	                    contractInfoSelectChange(index, row);
	                },
	                onDblClickRow: function(index, row) { //双击行事件 
	                    DbcontractInfoEditData(row);
	                    $('#contractInfoDatagrid').datagrid('selectRow', index);
	                }
	            });
	            return;
	        } else {
	            alert("没有相对应的合同");
	            return;
	        };
	    } else {
	        /**
					 *  datagrid 初始化 
					 */
	        $('#contractInfoDatagrid').datagrid({
	            url: "../land/contractInfo/getContractInfo",
	            rownumbers: true,
	            pagination: true,
	            fitColumns: true,
	            fit: true,
	            queryParams: $('#contractInfoSearchConditionForm').getFormData(),
	            columns: [[{
	                checkbox: true,
	                field: '',
	                title: ''
	            },
	            {
	                field: 'contractCode',
	                title: '合同编码',
	                width: 160
	            },
	            {
	                field: 'contractArea',
	                title: '签订面积',
	                width: 100
	            },
	            {
	                field: 'contractTime',
	                title: '承包期',
	                width: 100
	            },
	            {
	                field: 'contractor',
	                title: '承包人名称',
	                width: 100,
	                formatter: function(value, row, index) {
	                    return value == 'null' || value == 'undefind' ? "": value;
	                }

	            },
	            {
	                field: 'Arrears',
	                title: '欠缴金额',
	                width: '100'
	            },
	            {
	                field: 'flag',
	                title: '合同状态',
	                width: '100'
	            }]],
	            toolbar: "#contractInfoToolbar",
	            onSelect: function(index, row) {
	                contractInfoSelectChange(index, row);
	            },
	            onUnselect: function(index, row) {
	                contractInfoSelectChange(index, row);
	            },
	            onDblClickRow: function(index, row) { //双击行事件 
	                DbcontractInfoEditData(row);
	                $('#contractInfoDatagrid').datagrid('selectRow', index);
	            }
	        });
	        return;
	    } //else end

	});
	$("#com_community").combobox({
	    url: '../land/community/getCommunityByFarmCode',
	    valueField: 'id',
	    textField: 'text',
	    method: 'GET',
	    queryParams: {
	        "farmCode": $("#FarmCode").val()
	    },
	    onSelect: function(rec) {
	        $('#contract_residentsGroup').combobox('clear');
	        var url = '../land/contractInfo/getResidentsGroupByCommunity?communityCode=' + rec.id;
	        $('#contract_residentsGroup').combobox('reload', url);
	    }
	});
	function contractInfoSelectChange(index, row) { // 选择行事件 通用。
	    var selectedNum = $('#contractInfoDatagrid').datagrid('getSelections').length;
	    if (selectedNum == 1) {
	        $("#contractInfoEditButton").linkbutton("enable");
	        $("#contractInfoDeleButton").linkbutton("enable");
	        $("#contractInfoToMapButton").linkbutton("enable");
	        $("#contractInfoPrint").linkbutton("enable");
	        $("#contractInfoRentButton").linkbutton("enable");
	    } else if (selectedNum == 0) {
	        $("#contractInfoDeleButton").linkbutton("disable");
	        $("#contractInfoEditButton").linkbutton("disable");
	        $("#contractInfoToMapButton").linkbutton("disable");
	        $("#contractInfoPrint").linkbutton("disable");
	        $("#contractInfoRentButton").linkbutton("disable");
	    } else {
	        $("#contractInfoEditButton").linkbutton("disable");
	        $("#contractInfoToMapButton").linkbutton("disable");
	        $("#contractInfoPrint").linkbutton("disable");
	        $("#contractInfoRentButton").linkbutton("disable");
	    }
	}

	$('#contractInfoSearchButton').click(function() {
	    $('#contractInfoDatagrid').datagrid('load', $('#contractInfoSearchConditionForm').getFormData());
	});
	$('#contractInfoResetButton').click(function() {
	    var txts = document.getElementsByTagName("input");
	    var i;
	    for (i = 0; i < txts.length; i++) {
	        txts[i].value = "";
	    }
	});

	function contractInfoAddData() {
	    dictDataDialog("合同信息编辑", null);
	}
	function contractInfoEditData() {
	    var selected = $('#contractInfoDatagrid').datagrid('getSelected');
	    openPanelWin({
	        id: 'win',
	        url: '../land/contractInfo/getContractInfoByContractCode?code=' + selected.contractCode,
	    });
	}
	function DbcontractInfoEditData(row) {
	    openPanelWin({
	        id: 'win',
	        url: '../land/contractInfo/getContractInfoByContractCode?code=' + row.contractCode,
	    });
	}
	function contractInfoDeleData() {
	    var selections = $('#contractInfoDatagrid').datagrid('getSelections');
	    var num = selections.length;
	    $.messager.confirm('删除确认', '确定删除这 ' + num + ' 项吗?',
	    function(r) {
	        if (r) {
	            var ids = "";
	            for (sele in selections) {
	                ids += selections[sele].id;
	                if (sele < (num - 1)) ids += ",";
	            }
	            $.ajax({
	                url: "${ctx}/sys/dict/delete",
	                type: 'GET',
	                data: {
	                    'ids': ids
	                },
	                success: function(data) {
	                    $.messager.alert('操作结果', "<div style='text-align:center;width:100%;'>" + data.message + "</div>");
	                    $("#contractInfoDatagrid").datagrid('reload');
	                },
	                error: function(XMLHttpRequest, textStatus, errorThrown) {
	                    $.messager.alert('操作失败', "错误提示:" + XMLHttpRequest.responseText);
	                }
	            });
	        }
	    });
	}
	function save() {
	    var saveType = $("#contractInfoSaveType").val();
	    $.ajax({
	        type: "POST",
	        url: "${ctx}/sys/dict/" + saveType,
	        data: $('#contractInfoDataForm').serialize(),
	        //将Form 里的值序列化
	        asyn: false,
	        error: function(jqXHR, textStatus, errorMsg) {
	            $.messager.alert('操作结果', "" + jqXHR.responseText);
	            $("#contractInfoDataDialog").dialog("close");
	            $("#contractInfoDatagrid").datagrid('reload');
	        },
	        success: function(data) {
	            $.messager.alert('操作结果', "<div style='text-align:center;width:100%;'>" + data.message + "</div>");
	            $("#contractInfoDataDialog").dialog("close");
	            $("#contractInfoDatagrid").datagrid('reload');
	        }
	    });
	}

	function setDictFormValue(selected) {
	    $("#dictName").textbox('setValue', selected.dictName);
	    $("#dictCode").textbox('setValue', selected.dictCode);
	    $("#dictGroup").textbox('setValue', selected.dictGroup);
	    $("#dictValue").textbox('setValue', selected.dictValue);
	    $("#dictId").val(selected.id);
	    $("#contractInfoSaveType").val("update");
	}
	function clearDictForm() {
	    // $("#dictDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
	    $("#dictName").textbox('setValue', "");
	    $("#dictCode").textbox('setValue', "");
	    $("#dictGroup").textbox('setValue', "");
	    $("#dictValue").textbox('setValue', "");
	    $("#dictId").val("");
	    $("#contractInfoSaveType").val("create");
	}

	/**
			 * 设置分页
			 */
	var p = $('#contractInfoDatagrid').datagrid('getPager');
	$(p).pagination({
	    pageSize: 10,
	    //每页显示的记录条数，默认为15 
	    pageList: [10, 15, 20]
	});

	function refreshDictCache() {
	    $.ajax({
	        url: "${ctx}/sys/dict/refresh",
	        type: 'GET',
	        success: function(data) {
	            $.messager.alert('操作结果', "<div style='text-align:center;width:100%;'>" + data.message + "</div>");
	            $("#contractInfoDatagrid").datagrid('reload');
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	            $.messager.alert('操作失败', "错误提示:" + XMLHttpRequest.responseText);
	        }
	    });
	}
	//打开一个编辑窗口
	function openPanelWin(obj) {
	    var url = '';
	    var title = '编辑';
	    var id = 'win';
	    var width = 800;
	    var height = 500;
	    if (obj) {
	        if (obj.url) url = obj.url;
	        if (obj.title) title = obj.title;
	        if (obj.id) id = obj.id;
	        if (obj.width) width = obj.width;
	        if (obj.height) height = obj.height;
	    }
	    $iframeWindow.openWin({
	        id: id,
	        title: title,
	        href: url,
	        width: width,
	        height: height,
	        modal: true,
	        cache: true,
	        inline: true,
	        collapsible: false,
	        minimizable: false,
	        resizable: false,
	        onClose: function() {
	            $(this).window('destroy');
	        }
	    });

	}
	</script>
</div>