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
<title>Functional Requirements</title>
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
	<a  href="domainListCustomer.action" >DOMAINS</a>
	<a  href="listDomainSpecification.action?idDomain=<%out.println(request.getParameter("idDomain")); %>" >SPECIFICATIONS MANAGEMENT (<s:property value="#session.domainName" />)</a>
	<a class="active">FUNCTIONAL REQUIREMENTS</a>
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
                  	if($("#nameNewFunctionalReq").val().length !=0  && $("#bodyInput").val().length !=0 && $("#actorsInput").val().length !=0){
        		    	dialog.dialog( "close" );
        		    	$('#formtosub').submit();
        		    }
        		    else{
        			evidenzia($('#nameNewFunctionalReq'));
        			evidenzia($('#actorsInput'));        			
        			evidenzia($('#bodyInput'));
        			updateTips("Please fill out all mandatory fields.");
        			}
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
      
          if (editflag === "true") {
              //console.log("ho verificato che flag e true");
              dialog.dialog("open");
              setCookie("editflag", "false", 365);
              editflag = "false";
          } else {
              //console.log("ho verificato che flag e false");
              dialog = $("#dialog-form");
              dialog.dialog("close");
          }
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
		$( "#nameNewFunctionalReq" ).val("");
		$( "#descriptionInput" ).val("");
		$( "#priorityInput" ).val("");
		$( "#bodyInput" ).val("");
		$( "#actorsInput" ).val("");
		$( "#descriptionsInput" ).val("");
		
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
<div id="dialog-form" title="Functional Requirements">
  <p class="validateTips">Fill the fields and click Save.</p>
 <fieldset>
     <s:form id="formtosub" action="saveOrUpdateFunctionalReq">
	<s:push value="functionalReq">

		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idInput" name="idFunctionalReq" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameNewFunctionalReq" maxlength="250" name="name" label="Name" cssClass="fielddialog" />
		<s:textfield id="typeNewFunctionalReq" name="type" label="Type" readonly="true" cssClass="fielddialog" style="color:#9e9e9e;" />
		<!-- <s:textfield id="currentStateNewFunctionalReq" name="currentState" label="Current State"  readonly="true" cssClass="fielddialog" style="color:#9e9e9e;" /> -->
		<s:textfield id="priorityInput" maxlength="250" name="priority" label="Priority" cssClass="fielddialog" />		
		<s:textfield id="actorsInput" maxlength="250" name="actors" label="Actors" cssClass="fielddialog" />
		<s:textarea id="bodyInput" name="body" label="Body" style="height: 130px; width: 500px;resize: none;"/>
		<s:textarea id="descriptionsInput" name="description" style="height: 50px; width: 500px;resize: none;" label="Notes" />
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	
	</s:push>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  	</s:form>
    </fieldset>

</div>

<s:div  cssClass="mainDiV">
<s:url id="goalRel" action="listFunctionalReqRel">
	<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
	<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>		
</s:url>	
<s:url id="goalModel" action="goalEditor/apps/KitchenSink/loadGoalModel">
	<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
	<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>		
</s:url>	
<s:div  cssStyle="display:table;margin:auto;padding: 10px;">					 
<s:a  cssClass="ui-button ui-widget ui-corner-all" cssStyle="margin-right:10px;" href="%{goalRel}">VIEW GOAL MODEL</s:a>
<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{goalModel}">GOAL MODEL EDITOR</s:a>
</s:div>
<display:table export="false" id="alternatecolor" name="functionalReqList" pagesize="15" class="altrowstable"  uid="row" requestURI="listFunctionalReq"  style="margin-bottom:20px;">
        <display:setProperty name="basic.empty.showtable" value="true" />
			<display:column property="name" title="NAME" sortable="true"></display:column>
			<display:column property="type" title="TYPE" sortable="true"></display:column>
			<display:column property="body" title="BODY" sortable="true"></display:column>
			<display:column property="priority" title="PRIORITY" sortable="true"></display:column>
			<display:column property="actors" title="ACTORS" sortable="true"></display:column>
			<display:column property="currentState" title="CURRENT STATE" sortable="true"></display:column>
			
			<s:if test='#session.role!="guest"'>
			<display:column title="MODIFY" sortable="false" style="white-space:nowrap;width: 1%;" >
			<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		
				<s:url id="editURL" action="editFunctionalReq">
					<s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
				</s:url> 
            <s:if test='%{#attr.row.type=="manual"}'>
				<s:a id="editbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
            </s:if>
            <s:else>
				<s:a id="editbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all ui-state-disabled"  href="%{editURL}">EDIT</s:a>
            </s:else>	
<s:url id="deleteURL" action="deleteFunctionalReq">
				    <s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
 				
				</s:url>
			<s:if test='%{#attr.row.type=="manual"}'>
				<s:a  id="delbtn" onclick="aux='%{deleteURL}';clickFunc(ref,event)" cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
            </s:if>
            <s:else>
 				<s:a  id="delbtn" onclick="aux='%{deleteURL}';clickFunc(ref,event)" cssClass="ui-button ui-widget ui-corner-all ui-state-disabled" href="%{deleteURL}">DELETE</s:a>
            </s:else> 
		</display:column>
			<display:column title="MUSA" sortable="false" style="white-space:nowrap;width: 1%;" >
			<s:url id="changeStateFunctionalReqURL" action="changeStateFunctionalReq">
					  <s:param name="idFunctionalReq" value="%{#attr.row.idFunctionalReq}"></s:param>
					<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					<s:param name="d-16544-p" value="%{#parameters['d-16544-p']}" ></s:param>
			</s:url> 
			<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateFunctionalReqURL}">
			<s:if test='%{#attr.row.currentState=="activated"}'>DEACTIVATE</s:if>
				<s:else>ACTIVATE</s:else>				
				</s:a>
			</display:column>
			</s:if>
		</display:table>
 </s:div>
 
 <s:div cssClass="bottomButtons">
 <s:if test='#session.role!="guest"'>				
	<s:a id="newbtn" cssClass="ui-button ui-widget ui-corner-all centerTable" cssStyle="margin-bottom: 10px;" onClick="clickFunc(this,event)" href="#" >NEW FUNCTIONAL REQUIREMENT</s:a>
 </s:if>   
    <s:url id="editNoFunctionalReqURL" action="listNoFunctionalReq" escapeAmp="false">
	<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
     <s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
   </s:url>
   <s:a cssClass="ui-button ui-widget ui-corner-all centerTable" href="%{editNoFunctionalReqURL}">QUALITY REQUIREMENTS</s:a>
</s:div>

<s:div cssClass="descpagina">
<s:property value="#session['func_cust']"/>
<s:if test='#session["link_func_cust"] != ""'>
<a href="<s:property value="#session['link_func_cust']"/>" target="_blank"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>