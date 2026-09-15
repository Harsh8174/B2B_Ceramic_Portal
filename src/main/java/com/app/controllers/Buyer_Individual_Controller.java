package com.app.controllers;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.Buyer_Individual;
import com.app.model.Product;
import com.app.services.Service;
@SessionAttributes(names = {"sys_otp","buyer"})
@Controller
@RequestMapping("buyer/individual")
public class Buyer_Individual_Controller {
	
    @Autowired	
   private Service services;

   public void setServices(Service services) {
	this.services = services;
   }
	@RequestMapping("sendotp")
	 public ResponseEntity sendotp(@RequestParam("email") String email,ModelMap m ) {
       		Random r=new Random();
       		int sys_otp=r.nextInt(900000)+100000;
       		try {	
       			
       		System.out.println(sys_otp);
       		//services.sendOTP(email, sys_otp);
       		m.addAttribute("sys_otp", sys_otp);
       		Buyer_Individual buyer=new Buyer_Individual();
       		buyer.setBuyer_email(email);
       		buyer=services.getbuyer(buyer);
       		if(buyer==null) {
       		return ResponseEntity.status(HttpStatus.OK).body("success");
       		}
       		else {return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email Already Exist");}
       		}
       		catch (Exception e) {
				e.printStackTrace();
			}
       		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Not sended Otp");
	 }
	@RequestMapping("verifyotp")
	 public ResponseEntity verotp(@RequestParam("email") String email,@RequestParam("otp") String user_otp,ModelMap m,HttpSession session ) { 
		int sys_otp=(Integer) m.getAttribute("sys_otp");
		System.out.println(m);
        int us_otp=Integer.parseInt(user_otp);
        if(sys_otp==us_otp) {
        	
        	return ResponseEntity.status(HttpStatus.OK).body("OTP Matched Successfully!");
        }
        else {
        	return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid Otp");
        }
		  
	 }
	
	@RequestMapping("createaccount")
	public String createaccount(@ModelAttribute Buyer_Individual buyer) {
		
		   services.insertbuyer(buyer);
		   return "redirect:/products";
	}
	
	@RequestMapping("products")
	public ModelAndView getspecificproduct(@ModelAttribute Product product,@RequestParam("sellerType") String seller_type) {
       
		ModelAndView mav=new ModelAndView();
  	  mav.addObject("productList", services.getFilteredProducts(product, seller_type));
  	  mav.setViewName("Buyer_Individual/Buyer_Dashboard");
		 return mav;
	}
}
