var map, hashTabPic;
var dynamicUrl;
// arcgis对象
var arcgisObj = {};

require(["esri/map", "esri/layers/FeatureLayer", "esri/geometry/Extent",
    "esri/tasks/query", "esri/tasks/QueryTask", "esri/symbols/SimpleFillSymbol",
    "esri/symbols/SimpleLineSymbol", "esri/renderers/SimpleRenderer",
    "esri/Color", "esri/graphic","esri/layers/ArcGISDynamicMapServiceLayer",
    "esri/dijit/Scalebar","esri/dijit/InfoWindowLite", "esri/InfoTemplate",
    "esri/dijit/HomeButton","dojo/domReady!"], function(Map,FeatureLayer, 
    Extent, Query, QueryTask, SimpleFillSymbol,SimpleLineSymbol,
    SimpleRenderer, Color, Graphic,ArcGISDynamicMapServiceLayer, Scalebar,
    InfoWindowLite, InfoTemplate,HomeButton) {
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
    arcgisObj.HomeButton = HomeButton;
    // 创建地图
    dynamicUrl = server151URL + '/hnnc_dltb/MapServer';

    createMap();
    areaStatistics();
});

function createLayers() {

    var dynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(dynamicUrl);

    var template = new arcgisObj.InfoTemplate();
    template.setTitle("地块信息");
    template.setContent(getTextContent());

    var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/3', {
        "opacity": 0.2,
        outFields: getOutFields(),
        infoTemplate: template
    });

    var layers = null;
    layers = [dynamicLayer, eventLayer];
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
    return "<strong>三大类:</strong>${SDL}<br>" + getDisplayModel('地类名称', 'DLMC') + "<strong>面积:</strong>${Shape.STArea():handleArea}";
}

function getOutFields() {
    return ["SDL", "DLMC", "Shape.STArea()"];
}

function createMap() {
    var bounds = new arcgisObj.Extent({
        "xmin": 145237.58274757327,
        "ymin": 1993164.6357388513,
        "xmax": 626251.0447744974,
        "ymax": 2373636.2300153733,
        "spatialReference": {
            "wkid": 2382
        }
    });

    map = new arcgisObj.Map("mapDiv", {
        extent: bounds
    });

    var home = new arcgisObj.HomeButton({
        map: map
    }, "HomeButton");
    home.startup();

    new arcgisObj.Scalebar({
        map: map,
        attachTo: "bottom-left",
        scalebarUnit: "metric"
    });

    createLayers();
}

function layerClick(fl) {
    fl.on('click', function(evt) {
        map.graphics.clear();
        var highlightSymbol = new arcgisObj.SimpleFillSymbol(
            arcgisObj.SimpleFillSymbol.STYLE_SOLID,
            new arcgisObj.SimpleLineSymbol(
                arcgisObj.SimpleLineSymbol.STYLE_SOLID,
                new arcgisObj.Color([47, 79, 177]), 1),
            new arcgisObj.Color([125, 125, 125, 0.35]));
        var highlightGraphic = new arcgisObj.Graphic(evt.graphic.geometry,
            highlightSymbol);
        map.graphics.add(highlightGraphic);
    });
}

function areaStatistics() {
    // 统计详细分类
    var QTask = new esri.tasks.QueryTask(dynamicUrl + "/3");
    var queryStatistic = new esri.tasks.Query();
    queryStatistic.outFields = ["*"];
    queryStatistic.groupByFieldsForStatistics = ["DLMC"];

    var statDef = new esri.tasks.StatisticDefinition();
    statDef.statisticType = "sum";
    // count'|'sum'|'min'|'max'|'avg'|'stddev'
    statDef.onStatisticField = "Shape.STArea()";
    statDef.outStatisticFieldName = "sumMj";
    queryStatistic.outStatistics = [statDef]; // statDef0,
    queryStatistic.ReturnGeometry = false;
    queryStatistic.orderByFields = ["sumMj DESC"];
    QTask.execute(queryStatistic, ShowQueryStatistic);
}

function ShowQueryStatistic(results) {
    // 详细分类
    hashTabPic();
    var resultCount = results.features.length;
    var zmj = 0;

    for (var i = 0; i < resultCount; i++) {
        var attr = results.features[i].attributes;

        var sumMj = attr.sumMj;
        zmj = zmj + sumMj;

    }
    $('#show_grid0').empty();

    var tr_head = $('<tr></td><td class="grid_td">' + "图例" + '</td><td class="grid_td">' + "地类名称" + '</td><td class="grid_td">' + "面积(亩)" + '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
    $('#show_grid0').append(tr_head);
    var tr_head2 = $('<tr><td class="grid_td">' + "  " + '</td><td class="grid_td">' + "总面积" + '</td><td class="grid_td">' + (zmj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + "100%" + '</td></tr>');
    $('#show_grid0').append(tr_head2);
    var arrayObj = [];
    for (var i = 0; i < resultCount; i++) {
        var DLMC = results.features[i].attributes.DLMC;
        // var count = results.features[i].attributes.count;
        var sumMj = results.features[i].attributes.sumMj;
        var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";
        var imageurl = hashTabPic.items(DLMC);
        var trl = $('<tr><td class="grid_td"><img src="../static/image/dilei/' + imageurl + '.jpg"/></td><td class="grid_td">' + DLMC + '</td><td class="grid_td">' + (sumMj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + percert + '</td></tr>');

        $('#show_grid0').append(trl);

        arrayObj.push({
            "lable": DLMC,
            "value": DLMC
        });

    }

}

function cauculatePercent(num, total) {
    return parseFloat((num / total) * 100).toFixed(2) + '%';
}

function showData(array) {
    $('#show_grid').empty();
    for (var index in array) {
        var remark = array[index].remark;
        var percent = array[index].percent;
        var value = array[index].value;
        var clazz = 'clazz' + (parseInt(index));
        var tr = $('<tr><td class="grid_td"><span class="' + clazz + '">&nbsp&nbsp&nbsp</span></td><td class="grid_td">' + remark + '</td><td class="grid_td">' + value + '</td><td class="grid_td_right">' + percent + '</td></tr>');
        $('#show_grid').append(tr);
    }
}

function getQueryData() {
    var queryData = {};
    queryData.task = new arcgisObj.QueryTask(dynamicUrl + '/3');
    queryData.outFields = ["DLMC"];
    queryData.where = buildWhere();
    return queryData;
}

function buildWhere() {
    return " QSDWMC like '" + '%' + $('#QSDWMC').val() + '%' + "'";
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

        map.graphics.add(highlightGraphic);

    }
    map.setExtent(getExtent(queryResult));
}

function getShowContent(attribute) {
    var content = '';
    content += '<strong>三大类:</strong>' + handleClass(attribute.SDL) + '<br>';
    content += '<strong>地类名称：</strong>' + attribute.DLMC + '<br>';
    content += '<strong>面积：</strong>' + parseMu(attribute["Shape.STArea()"]) + '亩';
    return content;
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
    hashTabPic.add("机场用地", "jcyd");
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
    hashTabPic.add("沙地", "sd");
    hashTabPic.add("湖泊水面", "hpsm");
    hashTabPic.add("茶园", "cy");
    hashTabPic.add("沼泽地", "sd");
    hashTabPic.add("裸地", "sd");
    hashTabPic.add("城市", "jzz");
    hashTabPic.add("沿海滩涂", "hlsm");
    hashTabPic.add("农村道路", "ncdl");
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