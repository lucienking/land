var map, field;
var dynamicUrl, imageUrl;
// arcgis对象
var arcgisObj = {};
require([ "esri/map", "esri/layers/FeatureLayer", "esri/geometry/Extent",
		"esri/tasks/query", "esri/tasks/QueryTask", "dojo/on",
		"esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol",
		"esri/Color", "esri/graphic",
		"esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar",
		"esri/layers/ArcGISImageServiceLayer", "esri/InfoTemplate",
		"esri/dijit/HomeButton", "dojo/_base/connect", "agsjs/dijit/TOC",
		"dojo/fx","dojo/dom", "dojo/domReady!" ], function(Map, FeatureLayer, Extent,
		Query, QueryTask, on, SimpleFillSymbol, SimpleLineSymbol, Color,
		Graphic, ArcGISDynamicMapServiceLayer, Scalebar,
		ArcGISImageServiceLayer, InfoTemplate, HomeButton, connect, TOC, fx,dom) {
	arcgisObj.Map = Map;

	arcgisObj.FeatureLayer = FeatureLayer;
	arcgisObj.Extent = Extent;
	arcgisObj.Query = Query;
	arcgisObj.QueryTask = QueryTask;

	arcgisObj.on = on;
	arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
	arcgisObj.SimpleLineSymbol = SimpleLineSymbol;

	arcgisObj.Color = Color;
	arcgisObj.Graphic = Graphic;
	arcgisObj.ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer;

	arcgisObj.Scalebar = Scalebar;
	arcgisObj.ArcGISImageServiceLayer = ArcGISImageServiceLayer;
	arcgisObj.InfoTemplate = InfoTemplate;

	arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
	arcgisObj.HomeButton = HomeButton;
	arcgisObj.connect = connect;
	arcgisObj.TOC = TOC;
	arcgisObj.fx = fx;
	arcgisObj.dom=dom;
	// 创建地图
	imageUrl = server151URL + '/HnncImage_HainanPj/ImageServer';
	dynamicUrl = server151URL + '/lg_beizhandi/MapServer';
	field = [ "ZDH", "mj", "ZGHZCZ", "ZDZT", "ZDJTSJ", "XTDQLR" ];
	main();

});

function addLayers() {// 设置加载哪个图层
	template = new arcgisObj.InfoTemplate();
	template.setTitle("地块信息");
	template.setContent(getTextContent());
	var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
		"opacity" : 0.25,
		outFields : field,
		infoTemplate : template
	});
	var layers;
	imageServiceLayer = new esri.layers.ArcGISImageServiceLayer(imageUrl);
	layers = [ imageServiceLayer, eventLayer ];
	map.addLayers(layers);
	return eventLayer;
}

function handleArea(mj) {
	return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
}

function getDisplayModel(remark, column) {
	return '<strong>' + remark + ':</strong>${' + column + '}<br>';
}

function getTextContent() {
	return getDisplayModel('宗地号', 'ZDH') + getDisplayModel('占地主体', 'ZDZT')
			+ getDisplayModel('占地具体时间', 'ZDJTSJ')
			+ getDisplayModel('做过何种处置', 'ZGHZCZ')
			+ getDisplayModel('占地主体名称', 'XTDQLR')
			+ "<strong>面积:</strong>${mj:handleArea}";
}

function main() {
	var bounds = new arcgisObj.Extent({
		"xmin" : 50219.40844694423,
		"ymin" : 38820.979982184916,
		"xmax" : 79149.40844694423,
		"ymax" : 69910.97998218492,
		"spatialReference" : {
			"wkid" : 2382
		}
	});

	map = new arcgisObj.Map("mapDiv", {
		extent : bounds
	});
	var helement = "homeButton";
	var m = new ArcGIS();
	m.addDijit(helement);
	var layer = addLayers();// 设置加载图层
	var info = [ {
		layer : layer,
		title : "被占地"
	} ];
	var tocelement = "tocDiv";
	map.on('layers-add-result',function(results){
		try {
			m.addToc(info, tocelement);
        } catch (e) {
          alert(e);
        }
     });	
	/*
	 * 2.统计地块信息
	 */
	var service = dynamicUrl + "/0";
	var groupField = [ "XTDQLR" ];
	var statisticField = "MJ";
	var farmNo = '';
	var showElement = '#show_grid';
	var areaWhere = "farmCode =";
	m.areaStatisticsrow(service, field,areaWhere,groupField, statisticField,
			showElement, farmNo);
	/*
	 * 3.设置选择农场
	 */
	var data = [ {
		"name" : '海南省国营乐光农场',
		"code" : '333',
		"selected" : false
	}, {
		"name" : '',
		"code" : '13',
		"selected" : false
	} ];
	var selectFarmElement = '#farmName';
	var statisticsElement = '#statistics';
	m.seclecFarm(service, data, field, selectFarmElement, statisticsElement);
	/*
	 * 4.宗地号查询
	 */
	var searchButton=arcgisObj.dom.byId("searchBt");
	arcgisObj.on(searchButton,"click",function(evt){
		var wvalue=$("#DLMC").val();
		var where=m.buildWhere(wvalue);
		m.landSearch(service, field, where);
	});
}