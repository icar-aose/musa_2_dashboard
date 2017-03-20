<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
<title>MUSA GUI</title>
  <link rel="stylesheet" href="css/style.css" type="text/css"/>
   <link href="css/default.css" rel="stylesheet" type="text/css" media="all" />
 
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script type="text/javascript" src="script/musaGUIScript.js"></script>
  
</head>
<body>
<div id="header" >

	<div id="logo">
      
	<img  src="img/MUSA_LOGO.png" /> 
	<img  id ="logoICARHome" src="img/logoECOSICAR.png" /> 
<!-- 	<h1><a href="http://www.icar.cnr.it"><img id ="logoICAR" src="img/icarnewlogo.png" alt="VAI AL SITO ISTITUZIONALE" /></a> </h1> -->
	</div>
	<div id="menu">
		<ul>

		</ul>
		
	</div>
	
</div>

<!-- <a  href="../index.jsp" style="margin-left: 50px; margin-top: 200px">HOME</a> -->

<div id="mainDiV" style="text-align: center">
<h2> MUSA DASHBOARD</h2>
<div id="page" style="display: inline-block;">
	<div class="boxA">
		
		<div class="box">
			<span> <a  href="admin/index.jsp">ADMIN</a></span>
		</div>
		
	</div>

	<div class="boxB">
		
		<div class="box">
		<span> <a href="devTeam/listDevUser.action">DEV TEAM</a> </span>
<!-- 		<span> <a href="devTeam/domainListDev.action">DEV TEAM</a> </span> -->
	
		</div>
		
	</div>
	
	
	<div class="boxC">
		
		<div class="box">
		<span> <a href="customer/listCustomerUser.action">CUSTOMER</a></span>
<!-- 			<span> <a href="customer/domainListCustomer.action">CUSTOMER</a></span> -->
		</div>
		
	</div>

</div>
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