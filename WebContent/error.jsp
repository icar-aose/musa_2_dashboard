<%@ page language="java" isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>404-MUSA</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script>
function getBaseUrl() {
	var re = new RegExp(/\/[a-zA-Z0-9]*/);
	return re.exec(location.pathname)[0];
}
var baseUrl=getBaseUrl();
$('head').append('<link rel="stylesheet" type="text/css" href="'+baseUrl+'/css/login.css">');
</script>
</head>
<body>
 <div id="clouds">
            <div class="cloud x1"></div>
            <div class="cloud x1_5"></div>
            <div class="cloud x2"></div>
            <div class="cloud x3"></div>
            <div class="cloud x4"></div>
            <div class="cloud x5"></div>
        </div>
        <div class='c' id="writing">
            <div class='_404'>404</div>
            <hr>
            <div class='_1'>THE PAGE</div>
            <div class='_2'>WAS NOT FOUND</div>
            		
        </div>
<script>
var ruolo = '<%=session.getAttribute("role")%>';

switch(ruolo) {
	case 'customer':
		{$('#writing').append('<a class="btn" href="'+baseUrl+'/customer/domainListCustomer">BACK TO HOME</a>')};
	break;
	case 'admin':
		{$('#writing').append('<a class="btn" href="'+baseUrl+'/admin/index.jsp">BACK TO HOME</a>')};
	break;
	case 'dev':
		{$('#writing').append('<a class="btn" href="'+baseUrl+'/devTeam/domainListDev">BACK TO HOME</a>')};
	break;
	case 'super':
		{$('#writing').append('<a class="btn" href="'+baseUrl+'/super/index.jsp">BACK TO HOME</a>')};
	break;
	default: 
		{$('#writing').append('<a class="btn" href="'+baseUrl+'/login.jsp">LOGIN PAGE</a>')};
}
</script>

</body>
</html>