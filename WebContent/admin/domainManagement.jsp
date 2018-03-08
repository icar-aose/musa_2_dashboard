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
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a class="active" >DOMAIN MANAGEMENT</a>
</div></div>

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
<s:div  cssClass="mainDiV">
	<display:table export="false" id="alternatecolor" name="domainList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomain" style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" style="white-space:nowrap" >
				<s:url id="editURL" action="editDomain" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
				</s:url> 
				<s:a id="editbtn" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
<script>
var a =document.getElementById("editbtn");
var pgn=<%out.println("\""+request.getParameter("d-16544-p")+"\";");%>
if(pgn!="null"){
a.href=a.href + "&d-16544-p="+pgn;}</script>			
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
 <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newDomainDiv')" href="#"  style="display: table; margin: 0 auto;">NEW DOMAIN</a>
 
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