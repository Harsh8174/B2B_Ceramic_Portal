package com.app.dao;

import java.util.List;

import com.app.model.Company;
import com.app.model.Product;
import com.app.model.Product_Image;
import com.app.model.Seller;

public interface Companydao {
    public String addProduct(Product product);
    public String addProductimage(Product_Image product_img );
    public void updateProductimage(Product_Image product_img);
    public List<Product> getallProducts(int company_id);
    public List<Product_Image> getProductsallImages(Product product_id);
    public Product getProductById(int product_id);
    public String  updateProduct(Product product);
    public Company getCompany(int company_id);
}
