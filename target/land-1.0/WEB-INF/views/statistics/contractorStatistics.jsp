<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$("#contractor_farm_select").combobox({
		url:'${ctx}/sys/org/getAllFarms',
	    valueField:'code',
	    textField:'name',
	    method:'GET',
	    readonly:true,
	    onSelect:function(rec){
	    	initContractorPie(rec.code,rec.name);
		},
		onLoadSuccess:function(){
			$("#contractor_farm_select").combobox("select","${farmCode}");
			if("${farmCode}" == "1") {
				$(this).combobox("readonly",false); 
				initContractorPie("","海南农垦");
			}
		}
	}); 
	function initContractorPie(farmCode,farmName){
		var peopleChart = echarts.init(document.getElementById('contractor_people_main')); 
		var areaChart = echarts.init(document.getElementById('contractor_area_main')); 
		$.ajax({
			url:"${ctx}/statistics/getContractorData",
			type:'GET',
			data:{farmCode:farmCode=="1"?"":farmCode},
			success:function(data){
				var peopleNames = [];
				var areaNames = [];
				var peopleData = [];
				var areaData  = [];
				for(var o in data){
					peopleNames[o] = data[o].typeName;
					areaNames[o] = data[o].typeName;
					
					var people ={name: data[o].typeName,value:data[o].countNum};
					peopleData[o] = people;
					
					var area ={name: data[o].typeName,value:data[o].area};
					areaData[o] = area;
				}
				$('#contractor_area_Datagrid').datagrid({
					data:data,
				    method:'get',
				    title:"<div style='width:100%;text-align:center'>"+farmName+" 承包人信息统计</div>",
				    columns:[[
				     	{field:'isStaff',title:'是否职工',width:'10%',align:'center'},
				        {field:'typeName',title:'承包人类型',width:'10%',align:'center'},
				        {field:'area',title:'承包面积(亩)',width:'10%'},
				        {field:'areaPer',title:'面积占比',width:'10%',formatter:function(value,rec){
				        	return value+"%";
				        }},
				        {field:'countNum',title:'承租人数',width:'10%'},
				        {field:'countNumPer',title:'承租人数占比',width:'10%',formatter:function(value,rec){
				        	return value+"%";
				        }}
				    ]],
				    onLoadSuccess:function(data){
				    	mergeCells('contractor_area_Datagrid','isStaff');
				    	addSumCells('contractor_area_Datagrid','area','areaPer','countNum','countNumPer');
				    } 
				});
				var peopleOption = {
						title : {
							text : '承包人信息-人数统计',
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
							name : '人数统计',
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
							text : '承包人信息-面积统计',
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
<div style="margin-top:10px;margin-left:50px;margin-bottom:20px;">
	选择农场：<input id="contractor_farm_select" style="width:120px;" />
</div>
<div  style="width:93%;text-align:center;margin-left:20px;">
	<table id="contractor_area_Datagrid" style="width:100%;"></table>
</div>
<div class="echarts_container">
<div id="contractor_people_main" class="echarts_main" _echarts_instance_="14365133674850"
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
<div id="contractor_area_main" class="echarts_main" _echarts_instance_="143651434343521"
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
</div>