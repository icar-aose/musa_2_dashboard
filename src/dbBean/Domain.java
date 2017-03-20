package dbBean;

// Generated 1-mar-2017 16.50.58 by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Domain generated by hbm2java
 */
@Entity
@Table(name = "domain", catalog = "musa_db")
public class Domain implements java.io.Serializable {

	private Integer idDomain;
	private String name;
	private String description;
	private Set<DomainAssumption> domainAssumptions = new HashSet<DomainAssumption>(
			0);
	private Set<AbstractCapabilityProposal> abstractCapabilityProposals = new HashSet<AbstractCapabilityProposal>(
			0);
	private Set<DomainConfiguration> domainConfigurations = new HashSet<DomainConfiguration>(
			0);
	private Set<AbstractCapability> abstractCapabilities = new HashSet<AbstractCapability>(
			0);
	private Set<Specification> specifications = new HashSet<Specification>(0);

	public Domain() {
	}

	public Domain(String name) {
		this.name = name;
	}

	public Domain(String name, String description,
			Set<DomainAssumption> domainAssumptions,
			Set<AbstractCapabilityProposal> abstractCapabilityProposals,
			Set<DomainConfiguration> domainConfigurations,
			Set<AbstractCapability> abstractCapabilities,
			Set<Specification> specifications) {
		this.name = name;
		this.description = description;
		this.domainAssumptions = domainAssumptions;
		this.abstractCapabilityProposals = abstractCapabilityProposals;
		this.domainConfigurations = domainConfigurations;
		this.abstractCapabilities = abstractCapabilities;
		this.specifications = specifications;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "idDomain", unique = true, nullable = false)
	public Integer getIdDomain() {
		return this.idDomain;
	}

	public void setIdDomain(Integer idDomain) {
		this.idDomain = idDomain;
	}

	@Column(name = "name", nullable = false, length = 250)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "domain")
	public Set<DomainAssumption> getDomainAssumptions() {
		return this.domainAssumptions;
	}

	public void setDomainAssumptions(Set<DomainAssumption> domainAssumptions) {
		this.domainAssumptions = domainAssumptions;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "domain")
	public Set<AbstractCapabilityProposal> getAbstractCapabilityProposals() {
		return this.abstractCapabilityProposals;
	}

	public void setAbstractCapabilityProposals(
			Set<AbstractCapabilityProposal> abstractCapabilityProposals) {
		this.abstractCapabilityProposals = abstractCapabilityProposals;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "domain")
	public Set<DomainConfiguration> getDomainConfigurations() {
		return this.domainConfigurations;
	}

	public void setDomainConfigurations(
			Set<DomainConfiguration> domainConfigurations) {
		this.domainConfigurations = domainConfigurations;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "domain")
	public Set<AbstractCapability> getAbstractCapabilities() {
		return this.abstractCapabilities;
	}

	public void setAbstractCapabilities(
			Set<AbstractCapability> abstractCapabilities) {
		this.abstractCapabilities = abstractCapabilities;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "domain")
	public Set<Specification> getSpecifications() {
		return this.specifications;
	}

	public void setSpecifications(Set<Specification> specifications) {
		this.specifications = specifications;
	}

}