<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<body style="margin-left: 30px; background-color: SteelBlue ;">
<div align="center">	<h2>MUSA Login Page</h2>

	<s:form action="sessionman">
		<s:textfield name="userId" label="Username" />
		<s:password name="userPass" label="Password" />
		<s:submit value="Login" />
	</s:form>

	<s:property value="msg" />
</div>
</body>
</html>
