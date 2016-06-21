$.extend($.fn.validatebox.defaults.rules, {
	date: {
        validator: function(value,param){
        	value = value.replace(/\s+/g, "");
			if (String.prototype.parseDate){
				var pattern = param[0] || 'yyyy-MM-dd';
				return !value || value.parseDate(pattern);
			} else {
				return value.match(/^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/);
			}
        },
        message: '请输入正确的日期格式'
    },
    number: {
        validator: function(value,param){
        	return /^\d*$/.test(value);
        },
        message: '请输入整数'
    },
    fnumber: {
        validator: function(value,param){
        	return /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(value);
        },
        message: '请输入数字'
    },
    cellphone: {
        validator: function(value,param){
            return /^[0-9]{11}$/.test(value);
        },
        message: '请输入合法的手机号码'
    },
    idcard: {
        validator: function(value,param){
            return /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/.test(value)|| /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}[0-9 a-zA-Z]{1}$/.test(value);
        },
        message: '请输入合法的身份证号'
    },
    lte: {
        validator: function(value, param){
        	var type=param[0];
        	if(type=="int"){
        		value=parseInt(value);
			}else{
				value=parseFloat(value);
			}
        	var targetVal=param[1];
        	if(targetVal==""){
        		targetVal=0;
        	}
            return value <= targetVal;
        },
        message: '不能大于{1}'
    },
    checkRegion : {
		validator: function(value,param){
			var flag = true;
			var dataStr;
			var $id=$(param[0]);
			if($id.length>0){
				dataStr='dataId='+$id.val()+'&regionId='+value;
			}else{
				dataStr='regionId='+value;
			}
			$.ajax({
				url:$("#hddCheckRegionUrl").val(),
				data:dataStr,
				type:'GET',
				async:false,
				contentType:'application/json',
				dataType : 'json',  
		        success : function(data) {  
		    		if(data.code == 0){
		    			flag = false;
		    		}
		        },
		        error:function( xhr, status, error){
		        	$.messager.alert('提示', error, 'error');
		        }
			});
			return flag;
		},
		message: '已存在该地块编号的合同'
	},
	checkAgeLimit: {
        validator: function(value,param){
        	var idnumber=$("#partyBIDNumber").val();
        	var valid=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/.test(idnumber)|| /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}[0-9 a-zA-Z]{1}$/.test(idnumber);
        	var remain=30;
        	if(valid){
        		var len=idnumber.length;
        		var currentYear=$("#contractYear").val();
        		var year;
        		var sex;
        		if(len==18){
        			year=idnumber.substr(6,4);
        			sex=idnumber.substr(16,1);
        		}else if(len==15){
        			year="19"+idnumber.substr(6,2);
        			sex=idnumber.substr(14,1);
        		}
        		var age=parseInt(currentYear)-parseInt(year);
        		
        		if(sex%2==1){//男
        			remain=60-age;
        		}else{//女
        			remain=55-age;
        		}
        	}else{
        		return true;
        	}
            return value<=remain;
        },
        message: '承包期不得超过法定退休年龄'
    }
});