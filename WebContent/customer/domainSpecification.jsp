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
<title>Domain Configuration management</title>
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
	<a class="active">DOMAIN SPECIFICATIONS (<s:property value="#session.domainName" />)</a>
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
      height: 400,
      width: 650,
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
		console.log(ref.id);
		dialog = $( "#dialog-form" );
		dialog.dialog( "open" );
		$( "#idInput" ).val("");
		$( "#nameInput" ).val("");
		$( "#descriptionInput" ).val("");
		$( "#stateInput" ).val("");
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

<div id="dialog-form" title="Domain Specification">
  <p class="validateTips">Fill the fields and click Save.</p>
     
    <fieldset>
     <s:form id="formtosub" action="saveOrUpdateSpecification">
	<s:push value="specification">
		<s:hidden id="idInput" name="idSpecification" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="nameInput" name="name" label="Name" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="stateInput" name="state" label="State"  readonly="true" style="height: auto; width: 500px;resize: none;" />
<%-- 	<s:textfield id="userInput" name="user" label="User" /> --%>
		<s:textarea id="descriptionInput" name="description" label="Notes" style="height: 80px; width: 500px;resize: none;"/>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	</s:push>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="domainSpecificationList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomainSpecification"  style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="state" title="STATE" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
				<s:url id="editFunctionalReqURL" action="listFunctionalReq" escapeAmp="false">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editFunctionalReqURL}">FUNCTIONAL REQUIREMENTS</s:a>
				
				<s:url id="editNoFunctionalReqURL" action="listNoFunctionalReq" escapeAmp="false">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{editNoFunctionalReqURL}">QUALITY REQUIREMENTS</s:a>
	
				<s:url id="editProcess" action="listProcess" escapeAmp="false">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all ui-state-disabled" href="%{editProcess}">WF</s:a>
			
				<s:url id="changeStateSpecificationURL" action="changeStateSpecification">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateSpecificationURL}">
				
				<s:if test='%{#attr.row.state=="activate"}'>RETREAT</s:if>
				<s:else>INJECT</s:else>
				
				</s:a>
			
				<s:url id="viewCases" action="listCases">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{viewCases}">CASE DETAILS</s:a>

				<s:url id="editURL" action="editSpecification">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a id="editbtn" onClick="clickFunc(this)"  cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
		
				<s:url id="deleteURL" action="deleteSpecification">
					<s:param name="idSpecification" value="%{#attr.row.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  id="delbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>

		</display:column>
		
		</display:table>

 </s:div>
 <s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all"  id="newbtn" onClick="clickFunc(this)" href="#"  style="display: table; margin: 0 auto;">NEW SPECIFICATION</a>
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