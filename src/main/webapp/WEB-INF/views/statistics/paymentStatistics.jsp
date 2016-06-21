<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "payment_Container" style="width:100%">
<div id="payment_SearchConditionPanel" title="统计条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="payment_SearchConditionForm">
		<table style="width:99%;height:99%;margin-buttom:10px">
			<tr>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_payment_farm">选择农场</label>
					<input id="search_payment_farm" name="farmCode" class="easyui-combobox" style="width:120px;"/>
				</td>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_payment_year">选择年份</label>
					<select id="search_payment_year" class="easyui-combobox" name="yearStr" style="width:120px;">
					    <option value="2007-2008">2007-2008</option>
					    <option value="2008-2009">2008-2009</option>
					    <option value="2009-2010">2009-2010</option>
					    <option value="2010-2011">2010-2011</option>
					    <option value="2011-2012">2011-2012</option>
					    <option value="2012-2013">2012-2013</option>
					    <option value="2013-2014">2013-2014</option>
					    <option value="2014-2015">2014-2015</option>
					    <option value="2015-2016" selected="true">2015-2016</option>
					    <option value="2016-2017">2016-2017</option>
					    <option value="2017-2018">2017-2018</option>
					    <option value="2018-2019">2018-2019</option>
					    <option value="2019-2020">2019-2020</option>
					</select>
				</td>
				<td width="10%" align="center" colspan="2" style="min-width:150px">
						&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="3"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="payment_SearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="payment_SearchResultPanel" title="统计结果" class="easyui-panel" style="width:100%;">
	<table id="payment_Datagrid" style="width:100%;"></table>
</div>
<script type="text/javascript">

/**
 *  datagrid 初始化 
 */
$('#payment_Datagrid').datagrid({
    url:"${ctx}/statistics/getPaymentData",
    method:'get',
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'totalToPay',title:'总共应缴',width:'10%'},
        {field:'totalRecieve',title:'已收总额',width:'10%'},
        {field:'recievePer',title:'已收占比',width:'10%',formatter:function(value,rec){
        	if(value!= null)
        	return value+"%";
        }},
        {field:'ownshipRental',title:'总共欠缴',width:'10%'},
        {field:'ownshipPer',title:'欠缴占比',width:'10%',formatter:function(value,rec){
        	if(value!= null)
        	return value+"%";
        }},
        {field:'totalOwnship',title:'累计欠缴',width:'10%'} 
    ]],
    queryParams:$('#payment_SearchConditionForm').getFormData()
});
$('#payment_SearchButton').click(function(){
	$('#payment_Datagrid').datagrid('load',$('#payment_SearchConditionForm').getFormData());
});

$("#search_payment_farm").combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
	onLoadSuccess:function(){
		$("#search_payment_farm").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false);
		}
		$('#payment_Datagrid').datagrid('reload',$('#payment_SearchConditionForm').getFormData());
	}
}); 
</script>
</div>
