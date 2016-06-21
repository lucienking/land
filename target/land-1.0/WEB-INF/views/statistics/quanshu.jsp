<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	var farmCode = "${farmCode}" ;
	$("#quanshu_farm_select").combobox({
		url:'${ctx}/sys/org/getAllFarms',
	    valueField:'code',
	    textField:'name',
	    method:'GET',
	    readonly:true,
		onSelect:function(rec){
			initquanshuPie(rec.code=="1"?"":rec.code,rec.name  );
		},
		onLoadSuccess:function(){
			$("#quanshu_farm_select").combobox("select","${farmCode}");
			if("${farmCode}" == "1") {
				$(this).combobox("readonly",false);
				initquanshuPie("","海南农垦");
			}
		}
	}); 
	function initquanshuPie(farmCode,farmName){
		var quanshuChart = echarts.init(document.getElementById('quanshu_main')); 
		$.ajax({
			url:"${ctx}/statistics/getQuanshuData",
			type:'GET',
			data:{farmCode:farmCode},
			success:function(data){
				var names = [];
				var pieData = [];
				for(var o in data){
					names[o] = data[o].landType;
					var m = {name: data[o].landType,value:data[o].area};
					pieData[o] = m;
				}
			 	$('#quanshu_table').datagrid({
			 		title:"<div style='width:100%;text-align:center'>"+farmName+" 土地权属信息统计</div>",
					data:data,
				    columns:[[
						{field:'firstType',title:'确权情况',width:'20%'},
				        {field:'landType',title:'确权类型',width:'20%'},
				        {field:'area',title:'面积(亩)',width:'30%'},
				        {field:'areaPer',title:'面积占比',width:'30%',formatter:function(value,rec){
				        	return value+"%";
				        }}
				    ]],
				    onLoadSuccess:function(data){
				    	mergeCells('quanshu_table','firstType');
				    	addSumCells('quanshu_table','area','areaPer');
				    }
				}); 
				var option = {
						title : {
							text : '土地权属信息统计',
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
							name : '土地权属',
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
				quanshuChart.setOption(option);
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
			}
		});
	}
</script>
<div style="margin-top:10px;margin-left:50px;">
	选择农场：<input id="quanshu_farm_select" style="width:120px;" />
</div>
<div class="echarts_container">
<div style="margin-left:20px;margin-top:10px;width:45%;float:left;">
	<table id="quanshu_table"></table>
</div>
<div id="quanshu_main" class="echarts_main" _echarts_instance_="143651336748543479"
	style="-webkit-tap-highlight-color: transparent; -webkit-user-select: none; cursor: default; width:45%;float:left;margin-left:20px;background-color: rgba(0, 0, 0, 0);">
	<div
		style="position: relative; overflow: hidden; width: 983px; height: 378px;">
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
			style="position: absolute; display: block; overflow: hidden; transition: height 0.8s, background-color 1s; -webkit-transition: height 0.8s, background-color 1s; z-index: 1; left: 0px; top: 0px; width: 983px; height: 0px; background-color: rgb(240, 255, 255);">
			<p style="padding: 8px 0; margin: 0 0 10px 0; border-bottom: 1px solid #eee">数据视图</p>
			<textarea
				style="display: block; margin: 0px 0px 8px; padding: 4px 6px; overflow: auto; width: 100%; height: 278px; cursor: default;"></textarea>
			<button style="float: right; padding: 1px 6px;">关闭</button>
			<button style="float: right; margin-right: 10px; padding: 1px 6px;">刷新</button>
		</div>
	</div>
</div>
</div>
