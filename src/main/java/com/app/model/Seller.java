package com.app.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="Seller")
public class Seller {
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
@Column(name = "seller_id")
private int seller_id;
@Column(name = "seller_name")
private String seller_name;
@Column(name="seller_email")
private String seller_email;
@Column(name = "seller_contact")
private long seller_contact;
@Column(name="seller_password")
private String seller_password;

@OneToOne(cascade = CascadeType.ALL)
@JoinColumn(name = "seller_company")
private Company seller_company;

public int getSeller_id() {
	return seller_id;
}
public void setSeller_id(int seller_id) {
	this.seller_id = seller_id;
}
public String getSeller_name() {
	return seller_name;
}
public void setSeller_name(String seller_name) {
	this.seller_name = seller_name;
}

public String getSeller_email() {
	return seller_email;
}
public void setSeller_email(String seller_email) {
	this.seller_email = seller_email;
}
public long getSeller_contact() {
	return seller_contact;
}
public void setSeller_contact(long seller_contact) {
	this.seller_contact = seller_contact;
}
public String getSeller_password() {
	return seller_password;
}
public void setSeller_password(String seller_password) {
	this.seller_password = seller_password;
}
public Company getSeller_company() {
	return seller_company;
}
public void setSeller_company(Company seller_company) {
	this.seller_company = seller_company;
}


}
