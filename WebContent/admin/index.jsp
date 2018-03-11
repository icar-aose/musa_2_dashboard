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
  <link rel="stylesheet" href="../css/style.css" type="text/css"/>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
 
 <script type="text/javascript" src="../script/musaGUIScript.js"></script>
 
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>ADMINISTRATOR PANEL</b></p>
  <div style="clear: both;"></div>
</s:div>

<div class="center">
	<div class="boxAdmin">
		
		<div class="box">
<!-- 			<a href="anagrafica.php" class="image image-full"><img src="img/pers.png" alt="VAI AD ANAGRAFICA" /></a> -->
			
			<span> <a href="listGeneralConfiguration.action">CONFIG SETTINGS</a></span>
		</div>
		
	</div>

	<div class="boxB">
		
		<div class="box">
<!-- 			<a href="riepilogomovimenti.php" class="image image-full"><img id ="fondiImg" src="img/movimenti.png" alt="VAI GESTIONE FONDI" /></a> -->
			<span> <a  href="listDomain.action">DOMAIN MANAGEMENT</a> </span>
		</div>
		
	</div>

</div>



<div id="titleDiv">

</div>
<div  id="centerdiv">


<!-- <table id="Mainbutton" > -->
<!-- <tr> -->
<!-- <td> -->
<!-- <a  class="ui-button ui-widget ui-corner-all cm-button" href="listGeneralConfiguration.action">GENERAL CONFIGURATIONS SETTING</a> -->

<!-- </td> -->
<!-- <td> -->
<!-- <a class="ui-button ui-widget ui-corner-all" href="listDomain.action">DOMAIN MANAGEMENT</a> -->

<!-- </td> -->

<!-- </tr> -->
<!-- </table> -->
</div>
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