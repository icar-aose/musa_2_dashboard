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
<title>General Configuration management</title>
</head>
<body>
Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a>
 
<%

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
<li><a  href="./index.jsp" >ADMINISTRATOR PANEL</a></li>

		</ul>
		
	</div>
	
</div>
<s:div  cssClass="mainDiV">

<h1>GENERAL CONFIGURATIONS</h1>


	<display:table export="false" id="alternatecolor" name="generalConfigurationList" pagesize="5" class="altrowstable"  uid="row" requestURI="listGeneralConfiguration" style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="value" title="VALUE" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" >
		<s:url id="editURL" action="editGeneralConfiguration" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idGeneralConfiguration}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
				
				<s:url id="deleteURL" action="deleteGeneralConfiguration">
					<s:param name="id" value="%{#attr.row.idGeneralConfiguration}"></s:param>
					<s:param name="operation" value="delete"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
			
		</display:column>
		</display:table>
</s:div>
		
<%-- <s:div  cssClass="centerTable"> --%>
<!-- <h1>GENERAL CONFIGURATIONS</h1> -->
<!--  <table class="altrowstable" id="alternatecolor" align="center"> -->
<!-- 		<tr> -->
<!-- 			<th>Name</th> -->
<!-- 			<th>Value</th> -->
<!-- 			<th>Description</th> -->
<!-- 			<th>Actions</th> -->
			
<!-- 		</tr> -->
		  
<%--  		<s:iterator value="generalConfigurationList"> --%>
<!--  		<tr> -->
<%-- 				<td><s:property value="name"/></td> --%>
<%-- 				<td><s:property value="value"/></td> --%>
<%-- 				<td><s:property value="description"/></td> --%>
<!-- 				<td>	 -->
<%--  				<s:url id="editURL" action="editGeneralConfiguration" escapeAmp="false"> --%>
<%-- 					<s:param name="id" value="%{idGeneralConfiguration}"></s:param> --%>
<%-- 					<s:param name="operation_name" value="%{'edit'}"></s:param> --%>
<%-- 				</s:url>  --%>
<%-- 				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a> --%>
				
<%-- 				<s:url id="deleteURL" action="deleteGeneralConfiguration"> --%>
<%-- 					<s:param name="id" value="%{idGeneralConfiguration}"></s:param> --%>
<%-- 					<s:param name="operation" value="delete"></s:param> --%>
<%-- 				</s:url>  --%>
<%-- 				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a> --%>
<!-- 			 </td> -->
	
<!-- 		</tr> -->
<%-- 		</s:iterator> --%>
<!--  </table> -->
<%--  </s:div> --%>
 <s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newConfDiv')" href="#"  style="margin-left: 40%; margin-top: 40px">NEW CONFIGURATION</a>
 
 </s:div>
<s:div id="newConfDiv" cssClass="newDiv" >
<fieldset>
  <legend>GENERAL CONFIGURATION DATA:</legend>
  <s:form  action="saveOrUpdateGenConf">
	<s:push value="generalConfiguration">
	<s:hidden id="idInput" name="idGeneralConfiguration" />
<s:textfield id="nameInput" name="name" label="Name" />
<s:textfield id="valueInput" name="value" label="Value" />
<s:textarea id="descriptionInput" name="description" label="Notes" />
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