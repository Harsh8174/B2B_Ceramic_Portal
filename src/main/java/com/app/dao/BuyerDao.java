package com.app.dao;

import com.app.model.Buyer_Individual;

public interface BuyerDao {
    public String inserbuyer(Buyer_Individual buyer);
    public Buyer_Individual getbuyer(Buyer_Individual buyer);
    
}
