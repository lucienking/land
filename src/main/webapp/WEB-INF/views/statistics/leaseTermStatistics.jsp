<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "leaseTerm_Container">
<div style="margin-top:10px;margin-left:50px;margin-bottom:20px;">
	选择农场：<input id="search_leaseTerm_farm" style="width:120px;" />
</div>
<div  style="width:93%;text-align:center;margin-left:20px;">
	<table id="leaseTerm_Datagrid" style="width:100%;"></table>
</div>
<div class="echarts_container">
<div id="leaseTerm_people_main" class="echarts_main" _echarts_instance_="14365133674850333"
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
<div id="leaseTerm_area_main" class="echarts_main" _echarts_instance_="14365133674851333"
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

$("#search_leaseTerm_farm").combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
    onLoadSuccess:function(){
		$("#search_leaseTerm_farm").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false);
			initLeaseTermPie("","海南农垦");
		}
	},
	onSelect:function(rec){
		initLeaseTermPie(rec.code=="1"?"":rec.code,rec.name );
	}
}); 

function initLeaseTermPie(farmCode,farmName){
	var peopleChart = echarts.init(document.getElementById('leaseTerm_people_main')); 
	var areaChart = echarts.init(document.getElementById('leaseTerm_area_main')); 
	$.ajax({
		url:"${ctx}/statistics/getLeaseTermData",
		type:'GET',
		data:{farmCode:farmCode},
		success:function(data){
			var peopleNames = [];
			var areaNames = [];
			var peopleData = [];
			var areaData  = [];
			
			for(var o in data){
				peopleNames[o] = data[o].leaseTerm;
				areaNames[o] = data[o].leaseTerm;
				var m = {name: data[o].leaseTerm,value:data[o].area};
				peopleData[o] = m;
				
				var m2 ={name: data[o].leaseTerm,value:data[o].countNum};
				areaData[o] = m2;
			}
			$('#leaseTerm_Datagrid').datagrid({
				title:"<div style='width:100%;text-align:center'>"+farmName+" 承包租期统计</div>",
			    data:data,
			    columns:[[
			        {field:'leaseTerm',title:'范围',width:'16%',align:'center'},
			        {field:'area',title:'承包面积(亩)',width:'10%'},
			        {field:'areaPer',title:'面积占比',width:'10%',formatter:function(value,rec){
			        	return value+"%";
			        }},
			        {field:'countNum',title:'合同数',width:'10%'},
			        {field:'countNumPer',title:'合同数占比',width:'10%',formatter:function(value,rec){
			        	return value+"%";
			        }}
			    ]],
			    onLoadSuccess:function(data){
			    	addSumCells('leaseTerm_Datagrid','area','areaPer','countNum','countNumPer');
			    } 
			});
			var peopleOption = {
					title : {
						text : '承包租期-面积统计',
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
						text : '承包租期-合同数统计',
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
