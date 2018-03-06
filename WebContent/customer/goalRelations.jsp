<%@page import="dbBean.FunctionalReq"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
 <%@ taglib prefix="sj" uri="/struts-jquery-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
 <link rel="stylesheet" href="../css/style.css" type="text/css"/>
 <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
 
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../script/musaGUIScript.js"></script>

<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Goal Relations</title>
</head>
<body>
<!-- <a  href="index/index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->
 Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a>
<%
if(request.getParameter("idDomain")!=null){}
if(request.getParameter("operation_name")!=null){
if(request.getParameter("operation_name").equals("edit")||request.getParameter("operation_name").equals("new")){
%>
	<script>
	window.onload = function (event) {setEnabled('newConfDiv');}
	</script>
	<%
}
}
%>

<script>
$(document).ready(function(){
    $("#idButtonSave").attr("disabled",true);
    if($("#idfunctionalReqByIdStart").val() != $("#idfunctionalReqByIdEnd").val())	
        	$("#idButtonSave").attr("disabled", false);
    else
    	$("#idButtonSave").attr("disabled", true);
    $("#idfunctionalReqByIdStart, #idfunctionalReqByIdEnd").on('change',function(){
    if($("#idfunctionalReqByIdStart").val() != $("#idfunctionalReqByIdEnd").val())	
        	$("#idButtonSave").attr("disabled", false);
    else
    	$("#idButtonSave").attr("disabled", true);
    })    

});
</script>

<div id="header" class="container">
		<div id="menu">
		<ul>
			<li><a  href="domainListCustomer.action" >DOMAINS</a></li>
			<li><a  href="listDomainSpecification.action?idDomain=<%out.println(request.getParameter("idDomain")); %>" >SPECIFICATIONS</a></li>
			<li><a  href="listFunctionalReq.action?idDomain=<%out.println(request.getParameter("idDomain")); %>&idSpecification=<%out.println(request.getParameter("idSpecification")); %>" >FUNCTIONAL REQUIREMENTS</a></li>
		
	  </ul>
		
	</div>
</div>

<s:div  cssClass="mainDiV">

<h1>GOAL RELATIONS</h1>

<display:table export="false" id="alternatecolor" name="functionalReqRelList" pagesize="5" class="altrowstable"  uid="row" requestURI="listFunctionalReqRel"  style="margin-bottom:20px;">
			<display:column property="functionalReqByIdStart.name" title="START" sortable="true"></display:column>
			<display:column property="functionalReqByIdEnd.name" title="END" sortable="true"></display:column>
			<display:column property="type.typeName" title="TYPE" sortable="true"></display:column>
			<display:column property="name" title="LABEL" sortable="true"></display:column>			
			
			<display:column title="ACTIONS" sortable="false" style="white-space:nowrap" >
			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		
				<s:url id="editURL" action="editFunctionalReqRel">
					<s:param name="idFuncReqRel" value="%{#attr.row.idFuncReqRel}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{editURL}">MODIFY</s:a>			
				
				<s:url id="deleteURL" action="deleteFunctionalReqRel">
				    <s:param name="idFuncReqRel" value="%{#attr.row.idFuncReqRel}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="operation_name" value="delete"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
						</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>

		</display:column>
		</display:table>
 </s:div>
 <s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all"   href="editFunctionalReqRel.action?operation_name=new&idSpecification=<%out.println(request.getParameter("idSpecification"));%>&idDomain=<%out.println(request.getParameter("idDomain")) ;%>"  style="margin-left: 40%; margin-top: 40px">NEW RELATION</a>
<!--  <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newConfDiv')" href="#"  style="margin-left: 40%; margin-top: 40px">NEW FUNCTIONAL REQUIREMENT</a> -->
 </s:div>

<s:div id="newConfDiv" cssClass="newDiv" >
<fieldset>
  <legend>RELATION DATA:</legend>
  <s:form  action="saveOrUpdateFunctionalReqRel">
	<s:push value="functionalReqRel">
		<s:hidden id="idInput" name="idFuncReqRel" />
		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:select id="idfunctionalReqByIdStart" name="idfunctionalReqByIdStart" label="Start Relation" list="functionalReqList"  listKey="idFunctionalReq" listValue="name"/>
		<s:select id="idfunctionalReqByIdEnd" name="idfunctionalReqByIdEnd" label="End Relation" list="functionalReqList"  listKey="idFunctionalReq" listValue="name"/>
		<s:select id="idType" name="idType" label="Type" list="goalRelationTypeList" listKey="idGrt" listValue="typeName" />
		<s:textfield id="name" name="name" label="Label" />
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	    <s:submit id="idButtonSave" value="SAVE"  onclick="disableDiv('newConfDiv')" />
	</s:push>
	</s:form>
</fieldset>
	
</s:div>

<input type="button" id="credits" value="CREDITS" onclick="popupDialog()"/>
	<div id="dialog" title="CREDITS" style="display: none;">
 	<div id="developerDiv">
		Development:
		</div>
		<br>
		<div id="people">
		Antonella Cavaleri
		</div>
		<br>
		<div id="superVisionerDiv">
		Supervision:
		</div>
		<br>
		<div id="people">
		Luca Sabatucci, Massimo Cossentino
	</div> 
 	</div>

</body>
</html>