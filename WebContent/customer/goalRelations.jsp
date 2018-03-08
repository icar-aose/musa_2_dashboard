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
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
	<a  href="domainListCustomer.action" >DOMAINS</a>
	<a  href="listDomainSpecification.action?idDomain=<%out.println(request.getParameter("idDomain")); %>" >DOMAIN SPECIFICATIONS (<s:property value="#session.domainName" />)</a>
<a  href="listFunctionalReq.action?idDomain=<%out.println(request.getParameter("idDomain")); %>&idSpecification=<%out.println(request.getParameter("idSpecification")); %>" >FUNCTIONAL REQUIREMENTS</a>
	<a class="active">GOAL RELATIONS</a>
</div></div>
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

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="functionalReqRelList" pagesize="5" class="altrowstable"  uid="row" requestURI="listFunctionalReqRel"  style="margin-bottom:20px;">
			<display:column property="functionalReqByIdStart.name" title="START" sortable="true"></display:column>
			<display:column property="functionalReqByIdEnd.name" title="END" sortable="true"></display:column>
			<display:column property="type.typeName" title="TYPE" sortable="true"></display:column>
			<display:column property="name" title="LABEL" sortable="true"></display:column>			
			
			<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		
				<s:url id="editURL" action="editFunctionalReqRel">
					<s:param name="idFuncReqRel" value="%{#attr.row.idFuncReqRel}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a id="editbtn" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
<script>
var a =document.getElementById("editbtn");
var pgn=<%out.println("\""+request.getParameter("d-16544-p")+"\";");%>
if(pgn!="null"){
a.href=a.href + "&d-16544-p="+pgn;}</script>				
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
 <a class="ui-button ui-widget ui-corner-all"   href="editFunctionalReqRel.action?operation_name=new&idSpecification=<%out.println(request.getParameter("idSpecification"));%>&idDomain=<%out.println(request.getParameter("idDomain")) ;%>" style="display: table; margin: 0 auto;">NEW RELATION</a>
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