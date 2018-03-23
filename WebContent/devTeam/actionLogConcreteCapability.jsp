<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
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

<s:head/>
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
	<a  href="domainListDev.action" >DOMAINS</a>
	<a  href="listDomainConcreteCapabilities.action?idDomain=<%out.println(request.getParameter("idDomain")); %>"  >CONCRETE CAPABILITY (<s:property value="#session.domainName" />)</a>
	<a class="active">CAPABILITY LOG FOR INSTANCE</a>
</div></div>

<s:div  cssClass="mainDiV">
		<display:table export="false" id="alternatecolor" name="capabilityLogList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-bottom:20px;">
		<display:column property="timeOperation" title="TIME" sortable="true"></display:column>
		<display:column property="action" title="ACTION" sortable="true"></display:column>
	
		</display:table>
 
 </s:div>
<s:div cssClass="descpagina">
<s:property value="#session['logall_dev']"/>
<s:if test='#session["link_logall_dev"] != ""'>
<a href="<s:property value="#session['link_logall_dev']"/>" target="_blank"> (MORE INFO)</a>
</s:if>
</s:div>
</body>
</html>