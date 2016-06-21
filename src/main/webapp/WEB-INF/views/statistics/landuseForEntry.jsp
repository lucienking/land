<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "landuseEntry_Container" style="width:100%">
<div style="margin-left:8px;font-size:12px;text-align:center;">
	范围：<input id="search_landuseEntry_farm" style="width:120px;" />
</div>
<div  id="landuseEntry_SearchResultPanel"  style="width:100%;float:left;">
	<div id="landuseEntry_main" class="echarts_main" _echarts_instance_="14365213648736786"
	style="-webkit-tap-highlight-color: transparent; -webkit-user-select: none;
	 cursor: default; background-color: rgba(0, 0, 0, 0);width:340px;height:310px;">
	</div>
</div>
<script type="text/javascript">

$("#search_landuseEntry_farm").combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
	onLoadSuccess:function(){
		$("#search_landuseEntry_farm").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false);
			landuseEntryAreaPie("","海南农垦");
		}
	},
	onSelect:function(rec){
		landuseEntryAreaPie(rec.code=="1"?"":rec.code,rec.name  );
	},
}); 

function landuseEntryAreaPie(farmCode,farmName){
	var landuseEntryChart = echarts.init(document.getElementById('landuseEntry_main')); 
	$.ajax({
		url:"${ctx}/statistics/getLandUseData",
		type:'GET',
		data:{farmCode:farmCode},
		success:function(data){
			var names = [];
			var pieData = [];
			var i=0;
			for(var o in data){
				if(o==0||data[o].firstType!=data[o-1].firstType){
					names[i] = data[o].firstType;
					var m = {name: data[o].firstType,value:data[o].totalAreaAll};
					pieData[i] = m;
					i++;
				}
			}
			var option = {
					title : {
						text : '土地利用统计',
						subtext :farmName,
						x : 'center'
					},
					tooltip : {
						trigger : 'item',
						formatter : "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
						x : 'left',
						data : names
					},
					calculable : true,
					series : [ {
						name : '土地利用',
						type : 'pie',
						radius : '40%',
						center : [ '50%', '50%' ],
						data : pieData, 
			            itemStyle:{ 
			                normal:{ 
			                      label:{ 
			                        show: true, 
			                        formatter: '{b} : {c} ({d}%)' 
			                      }, 
			                      labelLine :{show:true} 
			                    } 
			                } 
					} ]
				};
			landuseEntryChart.setOption(option);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
		}
	});
}
</script>
</div>
