<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx }/static/js/print/printThis.js"></script>
<script type="text/javascript">
	function Preview() {
	    $("#printContent").printThis({
	        debug: false,
	        importCSS: true,
	        importStyle: true,
	        printContainer: true,
	        pageTitle: "",
	        removeInline: false,
	        printDelay: 333,
	        header: null,
	        formValues: true
	    });
	};
</script>
<style>
	.printPage{
		width:210mm;
		height:297mm;
	    page-break-before: auto;
	    page-break-after: always;
	}
	.printPagelast{
		width:210mm;
		height:297mm;
	    page-break-before: auto;
	    page-break-after: auto;
	}
	.printPage img{
		width:100%;
		height:100%;
	}
	.printPagelast img{
		width:100%;
		height:100%;
	}
	.titleDiv{
		width:100%;
		height:8mm;
		text-align:center;
		font-weight:bold;
		font-size:7mm;
		padding-top:4mm;
	}
	.bottomDiv{
		float:left;
	}
	.bottomDiv-left{
		float:left;
		width:104mm;
		height:23mm;
		text-align:left;
		font-size:3mm;
	}
	.bottomDiv-right{
		float:left;
		width:104mm;
		height:23mm;
		text-align:right;
		font-weight:bold;
		font-size:4mm;
	}
</style>

<div id= "printContent">
<c:forEach  items="${pageList}" var="jpgUrl" varStatus="stat">
	<c:if test="${!stat.last}">
    	<div class="printPage">
    </c:if>
    <c:if test="${stat.last}">
    	<div class="printPagelast">
    </c:if>
    <div class="titleDiv">
		${title==""?"某某队承包(租赁)宗地图":title }
	</div>
	<div class="contentDiv" style="width:200mm;height:260mm;text-align:center;" >
	<c:if test="${jpgUrl.size() ==1 }">
		<div class="oneParcel" style="width:200mm;height:260mm;text-align:center;" >
			<img alt="" src="${jpgUrl[0] }"   >
		</div>
	</c:if>
	<c:if test="${jpgUrl.size() ==2 }">
		<div class="twoParcel" style="width:200mm;height:130mm;text-align:center;" >
			<img alt="" src="${jpgUrl[0]  }"   >
		</div>
		<div class="twoParcel" style="width:200mm;height:130mm;text-align:center;" >
 			<img alt="" src="${jpgUrl[1]  }"  >
		</div>
	</c:if>
	<c:if test="${jpgUrl.size() ==3 }">
		<div class="threeParcel" >
			<div class="" style="float:left;width:100mm;height:130mm;text-align:center;">
				<img alt="" src="${jpgUrl[0]  }" >
			</div>
 			<div style="float:left;width:100mm;height:130mm;text-align:center;">
				<img alt="" src="${jpgUrl[1]  }"  >
			</div>
			<div style="float:left;width:200mm;height:130mm;text-align:center;">
				<img alt="" src="${jpgUrl[2]  }" >
			</div>
		</div>
	</c:if>
	<c:if test="${jpgUrl.size() ==4 }">
		<div class="fourParcel" style="display:block;width:200mm;">
			<div class="" style="float:left;width:100mm;height:130mm;text-align:center;">
				<img alt="" src="${jpgUrl[0]  }"  >
			</div>
 			<div style="float:left;width:100mm;height:130mm;text-align:center;">
				<img alt="" src="${jpgUrl[1]  }"   >
			</div>
			<div style="float:left;width:100mm;height:130mm;text-align:center;">
				<img alt="" src="${jpgUrl[2]  }"   >
			</div>
			<div style="float:left;width:100mm;height:130mm;text-align:center;">
				<img alt="" src="${jpgUrl[3]  }"  >
			</div>
		</div>
	</c:if>
	</div>
	<div class="bottomDiv">
	<div class="bottomDiv-left">
		${date }
		<br>
		海南平面坐标系
	</div>
	<div class="bottomDiv-right">
		<br>
		<br>
		<br>
		<br>
		${department==""?"海南农垦国土局":department }
	</div>
	</div>
	</div>
 </c:forEach>	
</div>
<div class="toolbar" style="width:219mm;height:40px;margin-top:15px;text-align:center;border:none;">
 <input type="button" value="确认打印" onclick="javascript:Preview();" width="120px"/>
</div>
