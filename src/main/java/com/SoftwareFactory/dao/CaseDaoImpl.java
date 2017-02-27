package com.SoftwareFactory.dao;

import com.SoftwareFactory.model.Case;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository("caseDao")
public class CaseDaoImpl implements CaseDao {

    private static final Logger logger = LoggerFactory.getLogger(CaseDaoImpl.class);

    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }


    @Override
    public Long create(Case aCase) {
        Session session = sessionFactory.getCurrentSession();
        Long id = (Long) session.save(aCase);
        return id;
    }

    @Override
    public Case read(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Case aCase = (Case) session.get(Case.class, id);
        return aCase;
    }

    @Override
    public void update(Case aCase) {
        Session session = sessionFactory.getCurrentSession();
        session.update(aCase);
        logger.error("Case update successfully, Case=" + aCase);
    }

    @Override
    public void delete(Case aCase) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(aCase);
        logger.info("Case deleted successfully, Case details=" + aCase);
    }

    @Override
    public List<Case> findAll() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Case");
        return query.list();
    }

    @Override
    public List<Case> findByField(String name, String project) {
        Session session = sessionFactory.getCurrentSession();
        List cases = session.createCriteria(Case.class)
                .add(Restrictions.like("name", name, MatchMode.ANYWHERE))
     /*           .add(Restrictions.like("project", name, MatchMode.ANYWHERE))*/
                .list();

        return cases;
    }

}
