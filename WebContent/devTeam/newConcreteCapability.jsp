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
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
	<a  href="domainListDev.action" >DOMAINS</a>
	
	<s:if test="%{#parameters.idAbstractCapability!=null}">
	<a  href="listDomainAbstractCapabilitiesDev.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >ABSTRACT CAPABILITIES (<s:property value="#session.domainName" />)</a>
	</s:if>
	<s:else>
	<a  href="listDomainConcreteCapabilities.action?idDomain=<%out.println(request.getParameter("idDomain")); %>">CONCRETE CAPABILITIES (<s:property value="#session.domainName" />)</a>
	</s:else>
	
	<a class="active">NEW CONCRETE CAPABILITY</a>
</div></div>

<script>
$(document).ready(function(){
    $("#sendButton").attr("disabled",true);
    if(($("#classNameInput").val().length !=0 ) && ($("#ipWorkspaceInput").val().length !=0) && ($("#wpnameInput").val().length !=0) && ($("#nameInput").val().length !=0) && ($("#idfileup").val().length !=0) && ($("#agentInput").val().length !=0))    	
        	$("#sendButton").attr("disabled", false);
	
    $("#classNameInput, #ipWorkspaceInput, #wpnameInput, #nameInput, #agentInput").keyup(function(){
        if($(this).val().length ==0)
        	$("#sendButton").attr("disabled", true);

        if(($("#classNameInput").val().length !=0 ) && ($("#ipWorkspaceInput").val().length !=0) && ($("#wpnameInput").val().length !=0) && ($("#nameInput").val().length !=0) && ($("#idfileup").val().length !=0) && ($("#agentInput").val().length !=0))    	
        	$("#sendButton").attr("disabled", false);
    })

    $("#idfileup").on('change',function(){
        if(($("#classNameInput").val().length !=0 ) && ($("#ipWorkspaceInput").val().length !=0) && ($("#wpnameInput").val().length !=0) && ($("#nameInput").val().length !=0) && ($("#idfileup").val().length !=0) && ($("#agentInput").val().length !=0))    	
        	$("#sendButton").attr("disabled", false);
    })    

});
</script>

<s:div style="display:table;margin:auto;" >
<fieldset>
  <legend>CONCRETE CAPABILITY DATA:</legend>
  <s:form  action="saveOrUpdateConcreteAbstractCapabilities" method="post" enctype="multipart/form-data">
	<s:push value="concreteCapability">
		<s:hidden id="idInput" name="idConcreteCapability" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:hidden id="stateInput" name="state" />
				
		<s:select id="idAbstractCapability" name="idAbstractCapability" label="Abstract Capability" list="abstractCapabilitiesList"  listKey="idAbstratCapability" listValue="name" style="height: auto; width: 500px;resize: none;"/>
		<s:textfield id="ipWorkspaceInput" name="ipWorkspace" label="Ip Workspace" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="wpnameInput" name="wpname" label="WPName" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="nameInput" name="name" label="Capability Name" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="agentInput" name="agent" label="Agent" style="height: auto; width: 500px;resize: none;" />
		<s:textarea id="descriptionInput" name="description" label="Notes" style="height: 80; width: 500px;resize: none;"/>
		<s:textfield id="classNameInput" name="classname" label="Class Name"  style="height: auto; width: 500px;resize: none;"/>
		<s:submit id="sendButton" value="SAVE"   />
	
	</s:push>
		<s:file id="idfileup" name="userJar" accept=".jar" label="User Jar File" />
	</s:form>
	<center><s:property value="textMsg" /></center>
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