package com.app.services;

import java.util.List;

import javax.mail.MessagingException;

import com.app.model.Product;
import com.app.model.Seller;

public interface Service {
    	public void sendOTP(String toEmail, int otp) throws MessagingException ;   
    	public String Insert_Seller(Seller seller);
    	public Seller Get_Seller(Seller seller);
    	public String Update_Seller(Seller seller);
    	public String Remove_Seller(Seller seller);
    	public String addProduct(Product product);
    	public List<Product> getProducts(Seller seller);
    	public Product getProductById(int product_id);
    	public String  updateProduct(Product product,int company_id);
}
