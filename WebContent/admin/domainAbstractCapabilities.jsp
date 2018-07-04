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
    <script type="text/javascript" src="../script/globalScripts.js"></script>
    <script type="text/javascript" src="../script/highlights.js"></script>
    <script type="text/javascript" src="../script/URI.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Domain Abstract Capability management</title>
  </head>
  <body>
    <s:url id="listURL" action="listDomainAbstractCapabilities" escapeAmp="false">
      <s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
    </s:url>
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
        <a href="./index.jsp">ADMINISTRATOR PANEL</a>
        <a href="listDomain.action">DOMAIN MANAGEMENT</a>
        <a class="active">
          ABSTRACT CAPABILITIES (
          <s:property value="#session.domainName" />
          )
        </a>
      </div>
    </div>
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
                  	if($("#nameInput").val().length !=0  && $("#bodyInput").val().length !=0){
        		    	dialog.dialog( "close" );
        		    	$('#formtosub').submit();
        		    }
        		    else{
        			evidenzia($('#nameInput'));
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
      
      function clickFunc(ref,event) {
          event.preventDefault();
          //console.log("funzione click");
          if (ref.id === "newbtn") {
              //console.log(ref.id);
              dialog = $("#dialog-form");
              dialog.dialog("open");
              $("#idInput").val("");
              $("#nameInput").val("");
              $("#descriptionInput").val("");
              $("#inputInput").val("");
              $("#outputInput").val("");
              $("#paramsInput").val("");
              $("#assumptionInput").val("");
              $("#bodyInput").val("");
          }
      
          if (ref.id === "editbtn") {
              //console.log(ref.id);
              setCookie("editflag", "true", 365);
              window.location.href = ref.href;
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
    <div id="dialog-form" title="Abstract Capability">
      <p class="validateTips">Fill the fields and click Save.</p>
      <fieldset>
        <s:form id="formtosub" action="saveOrUpdateDomainAbstractCapabilities">
          <s:push value="abstractCapability">
            <s:hidden id="idInput" name="idAbstractCapability" value="%{#parameters.id}" cssClass="fielddialog" />
            <s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
            <s:textfield id="nameInput" maxlength="250" name="name" label="Name" cssClass="fielddialog" />
            <s:textarea id="inputInput" maxlength="1000" name="input" label="Input" cssClass="fielddialog" />
            <s:textarea id="outputInput" maxlength="1000" name="output" label="Output" cssClass="fielddialog" />
            <s:textarea id="paramsInput" maxlength="1000" name="params" label="Params" cssClass="fielddialog" />
            <s:textarea id="assumptionInput" maxlength="1000" name="assumption" label="Assumption" cssClass="fielddialog" />
            <s:textarea id="bodyInput" name="body" label="Body" cssClass="areadialog" />
            <s:textarea id="descriptionInput" name="description" label="Notes" cssClass="fielddialog" />
          </s:push>
          <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
        </s:form>
      </fieldset>
    </div>
    <s:div cssClass="mainDiV">
      <display:table export="false" id="alternatecolor" name="abstractCapabilitiesList" pagesize="5" class="altrowstable" uid="row" requestURI="listDomainAbstractCapabilities" style="margin-bottom:20px;">
        <display:setProperty name="basic.empty.showtable" value="true" />
        <display:column property="name" title="NAME" sortable="true">
          <s:property value="name" />
        </display:column>
        <display:column sortable="true" property="idAbstratCapability" title="ID" class="hidden" headerClass="hidden" />
        <display:column property="body" title="BODY" sortable="true" style="white-space: pre-wrap;">
          <s:property value="body" />
        </display:column>
        <display:column property="assumption" title="ASSUMPTION" sortable="true">
          <s:property value="assumption" />
        </display:column>
        <display:column property="description" title="NOTES" sortable="true">
          <s:property value="description" />
        </display:column>
        
        <s:if test='#session.role!="guest"'>
        <display:column title="MODIFY" sortable="false" style="white-space:nowrap;width: 1%;">
           <s:url id="editURL" action="editDomainAbstractCapabilities" escapeAmp="false">
            <s:param name="id" value="%{#attr.row.idAbstratCapability}"></s:param>
            <s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
            <s:param name="d-16544-p" value="%{#parameters['d-16544-p']}"></s:param>
          </s:url>
          <s:a id="editbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all" href="%{editURL}">EDIT</s:a>
                
          <s:url id="deleteURL" action="deleteDomainAbstractCapabilities">
            <s:param name="id" value="%{#attr.row.idAbstratCapability}"></s:param>
            <s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
          </s:url>
          <s:a id="delbtn" onclick="aux='%{deleteURL}';clickFunc(ref,event)" cssClass="ui-button ui-widget ui-corner-all" href="%{deleteURL}">DELETE</s:a>
 </display:column>
 </s:if>
        <display:column title="SPECIFICATIONS" sortable="false" style="white-space:nowrap;width: 1%;">          
          <s:url id="listConcreteURL" action="listConcreteCapabilities">
            <s:param name="idAbstractCapability" value="%{#attr.row.idAbstratCapability}"></s:param>
            <s:param name="abstractCapabilityName" value="%{#attr.row.name}"></s:param>
            <s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
          </s:url>
          <s:a cssClass="ui-button ui-widget ui-corner-all" href="%{listConcreteURL}">LIST OF CONCRETE</s:a>
        </display:column>
      </display:table>
    </s:div>
    <script>
      $('td').highlight('scenario ');
      $('td').highlight('pre: ');
      $('td').highlight('post: ');
    </script>
    <s:div style="display:table;margin:auto;padding-top:20px;">
    <s:if test='#session.role!="guest"'>				
      <s:a id="newbtn" onClick="clickFunc(this,event)" cssClass="ui-button ui-widget ui-corner-all" href="#">NEW ABSTRACT CAPABILITY</s:a>
     </s:if>
      <s:url id="listAbstractCapabilityProposalURL" action="listAbstractCapabilityProposal">
        <s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
      </s:url>
      <s:a cssClass="ui-button ui-widget ui-corner-all" href="%{listAbstractCapabilityProposalURL}">VIEW THIRD-PARTY ABSTRACT CAPABILITY PROPOSAL</s:a>
    </s:div>
    
<s:div cssClass="descpagina">
<s:property value="#session['abscap_admin']"/>
<s:if test='#session["link_abscap_admin"] != ""'>
<a href="<s:property value="#session['link_abscap_admin']"/>" target="_blank"> (MORE INFO)</a>
</s:if>

</s:div>
  </body>
</html>