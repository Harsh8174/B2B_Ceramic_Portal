package com.app.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.model.Buyer_Business;

@Repository
public class BuyerBusinessDaoImpl implements BuyerBusinessDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public String insertBuyerBusiness(Buyer_Business buyer) {
        try {
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            session.save(buyer);
            session.getTransaction().commit();
            session.close();
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failure";
        }
    }

    @Override
    public Buyer_Business getBuyerBusiness(Buyer_Business buyer) {
        try {
            Session session = sessionFactory.openSession();
            Query<Buyer_Business> query = session.createQuery(
                "FROM Buyer_Business WHERE buyer_email = :email", 
                Buyer_Business.class
            );
            query.setParameter("email", buyer.getBuyer_email());
            Buyer_Business result = query.uniqueResult();
            session.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Buyer_Business> getAllBuyerBusiness() {
        try {
            Session session = sessionFactory.openSession();
            Query<Buyer_Business> query = session.createQuery(
                "FROM Buyer_Business", 
                Buyer_Business.class
            );
            List<Buyer_Business> result = query.getResultList();
            session.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String updateBuyerBusiness(Buyer_Business buyer) {
        try {
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(buyer);
            session.getTransaction().commit();
            session.close();
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failure";
        }
    }

    @Override
    public void deleteBuyerBusiness(int buyer_id) {
        try {
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            Buyer_Business buyer = session.get(Buyer_Business.class, buyer_id);
            if (buyer != null) {
                session.delete(buyer);
            }
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
