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
	<a  href="./index.jsp" >ADMINISTRATOR PANEL</a>
	<a  href="listDomain.action" >DOMAIN MANAGEMENT</a>
	<a  href="listDomainAbstractCapabilities?idDomain=<%out.println(request.getParameter("idDomain")); %>">ABSTRACT CAPABILITIES (<s:property value="#session.domainName" />)</a>
	<a class="active">ABSTRACT CAPABILITIES PROPOSAL</a>
</div></div>


<script>
  $( function() {
		var editflag = getCookie("editflag");
	  	//console.log("inizio programma, il flag e:"+editflag);
	 	var dialog, form, refusedialog,
	 	tips = $( ".validateTips" );  
	    dialog = $( "#dialog-form" ).dialog({
			
	        autoOpen: false,
	        height: "auto",
	        width: "auto",
	        modal: true,
	        resizable: false,
	        buttons: {
	        	"Close Window": function() {
	                dialog.dialog( "close" );
	              }
	        },
	        close: function() {
	        }
	      });

	    refusedialog = $( "#refusedialog" ).dialog({
			
	        autoOpen: false,
	        height: 280,
	        width: 600,
	        modal: true,
	        resizable: false,
	        buttons: {
	            "Refuse": function() {
		            if($('#motivation').val()!=""){
			            $('#formrefuse').submit();}
		            else{
		            	updateTips("Bisogna inserire una motivazione.");
		            	evidenzia($('#motivation'));
			            }
		            },
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
	//console.log("funzione click");

	if(ref.id === "editbtn"){
		event.preventDefault();
		//console.log(ref.id);
		setCookie("editflag", "true", 365);
		window.location.href=ref.href;
	}
	
	if(ref.id === "delbtn"){
		refusedialog = $( "#refusedialog" );
		refusedialog.dialog( "open" );
	}
	
}

</script>

<div id="dialog-form" title="Abstract Capability Proposal">
  <p class="validateTips">Fill the fields and click Save.</p>
      
    <fieldset>
     <s:form id="formtosub">
	<s:push value="abstractCapabilityProposal">
	    <s:textfield id="name" name="name"  label="NAME"  readonly="true" cssClass="fielddialog"/>
	    <s:textfield id="providerINPUT" name="provider"   label="PROVIDER" readonly="true" cssClass="fielddialog"/>
	    <s:textfield id="stateINPUT" name="state"   label="STATE" readonly="true" cssClass="fielddialog"/>
	    <s:textfield id="bodyINPUT" name="body" label="BODY"  readonly="true" cssClass="fielddialog"/>
	   	<s:textarea id="descriptionINPUT" name="description"  label="NOTES" readonly="true" cssClass="areadialog"/>
<%-- 	<s:select   id="stateINPUT" name="state"   label="STATE"  list="#{'approved':'approved', 'refused':'refused', 'waiting':'waiting'}"   value="{#state}" > </s:select> --%>
	    <s:textfield id="motivationCap" name="motivation"  label="MOTIVATION" readonly="true" cssClass="fielddialog"/>
	</s:push>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>



<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="abstractCapabilityProposalsList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-top:20px;">		
<%-- <display:setProperty name="paging.banner.onepage"> </display:setProperty> --%>
        <display:setProperty name="basic.empty.showtable" value="true" />
<display:column property="name" title="NAME" sortable="true"> <s:property value="name"/></display:column>
<%--  <display:column sortable="true" property="idAbstratCapability" title="ID"/> --%>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column property="state" title="PROPOSAL STATE" sortable="true" ></display:column>

<s:if test='#session.role!="guest"'>				
<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >
<s:url id="editURL" action="loadAbstractCapabilityProposal" escapeAmp="false"> 
					<s:param name="id" value="%{#attr.row.idProposal}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a id="editbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all"    href="%{editURL}"  >SHOW</s:a>

				<s:url id="acceptProposalURL" action="saveOrUpdateDomainAbstractCapabilityProposal">
					<s:param name="id" value="%{#attr.row.idProposal}"></s:param>
					<s:param name="state" value="%{'approved'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					</s:url> 
					
<%-- 					<sj:submit   cssClass="ui-button ui-widget ui-corner-all"  oncl href="%{acceptProposalURL}"  value="ACCEPT"></sj:submit > --%>
 
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{acceptProposalURL}">APPROVE</s:a>
				
				
<%-- 				<s:url id="refuseProposalURL" action="saveOrUpdateDomainAbstractCapabilityProposal"> --%>
<%-- 					<s:param name="id" value="%{#attr.row.idProposal}"></s:param> --%>
<%-- 					<s:param name="state" value="%{'refused'}"></s:param> --%>
<%-- 					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param> --%>
<%-- 				</s:url>  --%>

<%-- <s:url id="refuseProposalURL" var="remoteurl"  action="saveOrUpdateDomainAbstractCapabilityProposal"> --%>
<%-- <s:param name="id" value="%{#attr.row.idProposal}"></s:param>  --%>
<%-- 					<s:param name="state" value="%{'refused'}"></s:param> --%>
<%-- 					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param> --%>
<%-- 					</s:url> --%>



     <sj:a  id="delbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all">REFUSE</sj:a >
 <div id="refusedialog" title="Refuse Proposal">
  <p class="validateTips">Insert a motivation and click save.</p>
      
    <fieldset>
     <s:form id="formrefuse" action="saveOrUpdateDomainAbstractCapabilityProposal">

     <s:textfield id="motivation" name="motivation"  value="%{#attr.row.motivation}" label="MOTIVATION" style="height: 200px; width: 400px;resize: none;"  ></s:textfield>
     <s:hidden id="id" name="id" value="%{#attr.row.idProposal}" />
     <s:hidden id="motivationDB" name="motivationDB"  value="%{#attr.row.motivation}"  />
     <s:hidden id="state" name="state" value="%{'refused'}" />
     <s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}"/>
     
     <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>
<!-- 				<button   id="refuse_cap" >REFUSE</button> -->
</display:column>
</s:if>

</display:table>

 </s:div>

</body>
</html>