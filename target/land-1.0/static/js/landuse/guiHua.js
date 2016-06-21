var map;
var dynamicUrl;
var hashTab = new HashTable();
var arcgisObj = {};

require(["esri/map", "esri/layers/FeatureLayer", "esri/geometry/Extent",
    "esri/tasks/query", "esri/tasks/QueryTask", "dojo/on",
    "esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol",
    "esri/renderers/SimpleRenderer", "esri/Color", "esri/graphic",
    "esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar",
    "esri/dijit/InfoWindowLite", "esri/InfoTemplate",
    "esri/dijit/HomeButton",
    "dojo/domReady!"], function(Map, FeatureLayer, Extent, Query,
    QueryTask, on, SimpleFillSymbol, SimpleLineSymbol, SimpleRenderer,
    Color, Graphic, ArcGISDynamicMapServiceLayer, Scalebar,
    InfoWindowLite, InfoTemplate,HomeButton) {
    arcgisObj.Map = Map;
    arcgisObj.FeatureLayer = FeatureLayer;
    arcgisObj.Extent = Extent;
    arcgisObj.Query = Query;
    arcgisObj.QueryTask = QueryTask;

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
    // 创建地图
    dynamicUrl = server151URL + '/GuiHua_shidian/MapServer';
    var startTime = new Date().getMilliseconds();
    
    farmcombobox();
    createMap();
    AreaStatistic(); // 获取图例信息
    var endTime = new Date().getMilliseconds();
    var dates = endTime-startTime;
    console.log(dates);
});


function createLayers() {
    var template = new arcgisObj.InfoTemplate();
    template.setTitle("地块信息");
    template.setContent(getTextContent());

    var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
        "opacity": 1,
        outFields: getOutFields(),
        infoTemplate: template
    });
    var boundaryLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/1', {
        "opacity": 1
    });
    var layers = [boundaryLayer, eventLayer];
    return layers;
}

function handleArea(mj) {
    return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
}

function getTextContent() {
    return "<strong>农场名称:</strong>${NCMC}<br>" + '<strong>地类名称 :</strong>${firstTypeN}<br>' + "<strong>面积:</strong>${Shape.STArea():handleArea}";
}

function getOutFields() {
    return ["farmCode", "NCMC", "firstTypeN", "Shape.STArea()"];
}

function createMap() {
    var bounds = new arcgisObj.Extent({
        "xmin": 284117.861800,
        "ymin": 2026660.287000,
        "xmax": 464802.548300,
        "ymax": 2201218.343400,
        "spatialReference": {
            "wkid": 2382
        }
    });

    map = new arcgisObj.Map("mapDiv", {
        extent: bounds,
        logo: false
    });

    var home = new arcgisObj.HomeButton({
        map: map,
    }, "HomeButton");
    home.startup();

    var layers = createLayers();
    map.addLayers(layers);

    new arcgisObj.Scalebar({
        map: map,
        attachTo: "bottom-left",
        scalebarUnit: "metric"
    });
    
}

function AreaStatisticsDiKuai(farmNo) {
    // 统计基础地类
    var QTask = new esri.tasks.QueryTask(dynamicUrl + "/0");

    var queryStatistic = new esri.tasks.Query();
    queryStatistic.outFields = ["*"];
    if (farmNo != null && farmNo != undefined) {
        queryStatistic.where = "farmCode=" + farmNo;
    }
    // 要统计的地块类型
    queryStatistic.groupByFieldsForStatistics = ["firstTypeN"];

    var statDef = new esri.tasks.StatisticDefinition();
    statDef.statisticType = "sum";
    // count'|'sum'|'min'|'max'|'avg'|'stddev'
    statDef.onStatisticField = "Shape.STArea()";
    statDef.outStatisticFieldName = "sumMj";
    queryStatistic.outStatistics = [statDef];
    queryStatistic.ReturnGeometry = false;
    queryStatistic.orderByFields = ["sumMj DESC"];
    QTask.execute(queryStatistic, ShowQueryStatistic);
}
	/**
	 * 初始化农场选择下拉列表，当被选中时
	 */
function farmcombobox() {
    $('#farmName').combobox({
        url: '/land/landuse/guiHuaOrg', 
        method: 'GET',
        valueField: 'farmCode', 
        textField: 'NCMC', 
        onSelect: function(rec) {
            var farmNo = rec.farmCode;
            AreaStatistic(farmNo);
            landSearch(rec.NCMC);
        },
        onLoadSuccess: function() {
            var data = $('#farmName').combobox('getData');
            if (data.length == 1) {
                $("#farmName").combobox('select', data[0].code);
            }
        }
    });
}

// 地块统计信息
function ShowQueryStatistic(results) {
    var resultCount = results.features.length;
    var zmj = 0;
    for (var i = 0; i < resultCount; i++) {
        var attr = results.features[i].attributes;
        var sumMj = attr.sumMj;
        zmj = zmj + sumMj;
    }
    // 基础分类
    $('#show_grid').empty();
    var tr_head = $('<tr></td><td class="grid_td">' + "图例" + '</td><td class="grid_td">' + "地类名称" + '</td><td class="grid_td">' + "面积(亩)" + '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
    $('#show_grid').append(tr_head);
    var tr_head2 = $('<tr><td class="grid_td">' + "  " + '</td><td class="grid_td">' + "总面积" + '</td><td class="grid_td">' + (zmj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + "100%" + '</td></tr>');
    $('#show_grid').append(tr_head2);
    for (var i = 0; i < resultCount; i++) {
        // leixing即规划地类
        var leixing = results.features[i].attributes.firstTypeN;
        var sumMj = results.features[i].attributes.sumMj;
        var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";
        var imageurl = hashTab.items(leixing);
        var trl = $('<tr><td class="grid_td"><img src="' + dynamicUrl + '/0/images/' + imageurl + '"/></td><td class="grid_td">' + leixing + '</td><td class="grid_td">' + (sumMj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + percert + '</td></tr>');
        $('#show_grid').append(trl);
    }
}

function getQueryData(ncmc) {
    var queryData = {};
    queryData.task = new arcgisObj.QueryTask(dynamicUrl + '/0');
    queryData.outFields = ['NCMC'];
    queryData.where = buildWhere(ncmc);
    return queryData;
}

function buildWhere(ncmc) {
    where = " NCMC like '" + '%' + ncmc + '%' + "'";
    return where;
}

function parseMu(centiare) {
    return (parseFloat(centiare) / 666.67).toFixed(2);
}

function getExtent(queryResult) {
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
        }
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
function displayResult(queryResult) {
    map.graphics.clear();
    map.infoWindow.hide();
    for (var index in queryResult) {
        var feature = queryResult[index].feature;

        var highlightSymbol = new arcgisObj.SimpleFillSymbol(
            arcgisObj.SimpleFillSymbol.STYLE_SOLID,
            new arcgisObj.SimpleLineSymbol(
                arcgisObj.SimpleLineSymbol.STYLE_SOLID,
                new arcgisObj.Color([47, 79, 177]), 1),
            new arcgisObj.Color([125, 125, 125, 0.35]));
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
    var nnmc = attribute.NCMC;
    var dlmc = attribute.firstTypeN;
    var area = parseMu(attribute["Shape.STArea()"]);
    content += '<strong>农场名称:</strong>' + nnmc + '<br>';
    content += '<strong>地类名称：</strong>' + dlmc + '<br>';
    content += '<strong>面积：</strong>' + area + '亩';
    return content;
}

function landSearch(ncmc) {
    if (ncmc == "") ncmc = $('#NCMC').val();
    var queryData = getQueryData(ncmc);
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

function AreaStatistic(farmNo) {
	var lengendurl=dynamicUrl+'/legend';
    $.ajax({
        url:lengendurl,
        type: 'POST',
        dataType: 'json',
        data:{"f":'json'},
        success: function (data, status) {
            console.log(data);
            var layerlegend = data.layers[0].legend;
            console.log(layerlegend.length);
            for (var i = 0; i < layerlegend.length; i++) {
                hashTab.add(layerlegend[i].values[0], layerlegend[i].url);
            }
            AreaStatisticsDiKuai(farmNo);
        },
        error: function (data, status, e) {
            alert(e);
        }
    })
}

function HashTable() {
    this._hash = new Object();
    this.add = function(key, value) {
        if (typeof(key) != "undefined") {
            if (this.contains(key) == false) {
                this._hash[key] = typeof(value) == "undefined" ? null : value;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    };
    this.update = function(key, value) {
        if (typeof(key) != "undefined") {
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
        for (var k in this._hash) {
            i++;
        }
        return i;
    };

    this.indexValue = function(index) {
        var i = 0;
        for (var k in this._hash) {
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
        return typeof(this._hash[key]) != "undefined";
    };
    // /清空
    this.clear = function() {
        for (var k in this._hash) {
            delete this._hash[k];
        }
    };
}