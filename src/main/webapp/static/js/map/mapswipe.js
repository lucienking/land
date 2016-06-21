require(["esri/map",
	"esri/layers/ArcGISTiledMapServiceLayer",
	"dojo/dom","dojo/on",
	"dojo/dom-class",
	"esri/layers/ArcGISImageServiceLayer",
	"esri/layers/ArcGISDynamicMapServiceLayer",
	"dojo/domReady!"],
	function(map,ArcGISTiledMapServiceLayer,dom,on,domclass)
	{
		map1=new map("map1");
		/*加载地图*/
		var toplayer=new esri.layers.ArcGISImageServiceLayer("http://10.215.200.122:6080/arcgis/rest/services/lg_newimagedata/ImageServer",{id:"toplayer"});
		var bottomlayer=new esri.layers.ArcGISDynamicMapServiceLayer("http://10.215.200.122:6080/arcgis/rest/services/lg_basemap/MapServer",{id:"bottomlayer"});
		var l=map1.id+"_toplayer";
		var i=null;
		map1.addLayer(bottomlayer);
		map1.addLayer(toplayer);

		/*鼠标点击点击后激活或者关闭按钮*/
		var k=false;
		var c=false;
		on(dom.byId("verticalswipe"),"click",function(){k=!k});
		//console.log(k);
		//console.log(on);
		on(dom.byId("horizontalswipe"), "click",function(){c=!c});


		on(toplayer,"load",
			function(){
			    on(map1,"mouse-move",
			     function(B) {
					 //alert(i);
					 i=i?i:document.getElementById(map1.id+"_toplayer");//根据参数获取ID
				     var sX=B.screenPoint.x;
				     var sY=B.screenPoint.y;
				     var eh=i.style.height;
				     var ew=i.style.width;
				     var elH=parseInt(eh.substring(0,eh.lastIndexOf("px")));
				     var elW=parseInt(ew.substring(0,ew.lastIndexOf("px")));//根据元素获取元素宽高

				     var E=r(i);
				     var top=-E.y+"px";
				     var left=-E.x+"px";
				     var bottom,x;
					 //console.log(y+","+w);
				     bottom=c?(sY-E.y)+"px":(elH-E.y)+"px";
				     right=k?(sX-E.x)+"px":(elW-E.x)+"px";
				     console.log("rect("+top+","+right+","+bottom+","+left+")");
				     i.style.clip="rect("+top+","+right+","+bottom+","+left+")"})
			});

		    /*提取移动后的x,y坐标*/
			function r(z) {
			var w,y,v=z.style;
			//Safari 和 Chrome 支持替代的 -webkit-transform 属性（3D 和 2D 转换）。
			if(v["-webkit-transform"]){
				var A=v["-webkit-transform"];
				var u=A.replace(/translate\(|px|\s|\)/,"").split(",");
				w=parseInt(u[0]);
				y=parseInt(u[1])
			}
			else{
				//Internet Explorer 10、Firefox、Opera 支持 transform 属性。
				if(v.transform){
					var t=v.transform;
					var x=t.replace(/px|\s|translate3d\(|px|\)/g,"").split(",");
					w=parseInt(x[0]);
					y=parseInt(x[1])}
				//Internet Explorer 9 支持替代的 -ms-transform 属性（仅适用于 2D 转换）。
				else{
					w=parseInt(z.style.left.replace("px",""));
					y=parseInt(z.style.top.replace("px",""))}}
			return{x:w,y:y}
		}
		//var s=new b("map2");
		//var d=esri.layers.ArcGISImageServiceLayer("http://10.215.200.122:6080/arcgis/rest/services/lg_newimagedata/ImageServer",{id:"toplayer"});
		//var o=s.id+"_toplayer";
		//s.addLayer(d);
		//var m=null;
		//var n=false;
		//var e=false;
		//var f=false;
		//on(dom.byId("verticalswipeanim"),"click",function(){e=!e});
		//on(dom.byId("horizontalswipeanim"),"click",function(){f=!f});

		/*function a(v,F) {
			m=m?m:document.getElementById(v);
			var t=m.style.height;var D=m.style.width;
			var x=parseInt(t.substring(0,t.lastIndexOf("px")));
			var B=parseInt(D.substring(0,D.lastIndexOf("px")));
			var E=r(m);
			var w=-E.y+"px";
			var z=-E.x+"px";
			var u,y;
			u=(x-E.y)+"px";
			clipright=(B-E.x)+"px";
			//m.style["-webkit-transition"]="none";
			//m.style["-moz-transition"]="none";
			//m.style.transition="none";
			if (!F) {
				m.style.clip = "rect(" + w + "," + clipright + "," + u + "," + z + ")";
				setTimeout(
					function () {
					n = false;
					u = f ? w : u;
					clipright = e ? z : clipright;
					//m.style["-webkit-transition"] = "all 2s ease-in";
					//m.style["-moz-transition"] = "all 2s ease-in";
					//m.style.transition = "all 2s ease-in";
					//m.style.clip = "rect(" + w + "," + clipright + "," + u + "," + z + ")"
				}, 10)
			}
			else {
				var C = e ? z : clipright;
				var A = f ? w : u;
				m.style.clip = "rect(" + w + "," + C + "," + A + "," + z + ")";
				setTimeout(
					function () {
					n = true;
					*//*m.style["-webkit-transition"] = "all 2s ease-in";
					m.style["-moz-transition"] = "all 2s ease-in";
					m.style.transition = "all 2s ease-in";
					m.style.clip = "rect(" + w + "," + clipright + "," + u + "," + z + ")"*//*
				}, 10)
			}}*/

		/*on(dom.byId("showbt"),"click",function(){a(o,false)});
		on(dom.byId("hidebt"),"click",function(){a(o,true)});*/
		/*on(
			//s,
			"mouse-drag-start",
			function(){
			m.style["-webkit-transition"]="inherit";
			m.style["-moz-transition"]="inherit";
			m.style.transition="inherit";
			m.style.clip=n?"inherit":"rect(0px,0px,0px,0px)"
			}
		)*/
	});
