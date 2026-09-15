package com.app.model;

import java.time.LocalDateTime;
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
import javax.persistence.Table;

@Entity
@Table(name = "Orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private int order_id;

    @Column(name = "order_date")
    private LocalDateTime order_date;

    @Column(name = "order_quantity")
    private int order_quantity;

    @Column(name = "order_total_price")
    private double order_total_price;

    @Column(name = "order_status")
    private String order_status; // PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED

    @Column(name = "delivery_address")
    private String delivery_address;

    @Column(name = "order_notes")
    private String order_notes;

    // Foreign Key: Buyer_Individual
    @ManyToOne
    @JoinColumn(name = "buyer_id")
    private Buyer_Individual buyer_individual;

    // Foreign Key: Buyer_Business
    @ManyToOne
    @JoinColumn(name = "buyer_business_id")
    private Buyer_Business buyer_business;

    // Foreign Key: Product
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    // Getters and Setters
    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public LocalDateTime getOrder_date() {
        return order_date;
    }

    public void setOrder_date(LocalDateTime order_date) {
        this.order_date = order_date;
    }

    public int getOrder_quantity() {
        return order_quantity;
    }

    public void setOrder_quantity(int order_quantity) {
        this.order_quantity = order_quantity;
    }

    public double getOrder_total_price() {
        return order_total_price;
    }

    public void setOrder_total_price(double order_total_price) {
        this.order_total_price = order_total_price;
    }

    public String getOrder_status() {
        return order_status;
    }

    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }

    public String getDelivery_address() {
        return delivery_address;
    }

    public void setDelivery_address(String delivery_address) {
        this.delivery_address = delivery_address;
    }

    public String getOrder_notes() {
        return order_notes;
    }

    public void setOrder_notes(String order_notes) {
        this.order_notes = order_notes;
    }

    public Buyer_Individual getBuyer_individual() {
        return buyer_individual;
    }

    public void setBuyer_individual(Buyer_Individual buyer_individual) {
        this.buyer_individual = buyer_individual;
    }

    public Buyer_Business getBuyer_business() {
        return buyer_business;
    }

    public void setBuyer_business(Buyer_Business buyer_business) {
        this.buyer_business = buyer_business;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
