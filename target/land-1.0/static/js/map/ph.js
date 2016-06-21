var map, baseMap, layer_sdl, cur_themagic, legend, printer, dynamicLayer, eventLayer;
var dynamicUrl, imageUrl;
var bounds, sum, imageLayer, visible = [];

//arcgis对象
var arcgisObj = {};
function buildDoc(url) { //打印
    var printDiv = $('#printButton');
    var loadingMsg = $('<a href="#" class="easyui-linkbutton">正在生成发包文件,请稍后...</a>');
    printDiv.append(loadingMsg);
    loadingMsg.linkbutton({});
    $.post('buildDoc', //后台java
    {
        picHref: url //
    },
    function(data) {
        var docName = data.message;
        var bt = $('<a id="downloadBt" href="#" class="easyui-linkbutton">下载发包文件</a>');
        bt.linkbutton({});
        loadingMsg.remove(); //信息移除
        printDiv.append(bt); //打印按钮改变
        bt.click(function() {
            rebuildPrinter(); //重建打印功能按钮
            downLoadByFrame(docName); //加载doc文件
            $(this).remove();
        });
    });
}

function downLoadByFrame(docName) {
    var src = 'downLoadDoc?fileName=' + docName; //加载
    var iframe = $('<iframe src="' + src + '"></iframe>'); //主页面加载doc
    iframe.css({
        display: 'none'
    });
    $(document.body).append(iframe); //打开文档
}

function setLayout() { //设置布局
    var height = $(document).height();
    $('#statsPanel').css({
        height: height - 350,
        'overflow': 'auto'
    });
}

window.onload = function() {
    setLayout();
    //easyUi组件

    require(["esri/map", "esri/arcgis/utils", "esri/layers/FeatureLayer", "esri/geometry/Extent", "esri/tasks/query", "esri/tasks/QueryTask", "dojo/dom", "dojo/on", "esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol", "esri/renderers/SimpleRenderer", "esri/renderers/UniqueValueRenderer", "esri/renderers/ClassBreaksRenderer",

    "esri/Color", "esri/graphic", "esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/Scalebar", "esri/layers/ArcGISDynamicMapServiceLayer", "esri/dijit/InfoWindowLite", "esri/InfoTemplate", "dojo/dom-construct", "esri/dijit/Legend", "esri/dijit/Print", "esri/dijit/HomeButton", "dojo/domReady!"],
    function(Map, arcgisUtils, FeatureLayer, Extent, Query, QueryTask, dom, on, SimpleFillSymbol, SimpleLineSymbol, SimpleRenderer, UniqueValueRenderer, ClassBreaksRenderer, Color, Graphic, ArcGISDynamicMapServiceLayer, Scalebar, ArcGISDynamicMapServiceLayer, InfoWindowLite, InfoTemplate, domConstruct, Legend, Print, HomeButton) {
        arcgisObj.Map = Map;
        arcgisObj.arcgisUrils = arcgisUtils;
        arcgisObj.FeatureLayer = FeatureLayer;
        arcgisObj.Extent = Extent;
        arcgisObj.Query = Query;
        arcgisObj.QueryTask = QueryTask;
        arcgisObj.dom = dom;
        arcgisObj.on = on;
        arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
        arcgisObj.SimpleLineSymbol = SimpleLineSymbol;
        arcgisObj.SimpleRenderer = SimpleRenderer;
        arcgisObj.ClassBreaksRenderer = ClassBreaksRenderer;
        arcgisObj.UniqueValueRenderer = UniqueValueRenderer;
        arcgisObj.Color = Color;
        arcgisObj.Graphic = Graphic;
        arcgisObj.ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer;

        arcgisObj.Scalebar = Scalebar;
        arcgisObj.ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer;
        arcgisObj.InfoWindowLite = InfoWindowLite;
        arcgisObj.InfoTemplate = InfoTemplate;
        arcgisObj.domConstruct = domConstruct;
        arcgisObj.Legend = Legend;
        arcgisObj.Print = Print;
        arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
        arcgisObj.HomeButton = HomeButton;
        //创建地图
        //createMap();	
        farmcombobox(); //初始化农场combox
        createbaseMap(); //设置地图参数.加载地图

    });
};
function farmcombobox() {
    initFarmht();
    /*$('#FarmName').combobox({
			url : '../contract/findNcInfo',
			valueField : 'code',
			textField : 'name',*/
    $('#FarmName').combobox({
        //url : '../contract/findNcInfo',
        valueField: 'code',
        textField: 'name',
        data: [{
            "name": '海南省国营乐光农场',
            "code": '11',
            "selected": false
        },
        {
            "name": '',
            "code": '14',
            "selected": false
        },
        {
            "name": '',
            "code": '13',
            "selected": false
        }],

        onSelect: function(rec) {

            // var url = 'findCommunityInfoByFarmCode?farmCode=' + rec.code;
            var value = rec.name;

            map.removeAllLayers();

            var cPoint;
            bounds = ht[value]["bounds"];
            if (ht[value]["imageServiceLayer"] != "") {
                //imageUrl = serverURL + '/' + ht[value]["imageServiceLayer"] + '/ImageServer';
            	imageUrl="";
            }
            if (ht[value]["phlayer"] != "") {
                dynamicUrl = serverURL + '/' + ht[value]["phlayer"] + '/MapServer';
                //alert(dynamicUrl);
            }

            // createbaseMap();
            createMap();
            map.setExtent(bounds);
            // landSearchNew();
            // map.centerAt(cPoint);
            findcombobox();
        },
        onLoadSuccess: function() {
            //		    	   var value =rec.name;
            var data = $('#FarmName').combobox('getData');
            if (data.length == 1) {

                $("#FarmName").combobox('select', data[0].code);

            }

        }

    });

}
function initFarmht() {
    ht = {
        "海南省国营东昌农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 215835.44128499986,
                "ymin": 159895.37725000028,
                "xmax": 231686.21501500005,
                "ymax": 176334.36575000043,
                "spatialReference": {
                    "wkid": 2382
                }
            }),
        },

        "海南省国营红明农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营南田农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营立才农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营南新农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营南滨农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": bounds = new arcgisObj.Extent({
                "xmin": 65697.91168999979,
                "ymin": 25464.57120000096,
                "xmax": 84310.22871000013,
                "ymax": 44888.872799999175,
                "spatialReference": {
                    "wkid": 2382
                }
            }),
        },
        "海南省国营东红农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 194717.1440799999,
                "ymin": 149139.13934999946,
                "xmax": 219401.1115199999,
                "ymax": 168692.75364999977,
                "spatialReference": {
                    "wkid": 2382
                }
            }),
        },
        "海南省国营东太农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营东升农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 194634.04491999984,
                "ymin": 126565.0820499993,
                "xmax": 207293.75747999962,
                "ymax": 142685.93294999943,
                "spatialReference": {
                    "wkid": 2382
                }
            }),
            "imageServiceLayer": "",
        },
        "海南省国营东平农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营南俸农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营西联农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营八一农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营蓝洋农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营西培农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营南阳农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营东路农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营新中农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },

        "海南省国营东和农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营东兴农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营广坝农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营中瑞农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营金鸡岭农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营中坤农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营中建农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营红光农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营金安农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营红华农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 129424.822535,
                "ymin": 166547.7546000001,
                "xmax": 148192.60376500041,
                "ymax": 202621.1633999995,
                "spatialReference": {
                    "wkid": 2382
                }
            }),
        },
        "海南省国营邦溪农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营龙江农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营乐光农场": {
            "layer": " ",
            "imageServiceLayer": "lg_newimagedata",
            "phlayer":"lg_gengdiziyuanguanlidanyuan_pH",
            "bounds": new arcgisObj.Extent({
                "xmin": 284117.8618000001,
                "ymin": 2040351.7152999993,
                "xmax": 309523.8705000002,
                "ymax": 2070239.7237999998,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营山荣农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营保国农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营南平农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营岭门农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营三道农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 122415.2780350002,
                "ymin": 35058.79211499942,
                "xmax": 132556.65906499955,
                "ymax": 48961.87218500087,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营金江农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营乌石农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 138116.716845,
                "ymin": 94884.75700499918,
                "xmax": 177847.51685499976,
                "ymax": 126604.75289500077,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },

        "海南省国营长征农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营阳江农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },

        "海南省国营南海农场": {
            "layer": "",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 50219.40844694423,
                "ymin": 38820.979982184916,
                "xmax": 79149.40844694423,
                "ymax": 69910.97998218492,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
    };
}

function findcombobox() {

    $('#propName').combobox({

        valueField: 'code',
        textField: 'name',
        data: [{
            name: 'PH',
            code: 1
        },
        {
            name: '有机质',
            code: 2
        },
        {
            name: '速效钾',
            code: 3
        },
        {
            name: '有效磷',
            code: 4
        },
        {
            name: '灌溉保证率',
            code: 5
        },
        {
            name: '水源距离',
            code: 6
        },
        {
            name: '土属名称',
            code: 7
        }],

        onSelect: function(rec) { ///根据选择不同,不同渲染方法        
            var value = rec.code;
            var linesymbol = new arcgisObj.SimpleLineSymbol();
            // arcgisObj.SimpleLineSymbol.STYLE_SOLID,new arcgisObj.Color([195, 195,195]), 0.5 ) ;
            linesymbol.setWidth(0.5);
            switch (value) {
            case 1:

                var symbol = new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, new arcgisObj.SimpleLineSymbol(arcgisObj.SimpleLineSymbol.STYLE_SOLID, new arcgisObj.Color([255, 255, 255]), 0.5), null);

                // Add five breaks to the renderer.
                // If you have ESRI's ArcMap available, this can be a good way to determine break values.
                // You can also copy the RGB values from the color schemes ArcMap applies, or use colors
                // from a site like www.colorbrewer.org
                //
                // alternatively, ArcGIS Server's generate renderer task could be used
                var renderer = new arcgisObj.ClassBreaksRenderer(symbol, "ph");
                renderer.addBreak(4.8, 5.0, new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([56, 168, 0, 0.8])));
                renderer.addBreak(5.1, 5.2, new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([176, 224, 0, 0.8])));
                renderer.addBreak(5.3, 5.4, new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([255, 170, 0, 0.8])));
                renderer.addBreak(5.5, 5.8, new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([255, 0, 0, 0.8])));

                eventLayer.setRenderer(renderer);
                eventLayer.refresh();
                legend.refresh([{
                    layer: eventLayer,
                    title: 'PH',
                    defaultSymbol: false,
                    label: 'ddd'
                }]);
                break;
            case 2:
                var renderer = new arcgisObj.SimpleRenderer(new arcgisObj.SimpleFillSymbol().setOutline(new arcgisObj.SimpleLineSymbol().setWidth(0.5)));
                renderer.setColorInfo({
                    field: "有机质",
                    minDataValue: 4,
                    maxDataValue: 20,
                    colors: [new arcgisObj.Color([255, 255, 255]), new arcgisObj.Color([255, 0, 255])]
                });
                eventLayer.setRenderer(renderer);
                eventLayer.refresh();
                // legend.refresh();
                legend.refresh([{
                    layer: eventLayer,
                    title: '有机质',
                    defaultSymbol: false,
                    label: 'ddd'
                }]);
                break;
            case 3:
                var renderer = new arcgisObj.SimpleRenderer(new arcgisObj.SimpleFillSymbol().setOutline(new arcgisObj.SimpleLineSymbol().setWidth(0.5)));
                renderer.setColorInfo({
                    field: "速效钾",
                    minDataValue: 0,
                    maxDataValue: 100,
                    colors: [new arcgisObj.Color([255, 255, 255]), new arcgisObj.Color([15, 0, 255])]
                });
                eventLayer.setRenderer(renderer);
                eventLayer.refresh();
                legend.refresh([{
                    layer: eventLayer,
                    title: '速效钾',
                    defaultSymbol: false,
                    label: 'ddd'
                }]);
                break;
            case 4:
                var renderer = new arcgisObj.SimpleRenderer(new arcgisObj.SimpleFillSymbol().setOutline(new arcgisObj.SimpleLineSymbol().setWidth(0.5)));
                renderer.setColorInfo({
                    field: "有效磷",
                    minDataValue: 1,
                    maxDataValue: 20,
                    colors: [new arcgisObj.Color([255, 255, 255]), new arcgisObj.Color([0, 249, 230])]
                });
                eventLayer.setRenderer(renderer);
                eventLayer.refresh();
                legend.refresh([{
                    layer: eventLayer,
                    title: '有效磷',
                    defaultSymbol: false,
                    label: 'ddd'
                }]);
                break;
            case 5:
                var renderer = new arcgisObj.SimpleRenderer(new arcgisObj.SimpleFillSymbol().setOutline(new arcgisObj.SimpleLineSymbol().setWidth(0.5)));
                renderer.setColorInfo({
                    field: "灌溉保证率",
                    minDataValue: 1,
                    maxDataValue: 300,
                    colors: [new arcgisObj.Color([255, 255, 255]), new arcgisObj.Color([2, 0, 255])]
                });
                eventLayer.setRenderer(renderer);
                eventLayer.refresh();
                legend.refresh([{
                    layer: eventLayer,
                    title: '灌溉保证率',
                    defaultSymbol: false,
                    label: 'ddd'
                }]);
                break;
            case 6:
                var renderer = new arcgisObj.SimpleRenderer(new arcgisObj.SimpleFillSymbol().setOutline(new arcgisObj.SimpleLineSymbol().setWidth(0.5)));
                renderer.setColorInfo({
                    field: "水源距离",
                    minDataValue: 0,
                    maxDataValue: 2000,
                    colors: [new arcgisObj.Color([255, 255, 255]), new arcgisObj.Color([100, 0, 255])]
                });
                eventLayer.setRenderer(renderer);
                eventLayer.refresh();
                legend.refresh([{
                    layer: eventLayer,
                    title: '水源距离',
                    defaultSymbol: false,
                    label: 'ddd'
                }]);
                break;
            case 7:
                //唯一值渲染
                var defaultSymbol = new arcgisObj.SimpleFillSymbol().setStyle(arcgisObj.SimpleFillSymbol.STYLE_SOLID);

                defaultSymbol.outline.setWidth(0.5);
                //create renderer
                var renderer = new arcgisObj.UniqueValueRenderer(defaultSymbol, "土属名称");

                //add symbol for each possible value
                renderer.addValue("变质岩山地砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([100, 255, 200, 0.5])));
                renderer.addValue("变质岩黄色砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([0, 255, 0, 0.5])));
                renderer.addValue("潮沙土", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([0, 0, 255, 0.5])));
                renderer.addValue("砂页岩砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([255, 0, 255, 0.5])));
                renderer.addValue("砂页岩粗骨性砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([255, 205, 255, 0.75])));
                renderer.addValue("砂页岩赤红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([100, 25, 255, 0.5])));
                renderer.addValue("砂页岩黄色砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([200, 100, 0, 0.5])));
                renderer.addValue("花岗岩山地砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([127, 0, 0, 0.5])));
                renderer.addValue("花岗岩砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([255, 0, 0, 0.5])));
                renderer.addValue("花岗岩粗骨性砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([0, 255, 255, 0.5])));
                renderer.addValue("花岗岩褐色砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([255, 255, 0, 0.5])));
                renderer.addValue("花岗岩黄色砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([127, 7, 127, 0.5])));
                renderer.addValue("酸性紫色土", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([0, 0, 100, 0.5])));
                renderer.addValue("非耕型花岗岩黄色砖红壤", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([0, 200, 0, 0.5])));
                renderer.addValue("", new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, linesymbol, null).setColor(new arcgisObj.Color([236, 100, 255, 0.5])));

                eventLayer.setRenderer(renderer);
                eventLayer.refresh();
                legend.refresh([{
                    layer: eventLayer,
                    title: '土壤属性',
                    defaultSymbol: false,
                    label: '土壤属性'
                }]);

                break;
            }

        },

    });

}
function createbaseMap() {
    dynamicUrl = "";
    imageUrl = "";
    imageServiceLayer = "";

    map = new arcgisObj.Map("mapDiv");

    var home = new arcgisObj.HomeButton({
        map: map
    },
    "HomeButton");
    home.startup();

    buildLegend();
    //  buildPrinter();

    new arcgisObj.Scalebar({
        map: map,
        attachTo: "bottom-left",
        // "dual" displays both miles and kilmometers
        // "english" is the default, which displays miles
        // use "metric" for kilometers
        scalebarUnit: "metric"
    });

}
function buildLegend() {
    legend = new arcgisObj.Legend({
        map: map
    },
    "legend");
    legend.startup();
}
function createLayers() {
    if (dynamicUrl == "") {

} else {
        dynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(dynamicUrl, {
            "opacity": 0.8//透明度
        });

        var template = new arcgisObj.InfoTemplate();//弹出信息框
        template.setTitle("地块信息");
        template.setContent(getTextContent());

        eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
            outFields: getOutFields(),
            infoTemplate: template
        });
    }
    var layers;

//    if (imageUrl == "") {
//        layers = [eventLayer];
//    } else {
//        imageServiceLayer = new esri.layers.ArcGISImageServiceLayer(imageUrl);
//        layers = [eventLayer, imageServiceLayer];
//    	
//    }
    layers = [eventLayer];
    layerClick(eventLayer);
    //alert(layers);
    return layers;
}




function getDisplayModel(remark, column) {
    return '<strong>' + remark + ':</strong>${' + column + '}<br>';
}

function getTextContent() {
    return getDisplayModel('PH', 'pH') + getDisplayModel('有机质', '有机质') + getDisplayModel('速效钾', '速效钾') + getDisplayModel('有效磷', '有效磷') + getDisplayModel('灌溉保证率', '灌溉保证率') + getDisplayModel('水源距离', '水源距离') + getDisplayModel('土属名称', '土属名称') + "<strong>面积:</strong>${MJ:handleArea}";
}

function getOutFields() {
    return ["pH", "有机质", "速效钾", "有效磷", "灌溉保证率", "水源距离", "土属名称", "MJ"];
}

function buildPrinter() {//建立打印功能
    printer = new arcgisObj.Print({
        label: '生成发包文件',
        processingText: '正在生成图片,请稍后...',
        showpicText: '查看图片',
        map: map,
        url: serverURL + '/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task'
    },
    arcgisObj.dom.byId('printButton'));
    printer.on('print-start',
    function() {
        $('#downloadBt').remove();
    });
    printer.on('print-complete',
    function(evt) {
        buildDoc(evt.result.url);
    });
    printer.startup();
}

function rebuildPrinter() {
    printer.destroy();
    buildPrinter();
}

function createMap() {

    setLayers();

}

/*function buildLegend() {
	  legend = new arcgisObj.Legend({
			map: map,
			
	  }, "legend");
	  legend.startup();
  }
  */

function setLayers() {
    /*var layers = createLayers();
			map.addLayers(layers);
			areaStatisticssum();
			legend.refresh([{layer:layers[1], title:'芒果分布'}]);*/
    var layers = createLayers();
    map.addLayers(layers);
    if (imageServiceLayer == "") {
        if (layers[0].loaded) {
            buildLayerList(layers[0]);
            //alert(0);
        } else {
            dojo.connect(layers[0], "onLoad", buildLayerList);//连接图层和图层控制
            //alert(1);
        }

    } else {
        if (layers[1].loaded) {
            buildLayerList(layers[1]);
            //alert(2);
        } else {
            dojo.connect(layers[1], "onLoad", buildLayerList);
            //alert(3);
        }

    }

    //	areaStatisticssum();
    legend.refresh([{
        layer: eventLayer,
        title: '图例'
    }]);
    return;
}
function buildLayerList(layers) {//图层控制
    var treeList = []; // jquery-easyui的tree用到的tree_data.json数组
    var parentnodes = []; // 保存所有的父亲节点
    var root = {
        "id": "rootnode",
        "text": "自营经济",
        "children": []
    }; // 增加一个根节点
    var node = {};

   
    node = {
        "id": 0,
        "text": '土壤属性',
        "iconCls": " icon-blank",
        "checked": true,
        "children": []
    };
   
    treeList.push(node);
    // jquery-easyui的树
    $('#toc').tree({
        data: treeList,
        checkbox: true,
        // 使节点增加选择框
        onCheck: function(node, checked) { // 更新显示选择的图层
            var visible = [];

            var nodes = $('#toc').tree("getChecked");
            dojo.forEach(nodes,
            function(node) {
                visible.push(node.id);
            });

            if (visible.length === 0) {
                visible.push( - 1);
                layers.hide();
            } else {
                layers.show();
            }

        }
    });

   
}
function layerClick(fl) {//点击图层,选中图形高亮显示
    fl.on('click',
    function(evt) {
        map.graphics.clear();
        var highlightSymbol = new arcgisObj.SimpleFillSymbol(arcgisObj.SimpleFillSymbol.STYLE_SOLID, new arcgisObj.SimpleLineSymbol(arcgisObj.SimpleLineSymbol.STYLE_SOLID, new arcgisObj.Color([47, 79, 177]), 1), new arcgisObj.Color([125, 125, 125, 0.35]));
        var highlightGraphic = new arcgisObj.Graphic(evt.graphic.geometry, highlightSymbol);
        map.graphics.add(highlightGraphic);
    });
}

