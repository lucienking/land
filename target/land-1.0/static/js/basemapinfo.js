var datafarm;
var ht;
function initFarmdata()
{
	datafarm=[];
	
	var keys= Object.keys(ht);
	for(var i=1;i<keys.length+1;i++)
	{var key= keys[i-1];
		datafarm.push({
			"name": key,
			"code": i,
			"selected":false
			
		});
	}	
}

function initFarmht() {
    ht = {
        "海南省国营东昌农场": {
            "layer": "dcnc_20150210_zyjj",
            "selfEonomylayer":"zyjj_hnnc_20150811",
            "ownnershipinfolayer":"quanshu_hnnc",
            "bounds": new arcgisObj.Extent({
                "xmin": 215835.44128499986,
                "ymin": 159895.37725000028,
                "xmax": 231686.21501500005,
                "ymax": 176334.36575000043,
                "spatialReference": {
                    "wkid": 2382
                }
            }),
            "imageServiceLayer": "",
        },

        "海南省国营红明农场": {
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "nbnc_20150210_zyjj",
            "imageServiceLayer": "",
            "ownnershipinfolayer":"quanshu_hnnc",
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
            "layer": "nhnc_20150210_zyjj",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "dsnc_20150210_zyjj",
            "imageServiceLayer": "",
            "ownnershipinfolayer":"quanshu_hnnc",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "hhnc_20150210_zyjj",
            "imageServiceLayer": "",
            "ownnershipinfolayer":"quanshu_hnnc",
            "selfEonomylayer":"zyjj_hnnc_20150811",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
            "imageServiceLayer": "lg_newimagedata",
            "phlayer":"lg_gengdiziyuanguanlidanyuan_pH",
            "landuseplanlayer":"lg_zongtiguihua_GHDL",
            "ownnershipinfolayer":"quanshu_hnnc",
            "selfEonomylayer":"zyjj_hnnc_20150811",
            "bounds": new arcgisObj.Extent({
                "xmin": 276104.63101864,
                "ymin": 2038857.314874999,
                "xmax": 317537.10128136026,
                "ymax": 2071734.1242249997,
                "spatialReference": {
                    "wkid": 2382
                }
            }),
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
        "海南省国营山荣农场": {
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
            "ownnershipinfolayer":"quanshu_hnnc",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 157239.699900,
                "ymin": 53355.977300,
                "xmax": 172589.227700,
                "ymax": 68185.030900,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
        "海南省国营三道农场": {
            "layer": "sdnc_20150210_zyjj",
            "ownnershipinfolayer":"quanshu_hnnc",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "wsnc_20150210_zyjj",
            "ownnershipinfolayer":"quanshu_hnnc",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({
                "xmin": 138340.168500,
                "ymin": 95956.385700,
                "xmax": 177510.569300,
                "ymax": 125245.377900,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },

        "海南省国营长征农场": {
            "layer": "lg_ziyingjingji",
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
            "layer": "lg_ziyingjingji",
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
            "layer": "nhnc_20150210_zyjj",
            "ownnershipinfolayer":"quanshu_hnnc",
            "imageServiceLayer": "",
            "bounds": new arcgisObj.Extent({

                "xmin": 195750.611200,
                "ymin": 149106.131000,
                "xmax": 218904.675600,
                "ymax": 168177.500800,
                "spatialReference": {
                    "wkid": 2382
                }
            })
        },
    };
}