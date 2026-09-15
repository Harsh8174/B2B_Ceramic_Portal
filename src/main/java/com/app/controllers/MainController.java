package com.app.controllers;




import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.Buyer_Individual;
import com.app.model.Product;
import com.app.model.Seller;
import com.app.services.Service;


@Controller
public class MainController {

	private Service services;
	@Autowired
	public void setServices(Service services) {
		this.services = services;
	}
	
	@RequestMapping("register")
	public String Register() {
      
		
		return "Register";
	}
	@RequestMapping("login")
	public String Login() {
		return "Login";
	}
    @RequestMapping("logout")
    public String logout(HttpServletRequest request) {
    	request.getSession().invalidate();

        return "redirect:/";
    }
    @RequestMapping("products")
    public ModelAndView getallproducts() {
    	  System.out.println("main controoler");
    	  ModelAndView mav=new ModelAndView();
    	  mav.addObject("productList", services.getallProducts());
    	  mav.setViewName("Buyer_Individual/Buyer_Dashboard");
    	  return mav;
    }
   
    @RequestMapping("buyer/login")
	   public ModelAndView Login(@ModelAttribute Buyer_Individual buyer) {
		   
			Buyer_Individual buyer_inid= services.getbuyer(buyer);
		
				if(buyer_inid.getBuyer_type().equalsIgnoreCase("individual")) {
	       return new ModelAndView("Buyer_Individual/Buyer_Dashboard", "productList", services.getallProducts());
				}
			
		   
			   return new ModelAndView("Login", "error", "Credentials Not Matched");
		   
		   }
}
