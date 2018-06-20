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
<script type="text/javascript" src="../script/globalScripts.js"></script>
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
<s:if test='#session.root=="on"'>
	<a href="../super/index.jsp" >HOME</a>
</s:if>
	<a  href="domainListDev.action" >DOMAINS</a>
	<a class="active">NEW CONCRETE CAPABILITY (<s:property value="#session.domainName" />)</a>
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
        "Close": function() {
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

<div id="dialog-form" title="Abstract Capability Details">
  <p class="validateTips">Fill the fields and click Save.</p>
 <fieldset>
     <s:form id="formtosub">
		<s:hidden id="idInput2" name="abstractCapability.idAbstratCapability" />
		<s:hidden id="idDomain2" name="abstractCapability.idDomain" value="%{#parameters.idDomain}" />
		<s:hidden id="idAbstractCapability2" name="abstractCapability.idAbstractCapability" value="%{#parameters.id}" /> 
		<s:textfield id="nameInput2" maxlength="250" name="abstractCapability.name" label="Name" readonly="true" style="height: auto; width: 600px;resize: none;" />
		<s:textarea id="inputInput2" maxlength="1000" name="abstractCapability.input" label="Input"  readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="outputInput2" maxlength="1000" name="abstractCapability.output" label="Output" readonly="true" style="height: 80px; width: 600px;resize: none;"/>
		<s:textarea id="paramsInput2" maxlength="1000" name="abstractCapability.params" label="Params" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="bodyInput2" name="abstractCapability.body" label="Body" readonly="true" style="height: auto; width: 600px;resize: none;" />
		<s:textarea id="descriptionInput2"  name="abstractCapability.description" label="Notes" readonly="true" style="height: 80px; width: 600px;resize: none;" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
</s:form>

</fieldset>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">


</div>


<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="abstractCapabilitiesList" pagesize="10" class="altrowstable"  uid="row" requestURI="listDomainAbstractCapabilitiesDev"  style="margin-bottom:20px;">
<display:setProperty name="basic.empty.showtable" value="true" />		
<display:column property="name" title="LIST OF ABSTRACT CAPABILITIES" sortable="true"> <s:property value="name"/></display:column>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column title="ABSTRACT ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;">

				<s:url id="viewDetailsURL" action="detailsAbstractCapabilities" escapeAmp="false">
					<s:param name="id" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
				<s:a id="editbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all"  href="%{viewDetailsURL}">SHOW</s:a>
				
				<s:url id="listConcreteURL" action="listConcreteCapabilitiesDev">
					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
					<s:param name="abstractCapabilityName" value="%{#attr.row.name}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{listConcreteURL}">LIST CONCRETE</s:a>				
</display:column>
<display:column title="SPECIFICATIONS" sortable="false" style="white-space:nowrap;width: 1%;">
				
				<s:url id="newURL" action="newConcreteCapability" escapeAmp="false">
					<s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
						<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"  href="%{newURL}">NEW CONCRETE</s:a>
				
</display:column>

</display:table>

 </s:div>

<s:div cssClass="descpagina">
<s:property value="#session['newconc_dev']"/>
<s:if test='#session["link_newconc_dev"] != ""'>
<a href="<s:property value="#session['link_newconc_dev']"/>" target="_blank"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>