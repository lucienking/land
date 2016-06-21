<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

		    	<table id="tbMain" style="width:630px;" align="left" cellspacing="0" cellpadding="5">
		    	<tr><td colspan="7" class="common2">承包地信息</td></tr>
		  			<tr><td align="center" style="width:40px;">序号</td><td style="width:100px;">地块编号</td><td style="width:80px;">地类(等级)</td>
		  			<td style="width:80px;">面积(亩)</td><td style="width:80px;">土地现状</td>
		  			<td style="width:100px;">收费标准(元/亩)</td><td style="width:80px;">收费金额(元)</td>
		  			</tr>
		  		<tr>
		  		<c:forEach var="regList" items="${lc.regionList }" varStatus="seq">
		  		<tr><td align="center">${seq.count}</td><td><a href="<spring:url value="/reg/show?regListId=${regList.id }"/>">${regList.regionId }</a></td><td>${regList.landType }</td>
		  		<td>${regList.areaOfRegion }</td><td>${regList.landStatus }</td><td>${regList.price }</td>
		  		<td>${regList.money }</td>
		  		</tr>
		  		</c:forEach>
		  		</tr>
		  		<c:if test="${empty lc.regionList}">
		  		<tr><td colspan="7" align="center">无承包地信息</td></tr>
		  		</c:if>	
		    	</table>
		    	
		    	<table id="tbMain" style="width:630px;" align="left" cellspacing="0" cellpadding="5">
		    	<tr><td colspan="2" class="common2">合同相关附件</td></tr>
		    	<tr>
		    	<c:forEach var="attach" items="${lc.attachList }">
		    	<tr><td colspan="2">附件：<a href="<spring:url value="${attach.fileSrc }"/>/${attach.fileName}" target="_blank">${attach.originFileName }</a></td></tr>
		    	</c:forEach>
		    	</tr>
		    	
		    	</table>
			