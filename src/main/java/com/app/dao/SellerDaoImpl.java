package com.app.dao;



import java.util.Iterator;
import java.util.List;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.app.model.Seller;
@Component
public class SellerDaoImpl implements Dao {

	private HibernateTemplate hibernateTemplate;

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Transactional(readOnly = false)
	@Override
	public String Insert_Seller(Seller seller) {
		String status="";
		try {
		int id=(Integer)hibernateTemplate.save(seller);
		if(id==seller.getSeller_id()) {
			status= "success";
		}
		else {
			status="failure";
		}
		}catch (Exception e) {
			status="failure";
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public Seller Get_Seller(Seller seller) {
		String hql="from Seller where seller_email =:seller_email";
		List list= hibernateTemplate.findByNamedParam(hql, "seller_email", seller.getSeller_email());
		Seller s;
		if(!list.isEmpty()) {
		    Iterator<Seller> itr=list.iterator();
		    s=new Seller();
		    
		    while(itr.hasNext()) {
		    	s=itr.next();
		    }
		    
		 if(s.getSeller_password().equals(seller.getSeller_password())) {
			 
			 return s; 
		 }   
		 else {
			 
			 return null;
		 }
		}
		else {
			System.out.println("list empty");
			return null;
		}
	}

	@Override
	public String Update_Seller(Seller seller) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String Remove_Seller(Seller seller) {
		// TODO Auto-generated method stub
		return null;
	}
     
}
