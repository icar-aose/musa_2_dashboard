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
		console.log(ref.id + "click nuovo");
		dialog = $( "#dialog-form" );
		dialog.dialog( "open" );
		$( "#idInput" ).val("");
		$( "#nameInput" ).val("");
		$( "#descriptionInput" ).val("");
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
     <s:form id="formtosub" action="saveOrUpdateDomain">
	<s:push value="domain">
	<s:hidden id="idInput" name="idDomain" />
	<s:textfield id="nameInput" name="name"  style="height: auto; width: 500px;resize: none;" label="Name" />
	<s:textarea id="descriptionInput"  style="height: auto; width: 500px;resize: none;" name="description" label="Notes" />
	</s:push>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
	<display:table export="false" id="alternatecolor" name="domainList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomain" style="margin-bottom:20px;">
		
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
				<s:url id="editURL" action="editDomain" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
		<s:a id="editbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
	
				<s:url id="deleteURL" action="deleteDomain">
					<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
				</s:url> 
				
				<s:a id="delbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
				
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
 <a id="newbtn" class="ui-button ui-widget ui-corner-all"   onClick="clickFunc(this)" style="display: table; margin: 0 auto;">NEW DOMAIN</a>
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