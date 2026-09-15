package com.app.dao;

import java.util.List;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.app.model.Buyer_Individual;
@Repository("buyerdaoimpl")
public class BuyerDaoImpl implements BuyerDao {

	private HibernateTemplate hibernateTemplate;

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Transactional(readOnly = false)
	@Override
 	public String inserbuyer(Buyer_Individual buyer) {
       String status=null;
		try {
    	   
    	  int id= (Integer)  hibernateTemplate.save(buyer);
    	  if(id==buyer.getBuyer_id()) {
    		  status="success";
    	  }
       }catch (Exception e) {
    	   status="failure";
		e.printStackTrace();
	}		
		return status;
	}

	 @Override
	public Buyer_Individual getbuyer(Buyer_Individual buyer) {
		String hql="from Buyer_Individual where buyer_email=:buyer_email"; 
	 List<Buyer_Individual> buyer_indi=(List<Buyer_Individual>)hibernateTemplate.findByNamedParam(hql, "buyer_email", buyer.getBuyer_email());
	   if(buyer_indi.get(0).getBuyer_password().equals(buyer.getBuyer_password())) {	
		   return buyer_indi.get(0);
	   }
	   else {
		   return null;
	   }
	  
	}
}
