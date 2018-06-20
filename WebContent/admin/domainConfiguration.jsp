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
<s:if test='#session.root=="on"'>
	<a href="../super/index.jsp" >HOME</a>
</s:if>
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a  href="listDomain.action" >DOMAIN MANAGEMENT</a>
<a  class="active">DOMAIN CONFIGURATIONS (<s:property value="#session.domainName" />)</a>
</div></div>

<script>

  $( function() {
		var editflag = getCookie("editflag");
	  	//console.log("inizio programma, il flag e:"+editflag);
	 	var dialog, form,
	 	tips = $( ".validateTips" );
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
	
	if(ref.id === "editbtn"){
		//console.log(ref.id);
		setCookie("editflag", "true", 365);
		window.location.href=ref.href;
	}
}
</script>

<div id="dialog-form" title="Edit Configuration">
  <p class="validateTips">Fill the fields and click Save.</p>
 
     
    <fieldset>
<s:form id="formtosub"  action="saveOrUpdateDomainConf">
	<s:push value="domainConfiguration">
		<s:hidden id="idInput" name="idDomainConfiguration" readonly="true" cssClass="fielddialog" />
		<s:hidden id="idDomain" name="idDomain" readonly="true" value="%{#parameters.idDomain}" cssClass="fielddialog" />
		<s:textfield id="nameInput" name="name" readonly="true" label="Name" cssClass="fielddialog" />
		<s:textarea id="descriptionInput" name="description" readonly="true" label="Notes" cssClass="fielddialog" />
		<s:textfield id="valueInput" maxlength="250" name="value" label="Value" cssClass="fielddialog" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	</s:push>

      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="domainConfigurationList" pagesize="5" class="altrowstable"  uid="row" requestURI="listDomainConfiguration"  style="margin-bottom:20px;">
		<display:setProperty name="basic.empty.showtable" value="true" /> 	
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="value" title="VALUE" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column  title="ACTIONS" sortable="false" >
		<s:url id="editURL" action="editDomainConfiguration" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idDomainConfiguration}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a id="editbtn" cssClass="ui-button ui-widget ui-corner-all" onClick="clickFunc(this,event)"  href="%{editURL}">EDIT</s:a>
<!--
				<s:url id="deleteURL" action="deleteDomainConfiguration">
					<s:param name="id" value="%{#attr.row.idDomainConfiguration}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a> -->
			
		</display:column>
		
		</display:table>

 </s:div>

<s:div cssClass="descpagina">
<s:property value="#session['domconf_admin']"/>
<s:if test='#session["link_domconf_admin"] != ""'>
<a href="<s:property value="#session['link_domconf_admin']"/>" target="_blank"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>