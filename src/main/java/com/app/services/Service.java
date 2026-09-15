package com.app.services;

import java.util.List;

import javax.mail.MessagingException;

import com.app.model.Buyer_Individual;
import com.app.model.Product;
import com.app.model.Seller;

public interface Service {
    	public void sendOTP(String toEmail, int otp) throws MessagingException ;   
    	public String Insert_Seller(Seller seller);
    	public Seller Get_Seller(Seller seller);
    	public String Update_Seller(Seller seller);
    	public String Remove_Seller(Seller seller);
    	public String addProduct(Product product,String path);
    	public List<Product> getProducts(Seller seller);
    	public Product getProductById(int product_id);
    	public String  updateProduct(Product product,int company_id,String path);
    	public void deleteproduct(int product_id,String path);
    	public String insertbuyer(Buyer_Individual buyer);
    	public List<Product> getallProducts();
    	public List<Product> getFilteredProducts(Product product,String seller_type);
    	public Buyer_Individual getbuyer(Buyer_Individual buyer);
}
