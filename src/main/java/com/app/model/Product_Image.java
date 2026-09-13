package com.app.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
@Entity
public class Product_Image {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int product_image_id;
  
  private String product_image_name;
  
  @ManyToOne
  @JoinColumn(name = "product_id")
  private Product product;
  
  
  
  public int getProduct_image_id() {
	return product_image_id;
  }
  public void setProduct_image_id(int product_image_id) {
	this.product_image_id = product_image_id;
  }
  public String getProduct_image_name() {
	return product_image_name;
  }
  public void setProduct_image_name(String product_image_name) {
	this.product_image_name = product_image_name;
  }
  public Product getProduct() {
	return product;
  }
  public void setProduct(Product product) {
	this.product = product;
  }
 
}
