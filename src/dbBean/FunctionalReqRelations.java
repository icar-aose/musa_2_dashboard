package dbBean;
// Generated 28-feb-2018 18.14.57 by Hibernate Tools 5.2.8.Final


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
 * FunctionalReqRelations generated by hbm2java
 */
@Entity
@Table(name="functional_req_relations"
    ,catalog="musa_db"
)
public class FunctionalReqRelations  implements java.io.Serializable {


     private Integer idFuncReqRel;
     private FunctionalReq functionalReqByIdStart;
     private FunctionalReq functionalReqByIdEnd;
     private Specification specification;
     private String type;

    public FunctionalReqRelations() {
    }

    public FunctionalReqRelations(FunctionalReq functionalReqByIdStart, FunctionalReq functionalReqByIdEnd, Specification specification, String type) {
       this.functionalReqByIdStart = functionalReqByIdStart;
       this.functionalReqByIdEnd = functionalReqByIdEnd;
       this.specification = specification;
       this.type = type;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="idFunc_Req_rel", unique=true, nullable=false)
    public Integer getIdFuncReqRel() {
        return this.idFuncReqRel;
    }
    
    public void setIdFuncReqRel(Integer idFuncReqRel) {
        this.idFuncReqRel = idFuncReqRel;
    }

@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="id_start",referencedColumnName="idFunctional_Req", nullable=false)
    public FunctionalReq getFunctionalReqByIdStart() {
        return this.functionalReqByIdStart;
    }
    
    public void setFunctionalReqByIdStart(FunctionalReq functionalReqByIdStart) {
        this.functionalReqByIdStart = functionalReqByIdStart;
    }

@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="id_end",referencedColumnName="idFunctional_Req", nullable=false)
    public FunctionalReq getFunctionalReqByIdEnd() {
        return this.functionalReqByIdEnd;
    }
    
    public void setFunctionalReqByIdEnd(FunctionalReq functionalReqByIdEnd) {
        this.functionalReqByIdEnd = functionalReqByIdEnd;
    }

@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="id_spec",referencedColumnName="idSpecification", nullable=false)
    public Specification getSpecification() {
        return this.specification;
    }
    
    public void setSpecification(Specification specification) {
        this.specification = specification;
    }

    
    @Column(name="type", nullable=false, length=8)
    public String getType() {
        return this.type;
    }
    
    public void setType(String type) {
        this.type = type;
    }




}


