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
		 	<li><a  href="domainListDev.action" >DOMAINS</a></li>
			<li><a  href="listDomainAbstractCapabilitiesDev.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >ABSTRACT CAPABILITY</a></li>
			
	  </ul>
		
	</div>
	
</div>
<s:div id="newDiv" cssClass="newDiv" >
<fieldset>
  <legend>ABSTRACT CAPABILITY PROPOSAL DATA:</legend>
  <s:form  action="saveOrUpdateAbstractCapabilitiesProposal">
	<s:push value="abstractCapabilityProposal">
	
	

	
		<s:hidden id="idInput" name="idProposal" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" />
		
		<s:textarea id="inputInput" name="input" label="Input" />
		<s:textarea id="outputInput" name="output" label="Output" />
		<s:textarea id="paramsInput" name="params" label="Params" />
		<s:textarea id="preConditionInput" name="preCondition" label="PreCondition" />
		<s:textarea id="postConditionInput" name="postCondition" label="PostCondition" />
		
		<s:textarea id="descriptionInput" name="description" label="Notes" />
		
		
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		
		
		<s:submit  value="SAVE"  onclick="disableDiv('newDiv')" />
	
	    <s:hidden id="idAbstractCapability" name="idAbstractCapability" value="%{#parameters.id}" /> 
		
		
		
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