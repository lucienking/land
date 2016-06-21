<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html >
	<head>
	<link href="<spring:url value="/static/jquery-easyui/themes/default/easyui.css"/>" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="<spring:url value="/static/jquery/jquery-1.9.1.min.js"/>"></script>
	<script src="<spring:url value="/static/jquery-easyui/jquery.easyui.min.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/static/js/landContract/contractAdd.js"/>"></script>
	</head>
	<body>
    <input type="button" value="对内承包合同申请" title="对内承包合同申请" onclick="openIframeWindow('contractEdit',this)" maximized="true" url="addInner" />
    <input disabled="disabled" type="button" value="对外租赁合同申请" title="对外租赁合同申请" onclick="openIframeWindow('contractEdit',this)" maximized="true" url="addInner" />
    <input disabled="disabled" type="button" value="临时租地合同申请" title="临时租地合同申请" onclick="openIframeWindow('contractEdit',this)" maximized="true" url="addInner" />
    <input disabled="disabled" type="button" value="农民占地合同申请" title="农民占地合同申请" onclick="openIframeWindow('contractEdit',this)" maximized="true" url="addInner" />
   	</body>
</html>