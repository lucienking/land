
      var map;
      require([
        "esri/map",
        "esri/dijit/Popup", "esri/dijit/PopupTemplate",
        "esri/layers/ArcGISDynamicMapServiceLayer",
        "esri/layers/FeatureLayer",
        "esri/symbols/SimpleFillSymbol", "esri/Color",
        "dojo/dom-class", "dojo/dom-construct", "dojo/on",
        "dojox/charting/Chart", "dojox/charting/themes/Dollar",
        "dojo/domReady!"
      ], function(
        Map,
        Popup, PopupTemplate,ArcGISDynamicMapServiceLayer,
        FeatureLayer,
        SimpleFillSymbol, Color,
        domClass, domConstruct, on,
        Chart, theme
      ) {
        //The popup is the default info window so you only need to create the popup and 
        //assign it to the map if you want to change default properties. Here we are 
        //noting that the specified title content should display in the header bar 
        //and providing our own selection symbol for polygons.
        var fill = new SimpleFillSymbol("solid", null, new Color("#A4CE67"));
        var popup = new Popup({
            fillSymbol: fill,
            titleInBody: false
        }, domConstruct.create("div"));
        //Add the dark theme which is customized further in the <style> tag at the top of this page
        domClass.add(popup.domNode, "dark");

        map = new Map("map", {
                    infoWindow: popup
        });
        var agoServiceURL = serverURL +"/lg_gengdiziyuanguanlidanyuan_pH/MapServer";
        var agoLayer = new ArcGISDynamicMapServiceLayer(agoServiceURL);
        map.addLayer(agoLayer);
        var template = new PopupTemplate({//设置弹出框需要显示的字段,字段需要数值型
          title: "统计",
          description: "土壤属性: ",
          fieldInfos: [{ //define field infos so we can specify an alias
            fieldName: "有效磷",
            label: "有效磷"
          },{
            fieldName: "有机质",
            label: "有机质"
          },{
                fieldName: "速效钾",
                label: "速效钾"
              },{
                  fieldName: "pH",
                  label: "pH"
                }],
          mediaInfos:[{ //定义为直方图
            caption: "",
            type:"columnchart",
            value:{
              theme: "Dollar",
              fields:["有效磷","有机质","速效钾","pH"]
            }
          }]
        });

        var featureLayer = new FeatureLayer(serverURL +"/lg_gengdiziyuanguanlidanyuan_pH/MapServer/0",{
          mode: FeatureLayer.MODE_ONDEMAND,
          outFields: ["*"],
          infoTemplate: template
        });
        map.addLayer(featureLayer);
      });
   