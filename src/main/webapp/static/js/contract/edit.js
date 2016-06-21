$(function() {
	initElements();
});

function closePanelWin(id) {
	var winId = 'win';
	if (id) {
		winId = id;
	}
	$$.close(winId);
}

var $$ = {
	close : function(id) {
		$('#' + id).window('close');
	}
}

function initElements() {

	$('#landType').combobox({
		url : 'listLandType?time=20110101',
		valueField : 'code',
		disabled : true,
		textField : 'name'
	});

	$('#landLevel').combobox({
		url : 'listLandLevel?time=20110101',
		valueField : 'code',
		disabled : true,
		textField : 'name'
	});

	$('#place').combobox({
		url : 'listAllFarm?time=' + getBeginTime(),
		valueField : 'code',
		textField : 'name',
		disabled : true,
		onLoadSuccess : placeLoaded
	});

	$('#crops').combotree({
		url : 'listCrop',
		panelWidth : 180,
		multiple : true,
		checkbox : true,
		panelHeight : 300,
		disabled : true,
		onLoadSuccess : function() {
			if ($('#cropsValue').val()) {
				var values = $('#cropsValue').val().split(",");
				checkCombotreeNodes('crops', values);
			}
		},
	});

	$('#farm').combobox({
		url : '../farm/listAllFarm',
		value : $('#farmCode').val(),
		valueField : 'code',
		textField : 'name',
		disabled : true,
		onSelect : farmSelected,
		editable : false
	});

	$('#community').combobox({
		url : '../farm/listCommunity?farmCode=' + $('#farmCode').val(),
		value : $('#communityCode').val(),
		valueField : 'code',
		textField : 'name',
		disabled : true,
		onSelect : communitySelected
	});

	$('#productionTeam').combobox({
		url : '../farm/listTeam?communityCode=' + $('#communityCode').val(),
		onLoadSuccess : function() {
			$('#productionTeam').combobox('setValue', $('#teamCode').val());
		},
		valueField : 'code',
		textField : 'name',
		disabled : true,
		editable : false
	});

	$('#contractYears').validatebox({
		required : true,
		validType : 'number'
	});

	$('#area').validatebox({
		required : true,
		validType : 'double'
	});

	$('#contractYears').bind('blur', setEndTime);

	$('#contractorType').combotree({
		url : 'listContractorTypeTree',
		panelWidth : 180,
		panelHeight : 300
	});

	$('#papersType').combobox({
		valueField : 'code',
		textField : 'text',
		value : 1,
		data : [ {
			code : 1,
			text : '身份证'
		}, {
			code : 2,
			text : '军官证'
		} ]
	});
}

function getBeginTime() {
	var beginTime = $('#beginTime').val();
	console.log(beginTime);
	if (beginTime) {
		return beginTime.replace(/-/g, '');
	}
	return 20110101;
}

function placeLoaded() {
	var farmCode = $('#farmCode').val();
	var time = 20110101;

	var beginTime = null;
	try {
		beginTime = $('#beginTime').datebox('getText');
	} catch (e) {

	}
	console.log(2);
	if (beginTime) {
		console.log(3);
		time = beginTime.replace(/-/g, '');
	}
	$.post('getPlaceCode', {
		farmCode : farmCode,
		time : time
	}, function(data) {
		$('#place').combobox('setValue', data.code);
	}, 'json');
}

function setEndTime() {
	var beginTime = $('#beginTime').datebox('getText');
	var contractYears = $('#contractYears').val();

	if (beginTime && contractYears && parseInt(contractYears)) {
		$('#endTime').datebox('setValue', getEndtime(beginTime, contractYears));
	}
}

function getEndtime(beginTime, years) {
	var timeArray = beginTime.split('-');
	return parseInt(timeArray[0]) + parseInt(years) + '-' + timeArray[1] + '-'
			+ timeArray[2];
}

function farmSelected(row) {
	$('#community').combobox('clear');
	$('#productionTeam').combobox('clear');
	$('#community').combobox('reload',
			'../farm/listCommunity?farmCode=' + row.code);
}

function communitySelected(row) {
	$('#productionTeam').combobox('reload',
			'../farm/listTeam?communityCode=' + row.code);
}

function changeApply() {
	/*
	 * alert($('#contractorType').combotree('tree').tree('getSelected').id);
	 * return;
	 */
	if (!$('#contractForm').form('validate')) {
		$('#mainTabs').tabs('select', '合同信息');
		return;
	}
	if (!$('#contractorForm').form('validate')) {
		$('#mainTabs').tabs('select', '承包人信息');
		return;
	}
	var data = {};
	getFormData($('#contractForm'), data);
	getFormData($('#contractorForm'), data);
	data.beginTime = $('#beginTime').datebox('getText');
	data.endTime = $('#endTime').datebox('getText');
	if (document.getElementById('cancleDate')) {
		data.cancleDate = $('#cancleDate').datebox('getText');
	}
	data.crops = getCrops();
	data.parcels = getParcels();
	data.farm = {
		code : $('#farm').combobox('getValue')
	};
	data.community = {
		code : $('#community').combobox('getValue')
	};
	data.productionTeam = {
		code : $('#productionTeam').combobox('getValue')
	};
	data.contractors = getContractors();
	var param = {};
	param.contract = data;
	param.dirName = $('#dirName').val();
	saveData(param);
}

function getContractors() {
	var result = [];
	/*
	 * var contractor = {}; contractor.typeCode =
	 * ($('#contractorType').combotree('tree').tree('getSelected').id);
	 * contractor.papersType = $('#papersType').combobox('getValue');
	 * contractor.name = $('#contractorName').val(); contractor.papersNum =
	 * $('#papersNum').val(); contractor.id = $('#contractorId').val();
	 * result.push(contractor);
	 */
	return result;
}

function saveData(data) {
	$.ajax({
		url : 'changeApply',
		data : JSON.stringify(data),
		type : 'POST',
		async : false,
		contentType : 'application/json',
		dataType : 'json',
		success : function(data) {
			$.messager.alert('信息', data.message);
			$$.close('win');
			$('#datagrid').datagrid('reload');
		},
		error : function(xhr, status, error) {
			$.messager.alert('错误', error);
		}
	});
}

function getParcels() {
	var parcels = [];
	var parcelArray = $('#parcels').val().split(',');
	for ( var index in parcelArray) {
		parcels.push({
			parcelCode : parcelArray[index]
		});
	}
	return parcels;
}

function getCrops() {
	var cropValues = $('#crops').combotree('tree')
			.tree('getChecked', 'checked');
	var crops = [];
	for ( var index in cropValues) {
		crops.push({
			code : cropValues[index].id
		});
	}
	return crops;
}

function getFormData(form, data) {
	$(form).each(function() {
		var array = $(this).serializeArray();
		$.each(array, function() {
			if (this.name) {
				if (this.name.indexOf('.') != -1) {
					var arr = this.name.split('.');
					if (data[arr[0]]) {
						data[arr[0]][data[arr[1]]] = this.value;
					} else {
						data[arr[0]] = {};
						data[arr[0]][data[arr[1]]] = this.value;
					}
				} else {
					if (data[this.name]) {
						if (!data[this.name].push) {
							data[this.name] = [ data[this.name] ];
						}
						data[this.name].push(this.value || '');
					} else {
						data[this.name] = this.value || '';
					}
				}
			}
		});
	});
	return data;
}

function upload() {
	fileUpload(document.getElementById('uploadForm'), 'fileUpload', function(
			data) {
		var msgArr = data.split("__");
		var dirName = $('#dirName').val();
		if (!dirName) {
			$('#dirName').val(msgArr[0]);
		}
		addFileRow(msgArr[1]);
	});
}

function addFileRow(name) {
	$('#datagrid').datagrid('appendRow', {
		fileName : name
	});
}

function statusChange(obj) {
	var status = $(obj).attr('status');
	var id = $(obj).attr('contractId');
	if (status == '3') {
		approve(id);
	} else if (status == '-1') {
		rollback(id);
	}
}

function approve(id) {
	var url = 'statusToApproved';
	$.post(url, {
		id : id
	}, function(data) {
		if (data && data.code == '1') {
			$('#datagrid').datagrid('reload');
			closePanelWin('win');
			$.messager.alert('信息', data.message, 'info');
		}
	}, 'json');
}

function rollback(id) {
	var url = 'statusToRollback';
	$.messager.prompt('请输入回退原因', '回退原因:', function(r) {
		if (!r || r.trim().length == 0) {
			$.messager.alert('错误', '回退原因不能为空,操作失败', 'error');
		} else {
			$.post(url, {
				id : id,
				reason : r
			}, function(data) {
				if (data && data.code == '1') {
					$('#datagrid').datagrid('reload');
					closePanelWin('win');
					$.messager.alert('信息', data.message, 'info');
				}
			}, 'json');
		}
	});
}

function downloadFile(obj) {
	var url = 'downloadFile?id=' + $(obj).attr('fileId');
	window.location.href = url;
	var iframe = $('<iframe href="' + url + '" style="display:none;"></iframe>');
	$('#framebody').append(iframe);
}

function delFile(obj) {
	$.messager.confirm('信息', '确定删除文件吗？', function(r) {
		if (r) {
			var index = $($(obj).parent().parent().parent()).attr(
					'datagrid-row-index');
			$.post('delFile', {
				id : $(obj).attr('fileId')
			}, function(data) {
				if (data && data.code == '1') {
					$('#filesgrid').datagrid('deleteRow', index);
				}
			}, 'json');
		}
	});

}
