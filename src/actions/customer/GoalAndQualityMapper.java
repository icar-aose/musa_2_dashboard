package actions.customer;

public class GoalAndQualityMapper {
	private String idDB,objectType;

public String getIdDB() {
	return this.idDB;
}

public void setIdDB(String idDB) {
	this.idDB=idDB;
}

public String getObjectType() {
	return this.objectType;
}

public void setObjectType(String objectType) {
	this.objectType=objectType;
}

public void setAll(String idDB,String objectType) {
	this.idDB=idDB;
	this.objectType=objectType;
}
}