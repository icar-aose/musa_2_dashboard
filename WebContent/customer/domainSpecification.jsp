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
<!-- <a  href="index/index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->
Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a> 
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
<!--			<li><a  href="../index.jsp" >HOME</a></li> -->
			<li><a  href="domainListCustomer.action" >DOMAINS</a></li>
		</ul>
		
	</div>
	
</div>


<s:div  cssClass="mainDiV">
<h1>DOMAIN SPECIFICATIONS</h1>

<display:table export="false" id="alternatecolor" name="domainSpecificationList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomainSpecification"  style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="state" title="STATE" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" >
				<s:url id="editFunctionalReqURL" action="listFunctionalReq" escapeAmp="false">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editFunctionalReqURL}">FUNCTIONAL REQUIREMENTS</s:a>
				
				<s:url id="editNoFunctionalReqURL" action="listNoFunctionalReq" escapeAmp="false">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editNoFunctionalReqURL}">NON FUNCTIONAL REQUIREMENTS</s:a>
	
				<s:url id="editProcess" action="listProcess" escapeAmp="false">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{editProcess}">WF</s:a>
			
				<s:url id="changeStateSpecificationURL" action="changeStateSpecification">
						<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateSpecificationURL}">
				
				<s:if test='%{#attr.row.state=="activate"}'>RETREAT</s:if>
				<s:else>INJECT</s:else>
				
				</s:a>
			
				<s:url id="viewCases" action="listCases">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{viewCases}">CASE DETAILS</s:a>
			
				
				<s:url id="editURL" action="editSpecification">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{editURL}">MODIFY</s:a>
			
			
				<s:url id="deleteURL" action="deleteSpecification">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="operation_name" value="delete"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
			
			
			
		</display:column>
		
		</display:table>

 </s:div>
 <s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newConfDiv')" href="#"  style="margin-left: 40%; margin-top: 40px">NEW SPECIFICATION</a>
 
 </s:div>
<s:div id="newConfDiv" cssClass="newDiv" >
<fieldset>
  <legend>SPECIFICATION DATA:</legend>
  <s:form  action="saveOrUpdateSpecification">
	<s:push value="specification">
		<s:hidden id="idInput" name="idSpecification" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" />
		<s:textfield id="stateInput" name="state" label="State"  readonly="true"/>
<%-- 		<s:textfield id="userInput" name="user" label="User" /> --%>
		<s:textarea id="descriptionsInput" name="description" label="Notes" />
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