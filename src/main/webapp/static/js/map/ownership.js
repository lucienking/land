var map, baseMap, layer_ziyingjingji,layer_quanshu,layer_beizhandi,layer_sdl, cur_themagic, legend, printer;
var dynamicUrl,imageUrl;  var bounds,sum,imageServiceLayer,visible = []; ;
   //arcgis对象
   var arcgisObj = {};
   function buildDoc(url) {
	   var printDiv = $('#printButton_ownership');
	   var loadingMsg = $('<a href="#" class="easyui-linkbutton">正在生成发包文件,请稍后...</a>');
	   printDiv.append(loadingMsg);
	   loadingMsg.linkbutton({});
	   $.post('buildDoc', {picHref:url}, function(data) {
		   var docName = data.message;
		   var bt = $('<a id="downloadBt_ownership" href="#" class="easyui-linkbutton">下载发包文件</a>');
		   bt.linkbutton({});
		   loadingMsg.remove();
		   printDiv.append(bt);
		   bt.click(function() {
			   rebuildPrinter();
			   downLoadByFrame(docName);
			   $(this).remove();
		   });
	   });
   }
   
   function downLoadByFrame(docName) {
	   var src = 'downLoadDoc?fileName=' + docName;
	   var iframe = $('<iframe src="' + src + '"></iframe>');
	   iframe.css({
		   display:'none'
	   });
	   $(document.body).append(iframe);
   }
   
   function setLayout() {
	   var height = $(document).height();
	   var width = $(document).width();
	   $('#mapDiv_ownership').css({
		   height:height - $('#layout-header').height() -120,
		   width:width - $('#layout-content-left').width() -580
	   });
   }
   
  function main_ownership() {
	  setLayout();
		require([
		  "esri/map",
		  "esri/arcgis/utils",
		  "esri/layers/FeatureLayer",
		  "esri/geometry/Extent",
		  "esri/tasks/query",
		  "esri/tasks/QueryTask",
		  "dojo/dom", 
		  "dojo/on",
		  "esri/symbols/SimpleFillSymbol",
		  "esri/symbols/SimpleLineSymbol", 
          "esri/renderers/SimpleRenderer", 
		  "esri/Color",
		  "esri/graphic",
		  "esri/layers/ArcGISDynamicMapServiceLayer",
		  "esri/dijit/Scalebar",
		  "esri/layers/ArcGISImageServiceLayer",
		  "esri/dijit/InfoWindowLite",
          "esri/InfoTemplate",
		  "dojo/dom-construct",
		  "esri/dijit/Legend",
		  "esri/dijit/Print",
		  "esri/dijit/HomeButton",
		  "dojo/domReady!"
		  ], function(Map, arcgisUtils,FeatureLayer,Extent,Query, QueryTask,dom, on,SimpleFillSymbol,SimpleLineSymbol,SimpleRenderer,Color,Graphic,ArcGISDynamicMapServiceLayer, Scalebar,ArcGISImageServiceLayer,InfoWindowLite,InfoTemplate,domConstruct,Legend,Print,HomeButton){
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
			arcgisObj.Color = Color;
			arcgisObj.Graphic = Graphic;
			arcgisObj.ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer;
			
			arcgisObj.Scalebar = Scalebar;
			arcgisObj.ArcGISImageServiceLayer = ArcGISImageServiceLayer;
			arcgisObj.InfoWindowLite = InfoWindowLite;
			arcgisObj.InfoTemplate = InfoTemplate;
		    arcgisObj.domConstruct = domConstruct;
			arcgisObj.Legend = Legend;
			arcgisObj.Print = Print;
			arcgisObj.SimpleFillSymbol = SimpleFillSymbol;
			arcgisObj.HomeButton = HomeButton;
			//创建地图
			dijit.registry.forEach(function(w){  
			    if (w.get("id") == "mapDiv_ownership"){  
			    w.destroy();  
			    }  
			          
			    if (w.get("id") == "HomeButton_ownership"){  
			    w.destroy();  
			    }  
			    if (w.get("id") == "legend_ownership"){  
				    w.destroy();  
				    }
			    if (w.get("id") == "printButton_ownership"){  
				    w.destroy();  
				    }
			    if (w.get("id") == "scalebar_ownership"){  
				    w.destroy();  
				    }
			    
			   
			}); 
			findcombobox();
			 createbaseMap();
	  });
   };
   function findcombobox() {
		initFarmht();
		$('#FarmName_ownership').combobox({
			
				//url : '../contract/findNcInfo',
				valueField : 'code',
				textField : 'name',
				data: [{
					"name": '海南省国营乐光农场',
					"code": '11',
					"selected":false
				},{
					"name": '海南省国营乐光农场',
					"code": '12',
					"selected":false
				},{
					"name": '',
					"code": '13',
					"selected":false
				}
				],
		
			onSelect: function(rec){
	           
			// var url = 'findCommunityInfoByFarmCode?farmCode=' + rec.code;
				
			        var value =rec.name;
		           
		            map.removeAllLayers();
		          
		            var cPoint;
		            bounds = ht[value]["bounds"];
					
		            imageUrl = serverURL + '/'+ht[value]["imageServiceLayer"]+'/ImageServer';
	               	dynamicUrl = serverURL + '/'+ht[value]["layer"]+'/MapServer';
	                
		           	
		           // createbaseMap();
		            createMap();
		            map.setExtent(bounds);
		    		// landSearchNew();
		          // map.centerAt(cPoint);
		       },
		       onLoadSuccess:function(rec){
//		    	   var value =rec.name;
		    	   var data = $('#FarmName_ownership').combobox('getData');
	              if (data.length ==1)
	                	{              	
	                    
	                         $("#FarmName_ownership").combobox('select', data[0].code);
	                    
	                	}
		    	   
		    	   
		    	   
		       }


			})
		
	}
   function createMap() {

		$('#show_grid_ownership').empty();
		setLayers();
		
	}

   function initFarmht()
   { 
   ht  =     {   
       "海南省国营东昌农场"   :   {"layer":"",
    	"imageServiceLayer" : "",
       	   "bounds":  new arcgisObj.Extent({
               "xmin":215835.44128499986,
               "ymin": 159895.37725000028,
               "xmax": 231686.21501500005,
               "ymax": 176334.36575000043,
               "spatialReference":{"wkid":2382}}),
               },
    
       "海南省国营红明农场"   :   {"layer":"",
                       	 "imageServiceLayer" : "",
         	                 "bounds":  new arcgisObj.Extent({
      	                  	"xmin" : 50219.40844694423,
      		                "ymin" : 38820.979982184916,
      		                "xmax" : 79149.40844694423,
      		                "ymax" : 69910.97998218492,
      	                	"spatialReference" : { "wkid" : 2382 }
      	                   })       }, 
    "海南省国营南田农场"   :   {"layer":"",
   	 "imageServiceLayer" : "",
                        "bounds":  new arcgisObj.Extent({
          	                  	"xmin" : 50219.40844694423,
          		                "ymin" : 38820.979982184916,
          		                "xmax" : 79149.40844694423,
          		                "ymax" : 69910.97998218492,
          	                	"spatialReference" : { "wkid" : 2382    }
          	                   })         }, 
   "海南省国营立才农场"   :   {"layer":"",
   	 "imageServiceLayer" : "",
               	      "bounds":  new arcgisObj.Extent({
            	                  	"xmin" : 50219.40844694423,
            		                "ymin" : 38820.979982184916,
            		                "xmax" : 79149.40844694423,
            		                "ymax" : 69910.97998218492,
            	                	"spatialReference" : { "wkid" : 2382  }
            	                   })    },   
     "海南省国营南新农场"   :   {"layer":"",
   	  "imageServiceLayer" : "",
                 	        "bounds":  new arcgisObj.Extent({
              	                  	"xmin" : 50219.40844694423,
              		                "ymin" : 38820.979982184916,
              		                "xmax" : 79149.40844694423,
              		                "ymax" : 69910.97998218492,
              	                	"spatialReference" : { "wkid" : 2382 }
              	                   })         }, 
   "海南省国营南滨农场"   :   {"layer":"",
   	 "imageServiceLayer" : "",
                     	   "bounds":  bounds = new arcgisObj.Extent({
   		                     "xmin":65697.91168999979,
   		                     "ymin":25464.57120000096,
   		                     "xmax": 84310.22871000013,
   		                     "ymax": 44888.872799999175,
   		                     "spatialReference":{"wkid":2382}
   		                   }), }, 
    "海南省国营东红农场"   :   {"layer":"",
   	 "imageServiceLayer" : "",
                  	                 "bounds": new arcgisObj.Extent({
           		                     "xmin":194717.1440799999,
           		                     "ymin":149139.13934999946,
           		                     "xmax": 219401.1115199999,
           		                     "ymax": 168692.75364999977,
           		                     "spatialReference":{"wkid":2382}
           		                   }),
                                     },   
                  "海南省国营东太农场"   :   {"layer":"",
               	   "imageServiceLayer" : "",
                    	                 "bounds":  new arcgisObj.Extent({
                 	                  	"xmin" : 50219.40844694423,
                 		                "ymin" : 38820.979982184916,
                 		                "xmax" : 79149.40844694423,
                 		                "ymax" : 69910.97998218492,
                 	                	"spatialReference" : { "wkid" : 2382 }
                 	                   })       }, 
               "海南省国营东升农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                                   "bounds":  new arcgisObj.Extent({
          		                     "xmin": 194634.04491999984,
       		                     "ymin": 126565.0820499993,
       		                     "xmax": 207293.75747999962 ,
       		                     "ymax": 142685.93294999943 ,
       		                     "spatialReference":{"wkid":2382}
       		                   }), "imageServiceLayer" : "", }, 
              "海南省国营东平农场"   :   {"layer":"",
           	   "imageServiceLayer" : "",
                          	      "bounds":  new arcgisObj.Extent({
                       	                  	"xmin" : 50219.40844694423,
                       		                "ymin" : 38820.979982184916,
                       		                "xmax" : 79149.40844694423,
                       		                "ymax" : 69910.97998218492,
                       	                	"spatialReference" : { "wkid" : 2382  }
                       	                   })    },   
                "海南省国营南俸农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                            	        "bounds":  new arcgisObj.Extent({
                         	                  	"xmin" : 50219.40844694423,
                         		                "ymin" : 38820.979982184916,
                         		                "xmax" : 79149.40844694423,
                         		                "ymax" : 69910.97998218492,
                         	                	"spatialReference" : { "wkid" : 2382 }
                         	                   })         }, 
              "海南省国营西联农场"   :   {"layer":"",
           	   "imageServiceLayer" : "",
                                	   "bounds":  new arcgisObj.Extent({
                             	                  	"xmin" : 50219.40844694423,
                             		                "ymin" : 38820.979982184916,
                             		                "xmax" : 79149.40844694423,
                             		                "ymax" : 69910.97998218492,
                             	                	"spatialReference" : { "wkid" : 2382}
                             	                   })       }, 
      "海南省国营八一农场"   :   {"layer":"",
   	   "imageServiceLayer" : "",
                               	                 "bounds":  new arcgisObj.Extent({
                            	                  	"xmin" : 50219.40844694423,
                            		                "ymin" : 38820.979982184916,
                            		                "xmax" : 79149.40844694423,
                            		                "ymax" : 69910.97998218492,
                            	                	"spatialReference" : {"wkid" : 2382}
                            	                   })
                                                  },   
        "海南省国营蓝洋农场"   :   {"layer":"",
       	 "imageServiceLayer" : "",
                                 	                 "bounds":  new arcgisObj.Extent({
                              	                  	"xmin" : 50219.40844694423,
                              		                "ymin" : 38820.979982184916,
                              		                "xmax" : 79149.40844694423,
                              		                "ymax" : 69910.97998218492,
                              	                	"spatialReference" : { "wkid" : 2382 }
                              	                   })       }, 
         "海南省国营西培农场"   :   {"layer":"",
       	  "imageServiceLayer" : "",
                                                "bounds":  new arcgisObj.Extent({
                                  	                  	"xmin" : 50219.40844694423,
                                  		                "ymin" : 38820.979982184916,
                                  		                "xmax" : 79149.40844694423,
                                  		                "ymax" : 69910.97998218492,
                                  	                	"spatialReference" : { "wkid" : 2382    }
                                  	                   })         }, 
         "海南省国营南阳农场"   :   {"layer":"",
       	  "imageServiceLayer" : "",
                                       	      "bounds":  new arcgisObj.Extent({
                                    	                  	"xmin" : 50219.40844694423,
                                    		                "ymin" : 38820.979982184916,
                                    		                "xmax" : 79149.40844694423,
                                    		                "ymax" : 69910.97998218492,
                                    	                	"spatialReference" : { "wkid" : 2382  }
                                    	                   })    },   
             "海南省国营东路农场"   :   {"layer":"",
           	  "imageServiceLayer" : "",
                                         	        "bounds":  new arcgisObj.Extent({
                                      	                  	"xmin" : 50219.40844694423,
                                      		                "ymin" : 38820.979982184916,
                                      		                "xmax" : 79149.40844694423,
                                      		                "ymax" : 69910.97998218492,
                                      	                	"spatialReference" : { "wkid" : 2382 }
                                      	                   })         }, 
         "海南省国营新中农场"   :   {"layer":"",
       	  "imageServiceLayer" : "",
                                             	   "bounds":  new arcgisObj.Extent({
                                          	                  	"xmin" : 50219.40844694423,
                                          		                "ymin" : 38820.979982184916,
                                          		                "xmax" : 79149.40844694423,
                                          		                "ymax" : 69910.97998218492,
                                          	                	"spatialReference" : { "wkid" : 2382}
                                          	                   })       }, 
    
    "海南省国营东和农场"   :   {"layer":"",
   	 "imageServiceLayer" : "",
                	        "bounds":  new arcgisObj.Extent({
             	                  	"xmin" : 50219.40844694423,
             		                "ymin" : 38820.979982184916,
             		                "xmax" : 79149.40844694423,
             		                "ymax" : 69910.97998218492,
             	                	"spatialReference" : { "wkid" : 2382 }
             	                   })         }, 
   "海南省国营东兴农场"   :   {"layer":"",
   	 "imageServiceLayer" : "",                    	   "bounds":  new arcgisObj.Extent({
                 	                  	"xmin" : 50219.40844694423,
                 		                "ymin" : 38820.979982184916,
                 		                "xmax" : 79149.40844694423,
                 		                "ymax" : 69910.97998218492,
                 	                	"spatialReference" : { "wkid" : 2382}
                 	                   })       }, 
        "海南省国营广坝农场"   :   {"layer":"",
       	 "imageServiceLayer" : "",
                   	                 "bounds":  new arcgisObj.Extent({
                	                  	"xmin" : 50219.40844694423,
                		                "ymin" : 38820.979982184916,
                		                "xmax" : 79149.40844694423,
                		                "ymax" : 69910.97998218492,
                	                	"spatialReference" : {"wkid" : 2382}
                	                   })
                                      },   
                   "海南省国营中瑞农场"   :   {"layer":"",
                   	 "imageServiceLayer" : "",
                     	                 "bounds":  new arcgisObj.Extent({
                  	                  	"xmin" : 50219.40844694423,
                  		                "ymin" : 38820.979982184916,
                  		                "xmax" : 79149.40844694423,
                  		                "ymax" : 69910.97998218492,
                  	                	"spatialReference" : { "wkid" : 2382 }
                  	                   })       }, 
                "海南省国营金鸡岭农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                                    "bounds":  new arcgisObj.Extent({
                      	                  	"xmin" : 50219.40844694423,
                      		                "ymin" : 38820.979982184916,
                      		                "xmax" : 79149.40844694423,
                      		                "ymax" : 69910.97998218492,
                      	                	"spatialReference" : { "wkid" : 2382    }
                      	                   })         }, 
               "海南省国营中坤农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                           	      "bounds":  new arcgisObj.Extent({
                        	                  	"xmin" : 50219.40844694423,
                        		                "ymin" : 38820.979982184916,
                        		                "xmax" : 79149.40844694423,
                        		                "ymax" : 69910.97998218492,
                        	                	"spatialReference" : { "wkid" : 2382  }
                        	                   })    },   
                 "海南省国营中建农场"   :   {"layer":"",
               	  "imageServiceLayer" : "",
                             	        "bounds":  new arcgisObj.Extent({
                          	                  	"xmin" : 50219.40844694423,
                          		                "ymin" : 38820.979982184916,
                          		                "xmax" : 79149.40844694423,
                          		                "ymax" : 69910.97998218492,
                          	                	"spatialReference" : { "wkid" : 2382 }
                          	                   })         }, 
               "海南省国营红光农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                                 	   "bounds":  new arcgisObj.Extent({
                              	                  	"xmin" : 50219.40844694423,
                              		                "ymin" : 38820.979982184916,
                              		                "xmax" : 79149.40844694423,
                              		                "ymax" : 69910.97998218492,
                              	                	"spatialReference" : { "wkid" : 2382}
                              	                   })       }, 
                 "海南省国营金安农场"   :   {"layer":"",
               	  "imageServiceLayer" : "",
                              	                 "bounds":  new arcgisObj.Extent({
                           	                  	"xmin" : 50219.40844694423,
                           		                "ymin" : 38820.979982184916,
                           		                "xmax" : 79149.40844694423,
                           		                "ymax" : 69910.97998218492,
                           	                	"spatialReference" : {"wkid" : 2382}
                           	                   })
                                                 },   
                              "海南省国营红华农场"   :   {"layer":"",
                           	   "imageServiceLayer" : "",
                                	                 "bounds":  new arcgisObj.Extent({
                           		                     "xmin":129424.822535,
                           		                     "ymin":166547.7546000001,
                           		                     "xmax": 148192.60376500041,
                           		                     "ymax": 202621.1633999995,
                           		                     "spatialReference":{"wkid":2382}
                           		                   }),      }, 
                           "海南省国营邦溪农场"   :   {"layer":"",
                           	 "imageServiceLayer" : "",
                                               "bounds":  new arcgisObj.Extent({
                                 	                  	"xmin" : 50219.40844694423,
                                 		                "ymin" : 38820.979982184916,
                                 		                "xmax" : 79149.40844694423,
                                 		                "ymax" : 69910.97998218492,
                                 	                	"spatialReference" : { "wkid" : 2382    }
                                 	                   })         }, 
                          "海南省国营龙江农场"   :   {"layer":"",
                       	   "imageServiceLayer" : "",
                                      	      "bounds":  new arcgisObj.Extent({
                                   	                  	"xmin" : 50219.40844694423,
                                   		                "ymin" : 38820.979982184916,
                                   		                "xmax" : 79149.40844694423,
                                   		                "ymax" : 69910.97998218492,
                                   	                	"spatialReference" : { "wkid" : 2382  }
                                   	                   })    },   
                            "海南省国营乐光农场"   :   {"layer":"lg_beizhandi",
                           	 "imageServiceLayer" : "lg_newimagedata",
                                        	        "bounds":  new arcgisObj.Extent({
                                     	                  	"xmin" : 50219.40844694423,
                                     		                "ymin" : 38820.979982184916,
                                     		                "xmax" : 79149.40844694423,
                                     		                "ymax" : 69910.97998218492,
                                     	                	"spatialReference" : { "wkid" : 2382 }
                                     	                   })         }, 
                          "海南省国营山荣农场"   :   {"layer":"",
                       	   "imageServiceLayer" : "",
                                            	   "bounds":  new arcgisObj.Extent({
                                         	                  	"xmin" : 50219.40844694423,
                                         		                "ymin" : 38820.979982184916,
                                         		                "xmax" : 79149.40844694423,
                                         		                "ymax" : 69910.97998218492,
                                         	                	"spatialReference" : { "wkid" : 2382}
                                         	                   })       }, 
                          "海南省国营保国农场"   :   {"layer":"",
                       	   "imageServiceLayer" : "",
                                           	                 "bounds":  new arcgisObj.Extent({
                                        	                  	"xmin" : 50219.40844694423,
                                        		                "ymin" : 38820.979982184916,
                                        		                "xmax" : 79149.40844694423,
                                        		                "ymax" : 69910.97998218492,
                                        	                	"spatialReference" : {"wkid" : 2382}
                                        	                   })
                                                              },   
                                           "海南省国营南平农场"   :   {"layer":"",
                                           	 "imageServiceLayer" : "",
                                             	                 "bounds":  new arcgisObj.Extent({
                                          	                  	"xmin" : 50219.40844694423,
                                          		                "ymin" : 38820.979982184916,
                                          		                "xmax" : 79149.40844694423,
                                          		                "ymax" : 69910.97998218492,
                                          	                	"spatialReference" : { "wkid" : 2382 }
                                          	                   })       }, 
                                        "海南省国营岭门农场"   :   {"layer":"",
                                       	 "imageServiceLayer" : "",
                                                            "bounds":  new arcgisObj.Extent({
                                              	                  	"xmin" : 50219.40844694423,
                                              		                "ymin" : 38820.979982184916,
                                              		                "xmax" : 79149.40844694423,
                                              		                "ymax" : 69910.97998218492,
                                              	                	"spatialReference" : { "wkid" : 2382    }
                                              	                   })         }, 
                                       "海南省国营三道农场"   :   {"layer":"",
                                       	 "imageServiceLayer" : "",
                                                   	      "bounds":  new arcgisObj.Extent({
                                    		                     "xmin":122415.2780350002,
                                   		                     "ymin":35058.79211499942,
                                   		                     "xmax": 132556.65906499955,
                                   		                     "ymax": 48961.87218500087,
                                   		                     "spatialReference":{"wkid":2382}
                                   		                   })    },   
                                         "海南省国营金江农场"   :   {"layer":"",
                                       	  "imageServiceLayer" : "",
                                                     	        "bounds":  new arcgisObj.Extent({
                                                  	                  	"xmin" : 50219.40844694423,
                                                  		                "ymin" : 38820.979982184916,
                                                  		                "xmax" : 79149.40844694423,
                                                  		                "ymax" : 69910.97998218492,
                                                  	                	"spatialReference" : { "wkid" : 2382 }
                                                  	                   })         }, 
               "海南省国营乌石农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                                     "bounds":  new arcgisObj.Extent({
            		                     "xmin":138116.716845,
           		                     "ymin":94884.75700499918,
           		                     "xmax": 177847.51685499976,
           		                     "ymax": 126604.75289500077,
           		                     "spatialReference":{"wkid":2382}
           		                   })     }, 
                
                "海南省国营长征农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                            	        "bounds":  new arcgisObj.Extent({
                         	                  	"xmin" : 50219.40844694423,
                         		                "ymin" : 38820.979982184916,
                         		                "xmax" : 79149.40844694423,
                         		                "ymax" : 69910.97998218492,
                         	                	"spatialReference" : { "wkid" : 2382 }
                         	                   })         }, 
               "海南省国营阳江农场"   :   {"layer":"",
               	 "imageServiceLayer" : "",
                                	   "bounds":  new arcgisObj.Extent({
                             	                  	"xmin" : 50219.40844694423,
                             		                "ymin" : 38820.979982184916,
                             		                "xmax" : 79149.40844694423,
                             		                "ymax" : 69910.97998218492,
                             	                	"spatialReference" : { "wkid" : 2382}
                             	                   })       }, 
                             	                  
                  "海南省国营南海农场"   :   {"layer":"",
                             	                 	 "imageServiceLayer" : "",
                             	                              	        "bounds":  new arcgisObj.Extent({
                             	                           	                  	"xmin" : 50219.40844694423,
                             	                           		                "ymin" : 38820.979982184916,
                             	                           		                "xmax" : 79149.40844694423,
                             	                           		                "ymax" : 69910.97998218492,
                             	                           	                	"spatialReference" : { "wkid" : 2382 }
                             	                           	                   })         }, 
            };   
   }
   function changeThemagic() {
	    setLayers();
	    //buildConditionNodes();
   }
   
   function createLayers() {
		
		var dynamicLayer = new arcgisObj.ArcGISDynamicMapServiceLayer(dynamicUrl, {
			"opacity" : 0.8
		});
		
		 template = new arcgisObj.InfoTemplate();
		template.setTitle("地块信息");
		template.setContent(getTextContent());

		var eventLayer = new arcgisObj.FeatureLayer(dynamicUrl + '/0', {
			"opacity" : 0,
			outFields : getOutFields(),
			infoTemplate : template
		});
		var layers;
		
	if (imageUrl!="")
		{
		 imageServiceLayer = new esri.layers.ArcGISImageServiceLayer(imageUrl);
		 layers = [ imageServiceLayer, dynamicLayer, eventLayer ];

		
		}
	else
		{layers = [  dynamicLayer, eventLayer ];}
	layerClick(eventLayer);
		return layers;
	}
   
   function handleArea(mj) {
   		return (parseFloat(mj)*3/2000).toFixed(2) + '亩';
   }
   
   function handleClass(sdl) {
	   if(sdl == 1) {
		   return '农用地';
	   } else if(sdl == 2){
		   return '建设用地';
	   } else if(sdl == 3) {
		   return '未利用地';
	   }
   }
   
   function getDisplayModel(remark, column) {
	   return '<strong>' + remark + ':</strong>${'+column+'}<br>';
   }
   
   function getTextContent() {
		return 	getDisplayModel('宗地号','ZDH')
				+ getDisplayModel('占地主体','ZDZT')
				+ getDisplayModel('占地具体时间','ZDJTSJ')
				+ getDisplayModel('做过何种处置','ZGHZCZ')
				+ getDisplayModel('占地主体名称','XTDQLR')
				+ "<strong>面积:</strong>${mj:handleArea}";
   }
   
   function getOutFields() {
		return ["ZDH","mj","ZGHZCZ","ZDZT","ZDJTSJ","XTDQLR"];
   }
   
   function buildPrinter() {
	  printer = new arcgisObj.Print({
		  	label:'sdfasd',
		  	processingText:'正在生成图片,请稍后...',
		  	showpicText:'查看图片',
	  		map:map,
			url:serverURL + '/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task'
	  }, arcgisObj.dom.byId('printButton_ownership'));
	  printer.on('print-start', function() {
		  $('#downloadBt_ownership').remove();
	  });
	  printer.on('print-complete', function(evt) {
		  //rebuildPrinter();
		  buildDoc(evt.result.url);
	  });
	 printer.startup();
   }
   
   function rebuildPrinter() {
	   printer.destroy();
	   buildPrinter();
   }
  
  function createbaseMap() {
  	 
  	 /*var bounds = new arcgisObj.Extent({
            "xmin":50219.40844694423,
            "ymin":38820.979982184916,
            "xmax": 79149.40844694423,
            "ymax": 69910.97998218492,
            "spatialReference":{"wkid":2382}
          });
	      */
		  map = new arcgisObj.Map("mapDiv_ownership", { 
            	extent: bounds
          });
		  
		  var home = new arcgisObj.HomeButton({
	        map: map
	      }, "HomeButton_ownership");
	      home.startup();
	      
		  buildLegend();
		  buildPrinter();
		  
		  /*var infoWindow = new arcgisObj.InfoWindowLite(null, arcgisObj.domConstruct.create("div", null, null, map.root));
          infoWindow.startup();*/
          //map.setInfoWindow(infoWindow);
		/*  baseMap = new  arcgisObj.ArcGISImageServiceLayer( serverURL+ "/lg_newimagedata/ImageServer", {
           		
          });*/
		//  changeThemagic();
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
			
	  }, "legend_ownership");
	  legend.startup();
  }
  
  
  
  function layerClick(fl) {
  	fl.on('click', function(evt) {
	   map.graphics.clear(); 
	   var highlightSymbol = new arcgisObj.SimpleFillSymbol(
		  arcgisObj.SimpleFillSymbol.STYLE_SOLID, 
		  new arcgisObj.SimpleLineSymbol(
			arcgisObj.SimpleLineSymbol.STYLE_SOLID, 
			new arcgisObj.Color([47,79,177]), 
			1
		  ), 
		  new arcgisObj.Color([125,125,125,0.35])
	   );
	   var highlightGraphic = new arcgisObj.Graphic(evt.graphic.geometry,highlightSymbol);
	   map.graphics.add(highlightGraphic);
	});
  }
  
  function areaStatistics() {
	  
	  var URI = 'loseLandStats';
	  
	  $.post(URI,{},function(data) {
	  		if(data) {
	  			var rows = [];
	  			var allTotal = 0;
	  			if(data.length > 0)
	  				allTotal = (parseFloat(data[0].total)*3/2000).toFixed(2);
	  			for(var index in data) {
	  				var row = {};
	  				var stats = data[index];
	  				var total = (parseFloat(stats.total)*3/2000).toFixed(2);
	  		    	row.remark = stats.remark;
	  		    	row.value = total + '亩';
	  		    	row.percent = cauculatePercent(total, allTotal);
	  		    	rows.push(row);
	  			}
	  			showData(rows);
	  			//$('#show').datagrid('loadData',rows);
	  		}
	  	}, 'json');
  }
  
  function cauculatePercent(num, total) {
	  return parseFloat((num / total) * 100).toFixed(2) + '%';
  }
  
  function showData(array) {
		$('#show_grid_ownership').empty();
		for(var index in array) {
			var remark = array[index].remark;
			var percent = array[index].percent;
			var value = array[index].value;
			var tr = $('<tr><td class="grid_td">'+remark+'</td><td class="grid_td">'+value+'</td><td class="grid_td_right">'+percent+'</td></tr>');
			
			$('#show_grid_ownership').append(tr);
		}
	}
  
  function getQueryData() {
	 var queryData = {};
	 queryData.task =  new arcgisObj.QueryTask(serverURL + '/lg_beizhandi/MapServer/0');
	 queryData.outFields = ['ZDH'];
	 queryData.where = buildWhere();
	 return queryData;
  }
  
  function getConditions() {
	  var conditions = [];
	  $('.conditions').each(function() {
		  var name = $(this).attr('name');
		  var value = $(this).val();
		  var condition = {
			  name:name,
			  value:value
		  };
		  conditions.push(condition);
	  });
	  return conditions;
  }
  
  function buildWhere() {
		  var conditions = getConditions();
		  var where = '';
		  for(var index in conditions) {
			  var condition = conditions[index];
			  if(!condition.value || condition.value.length == 0)
				  continue;
			  if(where.length > 0) {
				  where += ' and ';
			  }
			  if(condition.name == 'minmj') {
				  where += 'mj > ' + toCentiare(condition.value);
			  } else if(condition.name == 'maxmj') {
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
			if(results.features) {
			   for(var index in results.features) {
					var feature = results.features[index];
					var extent = feature.geometry.getExtent();
					var result = {
						extent:extent,
						feature:feature
					};
					queryResult.push(result);
			   }
		   	   if(queryResult.length > 0) {
		   		   displayResult(queryResult);
		   	   } else {
		   		   $.messager.alert('提示', '没有符合条件的地块', 'info');
		   	   }
			}
	  });
	 
  }
  
  function getExtent(queryResult) {
	  var xmin =0;
	  var ymin = 0;
	  var xmax = 0;
	  var ymax = 0;
	  for(var index in queryResult) {
		  var extent = queryResult[index].extent;
		  if(xmin ==0) {
			  xmin = extent.xmin;
		  }
		  if(ymin == 0) {
			  ymin = extent.ymin;
		  }
		  if(xmax == 0) {
			  xmax = extent.xmax;
		  }
		  if(ymax == 0) {
			  ymax = extent.ymax;
		  }
		  xmin = (xmin > extent.xmin ? extent.xmin : xmin);
		  ymin = (ymin > extent.ymin ? extent.ymin : ymin);
		  xmax = (xmax > extent.xmax ? xmax : extent.xmax);
		  ymax = (ymax > extent.ymax ? ymax : extent.ymax);
	  }
	  return new arcgisObj.Extent({
	      "xmin":xmin,
	      "ymin":ymin,
	      "xmax":xmax,
	      "ymax":ymax,
	      "spatialReference":{"wkid":2382}
	  });
  }
  
  /**
 * @param queryResult
 * @returns
 */
function displayResult(queryResult) {
	  map.graphics.clear(); 
	  map.infoWindow.hide();
	  for(var index in queryResult) {
		  var feature = queryResult[index].feature;
		  var highlightSymbol = new arcgisObj.SimpleFillSymbol(
			  arcgisObj.SimpleFillSymbol.STYLE_SOLID, 
			  new arcgisObj.SimpleLineSymbol(
				arcgisObj.SimpleLineSymbol.STYLE_SOLID, 
				new arcgisObj.Color([47,79,177]), 
				1
			  ), 
			  new arcgisObj.Color([125,125,125,0.35])
		   );
		   var highlightGraphic = new arcgisObj.Graphic(feature.geometry,highlightSymbol);
		   
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
		  content += '<strong>占地主体：</strong>' + attribute.ZDZT + '<br>';
		  content += '<strong>占地具体时间：</strong>' + attribute.ZDJTSJ + '<br>';
		  content += '<strong>做过何种处置：</strong>' + attribute.ZGHZCZ + '<br>';
		  content += '<strong>占地主体名称：</strong>' + attribute.XTDQLR + '<br>';
		  content += '<strong>面积：</strong>' + parseMu(attribute.mj) + '亩';
	  return content;
  }
/*  function setLayers() {
		
		
					var layers = createLayers();
					map.addLayers(layers);
					legend.refresh([{layer:layers[1], title:'图例'}]);
				
					areaStatisticsrow();   
					   // areaStatisticsrow();
			
		return;
		
	}*/
  function setLayers() {
		/*var layers = createLayers();
		map.addLayers(layers);
		areaStatisticssum();
		legend.refresh([{layer:layers[1], title:'芒果分布'}]);*/
	  var layers = createLayers();
		map.addLayers(layers);
		if (imageServiceLayer!="")
		{
			if(layers[1].loaded)
				{
		     buildLayerList(layers[1]);
				}
			else
				{       
		     dojo.connect(layers[1], "onLoad", buildLayerList);
				}
		}
		else
		{
				if(layers[0].loaded)
				{
					buildLayerList(layers[0]);
				}
			else
				{       
					dojo.connect(layers[0], "onLoad", buildLayerList);
				}
		}
		
		
		areaStatisticsrow();
		legend.refresh([{layer:layers[1], title:'图例'}]);
         return;
}
function buildLayerList(layers) 
{	var treeList = [] ;// jquery-easyui的tree用到的tree_data.json数组
var parentnodes = [] ;// 保存所有的父亲节点
var root = {"id":"rootnode","text":"自营经济", "children":[]} ;// 增加一个根节点
var node = {} ;
	 
	        var layerinfos = layers.layerInfos ;
	       
	        if (layerinfos != null && layerinfos.length > 0) 
	        {
	           
	            for(var i=0,j=layerinfos.length;i<j;i++)
	            {
	                var info = layerinfos[i] ;
	                if (info.defaultVisibility)
	                {
	                    visible.push(info.id);
	                }
	                node = {
	                    "id":info.id,
	                    "text":info.name,
	                    "pid":info.parentLayerId,
	                  "iconCls":" icon-tip", 
	                    "checked":info.defaultVisibility ? true:false,
	                    "children":[]
	                    
	                   
	                   
	                } ;
	                if(info.parentLayerId==-1)
	                {
	                    parentnodes.push(node) ;
	                    root.children.push(node) ;
	                }
	                else
	                {
	                     getChildrenNodes(parentnodes, node);
	                      parentnodes.push(node) ;
	                }
	            }
	        }
		
	  treeList.push(node) ;
    // jquery-easyui的树
    $('#toc_ownership').tree({   
        data:treeList ,
        checkbox :true, // 使节点增加选择框
       
        onCheck:function (node,checked){// 更新显示选择的图层
            var visible = [];

            var nodes = $('#toc_ownership').tree("getChecked") ;
            dojo.forEach(nodes, function(node) {
                visible.push(node.id);
            });
         
            if (visible.length === 0) {
                visible.push(-1);
            }
            layers.setVisibleLayers(visible);
        }
    });         

    layers.setVisibleLayers(visible);

	        
}
	function areaStatisticsrow() {
		var QTask = new esri.tasks.QueryTask( dynamicUrl +"/0");
		
		

		var queryStatistic = new esri.tasks.Query();
		queryStatistic.outFields = [ "*" ];

		queryStatistic.groupByFieldsForStatistics = [ "XTDQLR" ];

		
		var statDef = new esri.tasks.StatisticDefinition();
		statDef.statisticType = "sum";	
		statDef.onStatisticField = "MJ";
		statDef.outStatisticFieldName = "sumMj";
		queryStatistic.outStatistics = [ statDef ]; // statDef0,
		queryStatistic.ReturnGeometry = false;
		queryStatistic.orderByFields = [ "sumMj DESC" ];

		
		QTask.execute(queryStatistic, ShowQueryStatistic);
	}
	function areaStatisticssum() {
		var QTask = new esri.tasks.QueryTask(dynamicUrl +"/0");
		// var queryName = "芒果";
		// var queryName0 = "农地";
		// var whereStr = " SHUZHONG like '%" + queryName + "%' or SHUZHONG like '%"
		// + queryName0 + "%'" ;
		var queryStatistic2 = new esri.tasks.Query();// 统计总面积
		var statDef2 = new esri.tasks.StatisticDefinition();
		statDef2.statisticType = "sum";
		statDef2.onStatisticField = "MJ";
		statDef2.outStatisticFieldName = "sumMj";
		queryStatistic2.outStatistics = [ statDef2 ];
		queryStatistic2.ReturnGeometry = false;
		QTask.execute(queryStatistic2, ShowQueryStatistic2);
	return true;
		
	}
	function ShowQueryStatistic2(results) {
		// alert(results.features[0].attributes.sumMj);
		sum = results.features[0].attributes.sumMj;
		$('#show_grid_ownership').empty();
		var tr_head = $('<tr><td class="grid_td">' + "地类名称"
				+ '</td><td class="grid_td">' + "面积(亩)"
				+ '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
		$('#show_grid_ownership').append(tr_head);
		var tr_head2 = $('<tr><td class="grid_td">' + "总面积"
				+ '</td><td class="grid_td">' + (sum * 3 / 2000).toFixed(2)
				+ '</td><td class="grid_td_right">' + "100%" + '</td></tr>');
		$('#show_grid_ownership').append(tr_head2);

	}
	function ShowQueryStatistic(results) {		
		var zmj=0;
		var resultCount = results.features.length;
		for ( var i = 0; i < resultCount; i++) {
			var attr= results.features[i].attributes;
		//	var DLMC = attr.DLMC;
			// var count = results.features[i].attributes.count;
			var sumMj = attr.sumMj;
			zmj=zmj+sumMj;
			
		}
		$('#show_grid_ownership').empty();
		var tr_head = $('<tr><td class="grid_td">' + "地类名称"
				+ '</td><td class="grid_td">' + "面积(亩)"
				+ '</td><td class="grid_td_right">' + "比例" + '</td></tr>');
		$('#show_grid_ownership').append(tr_head);
		var tr_head2 = $('<tr><td class="grid_td">' + "总面积"
				+ '</td><td class="grid_td">' + (zmj * 3 / 2000).toFixed(2)
				+ '</td><td class="grid_td_right">' + "100%" + '</td></tr>');
		$('#show_grid_ownership').append(tr_head2);
		for ( var i = 0; i < resultCount; i++) {
			var attr= results.features[i].attributes;
			var DLMC = attr.XTDQLR;
			// var count = results.features[i].attributes.count;
			var sumMj = attr.sumMj;
			var percert = Math.round(sumMj / zmj * 10000) / 100.00 + "%";

			var trl = $('<tr><td class="grid_td">' + DLMC
					+ '</td><td class="grid_td">' + (sumMj * 3 / 2000).toFixed(2)
					+ '</td><td class="grid_td_right">' + percert + '</td></tr>');

			$('#show_grid_ownership').append(trl);
		}
	}
