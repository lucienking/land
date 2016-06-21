	var map;
	
	var intervalId = null;
	
	var monitorPhone;
	
	 //经纬度转墨卡托
  	function lonlat2mercator(lonlat){
		var  mercator={x:0,y:0};
		var x = lonlat.x *20037508.34/180;
		var y = Math.log(Math.tan((90+lonlat.y)*Math.PI/360))/(Math.PI/180);
		y = y *20037508.34/180;
		mercator.x = x;
		mercator.y = y;
		return mercator ;
	   }

	 //墨卡托转经纬度
	 function mercator2lonlat(mercator){
		var lonlat={x:0,y:0};
		var x = mercator.x/20037508.34*180;
		var y = mercator.y/20037508.34*180;
		y= 180/Math.PI*(2*Math.atan(Math.exp(y*Math.PI/180))-Math.PI/2);
		lonlat.x = x;
		lonlat.y = y;
		return lonlat;
	 }
	
	 function getX(x) {
	 	return x *20037508.34/180;
	 }
	 
	 function getY(y) {
	 	var result;
		result = Math.log(Math.tan((90+y)*Math.PI/360))/(Math.PI/180);
		return result *20037508.34/180;
	 }
	
 function gridMonitor() {
		var keepMonitor = false;
		$('#phone').validatebox({
			required: true
		});
		$('#date').datebox({
			
		});
		
		require(["dijit/layout/ContentPane", "esri/InfoTemplate","esri/symbols/SimpleLineSymbol","esri/geometry/Extent","esri/geometry/Point", "esri/SpatialReference",
		         "esri/symbols/SimpleMarkerSymbol","esri/Color","esri/graphic",
		         "esri/symbols/SimpleFillSymbol","esri/geometry/Polygon","esri/map",
		         "esri/layers/ArcGISDynamicMapServiceLayer", "esri/geometry/Point",
		         "esri/geometry/Polyline","dojo/domReady!"]
		, function(ContentPane,InfoTemplate,SimpleLineSymbol,Extent,Point,SpatialReference,SimpleMarkerSymbol,Color,Graphic,SimpleFillSymbol,Polygon,Map, ArcGISDynamicMapServiceLayer, Point, Polyline) {
		var bounds = new Extent({
            "xmin":12274579.38811334,
            "xmax":12289637.482685499,
            "ymax": 2276558.2880848516,
            "ymin": 2269965.594395264,
            "spatialReference":{"wkid":102100}
          });
		
		map = new Map("map", {
			extent : bounds,
			basemap : 'satellite'
        });
				
//		map.on('mouse-move', function(evt) {
//			document.getElementById('cordination').innerHTML = evt.mapPoint.x + ',' + evt.mapPoint.y;
//		});
		
		map.on('load', function() {
			console.log(map.spatialReference.wkid);
			//map.graphics.add(graphic);
			//map.graphics.add(getSimpleMarkerSymbol(getX(110.30400177), getY(20.01488821)));
			//map.graphics.add(getSimpleFillSymbol(points));
			//startListen(Point, SpatialReference);
		});
		
		
		window.startListen =function(Point, SpatialReference) {
			monitorPhone = $('#phone').val();
			//drawCurLocation();
			if(monitorPhone=='') {
				$.messager.alert('错误', '手机号不能为空', 'error');
				$('#phone').focus();
				return;
			}
			keepMonitor = true;
			drawCurLocation();
			/*intervalId = setInterval(function() {
					drawCurLocation();
			}, 2000);*/
		};
		
		
		
		function drawCurLocation() {
			if(keepMonitor == true) {
				map.graphics.clear();
				$.post('getCurLocation',{phone:monitorPhone},function(data) {
					if(data) {
						var lon = getX(data.lon);
						var lat = getY(data.lat);
						map.graphics.add(getSimpleMarkerSymbol(lon, lat));
					}
					
				}, 'json');
				if(keepMonitor == true) {
					setTimeout(drawCurLocation, 4 * 1000);
				}
			}
		}
		
		window.drawLocations = function() {
			stopMonitor();
			var phone = $('#phone').val();
			if(phone=='') {
				$.messager.alert('错误', '手机号不能为空', 'error');
				$('#phone').focus();
				return;
			}
			//调用后台查找相对应的信息
			$.post('grid/findLocations',{phone:phone,date:$('#date').datebox('getText')},function(data) {
				var pointArray = [];
				if(data) {
					map.graphics.clear();
//					var monitorLocation = data.monitorLocation;
					var serviceLocation = data.serviceLocation;
					for(var index in serviceLocation) {
						var location = serviceLocation[index];
						map.graphics.add(getSimpleMarkerSymbolInfo(location));
					}
					for(var index in serviceLocation) {
						var location = serviceLocation[index];
						pointArray.push([getX(location.lon), getY(location.lat)]);
					}
					map.graphics.add(getSimpleFillSymbol(pointArray));
//					定位
					var minx=0,miny=0,maxx=0,maxy=0;
					
					var lot_x=[];
					var lat_y=[];
					for(var index in pointArray){
						lot_x.push(pointArray[index][0]);
						lat_y.push(pointArray[index][1]);
					}
					minx=Math.min.apply(null,lot_x)-1000;
					maxx=Math.max.apply(null,lot_x)+1000;
					miny=Math.min.apply(null,lat_y)-1000;
					maxy=Math.max.apply(null,lat_y)+1000;
//					alert(minx+","+maxx+","+miny+","+maxy);
					var spatialReference = new SpatialReference({ wkid: 102100 });
					var lExtend=new Extent(minx,miny,maxx,maxy,spatialReference);
					map.setExtent(lExtend);
				}
			}, 'json');
		};
		
		function locatedExtend(Extend){
			
		}
		//停止监控 **** BEGIN ***
		function stopMonitor() {
			map.graphics.clear();
			keepMonitor = false;
			//clearInterval(intervalId);
		}
		//停止监控 **** END ***
		
		//根据坐标得到一个图形  **** BEGIN ****
		function getSimpleMarkerSymbol(x, y) {
			
			var marksymbol = new SimpleMarkerSymbol({
			  "color": [216,19,21,100],
			  "size": 12,
			  "angle": -30,
			  "xoffset": 0,
			  "yoffset": 0,
			  "type": "esriSMS",
			  "style": "esriSMSCircle",
			  "outline": {
				"color": [216,19,21,255],
				"width": 1,
				"type": "esriSLS",
				"style": "esriSLSSolid"
			  }
			});
			var spatialReference = new SpatialReference({ wkid: 102100 });
			var graphic = new Graphic(new Point(x,y ,spatialReference), marksymbol);
			return graphic;
		}
		//根据坐标得到一个图形  **** END ****
		
		//根据坐标得到一个带template的图形  **** BEGIN ****
		function getSimpleMarkerSymbolInfo(location) {
			var x = getX(location.lon), y =getY(location.lat);
			//var phone = location.phone;
			//var serviceType = location.serviceType;
			//var serviceCont = location.serviceCont;
			//var feedback = location.feedback;
			//var d = new Date(location.receiveDate);
			//var date = d.getFullYear() + '年' + (d.getMonth() + 1) + '月' + d.getDate() + '日 ' + d.getHours() + ':' + d.getMinutes();
			//var name = location.user.name;
			var template = new InfoTemplate("<b>业务信息 - ${phone}</b>",
					"<b>时间 :</b> ${reportDate}<br>" +
					"<b>述求人 :</b> ${edtApplyUser}<br>" +
					"<b>主题 ：</b> ${edtTitle}<br>" +
					"<b>述求内容 ：</b> ${edtDetails}<br>" + 
					"<b>网格员姓名：</b> ${edtReporter}<br>");
			/*template.setTitle("业务信息");
			template.setContent();*/
			var marksymbol = new SimpleMarkerSymbol({
			  "singleTemplate": template,
			  "color": [216,19,21,100],
			  "size": 12,
			  "angle": -30,
			  "xoffset": 0,
			  "yoffset": 0,
			  "type": "esriSMS",
			  "style": "esriSMSCircle",
			  "outline": {
				"color": [216,19,21,255],
				"width": 1,
				"type": "esriSLS",
				"style": "esriSLSSolid"
			  }
			});
			var attr = {"edtApplyUser":location.applyername,
					"reportDate" : location.report_date,
					"phone":location.phone_number,
					"edtTitle" : location.title,
					"edtDetails" : location.details,
					"edtReporter" : location.reportername};//显示属性
			var spatialReference = new SpatialReference({ wkid: 102100 });
			var graphic = new Graphic(new Point(x,y ,spatialReference), marksymbol, attr, template);
			return graphic;
		}
		//根据坐标得到一个带template的图形  **** END ****
		
		//根据坐标数组得到一个闭合的图形对象  ********* BEGIN
		function getSimpleFillSymbol(pointsArray) {
			var polygonJson2 = {
				"rings" : [pointsArray],
				"spatialReference":{"wkid":102100}
			};								
			//WGS1984
			var polygon = new Polygon(polygonJson2);
			
			var symbol = new SimpleLineSymbol().setColor(new Color([216,19,21,0.5])).setWidth(4);
			
			var graphic = new Graphic(polygon, symbol);
			return graphic;
		}
		//根据坐标数组得到一个闭合的图形对象  ********* END
			
      });
	};
