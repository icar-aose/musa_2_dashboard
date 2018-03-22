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
<title>Domain management</title>
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
<a class="active">DOMAINS</a>
</div></div>

<s:div  cssClass="mainDiV">
	<display:table export="false" id="alternatecolor" name="domainList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomain" style="margin-bottom:20px;">
        <display:setProperty name="basic.empty.showtable" value="true" />
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
				
				
				<s:url id="abstractCapabilitiesURL" action="listDomainAbstractCapabilitiesDev">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{abstractCapabilitiesURL}">NEW CONCRETE</s:a>
				
				<s:url id="concreteCapabilitiesURL" action="listDomainConcreteCapabilities">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{concreteCapabilitiesURL}">MANAGEMENT OF CONCRETE</s:a>
<%-- 				 <s:url id="listAbstractCapabilityProposalURL" action="listAbstractCapabilityProposal"> --%>
<%-- 	   	<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param> --%>
<%-- 	   	<s:param name="domainName" value="%{#attr.row.name}"></s:param>--%>
<%-- 	   </s:url>  --%>
<%-- 	   <s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{listAbstractCapabilityProposalURL}">VIEW THIRD-PARTY ABSTRACT CAPABILITY PROPOSAL</s:a> --%>
 
				
				<s:url id="stateOfproposalURL" action="stateOfproposalCapabilities">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{stateOfproposalURL}">LIST OF PROPOSAL</s:a>
				
		</display:column>
		
		</display:table>

 </s:div>

<s:div cssClass="descpagina">
<s:property value="#session['home_dev']"/>
<s:if test='#session["link_home_dev"] != ""'>
<a href="<s:property value="#session['link_home_dev']"/>"> (MORE INFO)</a>
</s:if>
</s:div>
<script>
$(window).resize(function() {
    $("#dialog").dialog("option", "position", {my: "center", at: "center", of: window});
});
</script>
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
		<div id="people">
		Vincenzo Gasparo
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