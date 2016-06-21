<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "contractFarmily_Container">
<div style="margin-top:10px;margin-left:50px;margin-bottom:20px;">
	选择农场：<input id="search_contractFarmily_farm" style="width:120px;" />
</div>
<div  style="width:93%;text-align:center;margin-left:20px;">
	<table id="contractFarmily_Datagrid" style="width:100%;"></table>
</div>
<div class="echarts_container">
<div id="contractFarmily_people_main" class="echarts_main" _echarts_instance_="14365133674850211234"
	style="-webkit-tap-highlight-color: transparent; -webkit-user-select: none;
	 cursor: default; background-color: rgba(0, 0, 0, 0);width:45%;float:left;margin-left:20px;">
	<div style="position: relative; overflow: hidden; width: 983px; height: 378px;">
		<div data-zr-dom-id="bg" class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none;"></div>
		<canvas width="983" height="378" data-zr-dom-id="0" class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
		<canvas width="983" height="378" data-zr-dom-id="1" class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
		<canvas width="983" height="378" data-zr-dom-id="_zrender_hover_"
			class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
		<div class="echarts-dataview"
			style="position: absolute; display: block; overflow: hidden; transition: height 0.8s, background-color 1s; 
			-webkit-transition: height 0.8s, background-color 1s; z-index: 1; left: 0px; top: 0px;
			 width: 983px; height: 0px; background-color: rgb(240, 255, 255);">
			<p style="padding: 8px 0; margin: 0 0 10px 0; border-bottom: 1px solid #eee">数据视图</p>
			<textarea style="display: block; margin: 0px 0px 8px; padding: 4px 6px; overflow: auto; width: 100%; height: 278px; cursor: default;"></textarea>
			<button style="float: right; padding: 1px 6px;">关闭</button>
			<button style="float: right; margin-right: 10px; padding: 1px 6px;">刷新</button>
		</div>
	</div>
</div>
<div id="contractFarmily_area_main" class="echarts_main" _echarts_instance_="14365133674851342124"
	style="-webkit-tap-highlight-color: transparent; -webkit-user-select: none;
	 cursor: default; background-color: rgba(0, 0, 0, 0);width:45%;float:left;margin-left:10px;">
	<div style="position: relative; overflow: hidden; width: 983px; height: 378px;">
		<div data-zr-dom-id="bg" class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none;"></div>
		<canvas width="983" height="378" data-zr-dom-id="0" class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
		<canvas width="983" height="378" data-zr-dom-id="1" class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
		<canvas width="983" height="378" data-zr-dom-id="_zrender_hover_"
			class="zr-element"
			style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
		<div class="echarts-dataview"
			style="position: absolute; display: block; overflow: hidden; transition: height 0.8s, background-color 1s; 
			-webkit-transition: height 0.8s, background-color 1s; z-index: 1; left: 0px; top: 0px;
			 width: 983px; height: 0px; background-color: rgb(240, 255, 255);">
			<p style="padding: 8px 0; margin: 0 0 10px 0; border-bottom: 1px solid #eee">数据视图</p>
			<textarea style="display: block; margin: 0px 0px 8px; padding: 4px 6px; overflow: auto; width: 100%; height: 278px; cursor: default;"></textarea>
			<button style="float: right; padding: 1px 6px;">关闭</button>
			<button style="float: right; margin-right: 10px; padding: 1px 6px;">刷新</button>
		</div>
	</div>
</div>
<script type="text/javascript">
$("#search_contractFarmily_farm").combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
	onLoadSuccess:function(){
		$("#search_contractFarmily_farm").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false); 
			initcontractFarmilyPie("","海南农垦");
		}
	},
	onSelect:function(rec){
		initcontractFarmilyPie(rec.code=="1"?"":rec.code,rec.name);
	}
}); 

function initcontractFarmilyPie(farmCode,farmName){
	var peopleChart = echarts.init(document.getElementById('contractFarmily_people_main')); 
	var areaChart = echarts.init(document.getElementById('contractFarmily_area_main')); 
	$.ajax({
		url:"${ctx}/statistics/getContractFarmilyData",
		type:'GET',
		data:{farmCode:farmCode},
		success:function(data){
			var peopleNames = [];
			var areaNames = [];
			var peopleData = [];
			var areaData  = [];
			
			for(var o in data){
				peopleNames[o] = data[o].areaArea;
				areaNames[o] = data[o].areaArea;
				var m = {name: data[o].areaArea,value:data[o].num};
				peopleData[o] = m;
				
				var m2 ={name: data[o].areaArea,value:data[o].totalArea};
				areaData[o] = m2;
			}
			$('#contractFarmily_Datagrid').datagrid({
				title:"<div style='width:100%;text-align:center'>"+farmName+" 承包户情况统计</div>",
			    data:data,
			    columns:[[
			        {field:'areaArea',title:'范围',width:'16%',align:'center'},
			        {field:'totalArea',title:'承包面积(亩)',width:'10%'},
			        {field:'areaPer',title:'面积占比',width:'10%',formatter:function(value,rec){
			        	if(value!=null)
			        	return value+"%";
			        }},
			        {field:'num',title:'承包户数',width:'10%'},
			        {field:'numPer',title:'承包户占比',width:'10%',formatter:function(value,rec){
			        	if(value!=null)
			        	return value+"%";
			        }}
			    ]],
			    onLoadSuccess:function(data){
			    	addSumCells('contractFarmily_Datagrid','totalArea','areaPer','num','numPer');
			    }
			});
			var peopleOption = {
					title : {
						text : '承包户-户数统计',
						subtext : farmName,
						x : 'center'
					},
					tooltip : {
						trigger : 'item',
						formatter : "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
						x : 'left',
						data : peopleNames
					},
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {
				                show: true, 
				                type: ['pie', 'funnel'],
				                option: {
				                    funnel: {
				                        x: '25%',
				                        width: '50%',
				                        funnelAlign: 'left',
				                        max: 1548
				                    }
				                }
				            },
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
					calculable : true,
					series : [ {
						name : '户数统计',
						type : 'pie',
						radius : '70%',
						center : [ '50%', '60%' ],
						data : peopleData, 
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
			var areaOption = {
					title : {
						text : '承包户-面积统计',
						subtext : farmName,
						x : 'center'
					},
					tooltip : {
						trigger : 'item',
						formatter : "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
						x : 'left',
						data : areaNames
					},
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {
				                show: true, 
				                type: ['pie', 'funnel'],
				                option: {
				                    funnel: {
				                        x: '25%',
				                        width: '50%',
				                        funnelAlign: 'left',
				                        max: 1548
				                    }
				                }
				            },
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
					calculable : true,
					series : [ {
						name : '面积统计',
						type : 'pie',
						radius : '70%',
						center : [ '50%', '60%' ],
						data : areaData, 
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
			peopleChart.setOption(peopleOption);
			areaChart.setOption(areaOption);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
		}
	});
}
</script>
</div>
