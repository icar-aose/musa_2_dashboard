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
Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a>
<!-- <a  href="index/index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->
 <%
if(request.getParameter("operation_name")!=null){
if(request.getParameter("operation_name").equals("edit")){
	%>
	<script>
	window.onload = function (event) {
		setEnabled('newDomainDiv');
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
<li><a  href="./index.jsp" >ADMINISTRATOR PANEL</a></li>

<!-- 			<li> class="active"><a href="portaleutente.php" accesskey="1" title="">Homepage</a></li> -->
<!--            <li> <a href="modificapassword.php" accesskey="5" title="">MODIFICA PASSWORD</a></li> -->
<%-- 			<li> <a href="<?php echo $logoutAction ?>" accesskey="5" title="">LOGOUT: <?php echo $_SESSION['MM_Nome'],' ',$_SESSION['MM_Cognome'] ?></a></li> --%>
		

		</ul>
		
	</div>
	
</div>

<s:div  cssClass="mainDiV">

<h1>DOMAINS</h1>


	<display:table export="false" id="alternatecolor" name="domainList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomain" style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" style="white-space:nowrap" >
				<s:url id="editURL" action="editDomain" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
				
				<s:url id="deleteURL" action="deleteDomain">
					<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
					<s:param name="operation" value="delete"></s:param>
				</s:url> 
				
				<s:url id="deleteURL" action="deleteDomain">
					<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
					<s:param name="operation" value="delete"></s:param>
				</s:url> 
				
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
				
				<s:url id="configureDomainURL" action="listDomainConfiguration">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
					
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{configureDomainURL}">CONFIGURE</s:a>
				
				<s:url id="assumptionDomainURL" action="listDomainAssumption">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
					
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{assumptionDomainURL}">DEFINE ASSUMPTIONS</s:a>
				
				
				<s:url id="abstractCapabilitiesDomainURL" action="listDomainAbstractCapabilities">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
					
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{abstractCapabilitiesDomainURL}">MANAGE ABSTRACT CAPABILITIES</s:a>
				
		</display:column>
		
		</display:table>

 </s:div>

<s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newDomainDiv')" href="#"  style="margin-left: 45%; margin-top: 40px">NEW DOMAIN</a>
 
 </s:div>
<s:div id="newDomainDiv" cssClass="newDiv" >
<fieldset>
  <legend>DOMAIN DATA:</legend>
  <s:form  action="saveOrUpdateDomain">
	<s:push value="domain">
	<s:hidden id="idInput" name="idDomain" />
	<s:textfield id="nameInput" name="name" label="Name" />
	<s:textarea id="descriptionInput" name="description" label="Notes" />
	<s:submit  value="SAVE"  onclick="disableDiv('newDomainDiv')" />
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