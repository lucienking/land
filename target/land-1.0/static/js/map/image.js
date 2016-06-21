var serverURLtemp = "http://10.215.201.151:6080/arcgis/rest/services";// 现在影像实验数据放151上了,所以这里建立了临时路径
// arcgis对象
var arcgisObj = {};// 方便非主函数调用arcgisAPI
var map, dynamicUrl, imageUrl;
	require([ "esri/map", "esri/layers/FeatureLayer",
			"esri/geometry/Extent", "esri/tasks/query", "esri/tasks/QueryTask",
			"dojo/dom", "dojo/on", "esri/symbols/SimpleFillSymbol",
			"esri/symbols/SimpleLineSymbol", "esri/renderers/SimpleRenderer",
			"esri/Color", "esri/graphic",
			"esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar",
			"esri/layers/ArcGISImageServiceLayer",
			"esri/dijit/InfoWindowLite", "esri/InfoTemplate",
			"esri/dijit/HomeButton", "dojo/domReady!"], function(Map, FeatureLayer,
			Extent, Query, QueryTask, dom, on, SimpleFillSymbol,
			SimpleLineSymbol, SimpleRenderer, Color, Graphic,
			ArcGISDynamicMapServiceLayer, Scalebar, ArcGISImageServiceLayer,
			InfoWindowLite, InfoTemplate,
			HomeButton) {
		arcgisObj.Map = Map;// //将所有对象加入arcgisObj里,方便其他函数调用
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
		arcgisObj.InfoWindowLite = InfoWindowLite;
		arcgisObj.InfoTemplate = InfoTemplate;
		arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
		arcgisObj.HomeButton = HomeButton;
		arcgisObj.ArcGISImageServiceLayer = ArcGISImageServiceLayer;
		
		imageUrl = serverURLtemp + "/8farms/ImageServer";// 8个农场的影像服务地址
		dynamicUrl = serverURLtemp + '/cj_wgs/MapServer';// wgs84坐标系统的厂界服务
		createbaseMap();// 加载地图
		findcombobox();
	});
	
	/**
	 * 初始化下拉框列表，选择时跳转到该位置
	 */
function findcombobox() {
	$('#FarmName_image').combobox({
		url: '/land/thematicMap/imageOrg', // 数据是初始化农场名里的结果列表
        method: 'GET',
        valueField: 'farmCode', // id是编号
        textField: 'NCMC', // 农场名称
		onSelect : function(rec) {
			var values = rec.NCMC;
			landSearch(values);
		},
		onLoadSuccess :function(rec) {
			var data = $('#FarmName_image').combobox('getData');
			if (data.length == 1) {
				$('#FarmName_image').combobox('select', data[0].code);
			}
		}	
	});
}

/**
 * 展示查绚结果
 * @param queryResult
 * @returns
 */
function displayResult(queryResult) {
	map.graphics.clear();
	map.infoWindow.hide();
	for ( var index in queryResult) {
		var feature = queryResult[index].feature;
		var highlightSymbol = new arcgisObj.SimpleLineSymbol(
				arcgisObj.SimpleLineSymbol.STYLE_SOLID,
				new arcgisObj.Color([ 240, 230, 140 ]), 3);
		var highlightGraphic = new arcgisObj.Graphic(feature.geometry,
				highlightSymbol);
		map.graphics.add(highlightGraphic);
	}
	map.setExtent(getExtent(queryResult));
}
	/**
	 * 获取查询结果范围
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
		xmin = (xmin > extent.xmin ? extent.xmin : xmin);
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
			"wkid" : 102113
		}
	});
}
	/**
	 * 根据农村名称（ncmc）查出地块位置并显示
	 * @param ncmc
	 */
function landSearch(ncmc) {
	var queryTask = new arcgisObj.QueryTask(dynamicUrl + '/0');
	var query = new arcgisObj.Query();
	query.returnGeometry = true;
	query.maxAllowableOffset = 10;
	query.num = 2000;
	query.outFields = [ "OrganName"];
	query.where = " OrganName like '" + '%' + ncmc + '%' + "'";
	var querySearchResult = [];
	queryTask.execute(query, function(results) {
		if (results.features) {
			for ( var index in results.features) {
				var feature = results.features[index];
				var extent = feature.geometry.getExtent();
				var result = {
					extent : extent,
					feature : feature
				};
				querySearchResult.push(result);
			}
			if (querySearchResult.length > 0) {
				displayResult(querySearchResult);
			} else {
				$.messager.alert('提示', '没有符合条件的地块', 'info');
			}
		}
	});
}
function createbaseMap() {
	/**
	 * 初始化地图,设置范围
	 */
	map = new arcgisObj.Map("mapDiv_image");
	var home = new arcgisObj.HomeButton({
		map : map
	}, "HomeButton_image");
	home.startup();
	/**
	 * 设置比例尺,位置停靠左下，单位:米
	 */ 
	new arcgisObj.Scalebar({
		map : map,
		attachTo : "bottom-left",
		scalebarUnit : "metric"
	});
	/**
	 * 设置动态地图地址，以及透明度
	 */
	var dynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(dynamicUrl, {
		"opacity" : 0.8
	});
	// 影像地址
	var imageServiceLayer = new esri.layers.ArcGISImageServiceLayer(imageUrl);
	var template = new arcgisObj.InfoTemplate();
	var content = "<strong>农场名称:</strong>${OrganName}<br>";
	template.setTitle("地块信息");
	template.setContent(content);
	var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
		"opacity" : 0.5,
		outFields : [ "OrganName"],
		infoTemplate : template
	});
	var layers = [ imageServiceLayer, dynamicLayer, eventLayer ];
	map.addLayers(layers);
}