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
<title>CASES EXECUTION</title>
</head>
<body>
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
	<a  href="domainListCustomer.action" >DOMAINS</a>
	<a  href="listDomainSpecification.action?idDomain=<%out.println(request.getParameter("idDomain")); %>" >DOMAIN SPECIFICATIONS (<s:property value="#session.domainName" />)</a>
<a class="active">CASES DETAILS</a>
</div></div>
<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="casesExecutionList" pagesize="5" class="altrowstable"  uid="row" requestURI="listFunctionalReq"  style="margin-bottom:20px;">
			
			<display:column property="name" title="NAME" sortable="true"></display:column>
			<display:column property="startedTime" title="STARTED TIME" sortable="true"></display:column>
			<display:column property="terminatedTime" title="TERMIANTED STATE" sortable="true"></display:column>
<%-- 		<display:column property="specification.name" title=" STATE" sortable="true"></display:column> --%>
		
			<display:column title="ACTIONS" sortable="false" style="white-space:nowrap" >
			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:hidden id="idCaseExecution" name="idCaseExecution" value="%{#attr.row.idCase}" />
		
				<s:url id="viewURL" action="listCapabilityInstance">
					<s:param name="idCaseExecution" value="%{#attr.row.idCase}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{viewURL}">DETAILS</s:a>
			
		</display:column>
		</display:table>
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