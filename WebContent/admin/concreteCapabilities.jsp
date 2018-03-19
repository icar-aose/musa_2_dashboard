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
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a  href="listDomain.action" >DOMAIN MANAGEMENT</a>
	<a  href="listDomainAbstractCapabilities?idDomain=<%out.println(request.getParameter("idDomain")); %>">ABSTRACT CAPABILITIES (<s:property value="#session.domainName" />)</a>
	<a class="active">CONCRETE CAPABILITIES (<%out.println( request.getParameter("abstractCapabilityName"));%>)</a>
</div></div>

<s:div  cssClass="mainDiV">
		<display:table export="false" id="alternatecolor" name="concreteCapabilitiesList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-bottom:20px; ">
		<display:setProperty name="basic.empty.showtable" value="true" /> 	
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="user.name" title="PROVIDER" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		
		</display:table>
 
 </s:div>

<div style="display:table;margin:auto;">
<s:property value="#session['concap_admin']"/> <a href="<s:property value="#session['link_concap_admin']"/>">HELP</a>
</div>
</body>
</html>