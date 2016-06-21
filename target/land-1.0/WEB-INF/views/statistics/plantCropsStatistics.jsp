<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	function initPlantCropsPie(farmCode,farmName){
		var plantCropsChart = echarts.init(document.getElementById('plantCrops_main')); 
		$.ajax({
			url:"${ctx}/statistics/getPlantCropsData",
			type:'GET',
			data:{farmCode:farmCode},
			success:function(data){ 
				var names = [];
				var values = [];
				for(var o in data){
					names[o] = data[o].crops;
					values[o] = data[o].area;
				}
				$('#plantCrops_table').datagrid({
					title:"<div style='width:100%;text-align:center'>"+farmName+" 土地使用情况统计</div>",
					data:data,
				    columns:[[
				        {field:'crops',title:'使用类型',width:'50%'},
				        {field:'area',title:'使用面积(亩)',width:'50%'}
				    ]],
				    onLoadSuccess:function(data){
				    	addSumCells('plantCrops_table','area');
				    } 
				}); 
				var option = {
					    title : {
					        text: farmName+'土地使用情况统计分析' 
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['使用面积']
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
					    yAxis : [{
					            type : 'category',
					            data : names
					    }],
					    xAxis : [{
					            type : 'value'
					    }],
					    series : [{
				            name:'使用面积',
				            type:'bar',
				            data:values,
				            markPoint : {
				                data : [
				                    {type : 'max', name: '最大值'},
				                    {type : 'min', name: '最小值'}
				                ]
				            },
				            markLine : {
				                data : [
				                    {type : 'average', name: '平均值'}
				             	]
				            },
				            itemStyle:{ 
				                normal:{ 
				                      label:{ 
				                        show: true, 
				                        formatter: '{c}' 
				                      }, 
				                      labelLine :{show:true} 
				                    } 
				                } 
					     },
					    ]
					};
				plantCropsChart.setOption(option);
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
			}
		});
	}
	
$("#plantCrops_farm_select").combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
    onSelect:function(rec){
    	initPlantCropsPie(rec.code=="1"?"":rec.code,rec.name );
	},
	onLoadSuccess:function(){
		$("#plantCrops_farm_select").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false);
			initPlantCropsPie("","海南农垦");
		}
	}
}); 
	
</script>
<div style="margin-top:10px;margin-left:50px;margin-bottom:20px;">
	选择农场：<input id="plantCrops_farm_select" class="easyui-combobox" style="width:120px;" />
</div>

<div class="echarts_container">
	<div id="plantCrops_main" class="echarts_main" _echarts_instance_="1436522657711"
		style="-webkit-tap-highlight-color: transparent; -webkit-user-select: none; cursor: default; background-color: rgba(0, 0, 0, 0); height:800px;">
		<div style="position: relative; overflow: hidden; width: 983px; height: 378px;">
			<div data-zr-dom-id="bg" class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none;"></div>
			<canvas width="983" height="378" data-zr-dom-id="0"
				class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
			<canvas width="983" height="378" data-zr-dom-id="1"
				class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
			<canvas width="983" height="378" data-zr-dom-id="_zrender_hover_"
				class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
			<div class="echarts-dataview"
				style="position: absolute; display: block; overflow: hidden; transition: height 0.8s, background-color 1s; -webkit-transition: height 0.8s, background-color 1s; z-index: 1; left: 0px; top: 0px; width: 983px; height: 0px; background-color: rgb(240, 255, 255);"></div>
			<div class="echarts-tooltip zr-element"
				style="position: absolute; display: none; border: 0px solid rgb(51, 51, 51); white-space: nowrap; transition: left 0.4s, top 0.4s; -webkit-transition: left 0.4s, top 0.4s; border-radius: 4px; color: rgb(255, 255, 255); font-family: 微软雅黑, Arial, Verdana, sans-serif; padding: 5px; left: 331px; top: 262px; background-color: rgba(50, 50, 50, 0.498039);">
			</div>
		</div>
	</div>
	<div style="height:auto;width:95%;float:left;margin-left:20px;text-align:center;">
	  <div style="width:600px;MARGIN-RIGHT: auto; MARGIN-LEFT: auto; ">
		<table id="plantCrops_table" ></table>
	  </div>
	</div>
</div>

