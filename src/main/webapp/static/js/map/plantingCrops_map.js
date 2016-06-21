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
	arcgisObj.TOC = TOC;
	arcgisObj.dom = dom;
	// 创建地图
	imageUrl = server151URL + '/HnncImage_HainanPj/ImageServer';
	dynamicUrl = server151URL + '/zyjj_hnnc_20150811/MapServer';
	duijiedynamicUrl = server151URL + '/dcnc_duijie/MapServer';
	zhujidynamicUrl = server151URL + '/dcnc_anno/MapServer';
	field = [ "DKBH","mj"];
	main();
});

//加载图层
function addLayers() {
	var duijieDynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(
			duijiedynamicUrl);
	var zhujiDynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(
			zhujidynamicUrl);
	var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
		mode : arcgisObj.FeatureLayer.MODE_ONDEMAND,
		"opacity" : 0.3,
		outFields : field
	});
	var imageServiceLayer = new arcgisObj.ArcGISImageServiceLayer(imageUrl);
	layers = [ imageServiceLayer, zhujiDynamicLayer, duijieDynamicLayer,
			eventLayer, ];
	map.addLayers(layers);
	return eventLayer;
	
}


var arcgisUtil=new ArcGIS();

function main(){
	var bounds=new arcgisObj.Extent({
		xmin: 15268.735999999568,
		ymin: 8616.607999999076,
		xmax: 293927.3459999999,
		ymax: 230567.95800000057,
		"spatialReference" : {
			"wkid" : 2382
		}
	});
	
	map=new arcgisObj.Map("mapDiv",{
		extent:bounds
	});
	
	var layer=addLayers();
	
}

function locateParcel(){
	var parcelCode=null;
	var selectedRow=$('#parcelList').datagrid('getSelected');
	var service = dynamicUrl + "/0";
	var field=['DKBH'];
	if(selectedRow!=null){
		parcelCode=selectedRow.contract_parcel_code;
		arcgisUtil.landSearch(service,field,"DKBH='"+parcelCode+"'");
	}else{
		$.messager.alert('提示','请选择一条信息。');
	}
}