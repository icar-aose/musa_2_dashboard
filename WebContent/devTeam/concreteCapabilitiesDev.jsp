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
    <script type="text/javascript" src="../script/highlights.js"></script>
    <script type="text/javascript" src="../script/URI.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Concrete Capabilities</title>
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
<s:if test='#session.root=="on"'>
	<a href="../super/index.jsp" >HOME</a>
</s:if>
	<a  href="domainListDev.action" >DOMAINS</a>
<s:if test="%{#parameters.idAbstractCapability!=null}">
	<a  href="listDomainAbstractCapabilitiesDev.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >NEW CONCRETE CAPABILITY (<s:property value="#session.domainName" />)</a>
	<a class="active">MANAGE CONCRETE CAPABILITIES (<%out.println(request.getParameter("abstractCapabilityName")); %>)</a>
</s:if>
<s:else>	
	<a class="active">MANAGE CONCRETE CAPABILITIES (<s:property value="#session.domainName" />)</a>
</s:else>
</div></div>
    <script>
      function setCookie(cname, cvalue, exdays) {
          var d = new Date();
          d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
          var expires = "expires=" + d.toUTCString();
          document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
      }
      
      function getCookie(cname) {
          var name = cname + "=";
          var ca = document.cookie.split(';');
          for (var i = 0; i < ca.length; i++) {
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
      
      $(function() {
          var editflag = getCookie("editflag");
          //console.log("inizio programma, il flag e:" + editflag);
          var form,conf,
              tips = $(".validateTips");
      
          function updateTips(t) {
              tips
                  .text(t)
                  .addClass("ui-state-highlight");
              setTimeout(function() {
                  tips.removeClass("ui-state-highlight", 1500);
              }, 500);
          }
            
          conf = $("#del-confirm").dialog({
      
              autoOpen: false,
              resizable: false,
              height: "auto",
              width: "auto",
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
      
      function clickFunc(ref) {
          event.preventDefault();
          //console.log("funzione click");
      
          if (ref.id === "delbtn") {
              //console.log(ref.id);
              conf = $("#del-confirm");
              conf.dialog("open");
          }
      
      }
      
                  $(window).resize(function() {
                      $("#del-confirm").dialog("option", "position", {
                          my: "center",
                          at: "center",
                          of: window
                      });
                  });
      
    </script>
    <div id="del-confirm" title="Conferma Eliminazione">
      <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>L'elemento selezionato verrà eliminato definitivamente dal database, proseguire?</p>
    </div>
         
<s:div  cssClass="mainDiV">
		<display:table export="false" id="alternatecolor" name="concreteCapabilitiesList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-bottom:20px;">
        <display:setProperty name="basic.empty.showtable" value="true" />
		<display:column property="name" title="NAME" sortable="true"></display:column>
		<display:column property="state" title="STATE" sortable="true"></display:column>
		<display:column property="deploystate" title="DEPLOYSTATE" sortable="true"></display:column>
		<display:column property="abstractCapability.name" title="ABSTRACT" sortable="true"></display:column>
		<display:column property="description" title="NOTES" sortable="true"></display:column>
		<display:column property="wpname" title="WPNAME" sortable="true"></display:column>
		<display:column property="classname" title="CLASS NAME" sortable="true"></display:column>
		<display:column title="MODIFY" sortable="false" style="white-space:nowrap;width: 1%;" >
			
		<s:url id="editURL" action="editConcreteAbstractCapabilities" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#attr.row.abstractCapability.idAbstratCapability}"></s:param>
			<s:param name="abstractCapabilityName" value="%{#parameters.abstractCapabilityName}"></s:param>				
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 
		<s:a id="editbtn" cssClass="ui-button ui-widget ui-corner-all"  href="%{editURL}">EDIT</s:a>
				
		<s:url id="deleteURL" action="deleteConcreteCapability" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 
		<s:a id="delbtn" onclick="aux='%{deleteURL}';clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="%{deleteURL}">DELETE</s:a>				
	</display:column>
	<display:column title="MUSA" sortable="false" style="white-space:nowrap;width: 1%;" >			
		<s:url id="changeStateCapabilityURL" action="changeStateConcreteCapability">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url>
		 
		 <s:if test='%{#attr.row.deploystate=="undeployed"}'>
		<s:a  cssClass="ui-button ui-widget ui-corner-all ui-state-disabled" href="%{changeStateCapabilityURL}">
			<s:if test='%{#attr.row.state=="active"}'>STOP</s:if>
			<s:else>START</s:else>
		</s:a>	
		</s:if>
		
		<s:else>
		<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeStateCapabilityURL}">
					<s:if test='%{#attr.row.state=="active"}'>STOP</s:if>
					<s:else>START</s:else>
				</s:a>	
		</s:else>

		<s:url id="changeDeployCapabilityURL" action="changeDeployConcreteCapability">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url>
		 
		<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{changeDeployCapabilityURL}">
			<s:if test='%{#attr.row.deploystate=="deployed"}'>UNDEPLOY</s:if>
			<s:else>DEPLOY</s:else>
		</s:a>
				
		<s:url id="logCapabilityURL" action="logConcreteAbstractCapabilities" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 		
		<s:a cssClass="ui-button ui-widget ui-corner-all"   href="%{logCapabilityURL}">LOG (CASE)</s:a>
		
		<s:url id="logAllCapabilityURL" action="logAllConcreteAbstractCapabilities" escapeAmp="false">
			<s:param name="id" value="%{#attr.row.idConcreteCapability}"></s:param>
			<s:param name="idAbstractCapability" value="%{#parameters.idAbstractCapability}"></s:param>
			<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:url> 		
		<s:a cssClass="ui-button ui-widget ui-corner-all"   href="%{logAllCapabilityURL}">LOG (ALL)</s:a>
					
		</display:column>
		</display:table>
 
 </s:div>
<s:div cssClass="descpagina">
<s:property value="#session['manconc_dev']"/>
<s:if test='#session["link_manconc_dev"] != ""'>
<a href="<s:property value="#session['link_manconc_dev']"/>" target="_blank"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>