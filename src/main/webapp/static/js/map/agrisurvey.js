var map, field;
var dynamicUrl, duijiedynamicUrl, imageUrl;
// arcgis对象
var arcgisObj = {};

require([ "esri/map", "esri/layers/FeatureLayer", "esri/geometry/Extent",
		"esri/tasks/query", "esri/tasks/QueryTask", "dojo/on",
		"esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol",
		"esri/Color", "esri/graphic",
		"esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar",
		"esri/layers/ArcGISImageServiceLayer", "esri/InfoTemplate",
		"esri/dijit/HomeButton", "dojo/_base/connect", "agsjs/dijit/TOC",
		"dojo/fx", "dojo/dom", "dojo/domReady!" ], function(Map, FeatureLayer,
		Extent, Query, QueryTask, on, SimpleFillSymbol, SimpleLineSymbol,
		Color, Graphic, ArcGISDynamicMapServiceLayer, Scalebar,
		ArcGISImageServiceLayer, InfoTemplate, HomeButton, connect, TOC, fx,
		dom) {
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
	arcgisObj.dom = dom;
	// 创建地图
	imageUrl = server151URL + '/HnncImage_HainanPj/ImageServer';
	dynamicUrl = server151URL + '/Agri_Survey/MapServer';
	duijiedynamicUrl = server151URL + '/dcnc_duijie/MapServer';
	zhujidynamicUrl = server151URL + '/dcnc_anno/MapServer';
	field = [ "编号","farmcode","队名", "户主", "作物种类", "用地类型", "Shape.STArea()"];
	main();
});

function addLayers() {
	var duijieDynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(
			duijiedynamicUrl);
	var zhujiDynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(
			zhujidynamicUrl);
	infoTemplate = new arcgisObj.InfoTemplate();
	infoTemplate.setTitle("地块信息");
	
	var content = "<b>户主:</b>${户主}<br/>"
			+ "<b>队名:</b>${队名}<br/>"
			+ "<b>地块号:</b><b id='zcode'>${编号}</b>"
			+ "<a class='easyui-linkbutton'  href='#' onclick='toAgri()'id='toContact'>跳转至农用地调查查询</a><br>"
			+ "<b hidden>农场编号:</b><b hidden id='fcode'>${farmcode}</b>"
			+ "<b>作物种类:</b>${作物种类}<br/>"
			+ "<b>面积:</b>${Shape.STArea():handleArea}";// mi平方米转换成亩
	infoTemplate.setContent(content);
	var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
		mode : arcgisObj.FeatureLayer.MODE_ONDEMAND,
		"opacity" : 0.3,
		outFields : field,
		infoTemplate : infoTemplate
	});
	var imageServiceLayer = new arcgisObj.ArcGISImageServiceLayer(imageUrl);
	layers = [ imageServiceLayer, zhujiDynamicLayer, duijieDynamicLayer,
			eventLayer, ];
	map.addLayers(layers);
	return eventLayer;	
}

function handleArea(mj) {
	return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
}

function main() {
	var bounds = new arcgisObj.Extent({
		"xmin" : 216490.488900 ,
		"ymin" : 160524.455400,
		"xmax" : 231021.594200,
		"ymax" : 177453.138400,
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
		title : "农用地调查"
	} ];
	var tocelement = "tocDiv";
	m.addToc(info, tocelement);
	/*
	 * 2.统计地块信息
	 */
	var service = dynamicUrl + "/0";
	var groupField = [ "队名" ];
	var statisticField = "Shape.STArea()";
	var farmNo = '';
	var showElement = '#show_grid';
	var areaWhere = "farmcode =";
	m.areaStatisticsrow(service, field, areaWhere, groupField, statisticField,showElement, farmNo);
	/*
	 * 3.设置选择农场
	 */
	var data = [ {
		"name" : '海南国营东昌农场',
		"code" : '302',
		"selected" : false
	}, {
		"name" : '',
		"code" : '13',
		"selected" : false
	} ];
	var selectFarmElement = '#farmName';
	var statisticsElement = '#statistics';
	var selectFarm = arcgisObj.dom.byId("farmName");
	m.seclecFarm20(service, data, field, selectFarmElement, statisticsElement);
	/*
	 * 4.宗地号查询
	 */
	var searchButton = arcgisObj.dom.byId("searchBt");
	arcgisObj.on(searchButton, "click", function(evt) {
		var where = m.buildWhereAgri();
		m.landSearch(service, field, where);
	});
	/*
	 * 5.加载时,先判断是否是合同信息跳转过来的
	 */
	var url = location.search;
	var Request = new Object();
	if (url.indexOf("?") != -1) {// 判断是否有参数
		var str = url.substr(1);
		strs = str.split("&");
		for (var i = 0; i < strs.length; i++) {
			Request[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
		}
	} else {
		return;
	}
	var zCode = Request["zdCode"];// 取出参数
	var nCode = Request["ncCode"];
	var agriWhere=m.buildAgriQueryWhere(zCode,nCode);
	m.landSearch(service, field, agriWhere);
}

/*
 * 6.地图跳转合同fcode,dCode
 */
function toAgri() {
	var ch = new ArcGIS();
	var url = '../land/agriRes/selfSupport/formInfoQuery';
	//fcode和zcode是传递的参数
	var fcode = $("#fcode").text();
	var dCode =$("#zcode").text();
	console.log("fcode:"+fcode+",dCode:"+dCode);
	var title = '农用地调查查询';
	var mElement = "#mainTabs";
	ch.map2Contact(url, title, dCode, fcode, mElement);	
}