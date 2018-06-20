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
<script type="text/javascript" src="../script/globalScripts.js"></script>
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
<s:if test='#session.root=="on"'>
	<a href="../super/index.jsp" >HOME</a>
</s:if>
	<a  href="domainListDev.action" >DOMAINS</a>
	<s:if test="%{#parameters.id!=null && #parameters.idAbstractCapability!=null && #parameters.abstractCapabilityName!=null}">
	<a  href="listDomainAbstractCapabilitiesDev.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >NEW CONCRETE CAPABILITY (<s:property value="#session.domainName" />)</a>
	<a  href="listDomainConcreteCapabilities.action?idDomain=<%out.println(request.getParameter("idDomain")); %>&idAbstractCapability=<%out.println(request.getParameter("idAbstractCapability")); %>&abstractCapabilityName=<%out.println(request.getParameter("abstractCapabilityName")); %>">MANAGE CONCRETE CAPABILITIES (<%out.println(request.getParameter("abstractCapabilityName")); %>)</a>	
	</s:if>	
	<s:else>
	<a  href="listDomainAbstractCapabilitiesDev.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >NEW CONCRETE CAPABILITY (<s:property value="#session.domainName" />)</a>
	</s:else>
	
	<a class="active">CONCRETE CAPABILITY</a>
</div></div>
<script>
function clickFunc() {
	event.preventDefault();
	if(($("#classNameInput").val().length !=0 ) && ($("#ipWorkspaceInput").val().length !=0) &&
	($("#wpnameInput").val().length !=0) && ($("#nameInput").val().length !=0) && ($("#idfileup").val().length !=0) &&
	($("#agentInput").val().length !=0)){
    	$('#formtosub').submit();
    }
    else{
	evidenzia($('#classNameInput'));
	evidenzia($('#ipWorkspaceInput'));
	evidenzia($('#wpnameInput'));
	evidenzia($('#nameInput'));
	evidenzia($('#agentInput'));	
	evidenzia($('#idfileup'));
	}
}
</script>

<s:div style="display:table;margin:auto;" >
<fieldset>
  <legend>CONCRETE CAPABILITY DATA:</legend>
  <s:form  id="formtosub" action="saveOrUpdateConcreteAbstractCapabilities" method="post" enctype="multipart/form-data">
	<s:push value="concreteCapability">
		<s:hidden id="idInput" name="idConcreteCapability" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:hidden id="stateInput" name="state" />
				
		<s:select id="idAbstractCapability" value="%{#parameters.idDomain}" name="idAbstractCapability" label="Abstract Capability" list="abstractCapabilitiesList"  listKey="idAbstratCapability" listValue="name" cssClass="fielddialog"/>
		<s:textfield id="ipWorkspaceInput" maxlength="250" name="ipWorkspace" label="Ip Workspace" cssClass="fielddialog" />
		<s:textfield id="wpnameInput" maxlength="250" name="wpname" label="WPName" cssClass="fielddialog" />
		<s:textfield id="nameInput" maxlength="250" name="name" label="Capability Name" cssClass="fielddialog" />
		<s:textfield id="agentInput" name="agent" maxlength="250" label="Agent" cssClass="fielddialog" />
		<s:textfield id="classNameInput" maxlength="250" name="classname" label="Class Name"  cssClass="fielddialog"/>
		<s:textarea id="descriptionInput" name="description" label="Notes" style="height: 80; width: 500px;resize: none;"/>
		<s:submit id="savebtn"  onclick="clickFunc()"></s:submit>
	</s:push>
		<s:file id="idfileup" name="userJar" accept=".jar" label="User Jar File" />
	</s:form>
	<center><s:property value="textMsg" /></center>
</fieldset>
</s:div>
<s:div cssClass="descpagina">
<s:property value="#session['depconc_dev']"/>
<s:if test='#session["link_depconc_dev"] != ""'>
<a href="<s:property value="#session['link_depconc_dev']"/>" target="_blank"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>