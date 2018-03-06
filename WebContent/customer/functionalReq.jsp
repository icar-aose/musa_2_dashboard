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
<title>Functional Requirements</title>
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
	//window.onload =setEnabled;
	window.onload = function (event) {
		setEnabled('newConfDiv');
		<%
		Integer sizeFunctionalReq=0;
		if(request.getParameter("operation_name").equals("new")){
			if(request.getParameter("functionalReqCount").equals("")){
				sizeFunctionalReq=0;}
			else{
			sizeFunctionalReq=Integer.parseInt(request.getParameter("functionalReqCount"))+1;}
			//vedo calcolare il qaunti goals ci sono nel db in modo da inserire un numero progressivo
		%>
		newFunctionalReq(<%=sizeFunctionalReq%>);
		<%}%>
		}
	</script>
	<%
}

}
%>

<div id="header" class="container">

<!--	<div id="logo">
      
	<img id ="logoMUSA" src="../img/MUSA_LOGO.png" /> 
	<img id ="logoICAR" src="../img/logoECOSICAR.png" /> 
	</div>-->
	<div id="menu">
		<ul>
			<li><a  href="domainListCustomer.action" >DOMAINS</a></li>
			<li><a  href="listDomainSpecification.action?idDomain=<%out.println(request.getParameter("idDomain")); %>" >SPECIFICATIONS</a></li>
		
	  </ul>
		
	</div>
	
</div>


<s:div  cssClass="mainDiV">

<h1>FUNCTIONAL REQUIREMENTS</h1>

<s:url id="goalRel" action="listFunctionalReqRel">
				<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url>
				 
<h1><s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{goalRel}">EDIT GOAL MODEL</s:a></h1>

<display:table export="false" id="alternatecolor" name="functionalReqList" pagesize="5" class="altrowstable"  uid="row" requestURI="listFunctionalReq"  style="margin-bottom:20px;">
			
			<display:column property="name" title="NAME" sortable="true"></display:column>
			<display:column property="type" title="TYPE" sortable="true"></display:column>
			<display:column property="body" title="BODY" sortable="true"></display:column>
			<display:column property="priority" title="PRIORITY" sortable="true"></display:column>
			<display:column property="actors" title="ACTORS" sortable="true"></display:column>
			<display:column property="currentState" title="CURRENT STATE" sortable="true"></display:column>
   			<display:column property="description" title="NOTES" sortable="true"></display:column>
			<display:column title="ACTIONS" sortable="false" style="white-space:nowrap" >
			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		
				<s:url id="editURL" action="editFunctionalReq">
					<s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{editURL}">MODIFY</s:a>
			
			<s:url id="changeStateFunctionalReqURL" action="changeStateFunctionalReq">
					  <s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
			</s:url> 
			<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateFunctionalReqURL}">
			<s:if test='%{#attr.row.currentState=="activated"}'>DEACTIVATE</s:if>
				<s:else>ACTIVATE</s:else>
				
				</s:a>
			
				
				<s:url id="deleteURL" action="deleteFunctionalReq">
				    <s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="operation_name" value="delete"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
						</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
			
			
			
		</display:column>
		</display:table>
 </s:div>
 <h1>
 <s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all" href="editFunctionalReq.action?operation_name=new&idSpecification=<%out.println(request.getParameter("idSpecification"));%>&idDomain=<%out.println(request.getParameter("idDomain")) ;%>&functionalReqCount=${row_rowNum}">NEW FUNCTIONAL REQUIREMENT</a>

<!--  <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newConfDiv')" href="#"  style="margin-left: 40%; margin-top: 40px">NEW FUNCTIONAL REQUIREMENT</a> -->
 
 </s:div></h1>
<s:div id="newConfDiv" cssClass="newDiv" >
<fieldset>
  <legend>FUNCTIONAL REQUIREMENT DATA:</legend>
  <s:form  action="saveOrUpdateFunctionalReq">
	<s:push value="functionalReq">
		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idInput" name="idFunctionalReq" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameNewFunctionalReq" name="name" label="Name" />
		<s:textfield id="typeNewFunctionalReq" name="type" label="Type" readonly="true" style="color:#9e9e9e"></s:textfield>
		<s:textfield id="currentStateNewFunctionalReq" name="currentState" label="Current State"  readonly="true" style="color:#9e9e9e"/>
		<s:textfield id="priorityInput" name="priority" label="Priority" />		
		<s:textarea id="bodyInput" name="body" label="Body" />
		<s:textfield id="actorsInput" name="actors" label="Actors" />
		<s:textarea id="descriptionsInput" name="description" label="Notes" />
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	    <s:submit  value="SAVE"  onclick="disableDiv('newConfDiv')" />
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