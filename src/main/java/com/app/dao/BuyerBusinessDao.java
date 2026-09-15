package com.app.dao;

import com.app.model.Buyer_Business;
import java.util.List;

public interface BuyerBusinessDao {
    public String insertBuyerBusiness(Buyer_Business buyer);
    public Buyer_Business getBuyerBusiness(Buyer_Business buyer);
    public List<Buyer_Business> getAllBuyerBusiness();
    public String updateBuyerBusiness(Buyer_Business buyer);
    public void deleteBuyerBusiness(int buyer_id);
}
