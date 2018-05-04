package dbBean;
// Generated 28-feb-2018 18.14.57 by Hibernate Tools 5.2.8.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;

import java.sql.Blob;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * FunctionalReqRelations generated by hbm2java
 */
@Entity
@Table(name = "goalModel", catalog = "musa_db")
public class GoalModel implements java.io.Serializable {

	private Integer id;
	private Specification specification;
	private String name;
	private Blob json;
	
	public GoalModel() {
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "idSpec", referencedColumnName = "idSpecification", nullable = false)
	public Specification getSpecification() {
		return this.specification;
	}

	public void setSpecification(Specification specification) {
		this.specification = specification;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name = "json")
	public Blob getJson() {
		return json;
	}

	public void setJson(Blob json) {
		this.json = json;
	}

}
