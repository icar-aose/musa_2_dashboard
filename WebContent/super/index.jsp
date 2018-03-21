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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MUSA GUI</title>
</head>
<body>

<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
</div>

<!-- <a  href="../index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->

<div id="mainDiV" style="text-align: center">
<h2> MUSA DASHBOARD</h2>
<div id="page" style="display: inline-block;">
	<div class="boxA">
		
		<div class="box">
			<span> <a  href="../admin/index.jsp">ADMIN</a></span>
		</div>
		
	</div>

	<div class="boxB">
		
		<div class="box">
		<span> <a href="../devTeam/listDevUser.action">DEV TEAM</a> </span>
<!-- 		<span> <a href="devTeam/domainListDev.action">DEV TEAM</a> </span> -->
	
		</div>
		
	</div>
	
	
	<div class="boxC">
		
		<div class="box">
		<span> <a href="../customer/listCustomerUser.action">CUSTOMER</a></span>
<!-- 			<span> <a href="customer/domainListCustomer.action">CUSTOMER</a></span> -->
		</div>
		
	</div>

</div>
</div>

<s:div cssClass="descpagina">
<s:property value="#session['home_super']"/>
<s:if test='#session["link_home_super"] != ""'>
<a href="<s:property value="#session['link_home_super']"/>"> (MORE INFO)</a>
</s:if>
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