package dbBean;

// Generated 2-mar-2017 12.13.39 by Hibernate Tools 3.4.0.CR1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * AbstractCapabilityProposal generated by hbm2java
 */
@Entity
@Table(name = "abstract_capability_proposal", catalog = "musa_db")
public class AbstractCapabilityProposal implements java.io.Serializable {

	private Integer idProposal;
	private Domain domain;
	private AbstractCapability abstractCapability;
	private User user;
	private String name;
	private String input;
	private String output;
	private String params;
	private String preCondition;
	private String postCondition;
	private String description;
	private String state;
	private String motivation;

	public AbstractCapabilityProposal() {
	}

	public AbstractCapabilityProposal(Domain domain, String state) {
		this.domain = domain;
		this.state = state;
	}

	public AbstractCapabilityProposal(Domain domain,
			AbstractCapability abstractCapability, User user, String name,
			String input, String output, String params, String preCondition,
			String postCondition, String description, String state,
			String motivation) {
		this.domain = domain;
		this.abstractCapability = abstractCapability;
		this.user = user;
		this.name = name;
		this.input = input;
		this.output = output;
		this.params = params;
		this.preCondition = preCondition;
		this.postCondition = postCondition;
		this.description = description;
		this.state = state;
		this.motivation = motivation;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "idProposal", unique = true, nullable = false)
	public Integer getIdProposal() {
		return this.idProposal;
	}

	public void setIdProposal(Integer idProposal) {
		this.idProposal = idProposal;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "idDomain", nullable = false)
	public Domain getDomain() {
		return this.domain;
	}

	public void setDomain(Domain domain) {
		this.domain = domain;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "idAbstractCapability")
	public AbstractCapability getAbstractCapability() {
		return this.abstractCapability;
	}

	public void setAbstractCapability(AbstractCapability abstractCapability) {
		this.abstractCapability = abstractCapability;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "provider")
	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "name", length = 45)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "input")
	public String getInput() {
		return this.input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	@Column(name = "output")
	public String getOutput() {
		return this.output;
	}

	public void setOutput(String output) {
		this.output = output;
	}

	@Column(name = "params")
	public String getParams() {
		return this.params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	@Column(name = "preCondition", length = 250)
	public String getPreCondition() {
		return this.preCondition;
	}

	public void setPreCondition(String preCondition) {
		this.preCondition = preCondition;
	}

	@Column(name = "postCondition", length = 250)
	public String getPostCondition() {
		return this.postCondition;
	}

	public void setPostCondition(String postCondition) {
		this.postCondition = postCondition;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "state", nullable = false, length = 9)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "motivation", length = 250)
	public String getMotivation() {
		return this.motivation;
	}

	public void setMotivation(String motivation) {
		this.motivation = motivation;
	}

}
