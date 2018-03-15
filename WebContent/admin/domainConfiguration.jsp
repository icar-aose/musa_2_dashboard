<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
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
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a  href="listDomain.action" >DOMAIN MANAGEMENT</a>
<a  class="active">DOMAIN CONFIGURATIONS (<s:property value="#session.domainName" />)</a>
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
	setCookie("editflag", "true", 365);
	window.location.href=ref;
}

$(window).resize(function() {
    $("#dialog-form").dialog("option", "position", {my: "center", at: "center", of: window});
});
</script>

<div id="dialog-form" title="Edit Configuration">
  <p class="validateTips">Fill the fields and click Save.</p>
 
     
    <fieldset>
<s:form id="formtosub"  action="saveOrUpdateDomainConf">
	<s:push value="domainConfiguration">
		<s:hidden id="idInput" name="idDomainConfiguration" readonly="true" style="height: auto; width: 500px;resize: none;" />
		<s:hidden id="idDomain" name="idDomain" readonly="true" value="%{#parameters.idDomain}" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="nameInput" name="name" readonly="true" label="Name" style="height: auto; width: 500px;resize: none;" />
				<s:textarea id="descriptionInput" name="description" readonly="true" label="Notes" style="height: auto; width: 500px;resize: none;" />
		<s:textfield id="valueInput" name="value" label="Value" style="height: auto; width: 500px;resize: none;" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	</s:push>

      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="domainConfigurationList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomainConfiguration"  style="margin-bottom:20px;">
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="value" title="VALUE" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column  title="ACTIONS" sortable="false" >
		<s:url id="editURL" action="editDomainConfiguration" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idDomainConfiguration}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a id="editbtn" cssClass="ui-button ui-widget ui-corner-all" onClick="clickFunc(this.href)"  href="%{editURL}">EDIT</s:a>
<!--
				<s:url id="deleteURL" action="deleteDomainConfiguration">
					<s:param name="id" value="%{#attr.row.idDomainConfiguration}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a> -->
			
		</display:column>
		
		</display:table>

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