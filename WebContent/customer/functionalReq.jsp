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
<title>Functional Requirements</title>
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
	<a class="active">FUNCTIONAL REQUIREMENTS</a>
</div></div>


<script>

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

  $( function() {
		var editflag = getCookie("editflag");
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

	if(editflag === "true")
	{
		console.log("ho verificato che flag e true");
	    dialog.dialog( "open" );
	}
	else{
		console.log("ho verificato che flag e false");
		dialog = $( "#dialog-form" );
	  	dialog.dialog( "close" );
	  	}
	setCookie("editflag", "false", 365);
	editflag="false";
  });

function clickFunc(ref)
{	
	event.preventDefault();
	console.log("funzione click");
	
	if(ref.id === "newbtn"){
		console.log(ref.id + "click nuovo");
		dialog = $( "#dialog-form" );
		dialog.dialog( "open" );
		$( "#idInput" ).val("");
		$( "#nameNewFunctionalReq" ).val("");
		$( "#descriptionInput" ).val("");
		$( "#priorityInput" ).val("");
		$( "#bodyInput" ).val("");
		$( "#actorsInput" ).val("");
		$( "#descriptionsInput" ).val("");
		
	}

	if(ref.id === "editbtn"){
		console.log(ref.id);
		setCookie("editflag", "true", 365);
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

$(window).resize(function() {
    $("#dialog-form").dialog("option", "position", {my: "center", at: "center", of: window});
});
</script>

<div id="dialog-form" title="Functional Requirements">
  <p class="validateTips">Fill the fields and click Save.</p>
 <fieldset>
     <s:form id="formtosub" action="saveOrUpdateFunctionalReq">
	<s:push value="functionalReq">

		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idInput" name="idFunctionalReq" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameNewFunctionalReq" name="name" label="Name" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="typeNewFunctionalReq" name="type" label="Type" readonly="true" style="height: auto; width: 500px;resize: none;color:#9e9e9e;" />
		<s:textfield id="currentStateNewFunctionalReq" name="currentState" label="Current State"  readonly="true" style="height: auto; width: 500px;resize: none;color:#9e9e9e;" />
		<s:textfield id="priorityInput" name="priority" label="Priority" style="height: auto; width: 500px;resize: none;" />		
		<s:textarea id="bodyInput" name="body" label="Body" style="height: 80px; width: 500px;resize: none;"/>
		<s:textfield id="actorsInput" name="actors" label="Actors" style="height: 80px; width: 500px;resize: none;" />
		<s:textarea id="descriptionsInput" name="description" style="height: 80px; width: 500px;resize: none;" label="Notes" />
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	
	</s:push>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
<s:url id="goalRel" action="listFunctionalReqRel">
				<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>		
				</s:url>		 
<h1><s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{goalRel}">EDIT GOAL MODEL</s:a></h1>

<display:table export="false" id="alternatecolor" name="functionalReqList" pagesize="5" class="altrowstable"  uid="row" requestURI="listFunctionalReq"  style="margin-bottom:20px;">
			
			<display:column property="name" title="NAME" sortable="true"></display:column>
			<display:column property="type" title="TYPE" sortable="true"></display:column>
			<display:column property="body" title="BODY" sortable="true"></display:column>
			<display:column property="priority" title="PRIORITY" sortable="true"></display:column>
			<display:column property="actors" title="ACTORS" sortable="true"></display:column>
			<display:column property="currentState" title="CURRENT STATE" sortable="true"></display:column>
   			<display:column property="description" title="NOTES" sortable="true"></display:column>
			<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		
				<s:url id="editURL" action="editFunctionalReq">
					<s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a id="editbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>

			<s:url id="changeStateFunctionalReqURL" action="changeStateFunctionalReq">
					  <s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
			</s:url> 
			<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateFunctionalReqURL}">
			<s:if test='%{#attr.row.currentState=="activated"}'>DEACTIVATE</s:if>
				<s:else>ACTIVATE</s:else>
				
				</s:a>
			
				
				<s:url id="deleteURL" action="deleteFunctionalReq">
				    <s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  id="delbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
			
			</display:column>
		</display:table>
 </s:div>
 <h1>
 <s:div>
 <a id="newbtn" class="ui-button ui-widget ui-corner-all" onClick="clickFunc(this)" href="#" >NEW FUNCTIONAL REQUIREMENT</a>
 
 </s:div></h1>

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