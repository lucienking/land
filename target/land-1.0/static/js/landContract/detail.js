$(document).ready(function(){
	
	$.extend($.fn.window.methods , {  
		move: function(jq, param){
			return jq.each(function(){
				moveWindow(this, param);
			});
		} 
	});
	
});

/*function contractTypeSelectd(){
	var conSel = $('#contractTypeSel option:selected').val();
	var oTable = $("#tbMain");
	if(conSel == 1 || conSel == ""){
		oTable.find("#tr1").show();
		oTable.find("#tr2").show();
		oTable.find("#tr3").show();
		oTable.find("#tr11").show();
		oTable.find("#tr12").show();
		oTable.find("#tr13").show();
		oTable.find("#tr14").show();
		oTable.find("#tr4").hide();
		oTable.find("#tr5").hide();
		oTable.find("#tr6").hide();
		oTable.find("#tr7").hide();
		oTable.find("#tr8").hide();
		oTable.find("#tr9").hide();
		oTable.find("#tr10").hide();
	}else if(conSel == 2 || conSel == 3 || conSel == 4){
		oTable.find("#tr1").hide();
		oTable.find("#tr2").hide();
		oTable.find("#tr3").hide();
		oTable.find("#tr11").hide();
		oTable.find("#tr12").hide();
		oTable.find("#tr13").hide();
		oTable.find("#tr14").hide();
		oTable.find("#tr4").show();
		oTable.find("#tr5").show();
		oTable.find("#tr6").show();
		oTable.find("#tr7").show();
		oTable.find("#tr8").show();
		oTable.find("#tr9").show();
		oTable.find("#tr10").show();
	}
}*/

function closeContract(){
	$('#win').window('destroy');
	//$("#win").window('close');
}
