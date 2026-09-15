package com.app.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="Company")
public class Company {
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
@Column(name="company_id")
private int company_id;
@Column(name="company_name")
private String company_name;
@Column(name="company_email")
private String company_email;
@OneToOne(mappedBy = "seller_company")
private Seller seller;

@OneToMany(mappedBy = "company", cascade = CascadeType.ALL)
private List<Product> company_product;

@OneToOne(mappedBy = "company")
private Buyer_Business business;

public int getCompany_id() {
	return company_id;
}

public void setCompany_id(int company_id) {
	this.company_id = company_id;
}
public String getCompany_name() {
	return company_name;
}
public void setCompany_name(String company_name) {
	this.company_name = company_name;
}
public String getCompany_email() {
	return company_email;
}
public void setCompany_email(String company_email) {
	this.company_email = company_email;
}
public Seller getSeller() {
	return seller;
}
public void setSeller(Seller seller) {
	this.seller = seller;
}
public List<Product> getCompany_product() {
	return company_product;
}
public void setCompany_product(List<Product> company_product) {
	this.company_product = company_product;
}

public Buyer_Business getBusiness() {
	return business;
}

public void setBusiness(Buyer_Business business) {
	this.business = business;
}

}
