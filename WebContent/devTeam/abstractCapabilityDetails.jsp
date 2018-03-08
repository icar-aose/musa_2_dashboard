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
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
	<a  href="domainListDev.action" >DOMAINS</a>
	<a  href="listDomainAbstractCapabilitiesDev.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >ABSTRACT CAPABILITY (<s:property value="#session.domainName" />)</a>
	<a class="active">ABSTRACT CAPABILITY DETAILS</a>
</div></div>
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

<s:div id="newDiv" cssClass="newDiv" >
<fieldset>
  <legend>ABSTRACT CAPABILITY DATA:</legend>
  <s:form  action="saveOrUpdateDomainAbstractCapabilities">
	<s:push value="abstractCapability">
		<s:hidden id="idInput" name="idAbstratCapability" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" readonly="true" />
		<s:textarea id="inputInput" name="input" label="Input"  readonly="true"/>
		<s:textarea id="outputInput" name="output" label="Output" readonly="true"/>
		<s:textarea id="paramsInput" name="params" label="Params" readonly="true"/>
		<s:textarea id="bodyInput" name="body" label="Body" readonly="true"/>
	
		<s:textarea id="descriptionInput" name="description" label="Notes" readonly="true" />
		
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		
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