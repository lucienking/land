var map;
var arcgisObj = {};
require(
    ["esri/map", "dojo/dom", "dojo/on", "dojo/parser", "dojo/sniff",
        "esri/tasks/Geoprocessor","esri/tasks/FeatureSet",
        "esri/renderers/SimpleRenderer",
        "esri/symbols/SimpleFillSymbol",
        "esri/symbols/SimpleLineSymbol",
        "esri/layers/FeatureLayer",
        "esri/InfoTemplate",
        "esri/Color",
        "esri/dijit/Print",
        "esri/dijit/Scalebar",
        "dijit/layout/BorderContainer",
        "dijit/layout/ContentPane", "dojo/domReady!"
    ],
    function(Map, dom, on, parser, sniff, Geoprocessor,FeatureSet,SimpleRenderer,
    		SimpleFillSymbol,SimpleLineSymbol,FeatureLayer,InfoTemplate,Color,Print,Scalebar) {
        arcgisObj.Map = Map;
        arcgisObj.dom = dom;
        arcgisObj.on = on;
        arcgisObj.parser = parser;
        arcgisObj.sniff = sniff;
        arcgisObj.Geoprocessor = Geoprocessor;
        arcgisObj.FeatureSet=FeatureSet;
        arcgisObj.SimpleRenderer=SimpleRenderer;
        arcgisObj.SimpleFillSymbol=SimpleFillSymbol;
        arcgisObj.SimpleLineSymbol=SimpleLineSymbol;
        arcgisObj.FeatureLayer=FeatureLayer;
        arcgisObj.Color=Color;
        arcgisObj.InfoTemplate=InfoTemplate;
        arcgisObj.Extent=esri.geometry.Extent;
        parser.parse();
        var fileName;
        var loading = dom.byId("loading");
        map = new Map("mapCanvas", {
            extent: new esri.geometry.Extent({
                xmin: 51220.445500 ,
                ymin: 39609.162500,
                xmax: 76638.325100,
                ymax: 69507.765500,
                spatialReference: {
                    wkid: 2382
                }
            })
        });
        new Scalebar({
    		map : map,
    		attachTo : "bottom-left",
    		scalebarUnit : "metric"
    	});
        var arcgisURL = "http://10.215.201.151:6080/arcgis/rest/services/lg_dilei/MapServer";

        var Layer = new esri.layers.ArcGISDynamicMapServiceLayer(arcgisURL);
        map.addLayer(Layer);
        
        on(dom.byId("uploadForm"), "change", function(event) {
            fileName = event.target.value.toLowerCase();
            if (sniff("ie")) { // filename is full path in IE
                // so extract the file name
                var arr = fileName.split("\\");
                fileName = arr[arr.length - 1];
            }
            if (fileName.indexOf(".zip") !== -1) { // is file a zip
                // - if not notify user
                uploadFile(fileName);
            } else {
                dom.byId('upload-status').innerHTML = '<p style="color:red">请添加zip类型文件</p>';
            }
        });
        var printer = new Print({
            map: map,
            url: "http://10.215.200.134:6080/arcgis/rest/services/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task/execute"
          }, dom.byId("printButton"));
         printer.startup();
    });
/*
 * 上传zip文件,获取itemid
 */
function uploadFile(fileName) {
    arcgisObj.dom.byId('upload-status').innerHTML = '';
    //var str = location.href;
    var name = fileName.split(".");
    name = name[0].replace("c:\\fakepath\\", "");
    arcgisObj.dom.byId('upload-status').innerHTML = '<p></p>';
    arcgisObj.dom.byId('upload-status').innerHTML = '<b>上传… </b>' + name;
    id = "inFile";
    //var itemID = null;
    var uploadService = "http://10.215.200.134:6080/arcgis/rest/services/IntersectAndToJson/GPServer/uploads/upload";
    // 程序运行时所在计算机上，.sde文件的路径
    
    var now=new Date();
    var time=now.getFullYear()+""+(now.getMonth()+1)+now.getDate()+now.getHours()+now.getMinutes()+now.getSeconds()+now.getMilliseconds();
    time=time.substr(2);
    var params={};
    params.serverPath="D:\\arcgisserver\\config-store\\uploads\\";
    params.landuse="D:\\arcgisserver\\151.sde\\rims_arcgis.DBO.lg_dilei";
    params.Intersect_input = "D:\\arcgisserver\\151.sde\\rims_arcgis.DBO.shiyan\\i"+time;
    params.intersectservice="http://10.215.200.134:6080/arcgis/rest/services/IntersectAndToJson/GPServer/IntersectAndtoJson/execute";
    params.path_ToJSON="D:\\arcgisserver\\r"+time+".json";
    $("#uploadForm").ajaxSubmit({
        url: uploadService,
        type: 'POST',
        async: false,
        dataType: 'json',
        success: function(data, status) {
        	params.itemID = data.item.itemID;
            console.log(params.itemID);
            console.log("调用后台");
            arcgisObj.dom.byId('upload-status').innerHTML = '<b>上传文件成功 </b>' + name+',请耐心等待';
            getPath(params);
        },
        error: function(data, status, e) {
            $.messager.alert("error");
        }
    });
}
/*
 * 向后台请求执行相交操作，成功后获取esrijson和范围
 */
function getPath(params){
	$.ajax({
        url: "/land/thematicMap/runIntersectGeoProcessing",
        type: 'POST',
        dataType: 'json',
        data: {
            "itemID": params.itemID,
            "landuse":params.landuse,
            "intersectservice":params.intersectservice,
            "Intersect_input":params.Intersect_input,
            "path_ToJSON":params.path_ToJSON,
            "serverPath": params.serverPath
        },
        success: function(data, status) {
            console.log(data);
            arcgisObj.dom.byId('upload-status').innerHTML = '<p>正在相交分析，请稍后...</p>';
            if(data.results[0].value!=null){
            	console.log("相交分析成功");
            	var extent = data.results[1].value;
            	var reslutjson=data.results[0].value;
                createFeatureLayer(reslutjson,extent);
                arcgisObj.dom.byId('upload-status').innerHTML = '<p>分析成功</p>';
            }else{
            	console.log("相交分析失败");
                arcgisObj.dom.byId('upload-status').innerHTML = '<p>分析失败</p>';
            }

        },
        error: function(data, status, e) {
            console.log("e:"+e);
            console.log("status:"+status);
            arcgisObj.dom.byId('upload-status').innerHTML = '<p>分析失败</p>';
        }
    });
}
/*
 * 利用后台获取的json,组合成featureCollection，用于创建要素图层
 * 
 */
function createFeatureLayer(json,extent) {

    var json_geometryType= json.geometryType;
    var json_features= json.features;
    var jsonFS = {
        "geometryType": json_geometryType,
        "features": json_features
    };
    var fileldList=json.fieldAliases;
    
    var json_spatialReference= json.spatialReference.wkid;
    var json_fields= json.fields;
    var json_featureSet= new arcgisObj.FeatureSet(jsonFS);
    var layerDefinition = {
        "geometryType": json_geometryType,
        "spatialReference": json_spatialReference,
        "fields": json_fields
    };
    var featureCollection = {
        layerDefinition: layerDefinition,
        featureSet: json_featureSet
    };
    console.log(featureCollection);
    addfeaturelayer(featureCollection,fileldList,extent,json_spatialReference);
}

/**
 * 1创建要素图层，渲染后显示
 * 2获取后台传的范围参数，缩放至该范围
 * 3在table中展示数据字段名，然后再获取选择项，放入数组
 * 4通过设置属性表，控制要素图层的弹出框
 */
function addfeaturelayer(featureCollection,fileldList,extent,sp) {
    featureLayer = new arcgisObj.FeatureLayer(featureCollection);
    var renderer = new arcgisObj.SimpleRenderer(new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID,
        new arcgisObj.SimpleLineSymbol(arcgisObj.SimpleLineSymbol.NULL,
            new arcgisObj.Color([232, 104, 80]), 4), new arcgisObj.Color([232, 104, 80, 0.25])));
    featureLayer.setRenderer(renderer);
    map.addLayer(featureLayer);
    var fExtent = new arcgisObj.Extent({
        "xmin": extent.XMin,
        "ymin": extent.YMin,
        "xmax": extent.XMax,
        "ymax": extent.YMax,
        spatialReference: {
            wkid: sp
        }
    });
    map.setExtent(fExtent);
    var list = "";
	$('#infor_select').empty();
	var length=Object.keys(fileldList).length;
	var i=0;
	for (value in fileldList) {
	    i++;
	    if (i < length) {
	        list += '{' + '"itemid"' + ':' + '"'+value +'"'+ "}" + ",";
	    }else{
	        list += '{' + '"itemid"' + ':' + '"'+value +'"'+ "}";
	    }   	
	}
	var list_jsonString= '[' + list + ' ]';
	console.log(list_jsonString);
	var list_jsonObject= jQuery.parseJSON(list_jsonString);
	$('#infor_select').datagrid({
		data: list_jsonObject,
		onSelect: gSelection,
	    onUnselect: gSelection,
	    onSelectAll: gSelection,
	    onUnselectAll: gSelection		
	});
	function gSelection() {
	    var ids = [];
	    var rows = $('#infor_select').datagrid('getSelections');
	    for (var i = 0; i < rows.length; i++) {
	        ids.push(rows[i].itemid);
	    }
	    var content_attribute = "";
	    var infoTemplate_attribute = new arcgisObj.InfoTemplate();
	    if (ids.length>= 1) {
	    	for (var i=0; i <ids.length; i++) {
	    		content_attribute += "<b>" + ids[i] + ":</b>" + "${" + ids[i] + "}<br/>";
	    	}
	    	console.log(content_attribute);
	    	featureLayer.infoTemplate = infoTemplate_attribute.setTitle("地块信息");
	        featureLayer.infoTemplate = infoTemplate_attribute.setContent(content_attribute);
	    }else{
	    	featureLayer.infoTemplate='';
	    }
	}
}