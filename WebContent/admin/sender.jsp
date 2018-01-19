<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<body style="margin-left: 30px; background-color: SteelBlue ;">
<div align="center">	<h2>MUSA Send Message</h2>

	<s:form action="sender">
		<s:textfield name="msg" label="Messaggio da Inviare"/>
		<s:textfield name="host" label="Host" value="127.0.0.1"/>
		<s:textfield name="port" label="Porta" value="25000"/>
		<s:submit value="Invia" />
	</s:form>

</div>
</body>
</html>
