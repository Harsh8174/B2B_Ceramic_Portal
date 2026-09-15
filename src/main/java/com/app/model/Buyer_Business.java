package com.app.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Buyer_Business")
public class Buyer_Business {
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 private int buyer_id;
	 private String buyer_name;
	 private String buyer_type;
	 private String buyer_email;
	 private long buyer_contact;
	 private String buyer_password;
	 
	 @OneToOne
	 @JoinColumn(name = "company_id")
     private Company company;

	 public int getBuyer_id() {
		 return buyer_id;
	 }

	 public void setBuyer_id(int buyer_id) {
		 this.buyer_id = buyer_id;
	 }

	 public String getBuyer_name() {
		 return buyer_name;
	 }

	 public void setBuyer_name(String buyer_name) {
		 this.buyer_name = buyer_name;
	 }

	 public String getBuyer_type() {
		 return buyer_type;
	 }

	 public void setBuyer_type(String buyer_type) {
		 this.buyer_type = buyer_type;
	 }

	 public String getBuyer_email() {
		 return buyer_email;
	 }

	 public void setBuyer_email(String buyer_email) {
		 this.buyer_email = buyer_email;
	 }

	 public long getBuyer_contact() {
		 return buyer_contact;
	 }

	 public void setBuyer_contact(long buyer_contact) {
		 this.buyer_contact = buyer_contact;
	 }

	 public String getBuyer_password() {
		 return buyer_password;
	 }

	 public void setBuyer_password(String buyer_password) {
		 this.buyer_password = buyer_password;
	 }

	 public Company getCompany() {
		 return company;
	 }

	 public void setCompany(Company company) {
		 this.company = company;
	 }
	 
	 
}
