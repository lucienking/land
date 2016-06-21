var map,dynamicUrl, imageUrl,imageServiceLayer;
// arcgis对象
var arcgisObj = {};
	require(
			[ "esri/map", "esri/layers/FeatureLayer",
					"esri/geometry/Extent", "esri/tasks/query",
					"esri/tasks/QueryTask", "dojo/dom", "dojo/on",
					"esri/symbols/SimpleFillSymbol",
					"esri/symbols/SimpleLineSymbol",
					"esri/renderers/SimpleRenderer", "esri/Color",
					"esri/graphic", "esri/layers/ArcGISDynamicMapServiceLayer",
					"esri/dijit/Scalebar",
					"esri/layers/ArcGISImageServiceLayer",
					"esri/dijit/InfoWindowLite", "esri/InfoTemplate", 
					"esri/dijit/HomeButton","agsjs/dijit/TOC",
					"dojo/domReady!" ],
			function(Map, FeatureLayer, Extent, Query, QueryTask,
					dom, on, SimpleFillSymbol, SimpleLineSymbol,
					SimpleRenderer, Color, Graphic,
					ArcGISDynamicMapServiceLayer, Scalebar,
					ArcGISImageServiceLayer, InfoWindowLite, InfoTemplate,
					HomeButton, TOC) {
				arcgisObj.Map = Map;
				arcgisObj.FeatureLayer = FeatureLayer;
				arcgisObj.Extent = Extent;
				arcgisObj.Query = Query;
				arcgisObj.QueryTask = QueryTask;
				arcgisObj.dom = dom;
				arcgisObj.on = on;
				arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
				arcgisObj.SimpleLineSymbol = SimpleLineSymbol;
				arcgisObj.SimpleRenderer = SimpleRenderer;
				arcgisObj.Color = Color;
				arcgisObj.Graphic = Graphic;
				arcgisObj.ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer;

				arcgisObj.Scalebar = Scalebar;
				arcgisObj.ArcGISImageServiceLayer = ArcGISImageServiceLayer;
				arcgisObj.InfoWindowLite = InfoWindowLite;
				arcgisObj.InfoTemplate = InfoTemplate;
				
				arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
				arcgisObj.HomeButton = HomeButton;
				arcgisObj.TOC=TOC;
				imageUrl = server151URL + '/HnncImage_HainanPj/ImageServer';
				dynamicUrl = server151URL + '/lg_zyjj_mangguo/MapServer';

				createbaseMap(); // 创建地图
				areaStatisticssum();//统计
				findcombobox();// 初始化农场名称
			});
	/**
	 * 添加的是实验数据,因为只有乐光数据
	 * combobox被选择时会缩放到该选择项的位置farmSearch(value)
	 */
function findcombobox() {
	console.log("开始加农场");
	$('#FarmName_mango').combobox({
		url: '/land/thematicMap/mangguoOrg', // 数据是初始化农场名里的结果列表
        method: 'GET',
        valueField: 'farmCode', // id是编号
        textField: 'NCMC', // 农场名称
		onSelect : function(rec) {
			if(rec!=undefined){
			   var value = rec.NCMC;
			   var farmNo = rec.farmCode;
			   map.graphics.clear();
			   farmSearch(value);
			   //areaStatisticssum(farmNo);
			   console.log("开始选择农场" + imageUrl);
			}
		},
		onLoadSuccess : function() {
			var data = $('#FarmName_mango').combobox('getData');
			if (data.length == 1) {
				$("#FarmName_mango").combobox('select', data[0].code);//	                    
			}
		}		
	});
}
/**
 * 添加要素eventLayer和影像图层imageServiceLayer
 * @returns {arcgisObj.FeatureLayer}
 */
function createLayers() {
	console.log("开始设置图层createLayer");
	var template = new arcgisObj.InfoTemplate();
	template.setTitle("地块信息");
	template.setContent(getTextContent());
	var layers;
	var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
		"opacity" : 1,
		outFields : getOutFields(),
		infoTemplate : template
	});
	console.log(imageUrl);
	if (imageUrl != "") {
		imageServiceLayer = new esri.layers.ArcGISImageServiceLayer(imageUrl);
		console.log(imageServiceLayer);
		layers = [ imageServiceLayer, eventLayer ];

	} else {
		console.log(eventLayer);
		layers = [ eventLayer ];
	}
	map.addLayers(layers);
	return eventLayer;
}
/**
 * mi平方米转换成亩
 * @param mj
 * @returns {String}
 */
function handleArea(mj) {
	return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
}
/**
 * 信息框一行,名称+字段值
 * @param remark
 * @param column
 * @returns {String}
 */
function getDisplayModel(remark, column) {
	return '<strong>' + remark + ':</strong>${' + column + '}<br>';
}
/**
 * 信息框一行,名称+字段值
 * 平方米转换成亩handleArea
 * @returns {String}
 */
function getTextContent() {
	return getDisplayModel('地类名称', 'DLMC')
			+ getDisplayModel('地块编号', 'DKBH')
			+ "<strong>面积:</strong>${MJ:handleArea}";
}

/**
 * 设置输出字段:地类名/编号/面积
 * @returns {Array}
 */
function getOutFields() {
	return [ "DLMC", "DKBH", "MJ" ];
}
/**
 * 初始化地图以及插件，添加图层
 */
function createbaseMap() {
	var bounds=new arcgisObj.Extent({
		"xmin" : 55198.062230000454,
		"ymin" : 40179.46886000074,
		"xmax" : 76744.57777000013,
		"ymax" : 68860.57053999937,
		"spatialReference" : {
			"wkid" : 2382
		}
	});
	map = new arcgisObj.Map("mapDiv_mango",{
		extent:bounds
	});

	var home = new arcgisObj.HomeButton({
		map : map
	}, "HomeButton_mango");
	home.startup();
			
	new arcgisObj.Scalebar({
		map : map,
		attachTo : "bottom-left",
		scalebarUnit : "metric"
	});
    
    var layer=createLayers();;
	var layerInfo=[ {
		layer : layer,
		title : "种植作物"
	} ];
	var tocElement="tocDiv";
	console.log("开始设置图层控制");
	 map.on('layers-add-result',function(results){
		try {
			var toc = new arcgisObj.TOC({
				map : map,
				layerInfos : layerInfo
			}, tocElement);
			toc.startup();
        } catch (e) {
          alert(e);
        }
     });	
}
/**
 * 查询农场的位置，并缩放
 * @param ncmc
 */
function farmSearch(ncmc) {
	var query = new arcgisObj.Query();
	var queryTask = new arcgisObj.QueryTask(dynamicUrl + "/0");
	if (ncmc != ""&&ncmc != undefined) {
		query.where = " NCMC like '" + '%' + ncmc + '%' + "'";
		query.returnGeometry = true;
		query.maxAllowableOffset = 10;
		query.num = 2000;
		query.outFields = getOutFields();
		var queryResult = [];
		queryTask.execute(query, function(results) {
			if (results.features) {
				for ( var index in results.features) {
					var feature = results.features[index];
					var extent = feature.geometry.getExtent();
					var result = {
						extent : extent,
						feature : feature
					};
					queryResult.push(result);
				}
				if (queryResult.length > 0) {
					map.graphics.clear();
					map.infoWindow.hide();
					map.setExtent(getExtent(queryResult));
				} else {
					$.messager.alert('提示', '没有符合条件的地块', 'info');
				}
			}
		});
	}else{
		$.messager.alert('提示', '农场名称为空', 'info');
	}	
}
/**
 * 统计芒果总量，统计总面积
 */
function areaStatisticssum(farmNo) {
	console.log("开始统计");
	var queryStatistic = new esri.tasks.Query();
	if (farmNo != "" && farmNo != undefined) {
		queryStatistic.where = "farmcode=" + farmNo;
	}
	var QTask = new esri.tasks.QueryTask(dynamicUrl + "/0");
	var statDef = new esri.tasks.StatisticDefinition();
	statDef.statisticType = "sum";
	statDef.onStatisticField = "MJ";
	statDef.outStatisticFieldName = "sumMj";
	queryStatistic.outStatistics = [ statDef ];
	queryStatistic.ReturnGeometry = false;
	QTask.execute(queryStatistic, ShowQueryStatistic);
}
/**
 * 添加数据入表格
 * @param results
 */
function ShowQueryStatistic(results) {
	var sum = results.features[0].attributes.sumMj;
	$('#show_grid_mango').empty();
	var tr_head= $('<tr><td class="grid_td">' + "总面积"
			+ '</td><td class="grid_td">' + (sum * 3 / 2000).toFixed(2) + "亩"
			+ '</td></tr>');
	$('#show_grid_mango').append(tr_head);
}

function parseMu(centiare) {
	return (parseFloat(centiare) / 666.67).toFixed(2);
}
/**
 * 缩放至所选地块位置
 * @param queryResult
 * @returns {arcgisObj.Extent}
 */
function getExtent(queryResult) {
	var xmin = 0;
	var ymin = 0;
	var xmax = 0;
	var ymax = 0;
	for ( var index in queryResult) {
		var extent = queryResult[index].extent;
		if (xmin == 0) {
			xmin = extent.xmin;
		}
		if (ymin == 0) {
			ymin = extent.ymin;
		}
		if (xmax == 0) {
			xmax = extent.xmax;
		}
		if (ymax == 0) {
			ymax = extent.ymax;
		}
		xmin = (xmin > extent.xmin ? extent.xmin : xmin);// 多个图形需要判断所有图形的最大最小坐标
		ymin = (ymin > extent.ymin ? extent.ymin : ymin);
		xmax = (xmax > extent.xmax ? xmax : extent.xmax);
		ymax = (ymax > extent.ymax ? ymax : extent.ymax);
	}
	return new arcgisObj.Extent({
		"xmin" : xmin,
		"ymin" : ymin,
		"xmax" : xmax,
		"ymax" : ymax,
		"spatialReference" : {
			"wkid" : 2382
		}
	});
}