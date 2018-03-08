<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Concrete Capabilities</title>
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
	<a class="active">CONCRETE CAPABILITIES (<s:property value="#session.domainName" />)</a>
</div></div>

<s:div  cssClass="mainDiV">
		<display:table export="false" id="alternatecolor" name="concreteCapabilitiesList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="state" title="STATE" sortable="true"></display:column>
		<display:column property="deploystate" title="DEPLOYSTATE" sortable="true"></display:column>
		<%
		
		if( request.getParameter("domainName")!=null)
		%>
		<display:column property="abstractCapability.name" title="ABSTRACT" sortable="true"></display:column>
		<%%>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column property="wpname" title="WPNAME" sortable="true"></display:column>
		<display:column property="classname" title="CLASS NAME" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
			
		<s:url id="editURL" action="editConcreteAbstractCapabilities" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#attr.row.abstractCapability.idAbstratCapability}"></s:param>
			<s:param name="operation_name" value="%{'edit'}"></s:param>
				
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 
		<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">MODIFY</s:a>
				
		<s:url id="deleteURL" action="deleteConcreteCapability" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 
		<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{deleteURL}">DELETE</s:a>				
				
		<s:url id="changeStateCapabilityURL" action="changeStateConcreteCapability">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url>
		 
		 <s:if test='%{#attr.row.deploystate=="undeployed"}'>
		<s:a  cssClass="ui-button ui-widget ui-corner-all ui-state-disabled" href="%{changeStateCapabilityURL}">
			<s:if test='%{#attr.row.state=="active"}'>STOP</s:if>
			<s:else>START</s:else>
		</s:a>	
		</s:if>
		
		<s:else>
		<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateCapabilityURL}">
					<s:if test='%{#attr.row.state=="active"}'>STOP</s:if>
					<s:else>START</s:else>
				</s:a>	
		</s:else>

		<s:url id="changeDeployCapabilityURL" action="changeDeployConcreteCapability">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url>
		 
		<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeDeployCapabilityURL}">
			<s:if test='%{#attr.row.deploystate=="deployed"}'>UNDEPLOY</s:if>
			<s:else>DEPLOY</s:else>
		</s:a>



				
		<s:url id="logCapabilityURL" action="logConcreteAbstractCapabilities" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="operation_name" value="%{'edit'}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 		
		<s:a cssClass="ui-button ui-widget ui-corner-all"   href="%{logCapabilityURL}">LOG (CASE)</s:a>
		
		<s:url id="logAllCapabilityURL" action="logAllConcreteAbstractCapabilities" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="operation_name" value="%{'edit'}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 		
		<s:a cssClass="ui-button ui-widget ui-corner-all"   href="%{logAllCapabilityURL}">LOG (ALL)</s:a>
		
						
							
		</display:column>
		</display:table>
 
 </s:div>
 
  <s:div  cssClass="centerTable">
<table >
 <tr>
  <td>
  <s:url id="newURL" action="newConcreteCapability" escapeAmp="false">
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{newURL}">NEW CONCRETE CAPABILITY</s:a>

  </td>
  
  <tr>
 </table>
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