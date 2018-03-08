<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbDAO.GeneralConfigurationDAO" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
 <%@ taglib prefix="sj" uri="/struts-jquery-tags"%>  
 <%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
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
<title>Domain Configuration management</title>

<script type="text/javascript">


</script>
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
<a class="active">PROCESS</a>
</div></div>
<%
GeneralConfigurationDAO configurationDAO=new GeneralConfigurationDAO();
String ip= configurationDAO.getGeneralConfigurationByName("IP_WORKFLOW_EDITOR").get(0).getValue();
String port=configurationDAO.getGeneralConfigurationByName("PORT_WORKFLOW_EDITOR").get(0).getValue();

String hrefWorkflow="http://"+ip+":"+port+"/WorkflowWebEditor/Main.jsp?idWorkflow=";

// http://localhost:8080/WorkflowWebEditor/Main.jsp?idWorkflow=%{#attr.row.idWorkflow}

%>

<% 

if(request.getParameter("operation_name")!=null){
if(request.getParameter("operation_name").equals("edit")||request.getParameter("operation_name").equals("createNewProcess")){
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

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="processList" pagesize="5" class="altrowstable"  uid="row" requestURI="listProcess"  style="margin-bottom:20px;">
			
			<display:column property="name" title="NAME" sortable="true"></display:column>
			<display:column property="description" title="NOTES" sortable="true"></display:column>
			<display:column   class="last" title="ACTIONS" sortable="false" >
			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		
				<s:url id="goalsURL" action="generateGoals" >
					<s:param name="idWorkflow" value="%{#attr.row.idWorkflow}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 

<s:a  cssClass="ui-button ui-widget ui-corner-all"  href="" onclick="return verifyGoalProcessExist('%{#attr.row.idWorkflow}','%{#parameters.idSpecification}','%{#parameters.idDomain}');">GENERATE GOALS</s:a> 
<%-- 				<s:url id="verifygoalsURL" action="verifyGoalsProcessExist"> --%>
<%-- 					<s:param name="idWorkflow" value="%{#attr.row.idWorkflow}"></s:param> --%>
<%-- 					<s:param name="operation_name" value="%{'edit'}"></s:param> --%>
<%-- 					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param> --%>
<%-- 					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param> --%>
 				
<%-- 				</s:url>  --%>
<%-- 				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{verifygoalsURL}" >GENERATE GOALS</s:a> --%>
			
			
<%-- 			<s:a  cssClass="ui-button ui-widget ui-corner-all" href="http://localhost:8080/WorkflowWebEditor/Main.jsp?idWorkflow=%{#attr.row.idWorkflow}" target="_blank">MODIFY_OLD</s:a> --%>
		
			<a  class='ui-button ui-widget ui-corner-all' href='<%=hrefWorkflow %><s:property value="%{#attr.row.idWorkflow}"/> ' target='_blank'>MODIFY</a> 
		
				<s:url id="deleteURL" action="deleteProcess">
				   <s:param name="idWorkflow" value="%{#attr.row.idWorkflow}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="operation_name" value="%{'delete'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
						</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
			
			
			
		</display:column>
		</display:table>
 </s:div>
 <s:div  cssClass="center" >
 
 				<s:url id="newProcessURL" action="listProcess">
				   <s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="operation_name" value="%{'createNewProcess'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all"  style="margin-left: 20%; margin-top: 40px" href="%{newProcessURL}">NEW BUSINESS PROCESS</s:a>
			
				<s:url id="uploadProcessURL" action="listProcess">
				   <s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all"  style="margin-left: 2%; margin-top: 40px"  href="%{uploadProcessURL}">UPLOAD NEW PROCESS</s:a>
 
 </s:div>
<s:div id="newConfDiv" cssClass="newDiv" >
<fieldset>
  <legend>PROCESS DATA:</legend>
  <s:form  action="saveOrUpdateProcess" method="post" enctype="multipart/form-data">
	<s:push value="process">
		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idInput" name="idWorkflow" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<% if(request.getParameter("operation_name")!=null && request.getParameter("operation_name").equals("createNewProcess")){ %>
		<s:textfield id="nameInput" name="name" label="Name" />
		<%}else{ %>
		<s:file name="processFile" label="Select a File to upload" size="40" />
				
		<%} %>
		<s:textarea id="descriptionsInput" name="description" label="Notes" />
		
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	    <s:submit  value="SAVE" onclick="disableDiv('newConfDiv')" />
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