/**
 * Map封装关于gis用到的js方法
 */
var ArcGIS = function() {
};
ArcGIS.prototype = {
	/*
	 * 添加home和比例尺控件
	 */
	addDijit : function(homeButtonElement) {
		var home = new arcgisObj.HomeButton({
			map : map
		}, homeButtonElement);
		home.startup();
		// "dual" displays both miles and kilmometers
		// "english" is the default, which displays miles
		// use "metric" for kilometers
		var scalebar = new arcgisObj.Scalebar({
			map : map,
			attachTo : "bottom-left",
			scalebarUnit : "metric"
		});
	},
	/*
	 * 添加图层控制
	 */
	addToc : function(layerInfos, tocElement) {
		toc = new arcgisObj.TOC({
			map : map,
			layerInfos : layerInfos
		}, tocElement);
		toc.startup();
	},
	/*
	 * 设置选择农场
	 */
	seclecFarm : function(service, data, field, selectFarmElement,
			statisticsElement) {
		var that = this;
		console.log("service:" + service + ", data:" + data + ", field:"
				+ field + ", selectFarmElement:" + selectFarmElement
				+ ",statisticsElement:" + statisticsElement);
		$(selectFarmElement).combobox({
			valueField : 'code',
			textField : 'name',
			data : data,
			onSelect : function(rec) {
				var value = rec.name;// 获得选择农场名称
				var farmNo = rec.code;
				map.graphics.clear();
				that.farmSearch(service, value, field);
				that.areaStatisticsrow(farmNo);
				$(statisticsElement).text(value + " 地块统计信息");
				console.log("开始选择农场");
			},
			onLoadSuccess : function(rec) {
				var data = $(selectFarmElement).combobox('getData');
				if (data.length == 1) {
					$(selectFarmElement).combobox('select', data[0].code);
				}
			}
		});
	},
	seclecFarm20 : function(service, data, field, selectFarmElement,
			statisticsElement) {
		var that = this;
		console.log("service:" + service + ", data:" + data + ", field:"
				+ field + ", selectFarmElement:" + selectFarmElement
				+ ",statisticsElement:" + statisticsElement);
		$(selectFarmElement).combobox({
			valueField : 'code',
			textField : 'name',
			data : data,
			onSelect : function(rec) {
				var value = rec.name;// 获得选择农场名称
				var farmNo = rec.code;
				map.graphics.clear();
				that.farmSearch(service, value, field);
				console.log("开始选择农场");
			},
			onLoadSuccess : function(rec) {
				var data = $(selectFarmElement).combobox('getData');
				if (data.length == 1) {
					$(selectFarmElement).combobox('select', data[0].code);
				}
			}
		});
	},
	/*
	 * 地块查询
	 */
	landSearch : function(service, field, where) {
		var that = this;
		var queryTask = new arcgisObj.QueryTask(service);
		var query = new arcgisObj.Query();
		query.returnGeometry = true;
		query.maxAllowableOffset = 10;
		query.num = 2000;
		query.outFields = field;
		console.log(where);
		if (where != '') {
			query.where = where;
			console.log(query.where);
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
						that.displayResult(queryResult);
					} else {
						$.messager.alert('提示', '没有符合条件的地块', 'info');
					}
				} else {
					$.messager.alert('提示', '没有符合条件的地块', 'info');
				}
			});
		} else {
			$.messager.alert('提示', '请输入条件', 'info');
		}
	},
	/*
	 * 显示结果
	 */
	displayResult : function(queryResult) {
		var that = this;
		map.graphics.clear();
		map.infoWindow.hide();
		for ( var index in queryResult) {
			var feature = queryResult[index].feature;
			// var highlightSymbol = new arcgisObj.SimpleFillSymbol(
			// arcgisObj.SimpleFillSymbol.STYLE_SOLID,
			// new arcgisObj.SimpleLineSymbol(
			// arcgisObj.SimpleLineSymbol.STYLE_SOLID,
			// new arcgisObj.Color([ 47, 79, 177 ]), 1),
			// new arcgisObj.Color([ 125, 125, 125, 0.35 ]));
			var highlightSymbol = new arcgisObj.SimpleLineSymbol(
					arcgisObj.SimpleLineSymbol.STYLE_SOLID,
					new arcgisObj.Color([ 240, 230, 140 ]), 3);
			var highlightGraphic = new arcgisObj.Graphic(feature.geometry,
					highlightSymbol);
			// var template = new arcgisObj.InfoTemplate();
			// template.setTitle("地块信息");
			// template.setContent(this.getShowContent(feature.attributes));
			// highlightGraphic.setInfoTemplate(template);
			map.graphics.add(highlightGraphic);
		}
		map.setExtent(that.getExtent(queryResult));
	},
	/*
	 * 统计地块信息
	 */
	areaStatisticsrow : function(service, field, awhere, groupField,
			statisticField, showElement, farmNo) {
		var QTask = new esri.tasks.QueryTask(service);
		var queryStatistic = new esri.tasks.Query();
		if (farmNo != "" && farmNo != undefined) {
			// queryStatistic.where = "farmCode = " + farmNo;
			queryStatistic.where = awhere + farmNo;
			console.log(queryStatistic.where);
		} else {
			queryStatistic.where = "1=1";
		}
		queryStatistic.outFields = field;
		queryStatistic.groupByFieldsForStatistics = groupField;
		var statDef = new esri.tasks.StatisticDefinition();
		statDef.statisticType = "sum";
		statDef.onStatisticField = statisticField;
		statDef.outStatisticFieldName = "sumMj";
		queryStatistic.outStatistics = [ statDef ]; // statDef0,
		queryStatistic.ReturnGeometry = false;
		queryStatistic.orderByFields = [ "sumMj DESC" ];
		QTask.execute(queryStatistic,
				function(results) {
					var zmj = 0;
					var resultCount = results.features.length;
					for (var i = 0; i < resultCount; i++) {
						var attr = results.features[i].attributes;
						var sumMj = attr.sumMj;
						zmj = zmj + sumMj;
					}
					$(showElement).empty();
					var tr_head = $('<tr><td class="grid_td">' + "地类名称"
							+ '</td><td class="grid_td">' + "面积(亩)"
							+ '</td><td class="grid_td_right">' + "比例"
							+ '</td></tr>');
					$(showElement).append(tr_head);
					var tr_head2 = $('<tr><td class="grid_td">' + "总面积"
							+ '</td><td class="grid_td">'
							+ (zmj * 3 / 2000).toFixed(2)
							+ '</td><td class="grid_td_right">' + "100%"
							+ '</td></tr>');
					$(showElement).append(tr_head2);
					for (var i = 0; i < resultCount; i++) {
						var attr = results.features[i].attributes;
						var DLMC = attr[groupField];
						var sumMj = attr.sumMj;
						var percert = Math.round(sumMj / zmj * 10000) / 100.00
								+ "%";
						var trl = $('<tr><td class="grid_td">' + DLMC
								+ '</td><td class="grid_td">'
								+ (sumMj * 3 / 2000).toFixed(2)
								+ '</td><td class="grid_td_right">' + percert
								+ '</td></tr>');
						$(showElement).append(trl);
					}
				});
	},
	/*
	 * 农场位置定位
	 */
	farmSearch : function(service, ncmc, field) {
		console.log("service:" + service + ", ncmc:" + ncmc + ", field:"
				+ field);
		var that = this;
		var queryTask = new arcgisObj.QueryTask(service);
		var query = new arcgisObj.Query();
		query.returnGeometry = true;
		query.maxAllowableOffset = 10;
		query.num = 10000;
		query.outFields = field;
		if (ncmc != "" && ncmc != undefined) {
			query.where = " NCMC like '" + '%' + ncmc + '%' + "'";
		}
		console.log(query.where);

		queryTask.execute(query, function(results) {
			var queryResult = [];
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
					map.graphics.clear();
					map.infoWindow.hide();
					map.setExtent(that.getExtent(queryResult));
				} else {
					$.messager.alert('提示', '没有符合条件的地块', 'info');
				}
			}
		});
	},
	/*
	 * 获取结果范围
	 */
	getExtent : function(queryResult) {
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
		console.log("范围:xmin:" + xmin + ",ymin:" + ymin + ",xmax:" + xmax
				+ ",ymax:" + ymax);
		return new arcgisObj.Extent({
			"xmin" : xmin,
			"ymin" : ymin,
			"xmax" : xmax,
			"ymax" : ymax,
			"spatialReference" : {
				"wkid" : 2382
			}
		});
	},
	/*
	 * 被占地查询条件
	 */
	buildWhere : function(whereValue) {
		where = '';
		if (whereValue != '') {
			where = " ZDH = '" + whereValue + "'";
		}
		console.log("whereValue:" + whereValue + ",where:" + where);
		return where;
	},
	/*
	 * 平方米转换成亩，保留两位小数
	 */
	parseMu : function(centiare) {
		return (parseFloat(centiare) / 666.67).toFixed(2);
	},
	/*
	 * 显示结果信息模板
	 */
	getShowContent : function(attribute) {
		var content = '';
		content += '<strong>宗地号:</strong>' + attribute.ZDH + '<br>';
		content += '<strong>占地主体：</strong>' + attribute.ZDZT + '<br>';
		content += '<strong>占地具体时间：</strong>' + attribute.ZDJTSJ + '<br>';
		content += '<strong>做过何种处置：</strong>' + attribute.ZGHZCZ + '<br>';
		content += '<strong>占地主体名称：</strong>' + attribute.XTDQLR + '<br>';
		content += '<strong>面积：</strong>' + this.parseMu(attribute.mj) + '亩';
		return content;
	},
	/*
	 * 农用地调查
	 */
	buildWhereAgri : function() {
		var where = '';
		if (this.getConditions() != "") {
			var conditions = this.getConditions();
			for ( var index in conditions) {
				var condition = conditions[index];
				if (where.length > 0) {
					where += ' and ';
				}
				if (!condition.value || condition.value.length == 0) {
					continue;
				} else {
					where += (condition.name + "='" + condition.value + "' ");
				}
			}
		}
		return where;
	},
	getConditions : function() {
		var conditions = [];
		var i = 2;
		$('.conditions').each(function() {
			if ($(this).val() != "") {
				var name = $(this).attr('name');
				var value = $(this).val();
				var condition = {
					name : name,
					value : value
				};
				conditions.push(condition);
			}
		});
		return conditions;
	},
	/**
	 * 农用地地图跳转，跳转到iframe页面
	 * @param url
	 * @param title
	 * @param zdCode
	 * @param ncCode
	 * @param contactElement
	 */
	map2Contact : function(url, title, zdCode, ncCode, contactElement) {
		if (zdCode.length <= 0||ncCode.length <= 0) {
			$.messager.alert("地块号为空，不能跳转。");
			return;
		}
		var flag = parent.$(contactElement).tabs('exists', title);// 判断合同信息框是否已经加载,如加载,先关闭
		if (flag) {
			parent.$(contactElement).tabs('close', title);
		}
		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url + "?farmCode=" + ncCode + "&zdCode=" + zdCode+'" style="width:99%;height:99%;"></iframe>';  
		parent.$(contactElement).tabs('add', {
			title : title,
			content :content ,// 加载合同信息tab
			closable : true,
			cache : true
		});
		return;
	},
	buildAgriQueryWhere : function(zdCode, ncCode) {
		var zdCodes = zdCode.split(",");// 多个地块用,分隔
		var where;
		if (zdCodes.length == 1) {
			where = "farmcode='" + ncCode + "' and " + "编号='" + zdCode + "'";
		} else if (zdCodes.length > 1) {
			/*
			 * 当宗地号大于一个时，sql为farmcode='313' and (DKBH='2323' or DKBH='545')(举例)
			 */
			where = "farmcode='" + ncCode + "' and (编号='" + zdCodes[0] + "'";
			for (var j = 1; j < zdCodes.length; j++) {
				where += " or 编号='" + zdCodes[j] + "'";
			}
			where += ")";
		}
		return where;
	},
	/**
	 * 运用GP工具导入shp数据到数据库
	 */

	importData : function(importData, outputDatabase, service) {
		// var importData =
		// "D:\\arcgisserver\\directories\\arcgissystem\\arcgisuploads\\services\\ImportData.GPServer\\i3b9a5afa-d028-4bf8-a254-6206e681d7ba\\bou1_4p.shp";
		// var outputDatabase =
		// "F:\\imagedata\\upload.sde\\rims_arcgis.DBO.shiyan";
		// gp工具参数
		var params = {
			"ImportData" : importData,
			"OutputDatabase" : outputDatabase
		};
		// gp工具的
		// gpTask = new arcgisObj.Geoprocessor(
		// "http://10.215.201.151:6080/arcgis/rest/services/ImportData/GPServer/imortdata");
		gpTask = new arcgisObj.Geoprocessor(service);
		gpTask.submitJob(params, displayResult, errorGP);
		function displayResult(evt) {
			console.log(evt);
		}
		function errorGP() {
			console.log(evt);
		}
	}
};