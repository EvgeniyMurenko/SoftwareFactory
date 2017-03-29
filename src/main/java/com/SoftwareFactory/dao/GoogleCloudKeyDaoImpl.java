package com.SoftwareFactory.dao;

import com.SoftwareFactory.model.GoogleCloudKey;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("googleCloudKeyDao")
public class GoogleCloudKeyDaoImpl implements GoogleCloudKeyDao {

    private static final Logger logger = LoggerFactory.getLogger(ProjectDaoImpl.class);
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }

    @Override
    public Long create(GoogleCloudKey googleCloudKey) {
        Session session = sessionFactory.getCurrentSession();
        Long id = (Long) session.save(googleCloudKey);
        return id;
    }

    @Override
    public GoogleCloudKey read(Long id) {
        Session session = sessionFactory.getCurrentSession();
        GoogleCloudKey googleCloudKey = (GoogleCloudKey) session.get(GoogleCloudKey.class, id);
        return googleCloudKey;
    }

    @Override
    public void update(GoogleCloudKey googleCloudKey) {
        Session session = sessionFactory.getCurrentSession();
        session.update(googleCloudKey);
        logger.error("GoogleCloudKey update successfully, googleCloudKey=" + googleCloudKey);
    }

    @Override
    public void delete(GoogleCloudKey googleCloudKey) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(googleCloudKey);
        logger.info("GoogleCloudKey deleted successfully, googleCloudKey details=" + googleCloudKey);
    }

    @Override
    public List<GoogleCloudKey> findAll() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from GoogleCloudKeys");
        return query.list();
    }
}
