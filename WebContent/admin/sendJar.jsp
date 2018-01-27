<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/struts-tags" prefix="s"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
<title>MUSA GUI</title>
  <link rel="stylesheet" href="/css/style.css" type="text/css"/>
   <link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
 
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script type="text/javascript" src="script/musaGUIScript.js"></script>
  
</head>
<body >

	<div id="logo">
      
	<img  src="../img/MUSA_LOGO.png" /> 
	<img  id ="logoICARHome" src="../img/logoECOSICAR.png" /> 
<!-- 	<h1><a href="http://www.icar.cnr.it"><img id ="logoICAR" src="img/icarnewlogo.png" alt="VAI AL SITO ISTITUZIONALE" /></a> </h1> -->
	</div>
	<h2>Send Jar Test Page</h2>
<div id="sendJarForm" class="form-style-6">
	<s:form action="sendJar" method="post" enctype="multipart/form-data">
	<s:file name="userJar" label="User Jar File" />
	<s:submit value="Upload" />
		<s:property value="msg" />
</s:form>

	</div>

</body>
</html>
