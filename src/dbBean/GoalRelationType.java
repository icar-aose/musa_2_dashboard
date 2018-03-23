package dbBean;
// Generated 1-mar-2018 18.54.14 by Hibernate Tools 5.2.8.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * GoalRelationType generated by hbm2java
 */
@Entity
@Table(name = "goal_relation_type", catalog = "musa_db")

public class GoalRelationType implements java.io.Serializable {

	private Integer idGrt;
	private String typeName;
	private Set<FunctionalReqRelations> functionalReqRelationses = new HashSet<FunctionalReqRelations>(0);

	public GoalRelationType() {
	}

	public GoalRelationType(String typeName) {
		this.typeName = typeName;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "idGrt", unique = true, nullable = false)
	public Integer getIdGrt() {
		return this.idGrt;
	}

	public void setIdGrt(Integer idGrt) {
		this.idGrt = idGrt;
	}

	@Column(name = "typeName", nullable = false, length = 30)
	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "type")
	public Set<FunctionalReqRelations> getFunctionalReqRelationses() {
		return this.functionalReqRelationses;
	}

	public void setFunctionalReqRelationses(Set<FunctionalReqRelations> functionalReqRelationses) {
		this.functionalReqRelationses = functionalReqRelationses;
	}

}
