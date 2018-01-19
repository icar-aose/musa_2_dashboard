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
Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a> 
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
<div id="header" class="container">

	<div id="mainDiV" style="text-align: center">
<h2> MUSA DASHBOARD</h2>
<!-- 	<img id ="logoMUSA" src="../img/MUSA_LOGO.png" />  -->
<!-- 	<img  id ="logoICAR" src="../img/logoECOSICAR.png" />  -->
	</div>
	<div id="menu">
		<ul>
<!--			<li><a  href="../index.jsp" >HOME</a></li> -->
			<li><a  href="./index.jsp" >ADMINISTRATOR PANEL</a></li>
			<li><a  href="listDomain.action" >DOMAIN MANAGEMENT</a></li>
			<li><a  href="listDomainAbstractCapabilities.action?idDomain=<%out.println(request.getParameter("idDomain")); %>" >ABSTRACT CAPABILITIES </a></li>
		
	  </ul>
		
	</div>
	
</div>
<s:div  cssClass="mainDiV">

<h1>ABSTRACT CAPABILITIES PROPOSAL</h1>




<display:table export="false" id="alternatecolor" name="abstractCapabilityProposalsList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-top:20px;">		
<%-- <display:setProperty name="paging.banner.onepage"> </display:setProperty> --%>
<display:column property="name" title="NAME" sortable="true"> <s:property value="name"/></display:column>
<%--  <display:column sortable="true" property="idAbstratCapability" title="ID"/> --%>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column property="state" title="PROPOSAL STATE" sortable="true" ></display:column>

				
<display:column title="ACTIONS" sortable="false" >
<s:url id="editURL" action="loadAbstractCapabilityProposal" escapeAmp="false"> 
					<s:param name="id" value="%{#attr.row.idProposal}"></s:param>
					<s:param name="operation_name" value="%{'edit'}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
				</s:url> 
				<s:a cssClass="ui-button ui-widget ui-corner-all"    href="%{editURL}"  >SHOW</s:a>

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


    <sj:dialog 
        id="motivationDialog" 
       	title="REFUSE PROPOSAL" 
        resizable="true"
        height="200"
        width="400"
        autoOpen="false" 
 onOpenTopics="validateForm();">
     
     <s:form  id="motivationForm"  action="saveOrUpdateDomainAbstractCapabilityProposal" >
     <s:textfield id="motivation" name="motivation"  value="%{#attr.row.motivation}" label="MOTIVATION"   ></s:textfield>
     <s:hidden id="id" name="id" value="%{#attr.row.idProposal}" />
     <s:hidden id="motivationDB" name="motivationDB"  value="%{#attr.row.motivation}"  />
     <s:hidden id="state" name="state" value="%{'refused'}" />
     <s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}"/>
     <s:submit id="saveMotivationButton" value="SAVE"  onclick=" return validateForm()"/> 
    
     </s:form>
    </sj:dialog>
     <sj:a  cssClass="ui-button ui-widget ui-corner-all"  onclick="cleanForm()" openDialog="motivationDialog"  clearForm="true" value="REFUSE">REFUSE</sj:a >
 
<!-- 				<button   id="refuse_cap" >REFUSE</button> -->
</display:column>

</display:table>

 </s:div>
 <s:div  id="newConfDiv" cssClass="newDiv" >
	<fieldset>
  <legend>PROPOSAL DATA:</legend>
  <s:form>
  <s:push value="abstractCapabilityProposal">
     	<s:textfield id="name" name="name"  label="NAME"  readonly="true" />
	    <s:textfield id="providerINPUT" name="provider"   label="PROVIDER" readonly="true" />
	    <s:textfield id="stateINPUT" name="state"   label="STATE" readonly="true" />
	    <s:textfield id="preConditionINPUT" name="preCondition" label="PRE-CONDITION"  readonly="true"/>
	    <s:textfield id="postConditionINPUT" name="postCondition"   label="POST-CONDITION" readonly="true" />
	   	<s:textarea id="descriptionINPUT" name="description"  label="NOTES" readonly="true"/>
	  
<%-- 	    <s:select   id="stateINPUT" name="state"   label="STATE"  list="#{'approved':'approved', 'refused':'refused', 'waiting':'waiting'}"   value="{#state}" > --%>
	    
<%-- 	    </s:select> --%>
	  
	    <s:textfield id="motivationCap" name="motivation"  label="MOTIVATION" readonly="true"/>
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