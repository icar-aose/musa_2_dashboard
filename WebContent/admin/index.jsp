<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
<title>MUSA GUI</title>
  <link rel="stylesheet" href="../css/style.css" type="text/css"/>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
 
 <script type="text/javascript" src="../script/musaGUIScript.js"></script>
 
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />) |	<a href="../logout">Logout</a>
<div id="header" >

	<div id="logo">
      
	<img src="../img/MUSA_LOGO.png" /> 
	<img id ="logoICARHome" src="../img/logoECOSICAR.png" /> 
<!-- 	<h1><a href="http://www.icar.cnr.it"><img id ="logoICAR" src="img/icarnewlogo.png" alt="VAI AL SITO ISTITUZIONALE" /></a> </h1> -->
	</div>
	<div id="menu">
		<ul>
<li><a  href="index.jsp" >HOME</a></li>

<!-- 			<li> class="active"><a href="portaleutente.php" accesskey="1" title="">Homepage</a></li> -->
<!--            <li> <a href="modificapassword.php" accesskey="5" title="">MODIFICA PASSWORD</a></li> -->
<%-- 			<li> <a href="<?php echo $logoutAction ?>" accesskey="5" title="">LOGOUT: <?php echo $_SESSION['MM_Nome'],' ',$_SESSION['MM_Cognome'] ?></a></li> --%>
		

		</ul>
		
	</div>
	
</div>

<!-- <a  href="../index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->


<h2>ADMINISTRATOR PANEL</h2>
<div class="center">
	<div class="boxAdmin">
		
		<div class="box">
<!-- 			<a href="anagrafica.php" class="image image-full"><img src="img/pers.png" alt="VAI AD ANAGRAFICA" /></a> -->
			
			<span> <a href="listGeneralConfiguration.action">GENERAL CONFIGURATIONS SETTING</a></span>
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