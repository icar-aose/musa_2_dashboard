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
<title>Domain Configuration management</title>
</head>
<body>
<!-- <a  href="index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->
 
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

<div id="header" class="container">

	<div id="mainDiV" style="text-align: center">
<h2> MUSA DASHBOARD</h2>
<!-- 	<img id ="logoMUSA" src="../img/MUSA_LOGO.png" />  -->
<!-- 	<img  id ="logoICAR" src="../img/logoECOSICAR.png" />  -->
	</div>
	<div id="menu">
		<ul>
			<li><a  href="../index.jsp" >HOME</a></li>
			<li><a  href="domainListCustomer.action" >DOMAINS</a></li>
			<li><a  href="listDomainSpecification.action?idDomain=<%out.println(request.getParameter("idDomain")); %>" >SPECIFICATIONS</a></li>
		
	  </ul>
		
	</div>
	
</div>


<s:div  cssClass="mainDiV">
<h1> NON FUNCTIONAL REQUIREMENTS</h1>

<display:table export="false" id="alternatecolor" name="nonFunctionalReqList" pagesize="5" class="altrowstable"  uid="row" requestURI="listNoFunctionalReq"  style="margin-bottom:20px;">
			<display:column property="name" title="NAME" sortable="true"></display:column>
			<display:column property="currentState" title="CURRENT STATE" sortable="true"></display:column>
			<display:column property="description" title="NOTES" sortable="true"></display:column>
			<display:column title="ACTIONS" sortable="false" >
				<s:url id="editURL" action="editNoFunctionalReq">
					<s:param name="idNonFunctionalReq" value="%{#attr.row.idNonFunctionalReq}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{editURL}">MODIFY</s:a>
			
			<s:url id="changeStateNoFunctionalReqURL" action="changeStateNoFunctionalReq">
					  <s:param name="idFunctionalReq" value="%{#attr.row.idNonFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
			</s:url> 
			<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateNoFunctionalReqURL}">ACTIVE/DEACTIVATE</s:a>
			
			
				<s:url id="deleteURL" action="deleteNoFunctionalReq">
				    <s:param name="idNonFunctionalReq" value="%{#attr.row.idNonFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="operation_name" value="delete"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
						</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
			
			
			
		</display:column>
		</display:table>
 </s:div>
 <s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newConfDiv')" href="#"  style="margin-left: 40%; margin-top: 40px">NEW NON FUNCTIONAL REQUIREMENT</a>
 
 </s:div>
 

<s:div id="newConfDiv" cssClass="newDiv" >
<fieldset>
  <legend>NON FUNCTIONAL REQUIREMET DATA:</legend>
  <s:form  action="saveOrUpdateNoFunctionalReq">
	<s:push value="nonFunctionalReq">
		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idInput" name="idNonFunctionalReq"  />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" />
		<s:textfield id="valueInput" name="value" label="Expression" />
		<s:textfield id="currentStateInput" name="currentState" label="Current State" readonly="true" />
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