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
<title>General Configuration management</title>
</head>
<body>
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
<s:if test='#session.root=="on"'>
	<a href="../super/index.jsp" >HOME</a>
</s:if>
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
<a class="active">GENERAL CONFIGURATIONS</a>
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

function evidenzia(oggetto) {
    oggetto
      .addClass( "ui-state-highlight" );
    setTimeout(function() {
      oggetto.removeClass( "ui-state-highlight", 1500 );
    }, 500 );
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
      height: "auto",
      width: "auto",
      modal: true,
      resizable: false,
      buttons: {
        "Save": function() {
            if($('#valueInput').val()!=""){
            	dialog.dialog( "close" );
            	$('#formtosub').submit();
            }
            else{
			evidenzia($('#valueInput'));
			updateTips("Please fill out all mandatory fields.");}
        },
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
	if(ref.id === "editbtn"){
		console.log(ref.id);
		setCookie("editflag", "true", 365);
		window.location.href=ref.href;
	}
}

$(window).resize(function() {
    $("#dialog-form").dialog("option", "position", {my: "center", at: "center", of: window});
});
</script>

<div id="dialog-form" title="Edit Configuration">
  <p class="validateTips">Fill the fields and click Save.</p>
 
     
    <fieldset>
<s:form id="formtosub"  action="saveOrUpdateGenConf">
	<s:push value="generalConfiguration">
	<s:hidden id="idInput" name="idGeneralConfiguration" />
	<s:textfield id="nameInput" name="name" label="Name" readonly="true" cssClass="fielddialog" />
	<s:textarea id="descriptionInput" name="description" label="Notes" cssClass="fielddialog" readonly="true"/>
	<s:textfield id="valueInput" maxlength="250" name="value" cssClass="fielddialog" label="Value" />

	</s:push>

      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
	<display:table export="false" id="alternatecolor" name="generalConfigurationList" pagesize="10" class="altrowstable"  uid="row" requestURI="listGeneralConfiguration" style="margin-bottom:20px;">
		<display:setProperty name="basic.empty.showtable" value="true" /> 			
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="value" title="VALUE" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
		
		<s:url id="editURL" action="editGeneralConfiguration" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idGeneralConfiguration}"></s:param>
			<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
		</s:url> 
		<s:a id="editbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
			
<!--				
	<s:url id="deleteURL" action="deleteGeneralConfiguration">
		<s:param name="id" value="%{#attr.row.idGeneralConfiguration}"></s:param>
	</s:url> 
	<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a> 
-->	
		</display:column>
		</display:table>
</s:div>

<s:div cssClass="descpagina">
<s:property value="#session['genconf_admin']"/>
<s:if test='#session["link_genconf_admin"] != ""'>
<a href="<s:property value="#session['link_genconf_admin']"/>"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>