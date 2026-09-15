package com.app.dao;

import com.app.model.Order;
import java.util.List;

public interface OrderDao {
    public String createOrder(Order order);
    public Order getOrderById(int order_id);
    public List<Order> getOrdersByBuyerId(int buyer_id);
    public List<Order> getOrdersByBusinessBuyerId(int buyer_business_id);
    public String updateOrder(Order order);
    public void deleteOrder(int order_id);
    public List<Order> getAllOrders();
    public List<Order> getOrdersByProductId(int product_id);
    public List<Order> getOrdersByStatus(String status);
}
