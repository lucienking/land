var map, baseMap, layer_ziyingjingji, layer_quanshu, layer_beizhandi, layer_sdl, cur_themagic, legend, printer;
var legend0;
var dynamicLayer, dynamicLayer2, dynamicUrl, dynamicUrl2;
// arcgis对象
var arcgisObj = {};

window.onload = function() {

	require([ "esri/map", "esri/arcgis/utils", "esri/layers/FeatureLayer",
			"esri/geometry/Extent", "esri/tasks/query", "esri/tasks/QueryTask",
			"dojo/dom", "dojo/on", "esri/symbols/SimpleFillSymbol",
			"esri/symbols/SimpleLineSymbol", "esri/renderers/SimpleRenderer",
			"esri/Color", "esri/graphic",
			"esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar",
			"esri/layers/ArcGISDynamicMapServiceLayer",
			"esri/dijit/InfoWindowLite", "esri/InfoTemplate",
			"dojo/dom-construct", "esri/dijit/Legend", "esri/dijit/Print",
			"esri/dijit/HomeButton", "dojo/domReady!" ], function(Map,
			arcgisUtils, FeatureLayer, Extent, Query, QueryTask, dom, on,
			SimpleFillSymbol, SimpleLineSymbol, SimpleRenderer, Color, Graphic,
			ArcGISDynamicMapServiceLayer, Scalebar,
			ArcGISDynamicMapServiceLayer, InfoWindowLite, InfoTemplate,
			domConstruct, Legend, Print, HomeButton) {
		arcgisObj.Map = Map;
		arcgisObj.arcgisUrils = arcgisUtils;
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
		arcgisObj.ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer;
		arcgisObj.InfoWindowLite = InfoWindowLite;
		arcgisObj.InfoTemplate = InfoTemplate;
		arcgisObj.domConstruct = domConstruct;
		arcgisObj.Legend = Legend;
		arcgisObj.Print = Print;
		arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
		arcgisObj.HomeButton = HomeButton;
		// 创建地图
		createMap();
	});
};

function createLayers() {
	dynamicUrl =server151URL + '/lg_lindi/MapServer';
	dynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(dynamicUrl);
	var template = new arcgisObj.InfoTemplate();
	template.setTitle("地块信息");
	template.setContent(getTextContent());
	var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/1', {
		outFields : getOutFields(),
		infoTemplate : template
	});
	var layers = [ dynamicLayer, eventLayer ];
	layerClick(eventLayer);
	return layers;
}

function handleArea(mj) {
	return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
}

function getDisplayModel(remark, column) {
	return '<strong>' + remark + ':</strong>${' + column + '}<br>';
}

function getTextContent() {
	return getDisplayModel('树种', 'SHUZHONG')
			+ "<strong>面积:</strong>${MJ:handleArea}<br>"
			+ "<strong>森林类别:<strong>${森林类别}<br>"
			+ "<strong>生态区位:<strong>${生态区位}";
}

function getOutFields() {
	return [ "SHUZHONG", "MJ", "森林类别" ];
}

function createMap() {

	var bounds = new arcgisObj.Extent({
		"xmin" : 284117.8618000001,
		"ymin" : 2040351.7152999993,
		"xmax" : 309523.8705000002,
		"ymax" : 2070239.7237999998,
		"spatialReference" : {
			"wkid" : 2382
		}
	});

	map = new arcgisObj.Map("mapDiv", {
		extent : bounds
	});

	var home = new arcgisObj.HomeButton({
		map : map
	}, "HomeButton");
	home.startup();
	buildLegend();

//	baseMap = new arcgisObj.ArcGISDynamicMapServiceLayer(serverURL
//			+ "/lg_basemap/MapServer", {
//
//	});
	setLayers();
	new arcgisObj.Scalebar({
		map : map,
		attachTo : "bottom-left",
		scalebarUnit : "metric"
	});
}

function buildLegend() {
	legend = new arcgisObj.Legend({
		map : map
	}, "legend");
	legend.startup();

}

function setLayers() {
	var layers = createLayers();
	map.addLayers(layers);

	areaStatisticsrow();
	legend.refresh([ {
		layer : layers[0],
		title : '图例',
		label : 'ddd'
	} ]);
}
function layerClick(fl) {
	fl.on('click', function(evt) {
		map.graphics.clear();
		var highlightSymbol = new arcgisObj.SimpleFillSymbol(
				arcgisObj.SimpleFillSymbol.STYLE_SOLID,
				new arcgisObj.SimpleLineSymbol(
						arcgisObj.SimpleLineSymbol.STYLE_SOLID,
						new arcgisObj.Color([ 47, 79, 177 ]), 1),
				new arcgisObj.Color([ 125, 125, 125, 0.35 ]));
		var highlightGraphic = new arcgisObj.Graphic(evt.graphic.geometry,
				highlightSymbol);
		map.graphics.add(highlightGraphic);
	});
}


function areaStatisticsrow() {
	var QTask = new esri.tasks.QueryTask(dynamicUrl + "/1");

	var queryStatistic = new esri.tasks.Query();
	queryStatistic.outFields = [ "*" ];

	queryStatistic.groupByFieldsForStatistics = [ "SHUZHONG " ];

	var statDef = new esri.tasks.StatisticDefinition();
	statDef.statisticType = "sum";
	statDef.onStatisticField = "MJ";
	statDef.outStatisticFieldName = "sumMj";
	queryStatistic.outStatistics = [ statDef ]; 
	queryStatistic.ReturnGeometry = false;
	queryStatistic.orderByFields = [ "sumMj DESC" ];

	QTask.execute(queryStatistic, ShowQueryStatistic);
}
function ShowQueryStatistic(results) {

	var resultCount = results.features.length;
	var zmj = 0;

	for (var i = 0; i < resultCount; i++) {
		var attr = results.features[i].attributes;
		var sumMj = attr.sumMj;
		zmj = zmj + sumMj;
	}
	$('#show_grid').empty();
	var tr_head = $('<tr><td class="grid_td">' + "树种"
			+ '</td><td class="grid_td">' + "面积(亩)"
			+ '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
	$('#show_grid').append(tr_head);
	var tr_head2 = $('<tr><td class="grid_td">' + "总面积"
			+ '</td><td class="grid_td">' + (zmj * 3 / 2000).toFixed(2)
			+ '</td><td class="grid_td_right">' + "100%" + '</td></tr>');
	$('#show_grid').append(tr_head2);

	for (var i = 0; i < resultCount; i++) {
		var attr = results.features[i].attributes;
		var DLMC = attr.SHUZHONG;
		var sumMj = attr.sumMj;
		var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";

		var trl = $('<tr><td class="grid_td">' + DLMC
				+ '</td><td class="grid_td">' + (sumMj * 3 / 2000).toFixed(2)
				+ '</td><td class="grid_td_right">' + percert + '</td></tr>');

		$('#show_grid').append(trl);
	}
}
function cauculatePercent(num, total) {
	return parseFloat((num / total) * 100).toFixed(2) + '%';
}



