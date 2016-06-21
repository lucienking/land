<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style type="text/css">
	#tbMain{
	}
	#tbMain td{
	border:solid 1px #ccc;
	}
	.seasons table {
      }
	td{
			font-size:12px;
	}
    form { margin:0px; padding:0px; display:inline} 
	#tbMain td.common1{
		 background:#E0FFFF;
		 text-align:right;
	}
	#tbMain td.common2{
		cellspacing:0px;
		cellpadding:0px;
		color:#FFFFFF;
		line-height:18px;
		padding:4px;
		background:url('<spring:url value="/static/image/tubian.png" htmlEscape="true" />') no-repeat 0 0;
	}	
	</style>
	<script type="text/javascript" src="<spring:url value="/static/js/landContract/detail.js?r=1" />"></script>

<div id="mainContainer" class="easyui-layout" data-options="fit: true" >
	<form id="contractForm" method="post" action="save" style="height: 95%;" >
    <div data-options="region:'center'">
   	    <div id="mainTabs" data-options="fit: true" >
			<div>
		    	<input id="lcId" name="id" type="hidden" value="${lc.id }">
		    	<table id="tbMain" style="width:630px;" align="center" cellspacing="0" cellpadding="5">
		    		<tr><td colspan="6" class="common2">合同基本信息</td></tr>
		    		<tr>
		    			<td class="common1" style="width:130px;">合同编号：</td>
		    			<td style="width:170px;"><a href="<spring:url value="/landContract/preview/${lc.contractType }/${lc.id }"/>" target="_blank">${lc.contractNumber}</a></td>
		    			<td class="common1" style="width:130px;">合同类型：</td>
		    			<td>
		    			<c:if test="${lc.contractType eq 1}">对内承包</c:if><c:if test="${lc.contractType eq 2}">对外承包</c:if>
		    			<c:if test="${lc.contractType eq 3}">临时租地</c:if><c:if test="${lc.contractType eq 4}">农民占地</c:if>
		    			</td>
		    		</tr>
		    		<tr id="tr1">
		    			<td class="common1" style="width:100px;">发包方：</td>
		    			<td style="width:120px;">${lc.partyA}</td>
		    			<td class="common1" style="width:100px;">法定代表人：</td>
		    			<td style="width:120px;">${lc.representativeA}</td>
		    		</tr>
		    		<tr id="tr2">
		    			<td class="common1" style="width:100px;">承包方：</td>
		    			<td style="width:120px;">${lc.partyB}</td>
		    			<td class="common1" style="width:100px;">承包方身份证号：</td>
		    			<td style="width:120px;">${lc.partyBIDNumber}</td>
		    		</tr>
		    		<tr id="tr3">
		    			<td class="common1" style="width:100px;">承包方现居地：</td>
		    			<td style="width:120px;">${lc.partyBAddress}</td>
		    			<td class="common1" style="width:100px;">承包方联系方式：</td>
		    			<td style="width:120px;">${lc.partyBContact}</td>
		    		</tr>
		    		<tr id="tr11">
		    			<td class="common1" style="width:100px;">承包期限（年）：</td>
		    			<td style="width:120px;">${lc.timeLimit}</td>
		    			<td class="common1">合同起始日期：</td>
		    			<td>
		    			<fmt:formatDate value="${lc.startDate }" pattern="yyyy年MM月dd日"/>
    					</td>
		    		</tr>
		    		<tr id="tr12">
		    			<td class="common1">合同结束日期：</td>
		    			<td>
		    			<fmt:formatDate value="${lc.endDate }" pattern="yyyy年MM月dd日"/>
    					</td>
		    			<td class="common1">签订日期：</td>
		    			<td>
		    			<fmt:formatDate value="${lc.signingDate }" pattern="yyyy年MM月dd日"/>
    					</td>
		    		</tr>
		    		<tr id="tr13">
		    			<td class="common1" style="width:100px;">土地所属农场：</td>
		    			<td style="width:120px;">${lc.belongFarm}</td>
		    			<td class="common1">土地所属连队：</td>
		    			<td>${lc.belongGroup}</td>
		    		</tr>
		    		<tr id="tr14">
		    			<td class="common1">合同登记人：</td>
		    			<td>${lc.creator}</td>
		    			<td class="common1"></td>
		    			<td></td>
		    		</tr>
		    		<tr>
		    			<td class="common1" style="height:40px;">其他事项：</td>
		    			<td colspan="3">${lc.remarks}</td>
		    		</tr>
		    		
		    	</table>
		    	<jsp:include page="commonDetail.jsp"/>
		    	
			</div>
		</div>
    </div>
    <div data-options="region:'south'" style="height:40px;">
    	<div style="position: absolute;right: 10px;padding-top: 5px;">
    		<a id="close" class="easyui-linkbutton" onclick="closeContract()">关闭</a>
    	</div>
    </div>
    </form>
</div>