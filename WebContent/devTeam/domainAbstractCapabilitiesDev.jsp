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
<title>Domain Abstract Capability management</title>
</head>
<body>
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
	<a  href="domainListDev.action" >DOMAINS</a>
	<a class="active">ABSTRACT CAPABILITIES (<s:property value="#session.domainName" />)</a>
</div></div>

<script>
  $( function() {
		var editflag = document.cookie;
	  	console.log("inizio programma, il flag e:"+editflag);
	 	var dialog, form,
	 	tips = $( ".validateTips" );
	    function updateTips( t ) {
	      tips
	        .text( t )
	        .addClass( "ui-state-highlight" );
	      setTimeout(function() {
	        tips.removeClass( "ui-state-highlight", 1500 );
	      }, 500 );
	    }
  
    dialog = $( "#dialog-form" ).dialog({
		
      autoOpen: false,
      height: 600,
      width: 800,
      modal: true,
      resizable: false,
      buttons: {
        "Save": function() {
        	$('#formtosub2').submit();},
        "Close": function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
      }
    });

	if(editflag === "editflag=true")
	{	
		document.getElementById("formtosub2").style.display="none";
		console.log("ho verificato che flag e true");
		$(".ui-dialog").find(".ui-dialog-buttonpane button:first").hide();
	    dialog.dialog( "open" );
	}
	else{
		console.log("ho verificato che flag e false");
		dialog = $( "#dialog-form" );
	  	dialog.dialog( "close" );
	  	}
	document.cookie = "editflag=false";
	editflag="false";
  });

function clickFunc(ref)
{	
	event.preventDefault();
	console.log("funzione click");
	
	if(ref.id === "newbtn"){
		console.log(ref.id + "click nuovo");
		document.getElementById("formtosub").style.display="none";
		document.getElementById("formtosub2").style.display="block";
		dialog = $( "#dialog-form" );
		$(".ui-dialog").find(".ui-dialog-buttonpane button:first").show();
		dialog.dialog( "open" );
		$( "#nameInput" ).val("");
		$( "#inputInput" ).val("");
		$( "#outputInput" ).val("");
		$( "#paramsInput" ).val("");
		$( "#bodyInput" ).val("");
		$( "#descriptionInput" ).val("");

		document.getElementById("nameInput").readOnly = false;
		document.getElementById("inputInput").readOnly = false;
		document.getElementById("outputInput").readOnly = false;
		document.getElementById("paramsInput").readOnly = false;
		document.getElementById("bodyInput").readOnly = false;
		document.getElementById("descriptionInput").readOnly = false;
	}
	
	if(ref.id === "editbtn"){
        console.log(ref.id);
		document.cookie = "editflag=true";
		window.location.href=ref.href;
	}

}
</script>

<div id="dialog-form" title="Abstract Capability Details">
  <p class="validateTips">Fill the fields and click Save.</p>
 <fieldset>
     <s:form id="formtosub">
		<s:hidden id="idInput2" name="abstractCapability.idAbstratCapability" />
		<s:hidden id="idDomain2" name="abstractCapability.idDomain" value="%{#parameters.idDomain}" />
		<s:hidden id="idAbstractCapability2" name="abstractCapability.idAbstractCapability" value="%{#parameters.id}" /> 
		<s:textfield id="nameInput2" name="abstractCapability.name" label="Name" readonly="true" style="height: auto; width: 600px;resize: none;" />
		<s:textarea id="inputInput2" name="abstractCapability.input" label="Input"  readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="outputInput2" name="abstractCapability.output" label="Output" readonly="true" style="height: 80px; width: 600px;resize: none;"/>
		<s:textarea id="paramsInput2" name="abstractCapability.params" label="Params" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="bodyInput2" name="abstractCapability.body" label="Body" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="descriptionInput2" name="abstractCapability.description" label="Notes" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
</s:form>


<s:form id="formtosub2" action="saveOrUpdateAbstractCapabilitiesProposal" >	

		<s:hidden id="idInput" name="abstractCapabilityProposal.idAbstratCapability" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:hidden id="idAbstractCapability" name="abstractCapabilityProposal.idAbstractCapability" value="%{#parameters.id}" /> 
		<s:textfield id="nameInput" name="abstractCapabilityProposal.name" label="Name" readonly="true" style="height: auto; width: 600px;resize: none;" />
		<s:textarea id="inputInput" name="abstractCapabilityProposal.input" label="Input"  readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="outputInput" name="abstractCapabilityProposal.output" label="Output" readonly="true" style="height: 80px; width: 600px;resize: none;"/>
		<s:textarea id="paramsInput" name="abstractCapabilityProposal.params" label="Params" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="bodyInput" name="abstractCapabilityProposal.body" label="Body" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="descriptionInput" name="abstractCapabilityProposal.description" label="Notes" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>

 </s:form>
</fieldset>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">


</div>


<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="abstractCapabilitiesList" pagesize="10" class="altrowstable"  uid="row" requestURI="listDomainAbstractCapabilitiesDev"  style="margin-bottom:20px;">
		
<display:column property="name" title="NAME" sortable="true"> <s:property value="name"/></display:column>
<%--  <display:column sortable="true" property="idAbstratCapability" title="ID"/> --%>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;">

				<s:url id="viewDetailsURL" action="detailsAbstractCapabilities" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a id="editbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="%{viewDetailsURL}">DETAILS</s:a>
				
				
<%-- 				<s:url id="deployConcreteURL" action="newConcreteCapabilitiesDev"> --%>
<%-- 					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param> --%>
<%-- 					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param> --%>
<%-- 				</s:url>  --%>
<%-- 				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="newConcreteCapability.jsp?idAbstratCapability=%{#attr.row.idAbstratCapability}">DEPLOY CONCRETE</s:a> --%>
				
				
				<s:url id="newURL" action="newConcreteCapability" escapeAmp="false">
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
						<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{newURL}">DEPLOY CONCRETE</s:a>
				
				<s:url id="listConcreteURL" action="listConcreteCapabilitiesDev">
					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="abstractCapabilityName" value="%{#attr.row.name}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{listConcreteURL}">LIST CONCRETE</s:a>
</display:column>

</display:table>

 </s:div>
 <s:div  cssClass="centerTable">
 <table >
 <tr>
  <td>
	<s:a id="newbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="#">PROPOSE NEW ABSTRACT CAPABILITY</s:a>
  </td>
  
  <tr>
 </table>
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