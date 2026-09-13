package com.app.dao;

import com.app.model.Seller;

public interface Dao {
   public String Insert_Seller(Seller seller);
   public Seller Get_Seller(Seller seller);
   public String Update_Seller(Seller seller);
   public String Remove_Seller(Seller seller);
}
