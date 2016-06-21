<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.trackDisplayTable{
	width:750px;
	height:auto;
	font-size: 12px;
	cellspacing:0;
	cellpadding:0;
	border-collapse:collapse;
	border-radius: 5px;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
}
.trackDisplayTable tr  td{ 
	border:1px solid #95B8E7;
	text-align:center;
}
.btn_group{
		margin-top:20px;
		margin-bottom:15px;
		text-align:center;
	}
</style>
<div id="trackDisplayContainer" style="padding:5px 5px 5px 5px;">
<table class="trackDisplayTable" style="width:99%;margin:5px 5px 5px 5px;">
  <tr>
  	<td width="5%">序号</td>
  	<td width="15%">目前状态</td>
    <td width="15%">操作人</td>
    <td width="20%">操作时间</td>
    <td width="20%">操作内容</td>
    <td width="25%">处理意见</td>
  </tr>
<c:forEach items="${tracks }" var ="track"  varStatus="status">
 <tr>
 	<td>${status.index+1}</td>
  	<td>
  		<jksb:diction id="currentStatus" name="currentStatus" groupId="BPM_STATUS"  
  			dictValue="${track.currentStatus }"  display="Y"  >
		</jksb:diction>
  	</td>
    <td>${track.operateAccount }</td>
    <td>
    	<fmt:parseDate value="${track.operateDate }" var="operateDate" type="both"/>  
		<fmt:formatDate value="${operateDate }" type="both"/> 
    </td>
    <td>
    	<jksb:diction id="currentStatus" name="currentStatus" groupId="BPM_STATUS"  
  			dictValue="${track.operateContent }"  display="Y"  >
		</jksb:diction>
    </td>
    <td>${track.opinion }</td>
  </tr>
</c:forEach>
</table>
<!-- <div class="btn_group">
	<div style="display:inline;">
		<a id="cancel_btn" href="#" class="easyui-linkbutton" style="width:60px;height:25px;" >关闭取消</a>
	</div>
</div> -->
<!-- <div id="track_slider" style="height:100px;width:500px"></div> -->
</div>
<script>
$('#track_slider').slider({
	width:'90%',
    showTip:false,
    rule:['|','开始','申请','审批','结束','|']
});
</script>