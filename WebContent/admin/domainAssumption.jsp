<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@taglib prefix="display" uri="http://displaytag.sf.net"%>

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
<title>Domain Assumption management</title>
</head>
<body>
 
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
<li><a  href="../index.jsp" >HOME</a></li>
<li><a  href="./index.jsp" >ADMINISTRATOR PANEL</a></li>
<li><a  href="listDomain.action" >DOMAIN MANAGEMENT</a></li>


<!-- 			<li> class="active"><a href="portaleutente.php" accesskey="1" title="">Homepage</a></li> -->
<!--            <li> <a href="modificapassword.php" accesskey="5" title="">MODIFICA PASSWORD</a></li> -->
<%-- 			<li> <a href="<?php echo $logoutAction ?>" accesskey="5" title="">LOGOUT: <?php echo $_SESSION['MM_Nome'],' ',$_SESSION['MM_Cognome'] ?></a></li> --%>
		

		</ul>
		
	</div>
	
</div>

<h1>DOMAIN ASSUMPTIONS</h1>

<display:table export="false" id="alternatecolor" name="domainAssumptionList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomainAssumption" style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="assumption" title="ASSUMPTION" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" >
	<s:url id="editURL" action="editDomainAssumption" escapeAmp="false"> 
					<s:param name="id" value="%{#attr.row.idAssumption}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
				
				<s:url id="deleteURL" action="deleteDomainAssumption">
					<s:param name="id" value="%{#attr.row.idAssumption}"></s:param>
					<s:param name="operation" value="delete"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
		
	</display:column>
</display:table>

 <s:div  cssClass="centerTable">
<table>
 <tr>
  <td>
  <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newConfDiv')" href="#"  >NEW ASSUMPTION</a>
  
	  
<a class="ui-button ui-widget ui-corner-all"  href="#"  >UPLOAD ONTOLOGY</a>
 </td>
  
  <tr>
 </table>
 
 </s:div>
<s:div id="newConfDiv" cssClass="newDiv" >
<fieldset>
  <legend>DOMAIN ASSUMPTION DATA:</legend>
  <s:form  action="saveOrUpdateDomainAssumption">
	<s:push value="domainAssumption">
		<s:hidden id="idInput" name="idAssumption" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" />
		<s:textfield id="assumptionInput" name="assumption" label="Assumption " />
		<s:label style="font-weight: bolder;" value="[es: role(X) :- user(X)]"></s:label>
		<s:textarea id="descriptionInput" name="description" label="Notes" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		<s:submit  value="SAVE"  onclick="disableDiv('newConfDiv')" />
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