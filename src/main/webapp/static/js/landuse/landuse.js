var map;
var hashTab = new HashTable();
var hashTabPic;
var dynamicUrl;
// arcgis对象
var arcgisObj = {};

	require([ "esri/map","esri/layers/FeatureLayer","esri/geometry/Extent",
	        "esri/tasks/query", "esri/tasks/QueryTask",
	        "esri/symbols/SimpleFillSymbol","esri/symbols/SimpleLineSymbol",
	        "esri/renderers/SimpleRenderer","esri/Color", "esri/graphic",
			"esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar",
			"esri/dijit/InfoWindowLite", "esri/InfoTemplate",
			"esri/dijit/HomeButton", "dojo/domReady!" ], function(Map,
			FeatureLayer, Extent, Query, QueryTask,SimpleFillSymbol,
			SimpleLineSymbol, SimpleRenderer, Color, Graphic,
			ArcGISDynamicMapServiceLayer, Scalebar,InfoWindowLite, 
			InfoTemplate,HomeButton) {
		arcgisObj.Map = Map;
		arcgisObj.FeatureLayer = FeatureLayer;
		arcgisObj.Extent = Extent;
		arcgisObj.Query = Query;
		arcgisObj.QueryTask = QueryTask;
		
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
		// 创建地图
		dynamicUrl = server151URL + '/lg_dilei/MapServer';
		
		createMap();
		areaStatisticsAllType();// 获取图例图片
		areaStatisticsThreeType();// 获取图例信息
	});

function areaStatisticsAllType() {
	// 统计详细分类
	var QTask = new esri.tasks.QueryTask(dynamicUrl + "/0");
	var queryStatistic = new esri.tasks.Query();
	queryStatistic.outFields = [ "*" ];
	queryStatistic.groupByFieldsForStatistics = [ "DLMC" ];
	var statDef = new esri.tasks.StatisticDefinition();
	statDef.statisticType = "sum";
	// count'|'sum'|'min'|'max'|'avg'|'stddev'
	statDef.onStatisticField = "mj";
	statDef.outStatisticFieldName = "sumMj";
	queryStatistic.outStatistics = [ statDef ];
	queryStatistic.ReturnGeometry = false;
	queryStatistic.orderByFields = [ "sumMj DESC" ];
	QTask.execute(queryStatistic, ShowQueryStatisticAllType);
}

function ShowQueryStatisticAllType(results) {
	// 详细分类
	hashTabPic();
	var resultCount = results.features.length;
	var zmj = 0;

	for (var i = 0; i < resultCount; i++) {
		var attr = results.features[i].attributes;
		var sumMj = attr.sumMj;
		zmj = zmj + sumMj;
	}
	var tr_head = $('<tr></td><td class="grid_td">' + "图例"
			+ '</td><td class="grid_td">' + "地类名称"
			+ '</td><td class="grid_td">' + "面积(亩)"
			+ '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
	$('#show_grid0').append(tr_head);
	var tr_head2 = $('<tr><td class="grid_td">' + "  "
			+ '</td><td class="grid_td">' + "总面积" + '</td><td class="grid_td">'
			+ (zmj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">'
			+ "100%" + '</td></tr>');
	$('#show_grid0').append(tr_head2);
	var arrayObj = [];
	for (var i = 0; i < resultCount; i++) {
		var DLMC = results.features[i].attributes.DLMC;
		var sumMj = results.features[i].attributes.sumMj;
		var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";
		var imageurl = hashTabPic.items(DLMC);
		var trl = $('<tr><td class="grid_td"><img src="../static/image/dilei/'
				+ imageurl + '.jpg"/></td><td class="grid_td">' + DLMC
				+ '</td><td class="grid_td">' + (sumMj * 3 / 2000).toFixed(2)
				+ '</td><td class="grid_td_right">' + percert + '</td></tr>');
		$('#show_grid0').append(trl);

		arrayObj.push({
			"lable" : DLMC,
			"value" : DLMC
		});
	}
	$('#DLMC').combobox({
		textField : 'lable',
		valueField : 'value',
		width : 100
	});
	$("#DLMC").combobox("loadData", arrayObj);
}
function createLayers() {
	var template = new arcgisObj.InfoTemplate();
	template.setTitle("地块信息");
	template.setContent(getTextContent());
	var dikuailayer=new arcgisObj.FeatureLayer(dynamicUrl+'/0', {
		mode: arcgisObj.FeatureLayer.MODE_ONDEMAND
	});
	var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/1', {
		mode: arcgisObj.FeatureLayer.MODE_ONDEMAND,
		"opacity" :1,
		outFields : getOutFields(),
		infoTemplate : template
	});

	var layers =[dikuailayer,eventLayer];
	layerClick(eventLayer);
	map.addLayers(layers);
	
}

function handleArea(mj) {
	return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
}

function handleClass(sdl) {
	if (sdl == 1) {
		return '农用地';
	} else if (sdl == 2) {
		return '建设用地';
	} else if (sdl == 3) {
		return '未利用地';
	}
}

function getDisplayModel(remark, column) {
	return '<strong>' + remark + ':</strong>${' + column + '}<br>';
}

function getTextContent() {
	return "<strong>三大类:</strong>${SDL:handleClass}<br>"
			+ getDisplayModel('地类名称', 'DLMC')
			+ "<strong>面积:</strong>${mj:handleArea}";
}

function getOutFields() {
	return [ "QSDWMC", "SZSX", "DLBM", "DLMC", "SDL", "mj" ];
}

function createMap() {

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

	var home = new arcgisObj.HomeButton({
		map : map
	}, "HomeButton");
	home.startup();

	createLayers();
	
	
	new arcgisObj.Scalebar({
		map : map,
		attachTo : "bottom-left",
		scalebarUnit : "metric"
	});
}

function areaStatisticsSdl() {
	// 统计基础地类
	var QTask = new esri.tasks.QueryTask(dynamicUrl + "/1");
	var queryStatistic = new esri.tasks.Query();
	queryStatistic.outFields = [ "*" ];
	queryStatistic.groupByFieldsForStatistics = [ "SDL" ];
	var statDef = new esri.tasks.StatisticDefinition();
	statDef.statisticType = "sum";
	// count'|'sum'|'min'|'max'|'avg'|'stddev'
	statDef.onStatisticField = "mj";
	statDef.outStatisticFieldName = "sumMj";
	queryStatistic.outStatistics = [ statDef ]; // statDef0,
	queryStatistic.ReturnGeometry = false;
	queryStatistic.orderByFields = [ "sumMj DESC" ];

	QTask.execute(queryStatistic, ShowQueryStatisticSdl);
}

//基础分类
function ShowQueryStatisticSdl(results) {
	var resultCount = results.features.length;
	var zmj = 0;

	for (var i = 0; i < resultCount; i++) {
		var attr = results.features[i].attributes;
		var sumMj = attr.sumMj;
		zmj = zmj + sumMj;
	}
	
	$('#show_grid').empty();
	var tr_head = $('<tr></td><td class="grid_td">' + "图例"
			+ '</td><td class="grid_td">' + "地类名称"
			+ '</td><td class="grid_td">' + "面积(亩)"
			+ '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
	$('#show_grid').append(tr_head);
	var tr_head2 = $('<tr><td class="grid_td">' + "  "
			+ '</td><td class="grid_td">' + "总面积" + '</td><td class="grid_td">'
			+ (zmj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">'
			+ "100%" + '</td></tr>');
	$('#show_grid').append(tr_head2);
	for (var i = 0; i < resultCount; i++) {
		var DLMC = results.features[i].attributes.SDL;
		var sumMj = results.features[i].attributes.sumMj;
		var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";

		var imageurl = hashTab.items(DLMC);
		var trl = $('<tr><td class="grid_td"><img src="' + dynamicUrl
				+ '/1/images/' + imageurl + '"/></td><td class="grid_td">'
				+ handleClass(DLMC) + '</td><td class="grid_td">'
				+ (sumMj * 3 / 2000).toFixed(2)
				+ '</td><td class="grid_td_right">' + percert + '</td></tr>');
		$('#show_grid').append(trl);
	}
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


function buildWhere() {
	return " DLMC = '" + $('#DLMC').combobox('getValue') + "'";
}

function parseMu(centiare) {
	return (parseFloat(centiare) / 666.67).toFixed(2);
}

function toCentiare(mu) {
	return (parseFloat(mu) * 666.67);
}

// 查找详细地块类型
function landSearch() {
	var queryTask = new arcgisObj.QueryTask(dynamicUrl + '/0');
	var query = new arcgisObj.Query();
	query.returnGeometry = true;
	query.maxAllowableOffset = 10;
	query.num = 2000;
	query.outFields = getOutFields();
	query.where = buildWhere();
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
				displayResult(queryResult);
			} else {
				$.messager.alert('提示', '没有符合条件的地块', 'info');
			}
		}
	});

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

/**
 * @param queryResult
 * @returns
 */
function displayResult(queryResult) {
	map.graphics.clear();
	map.infoWindow.hide();
	for ( var index in queryResult) {
		var feature = queryResult[index].feature;
		var highlightSymbol = new arcgisObj.SimpleFillSymbol(
				arcgisObj.SimpleFillSymbol.STYLE_SOLID,
				new arcgisObj.SimpleLineSymbol(
						arcgisObj.SimpleLineSymbol.STYLE_SOLID,
						new arcgisObj.Color([ 47, 79, 177 ]), 1),
				new arcgisObj.Color([ 125, 125, 125, 0.35 ]));
		var highlightGraphic = new arcgisObj.Graphic(feature.geometry,
				highlightSymbol);

		var template = new arcgisObj.InfoTemplate();
		template.setTitle("地块信息");
		template.setContent(getShowContent(feature.attributes));

		highlightGraphic.setInfoTemplate(template);
		map.graphics.add(highlightGraphic);

	}
	map.setExtent(getExtent(queryResult));
}

function getShowContent(attribute) {
	var content = '';
	content += '<strong>三大类:</strong>' + handleClass(attribute.SDL) + '<br>';
	content += '<strong>地类名称：</strong>' + attribute.DLMC + '<br>';
	content += '<strong>面积：</strong>' + parseMu(attribute.mj) + '亩';
	return content;
}

function areaStatisticsThreeType() {
	var restURL = dynamicUrl + "/legend";// 构建的REST URL
	 $.ajax({
	        url:restURL,
	        type: 'POST',
	        dataType: 'json',
	        data:{"f":'json'},
	        success: function (data, status) {
	            var layerlegend = data.layers[1].legend;
	            console.log(layerlegend.length);
	            for (var i = 0; i < layerlegend.length; i++) {
	                hashTab.add(layerlegend[i].values[0], layerlegend[i].url);
	            }
	            areaStatisticsSdl();
	        },
	        error: function (data, status, e) {
	            alert(e);
	        }
	    })
}

function HashTable() {
	this._hash = new Object();
	this.add = function(key, value) {
		if (typeof (key) != "undefined") {
			if (this.contains(key) == false) {
				this._hash[key] = typeof (value) == "undefined" ? null : value;
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	};
	this.update = function(key, value) {
		if (typeof (key) != "undefined") {
			if (this.contains(key) == true) {
				this.remove(key);
				this.add(key, value);
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	};
	// /删除
	this.remove = function(key) {
		delete this._hash[key];
	};
	// /记录条数
	this.count = function() {
		var i = 0;
		for ( var k in this._hash) {
			i++;
		}
		return i;
	};

	this.indexValue = function(index) {
		var i = 0;
		for ( var k in this._hash) {
			if (i == index) {
				return this._hash[k];
			}
			i++;
		}
	};

	// /返回值、根据KEY值来返回
	this.items = function(key) {
		return this._hash[key];
	};

	// /是否存在true or false;
	this.contains = function(key) {
		return typeof (this._hash[key]) != "undefined";
	};
	// /清空
	this.clear = function() {
		for ( var k in this._hash) {
			delete this._hash[k];
		}
	};
}

function hashTabPic() {
	hashTabPic = new HashTable();
	hashTabPic.add("采矿用地", "ckyd");
	hashTabPic.add("村庄", "cz");
	hashTabPic.add("风景名胜及特殊用地", "fjmsjtsyd");
	hashTabPic.add("风景名胜设施用地", "fjmsssyd");
	hashTabPic.add("港口码头用地", "gkmtyd");
	hashTabPic.add("公路用地", "glyd");
	hashTabPic.add("沟渠", "gq");
	hashTabPic.add("管道运输用地", "gdyyyd");
	hashTabPic.add("灌木林地", "gmld");
	hashTabPic.add("果园", "gy");
	hashTabPic.add("旱地", "hd");
	hashTabPic.add("河流水面", "hlsm");
	hashTabPic.add("建制镇", "jzz");
	hashTabPic.add("坑塘水面", "ktsm");
	hashTabPic.add("民用机场用地", "ukcud");
	hashTabPic.add("内陆滩涂", "nltt");
	hashTabPic.add("农村居民点用地", "ncjmdyd");
	hashTabPic.add("其他草地", "qtcd");
	hashTabPic.add("其他独立建设用地", "qtdljsyd");
	hashTabPic.add("其他林地", "qtld");
	hashTabPic.add("其他园地", "qtyd");
	hashTabPic.add("人工牧草地", "rgmcd");
	hashTabPic.add("设施农用地", "ssnyd");
	hashTabPic.add("水工建筑用地", "sgjzyd");
	hashTabPic.add("水浇地", "sjd");
	hashTabPic.add("水库水面", "sksm");
	hashTabPic.add("水田", "st");
	hashTabPic.add("天然牧草地", "trmcd");
	hashTabPic.add("铁路用地", "tlyd");
	hashTabPic.add("盐田", "yt");
	hashTabPic.add("有林地", "yld");
	hashTabPic.add("自然保留地", "zrbld");
}
