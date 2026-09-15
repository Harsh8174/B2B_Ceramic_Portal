package com.app.services;

import java.util.List;

import javax.mail.MessagingException;

import com.app.model.Buyer_Business;
import com.app.model.Buyer_Individual;
import com.app.model.Order;
import com.app.model.Product;
import com.app.model.Seller;

public interface Service {
    
    // OTP Services
    public void sendOTP(String toEmail, int otp) throws MessagingException;
    
    // Seller Services
    public String Insert_Seller(Seller seller);
    public Seller Get_Seller(Seller seller);
    public String Update_Seller(Seller seller);
    public String Remove_Seller(Seller seller);
    
    // Product Services
    public String addProduct(Product product, String path);
    public List<Product> getProducts(Seller seller);
    public Product getProductById(int product_id);
    public String updateProduct(Product product, int company_id, String path);
    public void deleteproduct(int product_id, String path);
    public List<Product> getallProducts();
    public List<Product> getFilteredProducts(Product product, String seller_type);
    
    // Individual Buyer Services
    public String insertbuyer(Buyer_Individual buyer);
    public Buyer_Individual getbuyer(Buyer_Individual buyer);
    
    // Business Buyer Services
    public String insertBuyerBusiness(Buyer_Business buyer);
    public Buyer_Business getBuyerBusiness(Buyer_Business buyer);
    public List<Buyer_Business> getAllBusinessBuyers();
    
    // Order Services
    public String createOrder(Order order);
    public Order getOrderById(int order_id);
    public List<Order> getOrdersByBuyer(int buyer_id);
    public List<Order> getOrdersByBusinessBuyer(int buyer_business_id);
    public String updateOrderStatus(int order_id, String status);
    public void deleteOrder(int order_id);
    public List<Order> getAllOrders();
}
