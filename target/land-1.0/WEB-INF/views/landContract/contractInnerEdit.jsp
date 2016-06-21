<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>合同预览</title>
<link href="<spring:url value="/static/jquery-easyui/themes/icon.css"/>" type="text/css" rel="stylesheet" />
<link href="<spring:url value="/static/jquery-easyui/themes/default/easyui.css"/>" type="text/css" rel="stylesheet" />
<link href="<spring:url value="/static/styles/landContract/contract.css?r=1"/>" rel="stylesheet">
<link href="<spring:url value="/static/uploadify/uploadify.css" />" type="text/css" rel="stylesheet" />

<style media="print">
        .noprint
        {
            display: none;
        }
    </style>

<script type="text/javascript" src="<spring:url value="/static/jquery/jquery-1.9.1.min.js"/>"></script>
<script src="<spring:url value="/static/jquery-easyui/jquery.easyui.min.js"/>"></script>
<script src="<spring:url value="/static/jquery-easyui/locale/easyui-lang-zh_CN.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/static/My97DatePicker/WdatePicker.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/static/js/landContract/arithmetic.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/static/js/landContract/contractAdd.js?r=4"/>"></script>
<script type="text/javascript" src="<spring:url value="/static/js/landContract/customValidate.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/static/uploadify/jquery.uploadify.js?r=1" />"></script>
<script type="text/javascript">
$(document).ready(function(){
	var msg=$("#hddMsg").val();
	if(msg!=""){
		alert(msg);
	}
	
	var state=$("#hddState").val();
	if(state){
		$("input").attr("readonly","readonly");
	}else{
		var attachLength=$("#hddAttachLength").val();
		var remain=2-parseInt(attachLength);
		$("#file_upload").uploadify({
	        'height': 30,
	        'swf': '<spring:url value="/static/uploadify/uploadify.swf" />',
	        'uploader': '<spring:url value="/landContract/uploadAttach"/>',
	        'width': 80,
	        'fileObjName':'file',
	        'method':'post',
	        'fileSizeLimit':'20MB',
	        'multi':false,
			'uploadLimit':remain==0?1:remain,
			'successTimeout':300,
			'buttonText':'上传附件',
			'onCancel':function(file){
				$("#file_upload").uploadify("disable", false);
			},
			'onSelect':function(file){
				//$("#file_upload").uploadify("disable", true);
			},
			'onUploadStart':function(file){
				
			},
			'onUploadSuccess' : function(file, data, response) {
				var json=$.parseJSON(data);
				var fileName=json.fileName;
				var originFileName=json.originFileName;
				var $pFileUpload=$("#pFileUpload");
				$pFileUpload.after("<p>附件：<a href='"+json.fileSrc+"/"+fileName+"' target='_blank'>"+originFileName+"</a>"+
						"<input type=\"hidden\" name=\"fileNameArray\" value=\""+fileName+"\">"+
						"<input type=\"hidden\" name=\"originFileNameArray\" value=\""+originFileName+"\">"+
				"&nbsp;&nbsp;<input type='button' value='删除' onclick='deleteAttach(this);'></p>");
				//alert(json.fileName);
			},
			'onUploadError' : function(file, errorCode, errorMsg, errorString) {
				$("#file_upload").uploadify("disable", false);
	            alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
	        },
	        'onInit'   : function(instance) {
	        	if(remain==0){
	    			$("#pFileUpload").hide();
	    		}
	        }
	    });
		
	}
	
	
});

</script>
</head>
<body>
<div class="easyui-layout" data-options="${ hideBar eq true?'width:100%':'fit: true'}">
<input id="hddMsg" type="hidden" value="${msg }">
<input id="hddState" type="hidden" value="${preview }">
<input id="hddContractId" type="hidden" value="${contract.id }">
<input id="hddCheckRegionUrl" type="hidden" value="<spring:url value="/landContract/checkRegion"/>">
<form action="<spring:url value="/landContract/editInner/${contract.id }"/>" method="post" onsubmit="return formSubmit(this);">
<c:if test="${ hideBar ne true}">
<!-- 按钮栏 -->
<div id="layoutNorth" class="noprint" data-options="region:'north',split:false,collapsible:false" >
    <input id="hddOperation" type="hidden" name="operation">
    <c:if test="${ contract.state eq 0}">
    <input type="submit" value="保存" onclick="setOperation(0);" >
    <input type="submit" value="提交" onclick="setOperation(1);" >
    </c:if>
    <input type="button" value="打印预览" onclick="window.open('<spring:url value="/landContract/preview/${contract.contractType }/${contract.id }"/>');">
    </div>
    </c:if>
    
<!-- 打印按钮 -->
    <c:if test="${ hideBar eq true}">
    <div id="layoutNorth" class="noprint">
    <input type="button" onclick="window.print();" value="打印">
    </div>
    </c:if>
    
    <div id="layoutCenter" data-options="region:'center',border:false">
<p align="right">     </p>
<p align="right">合同编号：<input id="contractFarm" name="contractFarm" class="inputClass" type="text" value="${contract.contractFarm }" readonly="readonly">场字[<select id="contractYear" name="contractYear"><option>${contract.contractYear }</option></select>]    <input id="contractCode" name="contractCode" class="inputClass" type="text" value="${contract.contractCode }">    号 </p>
<p align="right">&nbsp;</p>
<p id="mainTitle" align="center"><strong>${contract.partyA }</strong> <br />
  <strong>内部土地承包合同书 </strong></p>
<p align="center"><strong>&nbsp;</strong></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<c:if test="${ hideBar eq true}">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p id="aTitle">发  包  方：${contract.partyA }</p>
  <p id="bTitle">承  包  方：${contract.partyB }</p>
  <p>&nbsp;</p>
<p>&nbsp;</p>
 </c:if>
<br clear="all" />
<p>&nbsp;</p>
<p>发  包  方：<input id="partyA" name="partyA" class="inputClass" type="text" value="${contract.partyA }" readonly="readonly"> （以下简称甲方） </p>
<p>法定代表人：<input id="representativeA" name="representativeA" class="inputClass" type="text" value="${contract.representativeA }" readonly="readonly"><br />
  <br />
  承  包  方：<input id="partyB" name="partyB" class="inputClass easyui-validatebox" required="true" type="text" value="${contract.partyB }"> （以下简称乙方） </p>
<p>身份证号：<input id="partyBIDNumber" name="partyBIDNumber" class="inputClass easyui-validatebox" required="true" data-options="validType:'idcard'" type="text" value="${contract.partyBIDNumber }"> </p>
<p>现住址：<input id="partyBAddress" name="partyBAddress" class="inputClass" type="text" value="${contract.partyBAddress }"> </p>
<p>&nbsp;</p>
<p>根据《中华人民共和国合同法》、《中华人民共和国土地管理法》、《海南经济特区土地管理条例》等有关法律、法规和海南省相关政策及《海南省国营东昌农场农业用地规范管理实施办法》的规定，甲、乙双方本着平等、自愿、有偿的原则，就海南省国营东昌农场土地承租事宜，经双方协商一致，订立本合同。 <br />
  <strong>  </strong><strong>第一条 承包土地概况 </strong><br />
  甲方自愿将其坐落于国营<input id="belongFarm" name="belongFarm" class="inputClass" type="text" value="${contract.belongFarm }" readonly="readonly">的<input id="areaOfLand" name="areaOfLand" class="inputClass" type="text" value="${contract.areaOfLand }" readonly="readonly">亩土地（详见下表）承包给乙方从事农业生产经营活动。 </p>
<p>&nbsp;</p>
<c:if test="${ contract.state eq 0 and preview ne true}">
<p class="noprint"><input type="button" value="添加地块" onclick="addRegionTr();"></p>
</c:if>
<input id="hddDelIdArray" type="hidden" name="delIdArray">
<table id="tbRegionInfo">
<thead>
  <tr>
    <td width="43" rowspan="2"><p align="center"><strong>序 号 </strong></p></td>
    <td width="77" rowspan="2"><p align="center"><strong>土地编号 </strong></p></td>
    <td width="76" rowspan="2"><p align="center"><strong>地类（等级） </strong></p></td>
    <td width="85" rowspan="2"><p align="center"><strong>面积（亩） </strong></p></td>
    <td width="138" colspan="4"><p align="center"><strong>四至界限 </strong></p></td>
    <td width="51" rowspan="2"><p align="center"><strong>土地现状 </strong></p></td>
    <td width="89" rowspan="2"><p align="center"><strong>收费标准（元/亩） </strong></p></td>
    <td width="75" rowspan="2"><p align="center"><strong>收费 </strong><br />
      <strong>金额 </strong><br />
      <strong>（元） </strong></p></td>
      <!-- <td width="75" rowspan="2"><p align="center"><strong>阶梯地价</strong><br />
      <strong>递增金额 </strong><br />
      <strong>（元） </strong></p></td> -->
      <c:if test="${ contract.state eq 0 and preview ne true}">
      <td width="43" rowspan="2" class="noprint"><p align="center"><strong>操作 </strong></p></td>
      </c:if>
  </tr>
  <tr>
    <td width="35"><p align="center"><strong>东 </strong></p></td>
    <td width="35"><p align="center"><strong>西 </strong></p></td>
    <td width="35"><p align="center"><strong>南 </strong></p></td>
    <td width="35"><p align="center"><strong>北 </strong></p></td>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="region" items="${contract.regionList }" varStatus="st">
  <tr>
    <td align="center">${st.count }</td>
    <td valign="middle"><input name="regionIdArray" class="noneBorder easyui-validatebox" required="true" data-options="validType:['checkRegion[\'#hddContractId\']']" type="text" value="${region.regionId }">
    <input type="hidden" name="idArray" value="${region.id }">
    </td>
    <td valign="middle"><input name="landTypeArray" class="noneBorder" type="text" value="${region.landType }"></td>
    <td valign="middle"><input name="areaOfRegionArray" class="noneBorder easyui-validatebox" data-options="validType: 'fnumber'" type="text" value="${region.areaOfRegion }" onblur="caculateAreaSum();areaChange(this);caculateMoneySum();"></td>
    <td valign="middle"><input name="eastArray" class="noneBorder" type="text" value="${region.east }"></td>
    <td valign="middle"><input name="westArray" class="noneBorder" type="text" value="${region.west }"></td>
    <td valign="middle"><input name="southArray" class="noneBorder" type="text" value="${region.south }"></td>
    <td valign="middle"><input name="northArray" class="noneBorder" type="text" value="${region.north }"></td>
    <td valign="middle"><input name="landStatusArray" class="noneBorder" type="text" value="${region.landStatus }"></td>
    <td valign="middle"><input name="priceArray" class="noneBorder easyui-validatebox" data-options="validType: 'fnumber'" type="text" value="${region.price }" onblur="priceChange(this);caculateMoneySum();"></td>
    <td valign="middle"><input name="moneyArray" class="noneBorder" type="text" value="${region.money }" readonly="readonly"></td>
    <%-- <td width="75" valign="middle"><input name="increaseMoneyArray" class="noneBorder easyui-validatebox" data-options="validType: 'fnumber'" type="text" value="${region.increaseMoney }" onblur="caculateIncreMoneySum();"></td> --%>
    <c:if test="${ contract.state eq 0 and preview ne true}">
    <td align="center" class="noprint"><input type="button" value="删除" onclick="delRegionTr(this);recordDelId(${region.id});"></td>
    </c:if>
  </tr>
  </c:forEach>
  </tbody>
</table>
<table id="tbRegionSum">
<tr>
    <td width="634" colspan="11" valign="top"><p><strong>承包土地的用途：<input id="landPurpose" name="landPurpose" class="inputClass" type="text" value="${contract.landPurpose }" readonly="readonly" style="width:120px;text-align: left;"> </strong></p></td>
  </tr>
  <tr>
    <td width="634" colspan="11" valign="top"><p><strong>合计：面积<span id="spAreaSum">${contract.areaOfLand }</span>亩，<%-- 基本地价收费总额<input id="baseRental" name="baseRental" class="noneBorder" type="text" value="${contract.baseRental }" readonly="readonly">元，阶梯地价递增总额<input id="increaseRental" name="increaseRental" class="noneBorder" type="text" value="${contract.increaseRental }" readonly="readonly">元， --%>应缴金额：<span id="spMoneySum">${contract.money }</span>元 </strong></p></td>
  </tr>
</table>
<p><strong>&nbsp;</strong></p>
<p><strong>第二条 承包期限 </strong><br />
<input id="startDate" name="startDate" type="hidden" value="<fmt:formatDate value="${contract.startDate }" pattern="yyyy年MM月dd日"/>">
<input id="endDate" name="endDate" type="hidden" value="<fmt:formatDate value="${contract.endDate }" pattern="yyyy年MM月dd日"/>">
  土地承包期限为<input id="timeLimit" name="timeLimit" class="inputClass easyui-validatebox" data-options="validType:['number','lte[\'int\',30]','checkAgeLimit']" type="text" value="${contract.timeLimit }">年，自<input id="startYear" class="inputClass" type="text" value="<fmt:formatDate value="${contract.startDate }" pattern="yyyy"/>" onblur="caculateEndDate();">年<input id="startMonth" class="inputClass" type="text" value="<fmt:formatDate value="${contract.startDate }" pattern="MM"/>" onblur="caculateEndDate();">月<input id="startDay" class="inputClass" type="text" value="<fmt:formatDate value="${contract.startDate }" pattern="dd"/>" onblur="caculateEndDate();">日起至<input id="endYear" class="inputClass" type="text" value="<fmt:formatDate value="${contract.endDate }" pattern="yyyy"/>" readonly="readonly">年<input id="endMonth" class="inputClass" type="text" value="<fmt:formatDate value="${contract.endDate }" pattern="MM"/>" readonly="readonly">月<input id="endDay" class="inputClass" type="text" value="<fmt:formatDate value="${contract.endDate }" pattern="dd"/>" readonly="readonly"">日止（土地承包期限不得超过30年，不得超过承包方的法定退休年龄，居民参照职工退休年龄执行）。 <br />
  <strong>第三条 土地承包费</strong> <br />
  土地承包费依据海南省农业厅、海南省国土资源厅、海南省农垦总局琼农字[2016]20号&ldquo;关于东昌农场农业用地规范管理（试点）工作若干问题处理意见的通知&rdquo;及&ldquo;海南省国营东昌农场农业用地规范管理实施办法&rdquo;规定的标准收费。 <br />
  （一）土地承包费按照阶梯地价执行，20亩（含）以内的按承包农业用地基本地价收费；20－50亩的部分按基本地价的120%收费；51－100亩的部分按基本地价的150%收费；101－150亩的部分按基本地价的180%收费；150亩以上的部分按基本地价的200%收费。今后承包农业用地基本地价按海南省公布的标准执行。 <br />
  （二）土地承包费：<input id="money" name="money" class="inputClass" type="text" value="${contract.money }" readonly="readonly">元，大写：<input id="wan" name="wan" class="inputClass" type="text" value="${contract.wan }" readonly="readonly">万<input id="qian" name="qian" class="inputClass moneyCn" type="text" value="${contract.qian }" readonly="readonly"> 仟<input id="bai" name="bai" class="inputClass moneyCn" type="text" value="${contract.bai }" readonly="readonly"> 佰<input id="shi" name="shi" class="inputClass moneyCn" type="text" value="${contract.shi }" readonly="readonly"> 拾<input id="yuan" name="yuan" class="inputClass moneyCn" type="text" value="${contract.yuan }" readonly="readonly"> 元<input id="jiao" name="jiao" class="inputClass moneyCn" type="text" value="${contract.jiao }" readonly="readonly"> 角<input id="fen" name="fen" class="inputClass moneyCn" type="text" value="${contract.fen }" readonly="readonly"> 分。 <br />
  （三）土地承包费每<input id="increaseCycle" name="increaseCycle" class="inputClass" type="text" value="${contract.increaseCycle }">年递增<input id="increasePercentage" name="increasePercentage" class="inputClass" type="text" value="${contract.increasePercentage }">%。 <br />
  （四）支付时间：每年8月31日前以货币形式向甲方全额支付当年的土地承包费。 <br />
  <strong>第四条  双方权利和义务 </strong><br />
  （一） 甲方的权利和义务 <br />
  1.依照合同书的约定收取土地承包费，依照合同书约定的期限收回承包土地。 <br />
  2.监督乙方按照合同书的约定合理利用、保护土地，制止乙方损坏土地和其他农业资源的行为，并有权要求乙方赔偿由此造成的损失。 <br />
  3.尊重乙方的生产经营自主权，不得干预乙方合法的生产经营活动。 <br />
  4.因国家、地方政府、农垦改革或甲方建设需要，甲方有权收回或调整承包土地，经评估后依法给予乙方青苗及地上附着物补偿。因甲方建设需要收回或调整承包土地的，应当经农场上级主管单位批准。<u> </u><br />
  5.发包土地被政府依法收回时，甲方依法获得相应的土地补偿费和安置补助费。 <br />
  （二） 乙方的权利和义务 <br />
  1.依照合同约定，独立从事农业生产经营活动，自负盈亏，自担风险。 <br />
  2.依照合同书的约定，按时足额向甲方支付土地承包费。 <br />
  3.保护承包土地完整不受侵占和农业基础设施不受破坏，不得擅自改变土地用途。 <br />
  4.若乙方需要办理林木所有权证或林木使用权证的，甲方应予以协助；本合同书中止、解除或终止时，乙方应当配合甲方办理林木所有权证或林木使用权证的变更手续。 <br />
  5.依法享受国家和当地政府提供的各类支农惠农政策补贴和服务。 <br />
  6.乙方在承包期限内死亡的，其合法继承人可以在承包期限内继续承包。 <br />
  7.承包土地被依法收回时，有权依照《国土资源部办公厅  农业部办公厅关于收回国有农场农用地有关补偿问题的复函》（国土资厅[2009]850号）获得安置补助费。 </p>
<p>8.因国家、地方政府、农垦改革或甲方建设需要，乙方应当同意甲方收回或调整承包土地，在接到甲方通知之日起30天内搬迁、清理青苗及地上附着物，依法享有青苗及地上附着物补偿。 <br />
  9.地下各类资源、埋藏物、隐藏物不属于承包范围，乙方不得在承包地内进行采石、采矿、取土等破坏农业产业及盗采资源的行为。 <br />
  <strong>第五条 合同的解除 </strong><br />
  （一）合同双方协商一致，可以解除合同。 <br />
  （二）订立合同所依据的法律、法规、规范性文件和上级主管部门政策发生调整和变化的，或遭遇不可抗力，致使本合同无法继续履行的，或继续履行将损害国家、甲乙双方或其中一方利益的，可以解除合同。 <br />
  （三）乙方有下列情形之一的，甲方可以解除合同，收回承包土地。青苗及地上附着物由甲方依法处置，处置所得款优先用于偿还甲方的土地承包费和违约金等债务，以及由此给甲方造成的损失，剩余部分归还乙方： <br />
  1.利用土地从事违法生产、经营的； <br />
  2.擅自改变合同约定的土地用途的； <br />
  3.对承包土地弃耕撂荒2年以上的； <br />
  4.不缴或欠缴土地承包费2年以上的； <br />
  5.破坏农业基础设施或对土地、水源等进行毁灭性、破坏性、伤害性的操作和生产的； <br />
  6.未经甲方书面同意，擅自将承包土地以转包、出租、互换、转让或入股等方式流转的。 <br />
  <strong>    </strong><strong>第六条 合同的终止 </strong><br />
  承包期满，本合同自动终止，青苗及地上附着物由乙方在承包期限届满之日起2个月内自行处理。如乙方需要继续承包，应当在承包期限届满前6个月内向甲方提出书面申请。在同等条件下，乙方未达到法定退休年龄的，乙方享有优先承包权；乙方达到退休年龄的，在同等条件下，其承包土地可由其在农场务农的子女优先承包经营。 <br />
  <strong>第七条  违约责任 </strong><br />
  （一）合同书签订后一年内，甲方未依合同约定将承包土地交付乙方的，乙方有权解除合同。合同解除后，甲方应当将乙方支付的土地承包费退还乙方，并按当年土地承包费的50%向乙方支付违约金。 <br />
  （二）乙方不缴或欠缴土地承包费6个月以上的，应当依照当年应缴土地承包费的50%向甲方支付违约金；不缴或欠缴12个月以上的，乙方应当依照当年应缴土地承包费的100%向甲方支付违约金。 <br />
  （三）以下情形，留在承包地上的青苗及地上附着物视为乙方遗弃物，甲方有权自行处置，收益归甲方： <br />
  1.合同解除、终止后2个月内未处理地上青苗及附着物的； <br />
  2.因国家、地方政府或甲方建设需要收回承包土地，经甲方通知，当季作物收获后，乙方未按时搬迁及处理青苗及地上附着物的。 <br />
  <strong>第八条 其他约定 </strong><br />
  （一）因国家、上级主管部门法律法规或有关政策的调整，造成本合同条款与新规定不相符的，甲乙双方应当根据新规定修改合同条款。 <br />
  （二）本合同履行期间发生争议，由双方协商解决。协商不成的，可向甲方所在地的人民法院提起诉讼。 <br />
  （三）本合同未尽事宜，由双方共同协商，达成一致意见，形成书面补充协议。补充协议与本合同具有同等法律效力。 <br />
  （四）本合同未约定或约定不明确的，适用《海南省国营东昌农场农业用地规范管理实施办法》。 <br />
  （五）甲乙双方签订本合同必须严格遵守国有资产管理关于发包权限、批准、程序等规定，违反规定或未履行必要程序的，合同不生效。 <br />
  （六）本合同自双方签章捺印之日起生效。本合同一式两份，甲乙双方各执一份。 <br />
  （七）本合同签订后，甲方与<input id="terminationPartyB" name="terminationPartyB" class="inputClass" type="text" value="${contract.terminationPartyB }">签订的原土地承包合同书同时终止执行。 <br />
  （八）双方约定的其他事项： <br />
  <input id="remarks" name="remarks" class="inputClass" type="text" value="${contract.remarks }">。 </p>
  <c:if test="${ contract.state eq 0 and preview ne true}">
   <p id="pFileUpload"><input id="file_upload" type="file" name="file_upload" multiple="true" /></p>
   </c:if>
  <input id="hddDelAttachIdArray" type="hidden" name="delAttachIdArray">
  <input id="hddAttachLength" type="hidden" value="${fn:length(contract.attachList) }">
  <c:forEach items="${contract.attachList }" var="attach">
  <p>附件：<a href="<spring:url value="${attach.fileSrc }"/>/${attach.fileName}" target="_blank">${attach.originFileName }</a>
  <c:if test="${ contract.state eq 0 and preview ne true}">
  &nbsp;&nbsp;<input type='button' value='删除' onclick='recordDelAttachId(${attach.id});deleteAttach(this);'></c:if>
  </p>
  </c:forEach>
<p>甲方（盖章）：                      乙方（签名捺印）： <br />
  法定代表人（签名）：                联系方式：<input id="partyBContact" name="partyBContact" class="inputClass" type="text" value="${contract.partyBContact }"></p>
<p>签订时间：<input id="signingDate" name="signingDate" class="inputClass" type="text" <c:if test="${ contract.state eq 0 and preview ne true}">onClick="WdatePicker({dateFmt:'yyyy年MM月dd日',readOnly:true})"</c:if>  value="<fmt:formatDate value="${contract.signingDate }" pattern="yyyy年MM月dd日"/>"> </p>
    </div>
    </form>
</div>
</body>
</html>