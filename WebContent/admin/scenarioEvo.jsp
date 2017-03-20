<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
  <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
 <link rel="stylesheet" href="../css/style.css" type="text/css"/>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../script/musaGUIScript.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Abstract Capability management</title>
</head>
<body>

<a  href="index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a>
 
<%
if(request.getParameter("idDomain")!=null){
	
}
if(request.getParameter("operation_name")!=null){
if(request.getParameter("operation_name").equals("edit")){
	%>
	<script>
	//window.onload =setEnabled;
	
	window.onload = function (event) {
		setEnabled('newConfDiv');
		}
	</script>
	<%
}
}
%>



<s:div id="newEvoSetDiv" cssClass="newDiv" >
<fieldset>
  <legend>EVO DATA:</legend>
	<s:form  action="saveOrUpdateScenarioEvo" id="evoForm">
		<s:push value="scenarioEvo">
			<s:hidden id="idInput" name="idScenarioEvo" />
 			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" /> 
 			<s:hidden id="idDomain" name="abstractCapability" value="%{abstractCapability}" /> 
 			
 			<s:hidden id="idAbstractCapability" name="idAbstractCapability" value="%{#parameters.id}" /> 
			<s:textfield id="nameInput" name="name" label="Name" />
			<s:textfield id="evolutionInput" name="evolution" label="Evolution" />
			<s:textarea id="descriptionInput" name="description" label="Notes" />
			<s:submit  value="SAVE EVO "  onclick="disableDiv('newEvoSetDiv','#evoForm')" />
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