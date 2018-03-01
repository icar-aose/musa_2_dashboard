<%@page import="dbBean.FunctionalReq"%>
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

<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Goal Relations</title>
</head>
<body>
<!-- <a  href="index/index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->
 Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a>

<div id="header" class="container">

	
</div>


<s:div  cssClass="mainDiV">

<h1>FUNCTIONAL REQUIREMENTS</h1>

<display:table export="false" id="alternatecolor" name="functionalReqRelList" pagesize="5" class="altrowstable"  uid="row" requestURI="listFunctionalReqRel"  style="margin-bottom:20px;">
			
			<display:column property="functionalReqByIdStart.name" title="START" sortable="true"></display:column>
			<display:column property="functionalReqByIdEnd.name" title="END" sortable="true"></display:column>
			<display:column property="type" title="TYPE" sortable="true"></display:column>

		</display:table>
 </s:div>
 <s:div  cssClass="newButton">
 <a class="ui-button ui-widget ui-corner-all"   href="editFunctionalReq.action?operation_name=new&idSpecification=<%out.println(request.getParameter("idSpecification"));%>&idDomain=<%out.println(request.getParameter("idDomain")) ;%>&functionalReqCount=${row_rowNum}"  style="margin-left: 40%; margin-top: 40px">NEW FUNCTIONAL REQUIREMENT</a>
<!--  <a class="ui-button ui-widget ui-corner-all"  onclick="enableDiv('newConfDiv')" href="#"  style="margin-left: 40%; margin-top: 40px">NEW FUNCTIONAL REQUIREMENT</a> -->
 
 
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