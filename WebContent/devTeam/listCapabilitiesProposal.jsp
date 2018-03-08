<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
 <%@ taglib prefix="sj" uri="/struts-jquery-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
 <link rel="stylesheet" href="../css/style.css" type="text/css"/>
 <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
 
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../script/musaGUIScript.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <sj:head jqueryui="true" />
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
	<a  href="domainListDev.action" >DOMAINS</a>
	<a class="active">ABSTRACT CAPABILITIES PROPOSAL (<s:property value="#session.domainName" />)</a>
</div></div>
<script>
	//window.onload =setEnabled;
	
// 	window.onload = function (event) {

// 		changeValue();
	
// 		};
	</script>
	
<%

if(request.getParameter("idDomain")!=null){
	
}
if(request.getParameter("operation_name")!=null){
if(request.getParameter("operation_name").equals("edit")){
	%>
	<script>
	//window.onload =setEnabled;
	
	window.onload = function (event) {
		setEnabled('newConfDiv');
		
		}
	</script>
	<%
}
}
%>

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="abstractCapabilityProposalsList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-top:20px;">		
<%-- <display:setProperty name="paging.banner.onepage"> </display:setProperty> --%>
<display:column property="name" title="NAME" sortable="true"> <s:property value="name"/></display:column>
<%--  <display:column sortable="true" property="idAbstratCapability" title="ID"/> --%>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column property="state" title="PROPOSAL STATE" sortable="true" ></display:column>

				
<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >

				<s:url id="retreatProposalURL" action="deleteAbstractCapabilityProposal">
					<s:param name="id" value="%{#attr.row.idProposal}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					</s:url> 
					
			<s:if test='%{#attr.row.state=="waiting"}'>
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{retreatProposalURL}">RETREAT</s:a>
			
			</s:if>

</display:column>

</display:table>

 </s:div>
 <s:div  id="newConfDiv" cssClass="newDiv" >
	<fieldset>
  <legend>PROPOSAL DATA:</legend>
  <s:form  action="updateAbstractCapabilitiesProposal" id="proposalForm">
	
  <s:push value="abstractCapabilityProposal">
 		 <s:hidden id="idInput" name="idProposal" />
  		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" /> 
 		<s:textfield id="name" name="name"  label="NAME"  />
	    <s:textfield id="preConditionINPUT" name="preCondition" label="PRE-CONDITION"  />
	    <s:textfield id="postConditionINPUT" name="postCondition"   label="POST-CONDITION" />
	    <s:textarea id="descriptionINPUT" name="description"  label="NOTES" />
	    <s:textfield id="providerINPUT" name="provider"   label="PROVIDER"  />
	     <s:textfield id="stateINPUT" name="state"   label="STATE" readonly="true" />
<%-- 	    <s:select   id="stateINPUT" name="state"   label="STATE"  list="#{'approved':'approved', 'refused':'refused', 'waiting':'waiting'}"   value="{#state}" > --%>
	    
<%-- 	    </s:select> --%>
	  
	    <s:textfield id="motivationCap" name="motivation"  label="MOTIVATION" readonly="true"/>
	    <s:submit  value="SAVE"  onclick="disableDiv('newDiv')" />
	</s:push>
      </s:form>
  </fieldset>
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