package com.app.model;


import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;
@Entity(name = "Product")
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private int    product_id;
    @Column(name = "Product_name")
	private String product_name;
    @Column(name = "Product_category")
    private String product_category;
    @Column(name = "Product_material")
    private String product_material;
    @Column(name = "Product_description")
    private String product_description;
    @Column(name = "Product_size")
    private String product_size;
    @Column(name = "Product_thickness")
    private String product_thickness;
    @Column(name = "Product_finish")
    private String product_finish;
    @Column(name = "Product_pieces_per_box")
    private int    product_pieces_per_box;
    @Column(name = "Product_coverage_area")
    private double product_coverage_area;
    @Column(name = "Product_price")
    private double product_price;
    @Column(name = "Product_price_unit")
    private String product_price_unit;
    @Column(name = "Product_minimum_order")
    private int    product_minimum_order;
    @Column(name = "Product_minimum_order_unit")
    private String product_minimum_order_unit;
    @Column(name = "Product_available_stock")
    private int    product_available_stock;
    
    @Transient
    private List<MultipartFile> product_file;
    
    
    @OneToMany(mappedBy = "product",cascade = CascadeType.ALL)
    private List<Product_Image> product_image_name;
	
    @ManyToOne
    @JoinColumn(name = "company_id")
    private Company company;
    
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_category() {
		return product_category;
	}
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	public String getProduct_material() {
		return product_material;
	}
	public void setProduct_material(String product_material) {
		this.product_material = product_material;
	}
	public String getProduct_description() {
		return product_description;
	}
	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}
	public String getProduct_size() {
		return product_size;
	}
	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}
	public String getProduct_thickness() {
		return product_thickness;
	}
	public void setProduct_thickness(String product_thickness) {
		this.product_thickness = product_thickness;
	}
	public String getProduct_finish() {
		return product_finish;
	}
	public void setProduct_finish(String product_finish) {
		this.product_finish = product_finish;
	}
	public int getProduct_pieces_per_box() {
		return product_pieces_per_box;
	}
	public void setProduct_pieces_per_box(int product_pieces_per_box) {
		this.product_pieces_per_box = product_pieces_per_box;
	}
	public double getProduct_coverage_area() {
		return product_coverage_area;
	}
	public void setProduct_coverage_area(double product_coverage_area) {
		this.product_coverage_area = product_coverage_area;
	}
	public double getProduct_price() {
		return product_price;
	}
	public void setProduct_price(double product_price) {
		this.product_price = product_price;
	}
	public String getProduct_price_unit() {
		return product_price_unit;
	}
	public void setProduct_price_unit(String product_price_unit) {
		this.product_price_unit = product_price_unit;
	}
	public int getProduct_minimum_order() {
		return product_minimum_order;
	}
	public void setProduct_minimum_order(int product_minimum_order) {
		this.product_minimum_order = product_minimum_order;
	}
	public String getProduct_minimum_order_unit() {
		return product_minimum_order_unit;
	}
	public void setProduct_minimum_order_unit(String product_minimum_order_unit) {
		this.product_minimum_order_unit = product_minimum_order_unit;
	}
	public int getProduct_available_stock() {
		return product_available_stock;
	}
	public void setProduct_available_stock(int product_available_stock) {
		this.product_available_stock = product_available_stock;
	}
	public List<MultipartFile> getProduct_file() {
		return product_file;
	}
	public void setProduct_file(List<MultipartFile> product_file) {
		this.product_file = product_file;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public List<Product_Image> getProduct_image_name() {
		return product_image_name;
	}
	public void setProduct_image_name(List<Product_Image> product_image_name) {
		this.product_image_name = product_image_name;
	}

}

