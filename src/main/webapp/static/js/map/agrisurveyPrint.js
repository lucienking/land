var map, field;
var dynamicUrl, imageUrl;
// arcgis对象
var arcgisObj = {};
require([ "esri/map", "esri/layers/FeatureLayer", "esri/geometry/Extent",
		"esri/tasks/query", "esri/tasks/QueryTask", "dojo/on",
		"esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol",
		"esri/Color", "esri/graphic", "esri/dijit/Print","esri/tasks/PrintTask",
		"esri/tasks/PrintTemplate", "esri/request","esri/tasks/PrintParameters",
		"esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar",
		"esri/layers/ArcGISImageServiceLayer", "esri/InfoTemplate",
		"esri/symbols/Font","esri/symbols/TextSymbol","esri/geometry/Polygon",
		"esri/geometry/Point","esri/dijit/HomeButton", "esri/geometry/scaleUtils", 
		"dojo/_base/connect", "dojo/_base/array",
		"dojo/fx", "dojo/dom", "dojo/domReady!" ], function(Map, FeatureLayer,
		Extent, Query, QueryTask, on, SimpleFillSymbol, SimpleLineSymbol,
		Color, Graphic, Print,PrintTask, PrintTemplate, esriRequest,PrintParameters,
		ArcGISDynamicMapServiceLayer, Scalebar, ArcGISImageServiceLayer,
		InfoTemplate,Font,TextSymbol,Polygon,Point, HomeButton,scaleUtils, connect, 
		arrayUtils, fx, dom) {
	arcgisObj.Map = Map;
	arcgisObj.FeatureLayer = FeatureLayer;
	arcgisObj.Extent = Extent;
	arcgisObj.Query = Query;
	arcgisObj.QueryTask = QueryTask;
	arcgisObj.on = on;
	arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
	arcgisObj.SimpleLineSymbol = SimpleLineSymbol;
	arcgisObj.Font=Font;
	arcgisObj.TextSymbol=TextSymbol;
	arcgisObj.Point=Point;
	arcgisObj.Polygon=Polygon;
	arcgisObj.scaleUtils=scaleUtils;
	arcgisObj.Color = Color;
	arcgisObj.Graphic = Graphic;
	arcgisObj.ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer;
	arcgisObj.Scalebar = Scalebar;
	arcgisObj.ArcGISImageServiceLayer = ArcGISImageServiceLayer;
	arcgisObj.InfoTemplate = InfoTemplate;
	arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
	arcgisObj.HomeButton = HomeButton;
	arcgisObj.connect = connect;
	arcgisObj.PrintTask=PrintTask;
	arcgisObj.Print = Print;
	arcgisObj.PrintTemplate = PrintTemplate;
	arcgisObj.PrintParameters=PrintParameters;
	arcgisObj.esriRequest = esriRequest;
	arcgisObj.fx = fx;
	arcgisObj.dom = dom;
	arcgisObj.arrayUtils = arrayUtils;
	// 创建地图
	dynamicUrl = server151URL + '/Agri_Survey/MapServer';
	field = [ "编号", "farmcode", "队名", "户主", "作物种类", "Shape.STArea()" ];
	main();
});

function main() {
	var bounds = new arcgisObj.Extent({
		"xmin" : 216490.488900,
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
	var eventLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(dynamicUrl , {
		"opacity" : 0
	});
	layers = [ eventLayer ];
	map.addLayers(layers);
	var service = dynamicUrl + "/0";
	isJump(service);
	$("#printbutton").click( Printjob );
}
function isJump(service) {
    var  nCode= $("#farmCode").val();
    var zCode = $("#zdCode").val();
    var groupName=$("#groupName").val();
    console.log(nCode,zCode);
    if (zCode !== "" && zCode!== "" && zCode !== 0 && nCode !== 0) {
    	var agriWhere = buildAgriQueryWhere(zCode, nCode);
    	landSearch(service, field, agriWhere);
      }
  }
function Printjob(){
  var name=$("#title").val();
  var author=$("#author").val();
  var authors={};
  authors.author=author;
  authors.name=name;
  var printUrl = "http://10.215.201.151:6080/arcgis/rest/services/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task/execute";
  var printTask = new arcgisObj.PrintTask();
  var Web_Map_as_JSON = printTask._getPrintDefinition(map);
  console.log(JSON.stringify(Web_Map_as_JSON));
  var layersd = Web_Map_as_JSON.operationalLayers[1].featureCollection.layers;
  var dpolygons=layersd[0].featureSet.features;
  var dpoints=layersd[1].featureSet.features;
  var webJson=[];
  var layouts={};
  var dprintParams= {};
  layouts.author=author;
  layouts.name=name;
  var height = map.height;
  var width = map.width;
  
  for (var j = 0; j < dpolygons.length; j++) {
	  var dsextent = new arcgisObj.Polygon(dpolygons[j].geometry).getExtent().expand(1.2);
      var unitValue = arcgisObj.scaleUtils.getUnitValue(new esri.SpatialReference(2382));
      if (dpolygons.length === 1) {
    	  var wscale=getWidthScale(dsextent, width, unitValue);
          var hscale = getHeightScale(dsextent, height, unitValue);
          dprintParams.scale=wscale>hscale?wscale:hscale;  
        //dprintParams.scale=getMyScale(map.extent, width, unitValue);
        webJson[j] = JSON.stringify(setPrintParameter(Web_Map_as_JSON, dsextent, layouts,dprintParams));
        
      } else {
        if (layersd[0].featureSet.geometryType === "esriGeometryPolygon") {
          var dpolygon = dpolygons[j];
          var wscale=getWidthScale(dsextent, width, unitValue);
          var hscale = getHeightScale(dsextent, height, unitValue);
          dprintParams.scale=wscale>hscale?wscale:hscale;
          console.log(wscale,hscale);
          if (layersd[1].featureSet.geometryType === "esriGeometryPoint") {
            var tpoint = dpoints[j*2];
            var apoint = dpoints[j*2+1];
            var dpoint =[tpoint,apoint];
            //console.log(j+":========="+JSON.stringify(getWebMapJson(name, webMapJson, dextent, dpolygon, dpoint)));
            webJson[j] = JSON.stringify(getWebMapJson(name, Web_Map_as_JSON, dsextent, dpolygon, dpoint,dprintParams));

          }
        }
      }

  }
  getprintUrls(webJson,printUrl,authors);
  
}
function setPrintParameter(webJson, extent, layouts,dprintParams) {
    webJson.mapOptions.scale = dprintParams.scale||8000;
    webJson.exportOptions = {"outputSize": [500, 400], "dpi": 300};
    webJson.layoutOptions = {
      "titleText": "",//layouts.name || "地块号",
      "authorText": "",//"海南农垦国土局",
      "copyrightText": "",//"海南金垦赛博信息科技有限公司",
      "scaleBarOptions": {
        "metricUnit": "esriMeters",
        "metricLabel": "m",
        "nonMetricUnit": "esriFeet",
        "nonMetricLabel": "ft"
      },
      "legendOptions": {"operationalLayers": [{}]}
    };
    webJson.mapOptions.extent = {
      "xmin": extent.xmin,
      "ymin": extent.ymin,
      "xmax": extent.xmax,
      "ymax": extent.ymax,
      "spatialReference": {"wkid": extent.spatialReference.wkid}
    };
    return webJson;
  }
function getHeightScale(extent, mapWd, unitValue) {
    var inchesPerMeter = 39.37;
    var decDegToMeters = 6370997 * Math.PI / 180;
    var ecd = esri.config.defaults;
    return (extent.getHeight() / mapWd) * (unitValue || decDegToMeters) * inchesPerMeter * ecd.screenDPI;
    //extent && mapWd ? extent.getWidth() / mapWd * (unitValue || decDegToMeters) * inchesPerMeter * ecd.screenDPI : 0;
};
  function getWidthScale(extent, mapWd, unitValue) {
	    var inchesPerMeter = 39.37;
	    var decDegToMeters = 6370997 * Math.PI / 180;
	    var ecd = esri.config.defaults;
	    
	    return (extent.getWidth() / mapWd) * (unitValue || decDegToMeters) * inchesPerMeter * ecd.screenDPI;
	    //extent && mapWd ? extent.getWidth() / mapWd * (unitValue || decDegToMeters) * inchesPerMeter * ecd.screenDPI : 0;
};
function getprintUrls(webJsons,printUrl,authors){
    if(webJsons!=[]){
      console.log(webJsons);
      var urls = "/land/agriRes/selfSupport/mapPrintPreview?jpgUrl=";
      var wlength=webJsons.length;
      var printUrls=[];
      arcgisObj.arrayUtils.forEach(webJsons,function(webjson,i){
    	console.log(webjson);  
        $.ajax({
          url: printUrl,
          type: 'GET',
          async: false,
          dataType: 'json',
          data: {
            "Web_Map_as_JSON": webjson,
            "Format":"jpg",
            "Layout_Template":"A4 Landscape",
            "f":"json"
          },
          success: function(data, status) {
        	var url=data.results[0].value.url;  
            console.log(url);
            printUrls.push(url);
          },
          error: function(data, status, e) {
            $.messager.alert("error");
          }
        });
      });
      console.log(printUrls);
      arcgisObj.arrayUtils.forEach(printUrls,function(printUrl,i){
    	  urls=setUrls(wlength,printUrl,urls,i);
      });
      if(authors.author!=null&&authors.name!=null){
    	  urls+="&department="+authors.author+"&title="+authors.name;
      }else if(authors.author!=null&&authors.name==null){
    	  urls+="&department="+authors.author+"&title=''";
      }else if(authors.author==null&&authors.name!=null){
    	  urls+="&department=''"+"&title="+authors.name;
      }else{
    	  urls+="&department=''&title=''";
      }
      
      console.log(urls);
      mergeImages(urls);
    }
  }

function setUrls(wlength,url,urls,i){
	if(i<wlength-1){
		urls+=url+",";
	}else if(i==wlength-1){
		urls+=url;
	}
	return urls;
}
function mergeImages(url) {
   forwardToTabPage(url,"地图打印预览");
 }

  //拼凑json,形成一个地块和文字json
function getWebMapJson(layouts, webJson, dextent, dpolygon, dpoint,dprintParams) {
    var extent = dextent;
    webJson = setPrintParameter(webJson, extent, layouts,dprintParams);
    webJson.operationalLayers[1].featureCollection.layers[0].featureSet.features = [];
    webJson.operationalLayers[1].featureCollection.layers[1].featureSet.features = [];
    for(var index in dpoint){
    	webJson.operationalLayers[1].featureCollection.layers[1].featureSet.features.push(dpoint[index]);
    }
    webJson.operationalLayers[1].featureCollection.layers[0].featureSet.features.push(dpolygon);
    
    return webJson;
  }
//构建 
function buildAgriQueryWhere(zdCode, ncCode) {
	var zdCodes = zdCode.split(",");// 多个地块用,分隔
	var ncCodes = ncCode.split(",");
	var where = '';
	if (zdCodes.length == 1) {
		where = "farmcode='" + ncCode + "' and " + "编号='" + zdCode + "'";
	} else if (zdCodes.length > 1) {
		/*
		 * 当宗地号大于一个时，sql为farmcode='302' and 编号='20-448' or (farmcode='302' and 编号='20-247') (举例)
		 */
		where = "farmcode='" + ncCodes[0] + "' and 编号='" + zdCodes[0] + "'";
		for (var j = 1; j < zdCodes.length; j++) {
			where += " or (farmcode='" + ncCodes[j] + "' and 编号='" + zdCodes[j] + "')";
		}
		
	}
	return where;
}

function landSearch(service, field, where) {
	var queryTask = new arcgisObj.QueryTask(service);
	var query = new arcgisObj.Query();
	query.returnGeometry = true;
	query.maxAllowableOffset = 0.001;
	query.num = 2000;
	query.outFields = field;
	console.log(where);
	if (where != '') {
		query.where = where;
		console.log(query.where);
		var queryResult = [];
		queryTask.execute(query, function(results) {
			if (results.features) {
				for ( var index in results.features) {
					var feature = results.features[index];
					var extent = feature.geometry.getExtent();
	                var result = {
	                  extent: extent,	
						feature : feature
					};
					queryResult.push(result);
				}
				if (queryResult.length > 0) {
					displayResult(queryResult);
				} else {
					$.messager.alert('提示', '没有符合条件的地块', 'info');
				}
			} else {
				$.messager.alert('提示', '没有符合条件的地块', 'info');
			}
		});
	} else {
		$.messager.alert('提示', '请输入条件', 'info');
	}
}
function displayResult(queryResult) {
	map.graphics.clear();
	map.infoWindow.hide();
	for ( var index in queryResult) {
		var feature = queryResult[index].feature;
		var highlightSymbol = new arcgisObj.SimpleFillSymbol(
				arcgisObj.SimpleFillSymbol.STYLE_NULL,
		           new arcgisObj.SimpleLineSymbol(
		        		   arcgisObj.SimpleLineSymbol.STYLE_SOLID,
		           new arcgisObj.Color([ 255, 0, 0 ]), 2),
		           new arcgisObj.Color([  255, 0, 0, 1 ]));
		var highlightGraphic = new arcgisObj.Graphic(feature.geometry,
				highlightSymbol);
		map.graphics.add(highlightGraphic);
		var gextent=getExtent(queryResult);
        map.setExtent(gextent.expand(1.2));
         var centroidP=feature.geometry.getCentroid();
         var centroidFont = new arcgisObj.Font("20px",arcgisObj.Font.STYLE_NORMAL,
        		 arcgisObj.Font.VARIANT_SMALLCAPSL, arcgisObj.Font.WEIGHT_BOLD);
         var dkExtent=new arcgisObj.Polygon(feature.geometry).getExtent();
         var b=dkExtent.ymax;
         var a=(dkExtent.xmax+dkExtent.xmin)/2;
         var topFont = new arcgisObj.Font("20px",arcgisObj.Font.STYLE_NORMAL,
        		 arcgisObj.Font.VARIANT_SMALLCAPSL, arcgisObj.Font.WEIGHT_BOLD);
         var topP=new arcgisObj.Point(a,b,map.spatialReference);
         var topTextSymbol = new arcgisObj.TextSymbol(feature.attributes["队名"]+"承包地块",topFont, new arcgisObj.Color([0, 0, 0]));
         //var topTextSymbol = new arcgisObj.TextSymbol(feature.attributes["队名"]+"承包地块"+"地块编号:"+feature.attributes["编号"],topFont, new arcgisObj.Color([0, 0, 0]));
         var topGraphic = new arcgisObj.Graphic(topP,topTextSymbol);
         map.graphics.add(topGraphic);
         var centroidTextSymbol = new arcgisObj.TextSymbol( "地块编号:"+feature.attributes["编号"]+"\n "+"面积:" +handleArea(feature.attributes["Shape.STArea()"]),centroidFont, new arcgisObj.Color([0, 0, 0]));
         var centroidGraphic = new arcgisObj.Graphic(centroidP,centroidTextSymbol);
         map.graphics.add(centroidGraphic);
//         for(var a=1;a<feature.geometry.rings[0].length;a++){
//           var textSymbol = new arcgisObj.TextSymbol(
//             "D" +"00"+ a,font, new arcgisObj.Color([0, 0, 0]));
//           var x=feature.geometry.rings[0][a][0];
//           var y=feature.geometry.rings[0][a][1];
//           var localtion=new arcgisObj.Point(x,y,map.spatialReference);
//           var labelPointGraphic = new arcgisObj.Graphic(localtion, textSymbol);
//           map.graphics.add(labelPointGraphic);
//         }
       }
	
}
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
	console.log("范围:xmin:" + xmin + ",ymin:" + ymin + ",xmax:" + xmax
			+ ",ymax:" + ymax);
	return new arcgisObj.Extent({
		"xmin" : xmin,
		"ymin" : ymin,
		"xmax" : xmax,
		"ymax" : ymax,
		"spatialReference" : map.spatialReference
	});
}
function handleArea(mj) {
    return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
  }

function forwardToTabPage(url,title){
    if (parent.$("#mainTabs").tabs('exists', title)) {
        parent.$("#mainTabs").tabs('close', title);
    }
    var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:99%;height:99%;"></iframe>';
    parent.$("#mainTabs").tabs('add', {
        title: title,
        content: content,
        closable: true
    });
}