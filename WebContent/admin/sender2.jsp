<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<body style="margin-left: 30px; background-color: SteelBlue ;">
<div align="center">	<h2>MUSA Send Message</h2>

	<s:form action="sender2">
		<s:textfield name="msg" label="Messaggio da Inviare" value=""/>
		<s:textfield name="host" label="Host" value="failover://tcp://localhost:61616"/>
		<s:submit value="Invia" />
	</s:form>

</div>
</body>
</html>
