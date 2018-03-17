<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
 <%@ taglib prefix="sj" uri="/struts-jquery-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
<link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/tabMenu.css" rel="stylesheet" type="text/css" media="all" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../script/musaGUIScript.js"></script>
<script type="text/javascript" src="../script/URI.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Abstract Capability management</title>
</head>
<body>
<%
if(request.getParameter("operation_name")!=null){
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
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">		
<div class="breadcrumb flat">
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a  href="listDomain.action" >DOMAIN MANAGEMENT</a>
	<a  href="listDomainAbstractCapabilities?idDomain=<%out.println(request.getParameter("idDomain")); %>">ABSTRACT CAPABILITIES (<s:property value="#session.domainName" />)</a>
	<a class="active">NEW ABSTRACT CAPABILITY</a>
</div></div>

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
		<s:textarea id="assumptionInput" name="assumption" label="Assumption" />
		<s:textarea id="bodyInput" name="body" label="Body" />		
		<s:textarea id="descriptionInput" name="description" label="Notes" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>

		<s:submit  value="SAVE"  onclick="disableDiv('newDiv')" />
	
	    <s:hidden id="idAbstractCapability" name="idAbstractCapability" value="%{#parameters.id}" /> 
		
	</s:push>
	
	</s:form>
</fieldset>
	
</s:div>


</body>
</html>