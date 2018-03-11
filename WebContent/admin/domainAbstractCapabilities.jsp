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
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a  href="listDomain.action" >DOMAIN MANAGEMENT</a>
<a  class="active">ABSTRACT CAPABILITIES (<s:property value="#session.domainName" />)</a>
</div>
</div>

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
        	$('#formtosub').submit();},
        Cancel: function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
      }
    });

	if(editflag === "editflag=true")
	{
		console.log("ho verificato che flag e true");
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
		console.log(ref.id);
		dialog = $( "#dialog-form" );
		dialog.dialog( "open" );
		$( "#idInput" ).val("");
		$( "#nameInput" ).val("");
		$( "#descriptionInput" ).val("");
		$( "#inputInput" ).val("");
		$( "#outputInput" ).val("");
		$( "#paramsInput" ).val("");
		$( "#assumptionInput" ).val("");
		$( "#bodyInput" ).val("");
		
	}
	
	if(ref.id === "editbtn"){
		console.log(ref.id);
		document.cookie = "editflag=true";
		window.location.href=ref.href;
	}
	
	if(ref.id === "delbtn"){
		console.log(ref.id);
		pg="d-16544-p";
		pg2="&d-16544-p=";
		pgn=getAllUrlParams()[pg];
		if(parseInt(pgn) != NaN){
   			totale=document.getElementById('row').rows.length -1;
				if(totale === 1){pgn=parseInt(pgn)-1;}
				window.location.href=ref.href+pg2+pgn;
		}
		else{window.location.href=ref.href;}
	}
	
}
</script>

<div id="dialog-form" title="Edit Domain">
  <p class="validateTips">Fill the fields and click Save.</p>
 
     
    <fieldset>
     <s:form id="formtosub" action="saveOrUpdateDomainAbstractCapabilities">
	<s:push value="abstractCapability">
	    <s:hidden id="idInput" name="idAbstractCapability" value="%{#parameters.id}" style="height: auto; width: 500px;resize: none;" /> 
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" style="height: auto; width: 500px;resize: none;" />		
		<s:textarea id="inputInput" name="input" label="Input" style="height: auto; width: 500px;resize: none;" />
		<s:textarea id="outputInput" name="output" label="Output" style="height: auto; width: 500px;resize: none;" />
		<s:textarea id="paramsInput" name="params" label="Params" style="height: auto; width: 500px;resize: none;" />
		<s:textarea id="assumptionInput" name="assumption" label="Assumption" style="height: 80px; width: 500px;resize: none;" />
		<s:textarea id="bodyInput" name="body" label="Body" style="height: 80px; width: 500px;resize: none;" />		
		<s:textarea id="descriptionInput" name="description" label="Notes" style="height: auto; width: 500px;resize: none;" />
	</s:push>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="abstractCapabilitiesList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomainAbstractCapabilities"  style="margin-bottom:20px;">
		
<display:column property="name" title="NAME" sortable="true"> <s:property value="name"/></display:column>
<display:column sortable="true" property="idAbstratCapability" title="ID" class="hidden" headerClass="hidden" />
<display:column property="body" title="BODY" sortable="true" style="white-space: pre-wrap;" ><s:property value="body"/></display:column>
<display:column property="assumption" title="ASSUMPTION" sortable="true" ><s:property value="assumption"/></display:column>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
<s:url id="editURL" action="editDomainAbstractCapabilities" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a id="editbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>

 				<s:url id="deleteURL" action="deleteDomainAbstractCapabilities">
					<s:param name="id" value="%{#attr.row.idAbstratCapability}"></s:param> 
 					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				</s:url>  
				<s:a id="delbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="%{deleteURL}" >DELETE</s:a> 
				
				<s:url id="listConcreteURL" action="listConcreteCapabilities">
					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="abstractCapabilityName" value="%{#attr.row.name}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{listConcreteURL}">LIST OF CONCRETE</s:a>
</display:column>

</display:table>

 </s:div>
 <s:div  cssClass="centerTable">
 <table >
 <tr>
  <td>

		<s:a id="newbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="#">NEW ABSTRACT CAPABILITY</s:a>

	   <s:url id="listAbstractCapabilityProposalURL" action="listAbstractCapabilityProposal">
	   	<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	   </s:url> 
	   <s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{listAbstractCapabilityProposalURL}">VIEW THIRD-PARTY ABSTRACT CAPABILITY PROPOSAL</s:a>
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