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
<title>Domain Abstract Capability management</title>
</head>
<body>
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
		 	<li><a  href="domainListDev.action" >DOMAINS</a></li>
			
	  </ul>
		
	</div>
	
</div>


<h1>ABSTRACT CAPABILITIES</h1>


<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="abstractCapabilitiesList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomainAbstractCapabilities"  style="margin-bottom:20px;">
		
<display:column property="name" title="NAME" sortable="true"> <s:property value="name"/></display:column>
<%--  <display:column sortable="true" property="idAbstratCapability" title="ID"/> --%>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column title="ACTIONS" sortable="false" style="white-space:nowrap">

				<s:url id="viewDetailsURL" action="detailsAbstractCapabilities" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{viewDetailsURL}">DETAILS</s:a>
				
				
<%-- 				<s:url id="deployConcreteURL" action="newConcreteCapabilitiesDev"> --%>
<%-- 					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param> --%>
<%-- 					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param> --%>
<%-- 				</s:url>  --%>
<%-- 				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="newConcreteCapability.jsp?idAbstratCapability=%{#attr.row.idAbstratCapability}">DEPLOY CONCRETE</s:a> --%>
				
				
				<s:url id="newURL" action="newConcreteCapability" escapeAmp="false">
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
						<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{newURL}">DEPLOY CONCRETE</s:a>
				
				
				<s:url id="listConcreteURL" action="listConcreteCapabilitiesDev">
					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="abstractCapabilityName" value="%{#attr.row.name}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{listConcreteURL}">LIST CONCRETE</s:a>
</display:column>

</display:table>

 </s:div>
 <s:div  cssClass="centerTable">
 <table >
 <tr>
  <td>
  <s:url id="newURL" action="newAbstractCapabilitiesProposal" escapeAmp="false">
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{newURL}">PROPOSE NEW ABSTRACT CAPABILITY</s:a>

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