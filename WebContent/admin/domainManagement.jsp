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
<script type="text/javascript" src="../script/globalScripts.js"></script>
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
<s:if test='#session.root=="on"'>
	<a href="../super/index.jsp" >HOME</a>
</s:if>
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a class="active" >DOMAIN MANAGEMENT</a>
</div></div>

<script>
      $(function() {
          var editflag = getCookie("editflag");
          //console.log("inizio programma, il flag e:" + editflag);
          var dialog, form,conf,
              tips = $(".validateTips");
       		  dialog = $("#dialog-form").dialog({
              autoOpen: false,
              height: "auto",
              width: "auto",
              modal: true,
              resizable: false,
              buttons: {
                  "Save": function() {
                      
                      if($('#nameInput').val()!=""){
                      	dialog.dialog( "close" );
                      	$('#formtosub').submit();
                      }
                      else{
          			evidenzia($('#nameInput'));
          			updateTips("Please fill out all mandatory fields.");}
            			
                  },
                  Cancel: function() {
                      dialog.dialog("close");
                  }
              },
              close: function() {}
          });
      
          conf = $("#del-confirm").dialog({
      
              autoOpen: false,
              resizable: false,
              height: "auto",
              width: 400,
              modal: true,
              buttons: {
                  "Delete": function() {
                      $(this).dialog("close");
                      var link = aux;
                      var parser = new DOMParser;
                      var dom = parser.parseFromString(link, "text/html");
                      link = dom.body.textContent;
                      pg="d-16544-p";
              		pgn=getAllUrlParams()[pg];
                      if(pgn===undefined || pgn===""){pgn="1";}
                      	totale = document.getElementById('row').rows.length - 1;
                      if(totale === 1 && pgn!="1"){pgn = parseInt(pgn) - 1;}
                      setCookie("pagina", pgn, 365);
                      window.location.href = link;
                  },
                  Cancel: function() {
                      $(this).dialog("close");
                  }
              }
          });
          
	if(editflag === "true")
	{
		//console.log("ho verificato che flag e true");
	    dialog.dialog( "open" );
	}
	else{
		//console.log("ho verificato che flag e false");
		dialog = $( "#dialog-form" );
	  	dialog.dialog( "close" );
	  	}
	setCookie("editflag", "false", 365);
	editflag="false";
  });

function clickFunc(ref,event)
{	
	event.preventDefault();
	//console.log("funzione click");
	if(ref.id === "newbtn"){
		//console.log(ref.id + "click nuovo");
		dialog = $( "#dialog-form" );
		dialog.dialog( "open" );
		$( "#idInput" ).val("");
		$( "#nameInput" ).val("");
		$( "#descriptionInput" ).val("");
	}

	if(ref.id === "editbtn"){
		//console.log(ref.id);
		setCookie("editflag", "true", 365);
		window.location.href=ref.href;
	}
	
    if (ref.id === "delbtn") {
        //console.log(ref.id);
        conf = $("#del-confirm");
        conf.dialog("open");
    }
	
}

</script>
<div id="del-confirm" title="Conferma Eliminazione">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>L'elemento selezionato verrà eliminato definitivamente dal database, proseguire?</p>
</div>
<div id="dialog-form" title="Domain Management">
  <p class="validateTips">Fill the fields and click Save.</p>
 
     
    <fieldset>
     <s:form id="formtosub" action="saveOrUpdateDomain">
	<s:push value="domain">
	<s:hidden id="idInput" name="idDomain" />
	<s:textfield id="nameInput" maxlength="250" name="name"  cssClass="fielddialog" label="Name" />
	<s:textarea id="descriptionInput"  cssClass="fielddialog" name="description" label="Notes" />
	</s:push>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
	<display:table export="false" id="alternatecolor" name="domainList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomain" style="margin-bottom:20px;">
		<display:setProperty name="basic.empty.showtable" value="true" /> 			
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column title="MODIFY" sortable="false" style="white-space:nowrap;width: 1%;" >
				<s:url id="editURL" action="editDomain" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
		<s:a id="editbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
			<s:url id="deleteURL" action="deleteDomain">
				<s:param name="id" value="%{#attr.row.idDomain}"></s:param>
			</s:url> 				
				<s:a id="delbtn"  onclick="aux='%{deleteURL}';clickFunc(ref,event)" cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
		</display:column>
		<display:column title="SPECIFICATIONS" sortable="false" style="white-space:nowrap;width: 1%;" >				
				<s:url id="configureDomainURL" action="listDomainConfiguration">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
					
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{configureDomainURL}">CONFIGURE</s:a>
				
				<s:url id="assumptionDomainURL" action="listDomainAssumption">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
					
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{assumptionDomainURL}">ASSUMPTIONS</s:a>
				
				
				<s:url id="abstractCapabilitiesDomainURL" action="listDomainAbstractCapabilities">
					<s:param name="idDomain" value="%{#attr.row.idDomain}"></s:param>
					
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{abstractCapabilitiesDomainURL}">ABSTRACT CAPABILITIES</s:a>
				
		</display:column>
		
		</display:table>

 </s:div>

<s:div  cssClass="newButton">
 <a id="newbtn" class="ui-button ui-widget ui-corner-all"   onClick="clickFunc(this,event)" style="display: table; margin-top: 20px!important; margin: auto;">NEW DOMAIN</a>
 </s:div>


<s:div cssClass="descpagina">
<s:property value="#session['domconf_admin']"/>
<s:if test='#session["link_domconf_admin"] != ""'>
<a href="<s:property value="#session['link_domconf_admin']"/>" target="_blank"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>