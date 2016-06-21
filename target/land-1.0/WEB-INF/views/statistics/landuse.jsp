<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "landuse_Container" style="width:100%">
<div style="margin-top:10px;margin-left:50px;margin-bottom:20px;">
	选择农场：<input id="search_landuse_farm" style="width:120px;" />
</div>
<div  id="landuse_SearchResultPanel"  style="width:99%;float:left;">
	<div  style="width:50%;float:left;margin-left:20px;">
		<table id="landuse_Datagrid" ></table>
	</div>
	<div id="landuse_main" class="echarts_main" _echarts_instance_="143651336748516786"
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
<script type="text/javascript">

$("#search_landuse_farm").combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
	onLoadSuccess:function(){
		$("#search_landuse_farm").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false); 
			landuseAreaPie("","海南农垦");
		}
	},
	onSelect:function(rec){
		landuseAreaPie(rec.code=="1"?"":rec.code,rec.name );
	},
}); 

function landuseAreaPie(farmCode,farmName){
	var landUseChart = echarts.init(document.getElementById('landuse_main')); 
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
			$('#landuse_Datagrid').datagrid({
				title:"<div style='width:100%;text-align:center'>"+farmName+" 土地利用统计</div>",
				data:data,
			    columns:[[
			        {field:'firstType',title:'大类',width:'15%',align:'center'},
			        {field:'secondType',title:'二级类',width:'20%'},
			        {field:'thirdType',title:'三级类',width:'20%'},
			        {field:'area',title:'面积(亩)',width:'15%'},
			        {field:'totalArea',title:'二级类小计(亩)',width:'15%'},
			        {field:'totalAreaAll',title:'大类小计(亩)',width:'15%'}
			    ]],
			    onLoadSuccess:function(data){
			    	mergeCells('landuse_Datagrid','secondType');
			    	mergeCells('landuse_Datagrid','firstType');
			    	mergeCells('landuse_Datagrid','totalArea');
			    	mergeCells('landuse_Datagrid','totalAreaAll');
			    	addSumCells('landuse_Datagrid','area');
			    }
			});
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
						name : '土地利用',
						type : 'pie',
						radius : '70%',
						center : [ '50%', '60%' ],
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
			landUseChart.setOption(option);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
		}
	});
}
</script>
</div>
