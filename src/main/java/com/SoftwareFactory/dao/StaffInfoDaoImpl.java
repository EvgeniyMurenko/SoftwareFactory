package com.SoftwareFactory.dao;

import com.SoftwareFactory.model.StaffInfo;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("staffInfoDao")
public class StaffInfoDaoImpl implements StaffInfoDao {

    private static final Logger logger = LoggerFactory.getLogger(ProjectDaoImpl.class);
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }

    @Override
    public Long create(StaffInfo staffInfo) {
        Session session = sessionFactory.getCurrentSession();
        Long id = (Long) session.save(staffInfo);
        return id;
    }

    @Override
    public StaffInfo read(Long id) {
        Session session = sessionFactory.getCurrentSession();
        StaffInfo staffInfo = (StaffInfo) session.get(StaffInfo.class, id);
        return staffInfo;
    }

    @Override
    public void update(StaffInfo staffInfo) {
        Session session = sessionFactory.getCurrentSession();
        session.update(staffInfo);
        logger.error("StaffInfo update successfully, staffInfo=" + staffInfo);
    }

    @Override
    public void delete(StaffInfo staffInfo) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(staffInfo);
        logger.info("StaffInfo deleted successfully, staffInfo details=" + staffInfo);
    }

    @Override
    public List<StaffInfo> findAll() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from StaffInfo");
        return query.list();
    }
}
