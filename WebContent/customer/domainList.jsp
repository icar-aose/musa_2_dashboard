<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
 <%@ taglib prefix="sj" uri="/struts-jquery-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
<link rel="stylesheet" href="../css/style.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../script/musaGUIScript.js"></script>

<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Domain management</title>
</head>
<body>


<div id="header" class="container">

	<div id="mainDiV" style="text-align: center">
<h2> MUSA DASHBOARD</h2>
<!-- 	<img id ="logoMUSA" src="../img/MUSA_LOGO.png" />  -->
<!-- 	<img  id ="logoICAR" src="../img/logoECOSICAR.png" />  -->
	</div>
	<div id="menu">
		<ul>
<li><a  href="../index.jsp" >HOME</a></li>

		</ul>
		
	</div>
	
</div>

<s:div  cssClass="mainDiV">

<h1>DOMAINS</h1>


	<display:table export="false" id="alternatecolor" name="domainList" pagesize="5" class="altrowstable"  uid="row" requestURI="domainListCustomer" style="margin-bottom:20px;">
		<display:column  property="name" title="NAME" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column   class="last" title="ACTIONS" sortable="false" >
		
		
				<s:url id="configureSpecificationURL" action="listDomainSpecification">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
					
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{configureSpecificationURL}">SPECIFICATIONS MANAGEMENT</s:a>
				
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