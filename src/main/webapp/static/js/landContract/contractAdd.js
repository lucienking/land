function addRegionTr(){
	$("#tbRegionInfo tbody").append('<tr>'+
    '<td width="43" align="center"></td>'+
    '<td width="77" valign="middle"><input name="regionIdArray" class="noneBorder" type="text"><input type="hidden" name="idArray" value=""></td>'+
    '<td width="76" valign="middle"><input name="landTypeArray" class="noneBorder" type="text"></td>'+
    '<td width="85" valign="middle"><input name="areaOfRegionArray" class="noneBorder" type="text" onblur="caculateAreaSum();areaChange(this);caculateMoneySum();"></td>'+
    '<td width="35" valign="middle"><input name="eastArray" class="noneBorder" type="text"></td>'+
    '<td width="35" valign="middle"><input name="westArray" class="noneBorder" type="text"></td>'+
    '<td width="35" valign="middle"><input name="southArray" class="noneBorder" type="text"></td>'+
    '<td width="35" valign="middle"><input name="northArray" class="noneBorder" type="text"></td>'+
    '<td width="51" valign="middle"><input name="landStatusArray" class="noneBorder" type="text"></td>'+
    '<td width="89" valign="middle"><input name="priceArray" class="noneBorder" type="text" onblur="priceChange(this);caculateMoneySum();"></td>'+
    '<td width="75" valign="middle"><input name="moneyArray" class="noneBorder" type="text" readonly="readonly"></td>'+
    //'<td width="75" valign="middle"><input name="increaseMoneyArray" class="noneBorder" type="text" onblur="caculateIncreMoneySum();"></td>'+
    '<td width="43" align="center"><input type="button" value="删除" onclick="delRegionTr(this);"></td>'+
  '</tr>');
	reShowNum();
	$('input[name="regionIdArray"]').validatebox({
		required: true,
		validType:'checkRegion[\'#hddContractId\']',
		delay:800
	});
	$('input[name="areaOfRegionArray"]').validatebox({
	    validType: 'fnumber'
	});
	$('input[name="priceArray"]').validatebox({
	    validType: 'fnumber'
	});
	/*$('input[name="increaseMoneyArray"]').validatebox({
	    validType: 'fnumber'
	});*/
}

function delRegionTr(element){
	$(element).parent().parent().remove();
	reShowNum();
	caculateAreaSum();
	caculateMoneySum();
}

function recordDelId(id){
	var val=$("#hddDelIdArray").val();
	if(val!=""){
		$("#hddDelIdArray").val(val+","+id);
	}else{
		$("#hddDelIdArray").val(id);
	}
}

function reShowNum(){
	$("#tbRegionInfo tbody tr").each(function(index,element){
		$(this).find('td:first').text(index+1);
	});
}

function areaChange(element){
	var val=$(element).val();
	var $tr=$(element).parent().parent();
	if(isNaN(val)==false&&val!=''){
		var price=$tr.find("input[name='priceArray']").val();
		if(isNaN(price)==false&&price!=''){
			var total=accMul(val,price);
			$tr.find("input[name='moneyArray']").val(total);
		}
	}else{
		$tr.find("input[name='moneyArray']").val("");
	}
}

function priceChange(element){
	var val=$(element).val();
	var $tr=$(element).parent().parent();
	if(isNaN(val)==false&&val!=''){
		var area=$tr.find("input[name='areaOfRegionArray']").val();
		if(isNaN(area)==false&&area!=''){
			var total=accMul(val,area);
			$tr.find("input[name='moneyArray']").val(total);
		}
	}else{
		$tr.find("input[name='moneyArray']").val("");
	}
}

function caculateAreaSum(){
	var areaSum=0;
	var val;
	$("#tbRegionInfo input[name='areaOfRegionArray']").each(function(index,element){
		val=$(this).val();
		if(isNaN(val)==false&&val!=''){
			areaSum=accAdd(areaSum,parseFloat(val));
		}
	});
	$("#spAreaSum").text(areaSum);
	$("#areaOfLand").val(areaSum);
}

function caculateMoneySum(){
	var moneySum=0;
	var val;
	$("#tbRegionInfo input[name='moneyArray']").each(function(index,element){
		val=$(this).val();
		if(isNaN(val)==false&&val!=''){
			moneySum=accAdd(moneySum,parseFloat(val));
		}
	});
	//$("#baseRental").val(moneySum);
	//caculateTotalSum();
	
	$("#spMoneySum").text(moneySum);
	$("#money").val(moneySum);
	convertMoneyCn(moneySum);
}

function convertMoneyCn(moneySum){
	var moneyCn=convertCurrency(moneySum);
	var wanIndex=moneyCn.lastIndexOf("万");
	var qianIndex=moneyCn.lastIndexOf("仟");
	var baiIndex=moneyCn.lastIndexOf("佰");
	var shiIndex=moneyCn.lastIndexOf("拾");
	var yuanIndex=moneyCn.lastIndexOf("元");
	var jiaoIndex=moneyCn.lastIndexOf("角");
	var fenIndex=moneyCn.lastIndexOf("分");
	if(wanIndex!=-1){
		var wan=moneyCn.substring(0,wanIndex);
		$("#wan").val(wan);
	}else{
		$("#wan").val("零");
	}
	if(qianIndex!=-1){
		var qian=moneyCn.substring(wanIndex==-1?0:wanIndex+1,qianIndex);
		$("#qian").val(qian);
	}else{
		$("#qian").val("零");
	}
	if(baiIndex!=-1){
		var bai=moneyCn.substring(qianIndex==-1?0:qianIndex+1,baiIndex);
		$("#bai").val(bai);
	}else{
		$("#bai").val("零");
	}
	if(shiIndex!=-1){
		var shi=moneyCn.substring(baiIndex==-1?0:baiIndex+1,shiIndex);
		$("#shi").val(shi);
	}else{
		$("#shi").val("零");
	}
	if(yuanIndex!=-1){
		var yuan=moneyCn.substring(shiIndex==-1?0:shiIndex+1,yuanIndex);
		$("#yuan").val(yuan);
	}else{
		$("#yuan").val("零");
	}
	if(jiaoIndex!=-1){
		var jiao=moneyCn.substring(yuanIndex==-1?0:yuanIndex+1,jiaoIndex);
		$("#jiao").val(jiao);
	}else{
		$("#jiao").val("零");
	}
	if(fenIndex!=-1){
		var fen=moneyCn.substring(jiaoIndex==-1?0:jiaoIndex+1,fenIndex);
		$("#fen").val(fen);
	}else{
		$("#fen").val("零");
	}
}

function caculateIncreMoneySum(){
	var moneySum=0;
	var val;
	$("#tbRegionInfo input[name='increaseMoneyArray']").each(function(index,element){
		val=$(this).val();
		if(isNaN(val)==false&&val!=''){
			moneySum=moneySum+parseFloat(val);
		}
	});
	$("#increaseRental").val(moneySum);
	caculateTotalSum();
}

function caculateTotalSum(){
	var a=$("#baseRental").val();
	var b=$("#increaseRental").val();
	var sum=parseFloat(a)+parseFloat(b);
	$("#spMoneySum").text(sum);
	$("#money").val(sum);
}

function caculateEndDate(){
	var timeLimit=$("#timeLimit").val();
	var startYear=$("#startYear").val();
	var startMonth=$("#startMonth").val();
	var startDay=$("#startDay").val();
	if(startYear!=""&&startMonth!=""&&startDay!=""){
		$("#startDate").val(startYear+"年"+startMonth+"月"+startDay+"日");
		if(timeLimit!=""){
			var endYear=parseInt(timeLimit)+parseInt(startYear);
			var d=addDate(endYear,startMonth,startDay,-1);
			var endMonth=d.getMonth()+1;
			var endDay=d.getDate();
			$("#endDate").val(endYear+"年"+endMonth+"月"+endDay+"日");
			$("#endYear").val(endYear);
			$("#endMonth").val(endMonth);
			$("#endDay").val(endDay);
		}else{
			$("#endDate").val("");
			$("#endYear").val("");
			$("#endMonth").val("");
			$("#endDay").val("");
		}
	}else{
		$("#startDate").val("");
		$("#endDate").val("");
		$("#endYear").val("");
		$("#endMonth").val("");
		$("#endDay").val("");
	}
	
}

function addDate(year,month,day,add){
	var a = new Date(year,month-1,day)
	a = a.valueOf();
	a = a + add * 24 * 60 * 60 * 1000;
	a = new Date(a);
	return a;
}

function setOperation(op){
	$("#hddOperation").val(op);
}

function delFile(targetId){
	var file=$("#"+targetId);
	file.after(file.clone().val(""));
	file.remove();
}

function deleteAttach(element){
	$(element).parent().remove();
	changeUploadLimit();
}

function recordDelAttachId(id){
	var val=$("#hddDelAttachIdArray").val();
	if(val!=""){
		$("#hddDelAttachIdArray").val(val+","+id);
	}else{
		$("#hddDelAttachIdArray").val(id);
	}
}

function changeUploadLimit(){
	$("#pFileUpload").show();
	var uploadLimit=$("#file_upload").uploadify('settings','uploadLimit');
	$('#file_upload').uploadify('settings','uploadLimit',uploadLimit+1);
	
}

function formSubmit(form){
	var result=$(form).form('validate');
	return result;
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


function convertCurrency(currencyDigits) {
	// Constants:
	var MAXIMUM_NUMBER = 99999999999.99;
	// Predefine the radix characters and currency symbols for output:
	var CN_ZERO = "零";
	var CN_ONE = "壹";
	var CN_TWO = "贰";
	var CN_THREE = "叁";
	var CN_FOUR = "肆";
	var CN_FIVE = "伍";
	var CN_SIX = "陆";
	var CN_SEVEN = "柒";
	var CN_EIGHT = "捌";
	var CN_NINE = "玖";
	var CN_TEN = "拾";
	var CN_HUNDRED = "佰";
	var CN_THOUSAND = "仟";
	var CN_TEN_THOUSAND = "万";
	var CN_HUNDRED_MILLION = "亿";
	var CN_DOLLAR = "元";
	var CN_TEN_CENT = "角";
	var CN_CENT = "分";
	var CN_INTEGER = "整";

	// Variables:
	var integral; // Represent integral part of digit number.
	var decimal; // Represent decimal part of digit number.
	var outputCharacters; // The output result.
	var parts;
	var digits, radices, bigRadices, decimals;
	var zeroCount;
	var i, p, d;
	var quotient, modulus;

	// Validate input string:
	currencyDigits = currencyDigits.toString();
	if (currencyDigits == "") {
		alert("Empty input!");
		return "";
	}
	if (currencyDigits.match(/[^,.\d]/) != null) {
		alert("Invalid characters in the input string!");
		return "";
	}
	if ((currencyDigits)
			.match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
		alert("Illegal format of digit number!");
		return "";
	}

	// Normalize the format of input digits:
	currencyDigits = currencyDigits.replace(/,/g, ""); // Remove comma delimiters.
	currencyDigits = currencyDigits.replace(/^0+/, ""); // Trim zeros at the beginning.
	// Assert the number is not greater than the maximum number.
	if (Number(currencyDigits) > MAXIMUM_NUMBER) {
		alert("Too large a number to convert!");
		return "";
	}

	// Process the coversion from currency digits to characters:
	// Separate integral and decimal parts before processing coversion:
	parts = currencyDigits.split(".");
	if (parts.length > 1) {
		integral = parts[0];
		decimal = parts[1];
		// Cut down redundant decimal digits that are after the second.
		decimal = decimal.substr(0, 2);
	} else {
		integral = parts[0];
		decimal = "";
	}
	// Prepare the characters corresponding to the digits:
	digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE,
			CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
	radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
	bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION);
	decimals = new Array(CN_TEN_CENT, CN_CENT);
	// Start processing:
	outputCharacters = "";
	// Process integral part if it is larger than 0:
	if (Number(integral) > 0) {
		zeroCount = 0;
		for (i = 0; i < integral.length; i++) {
			p = integral.length - i - 1;
			d = integral.substr(i, 1);
			quotient = p / 4;
			modulus = p % 4;
			if (d == "0") {
				zeroCount++;
				if(p<4){
					outputCharacters += digits[0] + radices[modulus];
				}
			} else {
				if (zeroCount > 0 && p>=4) {
					outputCharacters += digits[0];
				}
				zeroCount = 0;
				outputCharacters += digits[Number(d)] + radices[modulus];
			}
			if (modulus == 0 && zeroCount < 4) {
				outputCharacters += bigRadices[quotient];
			}
		}
		outputCharacters += CN_DOLLAR;
	}
	// Process decimal part if there is:
	if (decimal != "") {
		for (i = 0; i < decimal.length; i++) {
			d = decimal.substr(i, 1);
			if (d != "0") {
				outputCharacters += digits[Number(d)] + decimals[i];
			}else{
				outputCharacters += digits[0] + decimals[i];
			}
		}
	}
	// Confirm and return the final output string:
	if (outputCharacters == "") {
		outputCharacters = CN_ZERO + CN_DOLLAR;
	}
	outputCharacters = outputCharacters;
	return outputCharacters;
}
