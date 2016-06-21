var map, template,legend, visible = [];
var ht;
// arcgis对象
var arcgisObj = {};
var dynamicUrl, imageUrl, imageServiceLayer;
var zdCode = 0;
var ncCode = 0;
var tzzdCode, tzbcCode;
require(
    ["esri/map", "esri/arcgis/utils", "esri/layers/FeatureLayer",
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
        "dojo/domReady!"],
    function(Map, arcgisUtils, FeatureLayer, Extent, Query, QueryTask,
        dom, on, SimpleFillSymbol, SimpleLineSymbol,
        SimpleRenderer, Color, Graphic,
        ArcGISDynamicMapServiceLayer, Scalebar,
        ArcGISImageServiceLayer, InfoWindowLite, InfoTemplate,
        HomeButton, TOC) {
        arcgisObj.Map = Map;
        arcgisObj.arcgisUtils = arcgisUtils;
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
        
        arcgisObj.TOC=TOC;
        // 创建地图
        imageUrl = "http://10.215.201.151:6080/arcgis/rest/services/HnncImage_HainanPj/ImageServer"; // 影像数据
        dynamicUrl = "http://10.215.201.151:6080/arcgis/rest/services/zyjj_hnnc_20150811/MapServer"; // 动态
        ht = {
            "333": {
                "bounds": new Extent({
                    "xmin": 53181,
                    "ymin": 41483,
                    "xmax": 75759,
                    "ymax": 67652,
                    "spatialReference": {
                        "wkid": 2382
                    }
                })
            },
            "319": {
                "bounds": new Extent({
                    "xmin": 130278,
                    "ymin": 168190,
                    "xmax": 147024,
                    "ymax": 200981,
                    "spatialReference": {
                        "wkid": 2382
                    }
                })
            },
            "302": {
                "bounds": new Extent({
                    "xmin": 216490,
                    "ymin": 160525,
                    "xmax": 231020,
                    "ymax": 177448,
                    "spatialReference": {
                        "wkid": 2382
                    }
                })
            }
        };

        createbaseMap(); // 建立新地图
        areaStatisticsrow();
        findcombobox();
        landSearchNew(); // 如果是合同信息跳转至此,进入此函数判断
    });


function findcombobox() {
        $('#FarmName').combobox({
            url : '/land/thematicMap/zyjjOrg',
            method: 'GET',
            valueField: 'farmCode',
            textField: 'NCMC',
            onSelect: function(rec) {
            	if(rec!=undefined){
            		var value = rec.farmCode;
            		var bounds = ht[value]["bounds"];
            		map.setExtent(bounds);
            	}	
            },
            onLoadSuccess: function(rec) {
                var data = $('#FarmName').combobox('getData');
                $("#FarmName").combobox('select', data[0].code);
            }
        })   
}


function createLayers() {
    template = new arcgisObj.InfoTemplate();
    template.setTitle("地块信息");
    template.setContent(getTextContent());

    var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
        mode: arcgisObj.FeatureLayer.MODE_ONDEMAND,
        "opacity": 0.8,
        outFields: getOutFields(),
        infoTemplate: template
    });
    var layers;

    if (imageUrl != "") {
        imageServiceLayer = new esri.layers.ArcGISImageServiceLayer(imageUrl);
        layers = [imageServiceLayer, eventLayer];

    } else {
        layers = [eventLayer];
    }
    map.addLayers(layers);
    
    return eventLayer;
}

function handleArea(mj) {
    return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩'; // 平方米转换成亩
}

function handleClass(sdl) { // 地类类型设置
    if (sdl == 1) {
        return '农用地';
    } else if (sdl == 2) {
        return '建设用地';
    } else if (sdl == 3) {
        return '未利用地';
    }
}

function getDisplayModel(remark, column) {

    return '<strong>' + remark + ':</strong>${' + column + '}<br>'; // 模板一行,字段名+值

}

function handleArea0(zdh) { // 将宗地号设为全局
    zdCode = zdh;
    return zdCode;
}

function handleArea1(nch) { // 将农场号设为全局变量
    ncCode = nch;
    return ncCode;
}

function getTextContent() { // 信息内容表
    return content= "<strong>农场编号:</strong>${farmcode:handleArea1}<br>" +
                    "<strong>地块编号:</strong>${DKBH:handleArea0}" + 
                    "<a class='easyui-linkbutton'  href='#' onclick='newcontract()'>跳转至合同</a><br>"
                    + getDisplayModel('农场名称', 'NCMC') 
                    + getDisplayModel('户主', 'HZ') 
                    + getDisplayModel('地类名称', 'DLMC')
                    +"<strong>面积:</strong>${mj:handleArea}<br>";
}

function newcontract() { // 从宗地跳转至合同
    isMenuClick = true;
    var url = '../land/contract/contractQuery';
    if (zdCode <= 0) {
    	$.messager.alert("宗地号为空，不能跳转。");
        return;
    }
    var title = '合同信息查询';
    var flag = parent.$("#mainTabs").tabs('exists', title); // 判断合同信息框是否已经加载,如加载,先关闭
    if (flag) {
        parent.$("#mainTabs").tabs('close', title);
    }
    parent.$("#mainTabs").tabs('add', {
        title: title,
        href: url + "?farmCode=" + ncCode + "&placeCode=" + zdCode, // 加载合同信息tab
        closable: true,
        cache: true
    });
    return;
}

function getOutFields() { // 输出字段
    return ["pa_org", "pa_num", "pa_type", "pa_use", "pa_plant_d", "farmcode",
        "NCMC", "SZSS", "DLMC", "DKBH", "HZ", "SCDMC", "SCDBH", "mj"
    ];
}
// "dual" displays both miles and kilmometers
// "english" is the default, which displays miles
// use "metric" for kilometers
function createbaseMap() {

    map = new arcgisObj.Map("mapDiv");
    
    var home = new arcgisObj.HomeButton({ // 全图
        map: map
    }, "HomeButton");
    home.startup();

    new arcgisObj.Scalebar({ // 比例尺
        map: map,
        attachTo: "bottom-left",
        scalebarUnit: "metric"
    });
    var layer=createLayers();;
	var layerInfo=[ {
		layer : layer,
		title : "自营经济"
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
        $.messager.alert(e);
        }
     });	
}

function areaStatisticsrow() { // 统计
    var QTask = new esri.tasks.QueryTask(dynamicUrl + "/0");
    var queryStatistic = new esri.tasks.Query();
    queryStatistic.outFields = ["*"];
    queryStatistic.groupByFieldsForStatistics = ["DLMC"]; // 按照地类名称统计
    var statDef = new esri.tasks.StatisticDefinition();
    statDef.statisticType = "sum"; // 可以统计平均值,最大值,最小值,数量
    statDef.onStatisticField = "mj";
    statDef.outStatisticFieldName = "sumMj"; // 输出字段名
    queryStatistic.outStatistics = [statDef]; // statDef0,
    queryStatistic.ReturnGeometry = false;
    queryStatistic.orderByFields = ["sumMj DESC"]; // 排序
    QTask.execute(queryStatistic, ShowQueryStatistic);
}

function ShowQueryStatistic(results) {
    var resultCount = results.features.length;
    var zmj = 0;
    for (var i = 0; i < resultCount; i++) { // 将所有面积相加即为总数
        var attr = results.features[i].attributes;
        var sumMj = attr.sumMj;
        zmj = zmj + sumMj;
    }
    $('#show_grid').empty();
    var tr_head = $('<tr><td class="grid_td">' + "地类名称" + '</td><td class="grid_td">' + "面积(亩)" + '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
    $('#show_grid').append(tr_head);
    var tr_head2 = $('<tr><td class="grid_td">' + "总面积" + '</td><td class="grid_td">' + (zmj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + "100%" + '</td></tr>');
    $('#show_grid').append(tr_head2);
    for (var i = 0; i < resultCount; i++) { // 循环统计,加载至表格
        var attr = results.features[i].attributes;
        var DLMC = attr.DLMC;
        var sumMj = attr.sumMj;
        var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";
        if (DLMC) {
            // 百分比,取两位小数
            var trl = $('<tr><td class="grid_td">' + DLMC + '</td><td class="grid_td">' + (sumMj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + percert + '</td></tr>');
            $('#show_grid').append(trl);
        }
    }
}

function getQueryData() {
    var queryData = {};
    queryData.task = new arcgisObj.QueryTask(dynamicUrl + "/0");
    queryData.outFields = ['DKBH'];
    queryData.where = buildWhere();
    return queryData;
}

function getConditions() {
    var conditions = [];
    $('.conditions').each(function() {
        var name = $(this).attr('name');
        var value = $(this).val();
        var condition = {
            name: name,
            value: value
        };
        conditions.push(condition);
    });
    return conditions;
}

function buildWhere() {
    var conditions = getConditions();
    var where = '';
    for (var index in conditions) {
        var condition = conditions[index];
        if (!condition.value || condition.value.length == 0)
            continue;
        if (where.length > 0) {
            where += ' and ';
        }
        if (condition.name == 'minmj') {
            where += 'mj > ' + toCentiare(condition.value);
        } else if (condition.name == 'maxmj') {
            where += 'mj < ' + (parseFloat(condition.value) * 666.67);
        } else {
            where += (condition.name + "='" + condition.value + "' ");
        }
    }
    return where;
}

function parseMu(centiare) {
    return (parseFloat(centiare) / 666.67).toFixed(2);
}

function toCentiare(mu) {
    return (parseFloat(mu) * 666.67);
}

function landSearch() {
    var queryData = getQueryData();
    var queryTask = queryData.task;
    var query = new arcgisObj.Query();
    query.returnGeometry = true;
    query.maxAllowableOffset = 10;
    query.num = 2000;
    query.outFields = getOutFields();
    query.where = queryData.where;
    var queryResult = [];
    queryTask.execute(query, function(results) {
        if (results.features) {
            for (var index in results.features) {
                var feature = results.features[index];
                var extent = feature.geometry.getExtent();
                var result = {
                    extent: extent,
                    feature: feature
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

// 加载时,先判断是否是合同信息跳转过来的
function landSearchNew() {
    var url = location.search;
    var Request = new Object();
    if (url.indexOf("?") != -1) { // 判断是否有参数
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            Request[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
        }
    } else {
        return;
    }
    tzzdCode = Request["zdCode"]; // 取出参数
    tzncCode = Request["ncCode"];
    queryLand(); // 地图加载慢,等待了3秒
}

function queryLand() {
    var zdCodes = tzzdCode.split(","); // 多个地块用,分隔
    var queryData = {};
    queryData.task = new arcgisObj.QueryTask(dynamicUrl + "/0");
    queryData.outFields = ['DKBH'];
    if (zdCodes.length == 1) {

        queryData.where = "farmcode='" + tzncCode + "' and " + "DKBH='" + tzzdCode + "'";

    } else if (zdCodes.length > 1) {
        /*
         * 当宗地号大于一个时，sql为farmcode='313' and (DKBH='2323' or DKBH='545')(举例)
         */
        queryData.where = "farmcode='" + tzncCode + "' and (DKBH='" + zdCodes[0] + "'";
        for (var j = 1; j < zdCodes.length; j++) {
            queryData.where += " or DKBH='" + zdCodes[j] + "'";
        } // 初始化查询参数
        queryData.where += ")";
    }
    var queryTask = queryData.task; // 开始查询
    var query = new arcgisObj.Query();
    query.returnGeometry = true; // 返回图形
    query.maxAllowableOffset = 10;
    query.num = 2000; // 最大数
    query.outFields = getOutFields(); // 输出字段
    query.where = queryData.where;
    var queryResult = [];
    queryTask.execute(query, // 执行结果
        function(results) {
            if (results.features) {
                for (var index in results.features) {
                    var feature = results.features[index];
                    var extent = feature.geometry.getExtent();

                    var result = {
                        extent: extent,
                        feature: feature
                    };
                    queryResult.push(result); // 结果集添加至queryResult
                }
                if (queryResult.length > 0) {
                    displayResult(queryResult); // 显示结果
                } else {
                    $.messager.alert('提示', '没有符合条件的地块', 'info');
                }
            }
        });
}

function getExtent(queryResult) { // 获取结果集的范围
    var xmin = 0;
    var ymin = 0;
    var xmax = 0;
    var ymax = 0;
    for (var index in queryResult) {
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
        } // 判断图形范围,选取所以图形的最小最大坐标当显示范围
        xmin = (xmin > extent.xmin ? extent.xmin : xmin);
        ymin = (ymin > extent.ymin ? extent.ymin : ymin);
        xmax = (xmax > extent.xmax ? xmax : extent.xmax);
        ymax = (ymax > extent.ymax ? ymax : extent.ymax);
    }
    return new arcgisObj.Extent({
        "xmin": xmin,
        "ymin": ymin,
        "xmax": xmax,
        "ymax": ymax,
        "spatialReference": {
            "wkid": 2382
        }
    });
}

/**
 * @param queryResult
 * @returns
 */
function displayResult(queryResult) { // 设置显示结果的符合颜色等
    map.graphics.clear();
    map.infoWindow.hide();
    for (var index in queryResult) {
        var feature = queryResult[index].feature;
        var highlightSymbol = new arcgisObj.SimpleFillSymbol(
            arcgisObj.SimpleFillSymbol.STYLE_SOLID,
            new arcgisObj.SimpleLineSymbol(
                arcgisObj.SimpleLineSymbol.STYLE_SOLID,
                new arcgisObj.Color([0, 255, 255]), 1),
            new arcgisObj.Color([0, 255, 255, 1]));
        var highlightGraphic = new arcgisObj.Graphic(feature.geometry,
            highlightSymbol);

        var template = new arcgisObj.InfoTemplate();
        template.setTitle("地块信息");
        template.setContent(getShowContent(feature.attributes)); // 设置结果集的信息框
        highlightGraphic.setInfoTemplate(template);
        map.graphics.add(highlightGraphic);

    }
    map.setExtent(getExtent(queryResult));

}

function getShowContent(attribute) { // /结果集的弹出信息框
    var content = '';
    zdCode = attribute.DKBH;
    ncCode = attribute.farmcode;
    content += "<strong>农场编号:</strong>" + attribute.farmcode + "<br>";
    content += '<strong>地块编号:</strong>' + attribute.DKBH;
    content += "<a class='easyui-linkbutton'  href='#' onclick='newcontract()'>跳转至合同</a><br>";
    content += '<strong>农场名称：</strong>' + attribute.NCMC + '<br>';
    content += '<strong>户主：</strong>' + attribute.HZ + '<br>';
    content += '<strong>地类名称：</strong>' + attribute.DLMC + '<br>';
    content += '<strong>面积：</strong>' + parseMu(attribute.mj) + '亩';

    return content;
}