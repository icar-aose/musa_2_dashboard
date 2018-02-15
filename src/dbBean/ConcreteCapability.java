package dbBean;

import java.sql.Blob;

// Generated 2-mar-2017 14.39.22 by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * ConcreteCapability generated by hbm2java
 */
@Entity
@Table(name = "concrete_capability", catalog = "musa_db")
public class ConcreteCapability implements java.io.Serializable {

	private Integer idConcreteCapability;
	private AbstractCapability abstractCapability;
	private User user;
	private String name;
	private String ipWorkspace;
	private String wpname;
	private String state;
	private String deploystate;
	private String description;
	private String classname;
	private Blob jarfile;
	private Set<CapabilityInstance> capabilityInstances = new HashSet<CapabilityInstance>(
			0);

	public ConcreteCapability() {
	}

	public ConcreteCapability(String ipWorkspace, String wpname, String state) {
		this.ipWorkspace = ipWorkspace;
		this.wpname = wpname;
		this.state = state;
	}

	public ConcreteCapability(AbstractCapability abstractCapability, User user,
			String name, String ipWorkspace, String wpname, String state,String deploystate,
			String description, Set<CapabilityInstance> capabilityInstances,String classname) {
		this.abstractCapability = abstractCapability;
		this.user = user;
		this.name = name;
		this.ipWorkspace = ipWorkspace;
		this.wpname = wpname;
		this.state = state;
		this.description = description;
		this.classname=classname;
		this.capabilityInstances = capabilityInstances;
		this.deploystate = deploystate;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "idConcrete_Capability", unique = true, nullable = false)
	public Integer getIdConcreteCapability() {
		return this.idConcreteCapability;
	}

	public void setIdConcreteCapability(Integer idConcreteCapability) {
		this.idConcreteCapability = idConcreteCapability;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "idAbstract_Capability")
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

	@Column(name = "ipWorkspace", nullable = false)
	public String getIpWorkspace() {
		return this.ipWorkspace;
	}

	public void setIpWorkspace(String ipWorkspace) {
		this.ipWorkspace = ipWorkspace;
	}

	@Column(name = "wpname", nullable = false)
	public String getWpname() {
		return this.wpname;
	}

	public void setWpname(String wpname) {
		this.wpname = wpname;
	}

	@Column(name = "state", nullable = false, length = 15)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "deploystate", nullable = false, length = 15)
	public String getDeploystate() {
		return this.deploystate;
	}

	public void setDeploystate(String deploystate) {
		this.deploystate = deploystate;
	}
	
	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "classname")
	public String getClassname() {
		return this.classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}
	
	@Column(name = "jarfile")
    public Blob getJarfile() {
        return jarfile;
    }
 
    public void setJarfile(Blob jarfile) {
        this.jarfile = jarfile;
    }
 
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "concreteCapability")
	public Set<CapabilityInstance> getCapabilityInstances() {
		return this.capabilityInstances;
	}

	public void setCapabilityInstances(
			Set<CapabilityInstance> capabilityInstances) {
		this.capabilityInstances = capabilityInstances;
	}

}
