package com.app.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.model.Order;

@Repository
public class OrderDaoImpl implements OrderDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public String createOrder(Order order) {
        try {
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            session.save(order);
            session.getTransaction().commit();
            session.close();
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failure";
        }
    }

    @Override
    public Order getOrderById(int order_id) {
        try {
            Session session = sessionFactory.openSession();
            Order order = session.get(Order.class, order_id);
            session.close();
            return order;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Order> getOrdersByBuyerId(int buyer_id) {
        try {
            Session session = sessionFactory.openSession();
            Query<Order> query = session.createQuery(
                "FROM Order WHERE buyer_individual.buyer_id = :buyer_id ORDER BY order_date DESC",
                Order.class
            );
            query.setParameter("buyer_id", buyer_id);
            List<Order> result = query.getResultList();
            session.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Order> getOrdersByBusinessBuyerId(int buyer_business_id) {
        try {
            Session session = sessionFactory.openSession();
            Query<Order> query = session.createQuery(
                "FROM Order WHERE buyer_business.buyer_id = :buyer_business_id ORDER BY order_date DESC",
                Order.class
            );
            query.setParameter("buyer_business_id", buyer_business_id);
            List<Order> result = query.getResultList();
            session.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String updateOrder(Order order) {
        try {
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(order);
            session.getTransaction().commit();
            session.close();
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failure";
        }
    }

    @Override
    public void deleteOrder(int order_id) {
        try {
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            Order order = session.get(Order.class, order_id);
            if (order != null) {
                session.delete(order);
            }
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrders() {
        try {
            Session session = sessionFactory.openSession();
            Query<Order> query = session.createQuery(
                "FROM Order ORDER BY order_date DESC",
                Order.class
            );
            List<Order> result = query.getResultList();
            session.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Order> getOrdersByProductId(int product_id) {
        try {
            Session session = sessionFactory.openSession();
            Query<Order> query = session.createQuery(
                "FROM Order WHERE product.product_id = :product_id ORDER BY order_date DESC",
                Order.class
            );
            query.setParameter("product_id", product_id);
            List<Order> result = query.getResultList();
            session.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Order> getOrdersByStatus(String status) {
        try {
            Session session = sessionFactory.openSession();
            Query<Order> query = session.createQuery(
                "FROM Order WHERE order_status = :status ORDER BY order_date DESC",
                Order.class
            );
            query.setParameter("status", status);
            List<Order> result = query.getResultList();
            session.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
