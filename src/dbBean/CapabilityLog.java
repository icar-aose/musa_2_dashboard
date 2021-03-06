package dbBean;

// Generated 2-mar-2017 16.05.13 by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * CapabilityLog generated by hbm2java
 */
@Entity
@Table(name = "capability_log", catalog = "musa_db")
public class CapabilityLog implements java.io.Serializable {

	private Integer idCapabilityOperation;
	private CapabilityInstance capabilityInstance;
	private Date timeOperation;
	private String action;

	public CapabilityLog() {
	}

	public CapabilityLog(CapabilityInstance capabilityInstance,
			Date timeOperation, String action) {
		this.capabilityInstance = capabilityInstance;
		this.timeOperation = timeOperation;
		this.action = action;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "idCapability_Operation", unique = true, nullable = false)
	public Integer getIdCapabilityOperation() {
		return this.idCapabilityOperation;
	}

	public void setIdCapabilityOperation(Integer idCapabilityOperation) {
		this.idCapabilityOperation = idCapabilityOperation;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idInstance")
	public CapabilityInstance getCapabilityInstance() {
		return this.capabilityInstance;
	}

	public void setCapabilityInstance(CapabilityInstance capabilityInstance) {
		this.capabilityInstance = capabilityInstance;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "timeOperation", length = 19)
	public Date getTimeOperation() {
		return this.timeOperation;
	}

	public void setTimeOperation(Date timeOperation) {
		this.timeOperation = timeOperation;
	}

	@Column(name = "action", length = 45)
	public String getAction() {
		return this.action;
	}

	public void setAction(String action) {
		this.action = action;
	}

}
