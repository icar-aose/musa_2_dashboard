<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Abstract Capability management</title>
</head>
<body>
Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a>
<%
if(request.getParameter("editEvo")!=null){
%>
<script>
	//window.onload =setEnabled;
	window.onload = function (event) {
		setEnabled('newDiv');
		setEnabled('newEvoSetDiv');
	};
		
		
	</script>
<% 
}
else if(request.getParameter("operation_name")!=null){
if(request.getParameter("operation_name").equals("edit")){
	%>
	<script>
	//window.onload =setEnabled;
	
	window.onload = function (event) {
		setEnabled('newDiv');
		}
	</script>
	<%
}
}

%>

<script>
$(document).ready(function(){
    $("#sendButton").attr("disabled",true);
    
    $("#classNameInput, #ipWorkspaceInput, #wpnameInput, #nameInput").keyup(function(){
        if($(this).val().length ==0)
        	$("#sendButton").attr("disabled", true);

        if(($("#classNameInput").val().length !=0 ) && ($("#ipWorkspaceInput").val().length !=0) && ($("#wpnameInput").val().length !=0) && ($("#nameInput").val().length !=0) && ($("#idfileup").val().length !=0))    	
        	$("#sendButton").attr("disabled", false);
    })

    $("#idfileup").on('change',function(){
        if(($("#classNameInput").val().length !=0 ) && ($("#ipWorkspaceInput").val().length !=0) && ($("#wpnameInput").val().length !=0) && ($("#nameInput").val().length !=0) && ($("#idfileup").val().length !=0))    	
        	$("#sendButton").attr("disabled", false);
    })    

});
</script>
 
<div id="header" class="container" >

<div id="mainDiV" style="text-align: center">
<h2> MUSA DASHBOARD</h2>
<!-- 	<img id ="logoMUSA" src="../img/MUSA_LOGO.png" />  -->
<!-- 	<img  id ="logoICAR" src="../img/logoECOSICAR.png" />  -->
	</div>
	<div id="menu">
		<ul>
<!--			<li><a  href="../index.jsp" >HOME</a></li> -->
		 	<li><a  href="domainListDev.action" >DOMAINS</a></li>
			<li><a  href="listDomainAbstractCapabilitiesDev.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >ABSTRACT CAPABILITY</a></li>
				
	  </ul>
		
	</div>
	
</div>
<s:div id="newDiv" cssClass="newDiv" >
<fieldset>
  <legend>CONCRETE CAPABILITY DATA:</legend>
  <s:form  action="saveOrUpdateConcreteAbstractCapabilities" method="post" enctype="multipart/form-data">
	<s:push value="concreteCapability">
		<s:hidden id="idInput" name="idConcreteCapability" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:hidden id="stateInput" name="state" />
				
		<s:select id="idAbstractCapability" name="idAbstractCapability" label="Abstract Capability" list="abstractCapabilitiesList"  listKey="idAbstratCapability" listValue="name"/>
		<s:textfield id="ipWorkspaceInput" name="ipWorkspace" label="Ip Workspace"  />
		<s:textfield id="wpnameInput" name="wpname" label="WPName"  />
		<s:textfield id="nameInput" name="name" label="Capability Name"  />
		<s:textarea id="descriptionInput" name="description" label="Notes" />
		<s:textfield id="classNameInput" name="classname" label="Class Name"  />
		<s:submit id="sendButton" value="SAVE"   />
	
	</s:push>
		<s:file id="idfileup" name="userJar" accept=".jar" label="User Jar File" />
	</s:form>
	<center><s:property value="msg" /></center>
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