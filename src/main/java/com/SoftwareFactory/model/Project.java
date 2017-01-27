package com.SoftwareFactory.model;



import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

import java.time.LocalDate;
import java.util.Set;


@Table(name ="s_projects")
public class Project {

    public Project(){}


    @Id
    @GeneratedValue(generator = "increment2")
    @GenericGenerator(name = "increment2", strategy = "increment")
    @Column(name="id")
    private Long id;

    @Column(name="name")
    private String projectName;


    @Column(name="date_create")
    private LocalDate createDate;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="status_id")
    private Status status;

    @ManyToOne
    @JoinColumn(name="user_id", nullable=false)
    private CustomerInfo customerInfo;

    @OneToMany
    @JoinColumn(name="project")
    private Set<Case> cases;

}
