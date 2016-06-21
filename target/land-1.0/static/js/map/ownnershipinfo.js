var map, imageUrl;
// arcgis对象
var arcgisObj = {};
var dynamicUrl = "";
var imageServiceLayer = "";

require(["esri/map", "esri/layers/FeatureLayer", "esri/geometry/Extent",
        "esri/tasks/query", "esri/tasks/QueryTask", "dojo/on",
        "esri/symbols/SimpleFillSymbol","esri/symbols/SimpleLineSymbol",
        "esri/Color","esri/graphic",
        "esri/layers/ArcGISDynamicMapServiceLayer",
        "esri/dijit/Scalebar", "esri/InfoTemplate",
        "esri/dijit/Legend", "esri/dijit/HomeButton",
        "esri/layers/ArcGISImageServiceLayer", "agsjs/dijit/TOC",
        "dojo/domReady!"],function (Map, FeatureLayer, Extent, Query,
        QueryTask, on,SimpleFillSymbol, SimpleLineSymbol, Color, Graphic,
        ArcGISDynamicMapServiceLayer, Scalebar, InfoTemplate,Legend, 
        HomeButton, ArcGISImageServiceLayer, TOC) {
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

        arcgisObj.InfoTemplate = InfoTemplate;

        arcgisObj.Legend = Legend;

        arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
        arcgisObj.HomeButton = HomeButton;
        arcgisObj.ArcGISImageServiceLayer = ArcGISImageServiceLayer;
        arcgisObj.TOC = TOC;
        dynamicUrl = server151URL + "/quanshu_hnnc/MapServer";
        imageUrl = server151URL + '/HnncImage_HainanPj/ImageServer';
        farmcombobox();
        createbaseMap();
        areaStatistics();
    });
/**
 * "dual" displays both miles and kilmometers "english" is the default, which
 * displays miles use "metric" for kilometers
 */
function createbaseMap() {
    var initialExtent = new arcgisObj.Extent({
        "xmin": 1335.8054999995384,
        "ymin": -2480.9595000010086,
        "xmax": 307860.2764999999,
        "ymax": 241665.52550000066,
        "spatialReference": {
            "wkid": 2382
        }
    });
    map = new arcgisObj.Map("mapDiv", {
        extent: initialExtent
    });

    var homebutton = new arcgisObj.HomeButton({
        map: map
    }, "HomeButton");
    homebutton.startup();

    new arcgisObj.Scalebar({
        map: map,
        attachTo: "bottom-left",
        scalebarUnit: "metric"
    });
    var layerInfo = createLayers();
    var tocElement = "tocDiv";

    map.on('layers-add-result', function (results) {
        try {
            var toc = new arcgisObj.TOC({
                map: map,
                layerInfos: layerInfo
            }, tocElement);
            toc.startup();
            console.log("开始设置图层控制");
        } catch (e) {
            alert(e);
        }
    });
}

function farmcombobox() {
    $('#farmName').combobox({
        url: '/land/ownnership/ownnershipOrg', // 数据是初始化农场名里的结果列表
        method: 'GET',
        valueField: 'farmCode', // id是编号
        textField: 'NCMC', // 农场名称
        onSelect: function (rec) {
            var value = rec.NCMC;
            var farmNo = rec.farmCode;
            map.graphics.clear();
            landSearch(value);
            areaStatistics(farmNo);
        },
        onLoadSuccess: function () {
            var data = $('#farmName').combobox('getData');
            if (data.length == 1) {
                $("#farmName").combobox('select', data[0].code);
            }
        }
    });
}

function createLayers() {
    template = new arcgisObj.InfoTemplate();
    template.setTitle("地块信息");
    template.setContent(getTextContent());

    var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
        "opacity": 1,
        outFields: getOutFields(),
        infoTemplate: template
    });
    var hainanLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/1', {
        "opacity": 1,
    });

    var imagelayer = new arcgisObj.ArcGISImageServiceLayer(imageUrl);
    var layers;
    layers = [imagelayer, hainanLayer, eventLayer];

    var layerInfo = [{
        layer: eventLayer,
        title: "权属地图"
    }, {
        layer: hainanLayer,
        title: "海南省界"
    }
    ];
    map.addLayers(layers);
    return layerInfo;
}

function handleArea(mj) {
    return (parseFloat(mj) * 3 / 2000).toFixed(2) + '亩';
}

function getDisplayModel(remark, column) {
    return '<strong>' + remark + ':</strong>${' + column + '}<br>';
}

function getTextContent() {
    return getDisplayModel('宗地号', 'ZDH') + getDisplayModel('使用权人', 'SYQR') + getDisplayModel('状态', 'QQZT') + "<strong>面积:</strong>${Shape.STArea():handleArea}";
}

function getOutFields() {
    return ["QQZT", "NCMC", "ZDH", "farmcode", "Shape.STArea()", "SYQR"];
}

function areaStatistics(farmNo) {
    var QTask = new esri.tasks.QueryTask(dynamicUrl + "/0");

    var queryStatistic = new esri.tasks.Query();
    queryStatistic.outFields = ["*"];
    if (farmNo != "" && farmNo != undefined) {
        queryStatistic.where = "farmcode=" + farmNo;
    }
    queryStatistic.groupByFieldsForStatistics = ["QQZT"];
    var statDef = new esri.tasks.StatisticDefinition();
    statDef.statisticType = "sum";
    statDef.onStatisticField = "Shape.STArea()";
    statDef.outStatisticFieldName = "sumMj";
    queryStatistic.outStatistics = [statDef];
    queryStatistic.ReturnGeometry = false;
    queryStatistic.orderByFields = ["sumMj DESC"];

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
    var tr_head = $('<tr><td class="grid_td">' + "地类名称" + '</td><td class="grid_td">' + "面积(亩)" + '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
    $('#show_grid').append(tr_head);
    var tr_head2 = $('<tr><td class="grid_td">' + "总面积" + '</td><td class="grid_td">' + (zmj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + "100%" + '</td></tr>');
    $('#show_grid').append(tr_head2);
    for (var i = 0; i < resultCount; i++) {
        var DLMC = results.features[i].attributes.QQZT;
        var sumMj = results.features[i].attributes.sumMj;
        var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";

        var trl = $('<tr><td class="grid_td">' + DLMC + '</td><td class="grid_td">' + (sumMj * 3 / 2000).toFixed(2) + '</td><td class="grid_td_right">' + percert + '</td></tr>');

        $('#show_grid').append(trl);
    }
}

function showData(array) {
    $('#show_grid').empty();
    for (var index in array) {
        var remark = array[index].remark;
        var percent = array[index].percent;
        var value = array[index].value;
        var tr = $('<tr><td class="grid_td">' + remark + '</td><td class="grid_td">' + value + '</td><td class="grid_td_right">' + percent + '</td></tr>');
        $('#show_grid').append(tr);
    }
}

function getConditions() {
    var conditions = [];
    $('.conditions').each(function () {
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
        where += (condition.name + "='" + condition.value + "' ");
    }
    return where;
}

function buildOrgWhere(ncmc) {
    where = " NCMC like '" + '%' + ncmc + '%' + "'";
    return where;
}

function parseMu(centiare) {
    return (parseFloat(centiare) / 666.67).toFixed(2);
}

function landSearch(ncmc) {
    var query = new arcgisObj.Query();
    var queryTask = new arcgisObj.QueryTask(dynamicUrl + "/0");
    if (ncmc == "") {
        query.where = buildWhere();
    } else {
        query.where = buildOrgWhere(ncmc);
    }
    query.returnGeometry = true;
    query.maxAllowableOffset = 10;
    query.num = 2000;
    query.outFields = getOutFields();
    var queryResult = [];
    queryTask.execute(query, function (results) {
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
        highlightGraphic.setInfoTemplate(template);
        map.graphics.add(highlightGraphic);
    }
    map.setExtent(getExtent(queryResult));
}

function getShowContent(attribute) {
    var content = '';
    content += '<strong>宗地号:</strong>' + attribute.ZDH + '<br>';
    content += '<strong>使用权人:</strong>' + attribute.SYQR + '<br>';
    content += '<strong>状态：</strong>' + attribute.QQZT + '<br>';
    content += '<strong>面积：</strong>' + parseMu(attribute["Shape.STArea()"]) + '亩';
    return content;
}