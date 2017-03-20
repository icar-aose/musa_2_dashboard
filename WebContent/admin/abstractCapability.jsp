<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
  <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Abstract Capability management</title>
</head>
<body>

<%
if(request.getParameter("editEvo")!=null){
%>
<script>
	//window.onload =setEnabled;
	window.onload = function (event) {
		setEnabled('newDiv');
		setEnabled('newEvoSetDiv');
	};
		
		
	</script>
<% 
}
else if(request.getParameter("operation_name")!=null){
if(request.getParameter("operation_name").equals("edit")){
	%>
	<script>
	//window.onload =setEnabled;
	
	window.onload = function (event) {
		setEnabled('newDiv');
		}
	</script>
	<%
}
}

%>

<div id="header" class="container">

	<div id="mainDiV" style="text-align: center">
<h2> MUSA DASHBOARD</h2>
<!-- 	<img id ="logoMUSA" src="../img/MUSA_LOGO.png" />  -->
<!-- 	<img  id ="logoICAR" src="../img/logoECOSICAR.png" />  -->
	</div>
	<div id="menu">
		<ul>
			<li><a  href="../index.jsp" >HOME</a></li>
			<li><a  href="./index.jsp" >ADMINISTRATOR PANEL</a></li>
			<li><a  href="listDomain.action" >DOMAIN MANAGEMENT</a></li>
			
	  </ul>
		
	</div>
	
</div>
<s:div id="newDiv" cssClass="newDiv" >
<fieldset>
  <legend>ABSTRACT CAPABILITY DATA:</legend>
  <s:form  action="saveOrUpdateDomainAbstractCapabilities">
	<s:push value="abstractCapability">
		<s:hidden id="idInput" name="idAbstratCapability" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" />
		
		
		<s:textarea id="inputInput" name="input" label="Input" />
		<s:textarea id="outputInput" name="output" label="Output" />
		<s:textarea id="paramsInput" name="params" label="Params" />
		<s:textarea id="preConditionInput" name="preCondition" label="PreCondition" />
		<s:textarea id="postConditionInput" name="postCondition" label="PostCondition" />
		
		<s:textarea id="descriptionInput" name="description" label="Notes" />
		
		
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		
		<display:table export="false" id="alternatecolor" name="scenarioEvos" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-bottom:20px;margin-top:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="evolution" title="EVOLUTION" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" >
		<s:url id="editURL" action="editScenarioEvo">
							<s:param name="idEvo" value="%{#attr.row.idScenarioEvo}"></s:param>
							<s:param name="idAbstractCapability" value="%{#parameters.id}"></s:param>
							<s:param name="operation_name" value="%{'editEvo'}"></s:param>
							<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
						</s:url> 
						<s:a cssClass="ui-button ui-widget ui-corner-all"   href="%{editURL}">EDIT</s:a>
						
						<s:url id="deleteURL" action="deleteScenarioEvo">
							<s:param name="idEvo" value="%{#attr.row.idScenarioEvo}"></s:param>
							<s:param name="idAbstractCapability" value="%{#parameters.id}"></s:param>
							<s:param name="operation" value="delete"></s:param>
							<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
						</s:url> 
						<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
						
		</display:column>

		</display:table>
		<s:submit  value="SAVE"  onclick="disableDiv('newDiv')" />
	
	    <s:hidden id="idAbstractCapability" name="idAbstractCapability" value="%{#parameters.id}" /> 
		
		
		
	</s:push>
	
	</s:form>
	<%if(request.getParameter("id")!=null)
	{%>
		 <a class="ui-button ui-widget ui-corner-all"  onclick="setEnabled('newEvoSetDiv')" href="#" style="margin-bottom: 5%; margin-right: 20%">NEW EVO</a>
	
<%} %>
<s:div id="newEvoSetDiv" cssClass="newEvoDiv" >
<fieldset>
  <legend>EVO DATA:</legend>
	<s:form  action="saveOrUpdateScenarioEvo" id="evoForm">
		<s:push value="scenarioEvo">
			<s:hidden id="idInput" name="idScenarioEvo" />
 			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" /> 
 			<s:hidden id="idAbstractCapability" name="idAbstractCapability" value="%{#parameters.id}" /> 
			<s:textfield id="nameInput" name="name" label="Name" />
			<s:textfield id="evolutionInput" name="evolution" label="EVOLUTION" />
			<s:textarea id="descriptionInput" name="description" label="Notes" />
			<s:submit  value="SAVE EVO "  onclick="disableDiv('newEvoSetDiv','#evoForm')" />
		</s:push>
	</s:form>
</fieldset>
</s:div>

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