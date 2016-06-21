<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript"
	src="<spring:url value="/static/js/contract/edit.js" />"></script>
<div id="mainContainer" class="easyui-layout" data-options="fit: true">
	<div data-options="region:'center'">
		<div id="mainTabs" class="easyui-tabs" data-options="fit: true">
			<div title='合同信息' style="padding: 10px;">
				<form id="contractForm">
					<input type="hidden" name="id" value="${contract.id}" />
					<table>
						<tr>
							<td colspan="4"></td>
						</tr>
						<tr>
							<td>合同编号</td>
							<td><input id="contractNo" type="text" name="contractNo"
								value="${contract.contractNo}" /></td>
							<td>合同甲方</td>
							<td><input id="firstParty" value="${contract.firstParty}" /></td>
							<td>甲方法人</td>
							<td><input type="text" name="firstPtRepresentative"
								id="firstPtRepresentative"
								value="${contract.firstPtRepresentative}" /></td>
						</tr>
						<tr>
							<td>保障地面积</td>
							<td><input id="affordableArea"
								value="${contract.affordableArea}" /></td>
							<td>所在农场</td>
							<td><input type="text" id="" name="" value="${farmName}" /></td>
							<td>所在社区</td>
							<td><input id="com" value="${community.communityName }" /></td>
						</tr>
						<tr>
							<td>居民小组</td>
							<td><input id="" value="${ResidentsGroup.residentsGrpName }" /></td>
							<td>签订地址</td>
							<td><input id="" /> <input type="hidden" id="" value="" /></td>
							<td>承包期限</td>
							<td><input type="text" id="leaseTerm" name="leaseTerm"
								value="${contract.leaseTerm }" /></td>
						</tr>
						<tr>
							<td>起始时间</td>
							<td><input type="text" id="startDate" name="startDate"
								value="<fmt:formatDate value='${contract.startDate }' pattern='yyyy-MM-dd'/>" /></td>
							<td>到期时间</td>
							<td><input type="text" id="expiredDate" name="expiredDate"
								value="<fmt:formatDate value='${contract.expiredDate }' pattern='yyyy-MM-dd'/>" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div title="承包人信息">
				<table class="easyui-datagrid" style="width: 400px; height: 250px"
					data-options="fitColumns:true,singleSelect:true,fit:true">
					<c:if test="${contract.secondPartyType eq 'ENTERPRISE'}">
						<thead>
							<tr>
								<th data-options="field:'contractorName',width:100">承包方名称</th>
								<th data-options="field:'legalPersonName',width:100">企业法人</th>
								<th data-options="field:'legalPersonIdNO',width:100">法人身份证</th>
								<th data-options="field:'organizationCode',width:100">组织机构代码</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${contract.contractorEnterprise}"
								var="contractor">
								<tr>
									<td><c:out value="${contractor.contractorName}"></c:out></td>
									<td><c:out value="${contractor.legalPersonName}"></c:out></td>
									<td><c:out value="${contractor.legalPersonIdNO}"></c:out></td>
									<td><c:out value="${contractor.organizationCode}"></c:out></td>
								</tr>
							</c:forEach>
						</tbody>
					</c:if>
					<c:if test="${contract.secondPartyType eq 'PERSONAL'}">
						<thead>
							<tr>
								<th data-options="field:'contractorName',width:100">承包方名称</th>
								<th data-options="field:'contractorIdType',width:100">证件类型</th>
								<th data-options="field:'contractorIDNO',width:100">证件号码</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${contract.contractorPersonal}"
								var="contractor">
								<tr>
									<td><c:out value="${contractor.contractorName}"></c:out></td>
									<td><c:out value="${contractor.contractorIdType}"></c:out></td>
									<td><c:out value="${contractor.contractorIDNO}"></c:out></td>
								</tr>
							</c:forEach>
						</tbody>
					</c:if>
				</table>
			</div>
			<div title="附件文件">
				<table id="filesgrid" class="easyui-datagrid"
					style="width: 400px; height: 250px"
					data-options="fitColumns:true,singleSelect:true,fit:true">
					<thead>
						<tr>
							<th data-options="field:'fileName',width:100">文件名称</th>
							<th data-options="field:'operation',width:100">操作</th>
						</tr>
					</thead>
					<%-- <tbody>
						<c:if test="${!empty contract.contractFiles }">
							<c:forEach items="${contract.contractFiles }" var="file">
								<tr>
									<td><c:out value="${file.fileName}"></c:out></td>
									<td><a href="#" fileId="${file.id }"
										onclick="downloadFile(this)" class="easyui-linkbutton">下载</a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody> --%>
				</table>
			</div>
		</div>
	</div>
	<div data-options="region:'south'" style="height: 40px;">
		<div style="position: absolute; right: 10px; padding-top: 5px;">
			<%-- <c:if test="${contract.status eq 2 }">
				<a id="save" status="3" contractId="${contract.id}"
					class="easyui-linkbutton" onclick="statusChange(this);">备案</a>
				<a id="save" status="-1" contractId="${contract.id}"
					class="easyui-linkbutton" onclick="statusChange(this);">回退</a>
			</c:if> --%>
			<a id="save" class="easyui-linkbutton" onclick="closePanelWin('win')">取消</a>
		</div>
	</div>
</div>
