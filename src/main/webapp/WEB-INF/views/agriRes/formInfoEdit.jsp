<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
	#formInfoEdit_container td.query{
		font-size:12px;
		padding:0 2px;
 		text-align:center; 
	}
	#formInfoEdit_container .red-line-border{
		border:1px solid red;
	}
	 
	#formInfoEdit_container td{border:solid black; border-width:1px 0px 0px 1px;}
	#formInfoEdit_container table{ border:none;}
	#formInfoEdit_container input[type="text"]{border:0px solid #c00;color:blue;}
	#selfsupp_search_table span{color:blue;}
</style>
<script type="text/javascript">
$(function(){
	
	$(".personStatus").each(function(){
		var num = parseInt($("#edit_sf"+$(this).val()).html());
		$("#edit_sf"+$(this).val()).html(num+1);
	});
	
	/**
	  表单提交
	*/
	$("#peopleEdit_submit_btn").click(function(){
		$.ajax({
			type: "POST",
			url:"${ctx}/agriRes/selfSupport/formInfoUpdate",
			data:$('#formInfoEdit_peopleInfo_form').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',""+data.message+"","info",function(r){
		    		return;
		    	});
		   }
		});   
	});
	
	/*
	 * 关闭
	 */
	$(".edit_close_btn").click(function(){
		$("#formInfoQueryEditDialog").dialog('close');
	});
});
</script>

<div id="formInfoEdit_container" style="width:99%;height:99%;">
<div  class="easyui-tabs" style="width:99%;height:auto;">
<div title="家庭人口信息" data-options="fit:true" style="padding-bottom:20px;">
<form id="formInfoEdit_peopleInfo_form">
<table id="selfsupp_search_table" class="selfsupp_search_table" border="1" cellspacing="0">
	<tr>
		<td height="12px" colspan="16" style="border:none">&nbsp;<input type="hidden" name="id" value="${form.id }"/></td>
		<td height="12px" colspan="2" style="font-size:12px;border:none">编号：<input type="text" id="" name="cardNo" value="${form.cardNo}" style="width:50%"/></td>
	</tr>
	<tr>
		<td width="100%" height="20px" colspan="18" align="center" style="border:none;font-size:23px;font-weight:bold;">农场职工居民家庭人口信息调查表</td>
	</tr>
	<tr>
		<td height="12px" colspan="8" style="font-size:12px;border:none;margin-top:5px;">生产队（□并场队：□难侨队）：<input type="text" id="" name="isCombined" value="${form.isCombined}" style="width:50%"/></td>
		<td height="12px" colspan="6" style="font-size:12px;border:none;margin-top:5px;">居住地址：<input type="text" id="" name="houseLocation" value="${form.houseLocation}" style="width:50%"/></td>
		<td height="12px" colspan="4" style="font-size:10px;font-weight:bold;border:none;margin-top:5px;" align="center">单位：人、M²、亩</td>
	</tr>
	<tr>
		<td width="100%" height="20px" colspan="18" align="center" style="font-size:16px;border-right:1px solid black;">家庭信息</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">户主</td>
		<td  height="20px" colspan="2" align="center" style="font-size:16px;"><input type="text" id="" name="familyHost" value="${form.familyHost}" style="width:100%"/></td>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">户号</td>
		<td  height="20px" colspan="2" align="center" style="font-size:16px;"><input type="text" id="" name="familyNo" value="${form.familyNo}" style="width:100%"/></td>
		<td  height="20px" colspan="1" align="center" style="font-size:16px;">家庭电话</td>
		<td  height="20px" colspan="3" align="center" style="font-size:16px;"><input type="text" id="" name="telephoneNumber" value="${form.telephoneNumber}" style="width:100%"/></td>
		<td  height="20px" colspan="3" align="center" style="font-size:16px;">户口所在派出所</td>
		<td  height="20px" colspan="5" align="center" style="font-size:16px;border-right:1px solid black;"><input type="text" id="" name="familyLocation" value="${form.familyLocation}" style="width:100%"/></td>
	</tr>
	<tr>
		<td  height="20px" colspan="18" align="center" style="font-size:16px;border-right:1px solid black;">家庭成员信息（含户主）</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" align="center" style="font-size:14px;">
			家庭人口<span id="jtrk"> ${form.agriPerson.size() } </span>人
		</td>
		<td id="edit_sf_span_td" height="40px" colspan="17" align="left" style="font-size:14px;border-right:1px solid black;">
			在册在岗（管理人员）<span id="edit_sf1">0</span>人；在册在岗（工人）<span id="edit_sf2">0</span>人；
			在册不在岗（领取生活费）<span id="edit_sf3">0</span>人；在册不在岗（不领生活费用）<span id="edit_sf4">0</span>人；
			离退休<span id="edit_sf5">0</span>人；非职工居民（18岁以下）<span id="edit_sf6">0</span>人；
			非职工居民（女的49岁、男的59岁以下）<span id="edit_sf7">0</span>人；
			非职工居民（女的50岁、男的60岁以上）<span id="edit_sf8">0</span>人 
		</td>
	</tr>
	<tr>
		<td width="10%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">姓名</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">性别</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">民族</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">年龄</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">身份</td>
		<td width="20%" height="20px" colspan="6" rowspan="2" align="center" style="font-size:16px;">身份证号码</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">与户主关系</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">学历</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">婚姻状况</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;">现居住地</td>
		<td width="6%" height="20px" colspan="2" rowspan="1" align="center" style="font-size:16px;">是否长期居住农场</td>
		<td width="3%" height="20px" colspan="1" rowspan="2" align="center" style="font-size:16px;border-right:1px solid black;">是否使用土地</td>
	</tr>
	<tr>
		<td  height="20px" colspan="1" rowspan="1" align="center" style="font-size:16px;">&nbsp;是&nbsp;</td>
		<td  height="20px" colspan="1" rowspan="1" align="center" style="font-size:16px;">离场时间</td>
	</tr>
	<c:forEach items="${form.agriPerson}" var="person" varStatus="status"> 
	<tr>
		<td  height="20px" colspan="1" >
			<input type="hidden" id="" name="agriPerson[${status.index }].id" value="${person.id}" style="width:100%"/>
			<input type="text" id="" name="agriPerson[${status.index }].personName" value="${person.personName}" style="width:100%"/>
		</td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].personSex" value="${person.personSex}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].personNation" value="${person.personNation}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].personAge" value="${person.personAge}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" class="personStatus" name="agriPerson[${status.index }].personStatus" value="${person.personStatus}" style="width:100%"/></td>
		<td  height="20px" colspan="6"><input type="text" id="" name="agriPerson[${status.index }].persionId" value="${person.persionId}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].familyRelationship" value="${person.familyRelationship}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].education" value="${person.education}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].married" value="${person.married}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].currentResident" value="${person.currentResident}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].isLiveInFarm" value="${person.isLiveInFarm}" style="width:100%"/></td>
		<td  height="20px" colspan="1" ><input type="text" id="" name="agriPerson[${status.index }].leaveTime" value="${person.leaveTime}" style="width:100%"/></td>
		<td  height="20px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriPerson[${status.index }].hasLand" value="${person.hasLand}" style="width:100%"/></td>
	</tr>
	</c:forEach> 
	<tr>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="6" style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-bottom:1px solid black;"> </td>
		<td  height="20px" colspan="1"  style="border-right:1px solid black;border-bottom:1px solid black;"> </td>
	</tr> 
	<tr>
		<td height="20px" colspan="6" style="border:none;">调查时间：<input name="researchDate" value="${form.researchDate }" class="easyui-datebox" style="width:120px;"/></td>
		<td height="20px" colspan="6" style="border:none;">被调查人：<input type="text" id="" name="researchObject" value="${form.researchObject}" style="width:50%"/></td>
		<td height="20px" colspan="6" style="border:none;">信息采集人：<input type="text" id="" name="investigator" value="${form.investigator}" style="width:50%"/></td>
	</tr>
	<tr>
		<td height="12px" colspan="18" style="font-size:12px;border:none;border-left:none;padding:10px 10px 10px 10px;"> 
		&nbsp;&nbsp;<b>填报说明：</b>一、已故人员不列入调查对象；户主已故的，由配偶或子女作为户主。
	         二、 居住情况①.房屋类型填写数字：1.钢混、2.砖混、3.砖木、4.简易、5.其他；②.房屋面积填写具体；③.占地面积填写具体面积。
	         三、身份栏填写数字；1.在册在岗（管理人员）；2.在册在岗（工人）；3.在册不在岗（领生活费用）；4.在册不在岗（不领生活费用）；4.离退休；5.非职工居民（18岁以下）；6.非职工居民（女的50岁、男的60岁以下）；7.非职工居民（女的50岁、男的60岁以上）。
	         四、户主关系栏填写数字；1.户主；2.配偶；3.子；4.女；5.孙子、孙女或外孙子、外孙女；6.父母；7.祖父母或外祖父母；8.兄弟姐妹；9.儿媳；10.其它。
	         五、学历栏填写数字；1.本科以上；2.专科；3.中专、技校、高中；4.初中以下。
	         六、婚姻状况填写数字；1.已婚；2.未婚；3.离异；4.丧偶。
	         七、现居住地栏填写数字；1.本场；2.本市县；3.本省；4.省外；5.境外；6国外。
	         八、是否长期居住农场栏，长期居住农场的，填写是，长期不居住农场的，填写数字；1.离场时间达2-5年；2.6-10年；3.超过10年。
	         九、是否使用土地栏填写数字；1.使用本农场土地；2.使用外农场土地；3.使用海胶基地分公司土地；4.垦区外土地；5.没有使用土地。
	         十、从业地址栏填写数字；1.本场；2.本市县；3.本省；4.省外；5.境外；6国外。
	       十一、从事职业栏填写数字；1.行政机关；2.企事业单位；3.灵活就业；4.现役；5.待业。
	       十二、主要经济来源（类型）栏填写数字；1.行政、企事业工资；2.灵活就业工资；3.种养业；4.经商；5.离退休金；6.国家救济。
	       十三、2014年主要支出栏填写具体支出金额；1.生活支出（衣、食、行、水、电、气、通讯等）；2.生产支出；3.住房；4.大型家用品；5.教育文化娱乐；6.医疗保健；7.风俗随礼；8.缴纳社保。
		</td>
	</tr>
	<tr>
		<td height="20px" colspan="18" style="border:none;text-align:center;"> 
			<input type="button" value="提交" id="peopleEdit_submit_btn"/>
			<input type="button" value="关闭" class="edit_close_btn"/>
		</td>
	</tr>
</table>
</form>
<form id="formInfoEdit_landInfo_form">
  </div>
    <div title="家庭用地信息" style="padding-bottom:20px;" data-options="fit:true">
    	<table id="selfsupp_search_table" class="selfsupp_search_table" border="1" cellspacing="0" style="width:90%" align="center">
			<tr>
				<td height="12px" colspan="8" style="border:none">&nbsp;</td>
				<td height="12px" colspan="1" style="font-size:12px;border:none">编号：<input type="text" id="" name="cardNo" value="${form.cardNo }" style="width:50%"/></td>
			</tr>
			<tr>
				<td height="20px" colspan="9" align="center" style="border:none;font-size:23px;font-weight:bold;">农场职工居民家庭用地信息调查表</td>
			</tr>
			<tr>
				<td height="12px" colspan="4" style="font-size:12px;border:none;margin-top:5px;">生产队（□并场队：□难侨队）：<input type="text" id="" name="isCombined" value="${form.isCombined }" style="width:50%"/></td>
				<td height="12px" colspan="4" style="font-size:12px;border:none;margin-top:5px;">居住地址：<input type="text" id="" name="houseLocation" value="" style="width:50%"/></td>
				<td height="12px" colspan="1" style="font-size:10px;font-weight:bold;border:none;margin-top:5px;" align="center">单位：人、M²、亩</td>
			</tr>
			<tr>
				<td height="20px" colspan="9" align="center" style="font-size:16px;border-right:1px solid black;">自用土地情况</td>
			</tr>
			<tr>
				<td width="8%" height="20px" colspan="1" >土地使用人</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td width="8%"  height="20px" colspan="1" >${parcel.contractorName }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td width="8%"  height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td width="8%"  height="20px" colspan="1" style="border-right:1px solid black;"> &nbsp; </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >土地来源</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.parcelOrigin }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td  height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >用地类型</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.landType }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >地块编号</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.parcelCode }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >地块子号</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.subParcelCode }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >地块位置</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.location }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >自报面积</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.theySaidArea }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr><tr>
				<td height="20px" colspan="1" >起始使用年份</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.startY }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >是否签订合同</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.isSigned }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >合同约定年限</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.leaseTerm }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >合同签订面积</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.signingArea }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr><tr>
				<td height="20px" colspan="1" >土地承包租金</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.rentalPrice }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr><tr>
				<td height="20px" colspan="1" >核实面积</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.actualArea }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >种植作物</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.plant }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"> </td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >是否违约使用</td>
				<c:forEach items="${form.agriSelfParcel}" var="parcel"> 
					<td  height="20px" colspan="1" >${parcel.isBreakRule }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;"><input type="text" id="" name="agriSelfParcel[7].isBreakRule" value="" style="width:100%;"/></td>
			</tr>
			<tr>
				<td height="20px" colspan="9" align="center" style="font-size:16px;border-right:1px solid black;">转包土地情况</td>
			</tr>
			<tr>
				<td height="20px" colspan="1" >原土地承包人</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.oldContrator }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >转包是否经农场同意</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.isAgreeByFarm }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >地块编号</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.parcelCode }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >地块子号</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.subParcelCode }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >地块位置</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.loacation }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >转包面积</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.subcontractArea }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >转包年份</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.subcontractY }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >转包租金</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.subcontractRental }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${parcelNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
				<tr>
				<td height="20px" colspan="1" >现使用人姓名</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" >${subContract.presentContractor }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" >&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;">&nbsp;</td>
			</tr>
			<tr>
				<td  height="20px" colspan="1" style="border-bottom:1px solid black;">现使用人单位</td>
				<c:forEach items="${form.agriSubContract}" var="subContract"> 
					<td height="20px" colspan="1" style="border-bottom:1px solid black;" >${subContract.presentEnterprise }</td>
				</c:forEach>
				<c:forEach var="s"  begin="1" end="${subContractNum }">
					<td height="20px" colspan="1" style="border-bottom:1px solid black;">&nbsp;</td>
				</c:forEach>
				<td height="20px" colspan="1" style="border-right:1px solid black;border-bottom:1px solid black;">&nbsp;</td>
			</tr>
			<tr>
				<td height="20px" colspan="3" style="border:none;">调查时间：<input name="researchDate" value="${form.researchDate }" class="easyui-datebox" style="width:120px;"/></td>
				<td height="20px" colspan="3" style="border:none;">被调查人：<input type="text" id="" name="researchObject" value="" style="width:50%"/></td>
				<td height="20px" colspan="3" style="border:none;">信息采集人：<input type="text" id="" name="investigator" value="" style="width:50%"/></td>
			</tr>
			<tr>
				<td height="12px" colspan="9" style="font-size:12px;border:none;border-left:none;padding:10px 10px 10px 10px;"> 
					注：一、土地来源栏填写数字：1.自己开荒；2.与农场承包；3.转包他人土地。二、用地类型栏填写数字；1.保障用地；2.经营用地。三、地块位置栏填写生产队。四、是否签订合同栏填写数字；1.是；2.否。五、土地承包金栏填写当年土地租金单价，实物分成的，按当年应收实物折成现金。六、核实面积栏填写图解面积。七、是否违约使用填写数字；1.擅自改变土地用途；2.连续两年未足额缴交租金；3.其他；4.否。八、是否经农场同意栏填写数字；1.是；2.否。
				</td>
			</tr>
			<tr>
				<td height="20px" colspan="42" style="border:none;text-align:center;"> 
					<input type="button" value="提交" id="landEdit_submit_btn"/>
					<input type="button" value="关闭" class="edit_close_btn"/>
				</td>
			</tr>
		</table>
    </div>
    </form>
</div>
</div>

