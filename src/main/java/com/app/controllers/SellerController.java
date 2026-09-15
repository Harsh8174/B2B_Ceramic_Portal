package com.app.controllers;



import java.io.File;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Random;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.Company;
import com.app.model.Product;
import com.app.model.Seller;
import com.app.services.Service;

@Controller
@SessionAttributes(names = {"sys_otp","user","Seller","total_products"})
@RequestMapping("seller")
public class SellerController {
     
	
	private Service services;
	@Autowired
	public void setServices(Service services) {
		this.services = services;
	}
	
	@RequestMapping("/")
	public String register() {
		//System.out.println("Seller default handler");
		return"";
	}
	
	@RequestMapping(value = "sendotp",method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)	
	public ResponseEntity<String> sendotp(@RequestParam("email") String email,ModelMap m) {
		Random R = new Random();
		int sys_otp = 100000 + R.nextInt(900000);

		 try {
		services.sendOTP(email, sys_otp);
		Seller s=new Seller();
		s.setSeller_email(email);
		
		s=services.Get_Seller(s);
		System.out.println(s);
        if(s!=null) {
        	return ResponseEntity.status(HttpStatus.CONFLICT).body("Email Already Exist");
        }	
        else {
		m.addAttribute("sys_otp", sys_otp);
		System.out.println("sys_otp:"+sys_otp);
        return ResponseEntity.status(HttpStatus.OK).body("Otp Sended Successfully");
        } 
        }catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Problem Otp not sended");
		}
		 
		
	}
	
	@RequestMapping(value = "verifyotp",method = RequestMethod.POST)
	public ResponseEntity<String> verifyotp(@RequestParam("otp") String user_otp,ModelMap m) {
		
		int sys_otp=(Integer) m.getAttribute("sys_otp");
        int us_otp=Integer.parseInt(user_otp);
        if(sys_otp==us_otp) {
        	return ResponseEntity.status(HttpStatus.OK).body("OTP Matched Successfully!");
        }
        else {
        	return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid Otp");
        }
	}
	
	@RequestMapping(value="createaccount" ,method = RequestMethod.POST)
	public ModelAndView addUser(@RequestParam("name") String name,@RequestParam("email") String email,@RequestParam("mobile") String mobile,@RequestParam("password")
	String password,@RequestParam("seller_type") String seller_type ,@RequestParam("company_name") String company,
	@RequestParam("company_email") String companyEmail) {
		
		
		Seller s=new Seller();
    	s.setSeller_name(name);
    	s.setSeller_email(email);
    	s.setSeller_contact(Long.parseLong(mobile));
    	s.setSeller_password(password);
        s.setSeller_type(seller_type);
		Company c=new Company();
		c.setCompany_name(company);
		c.setCompany_email(companyEmail);
		s.setSeller_company(c);
		String status=services.Insert_Seller(s);
		if(status.equals("success")) {
		return new ModelAndView("Seller/Seller_Dashboard", "Seller", s);
		}
		else {
			return null;
		}
	}
	
	   @RequestMapping("login")
	   public ModelAndView Login(@ModelAttribute Seller seller,ModelMap m) {
		   
		   Seller s= services.Get_Seller(seller);
		   if(s!=null) {
			List<Product> list= services.getProducts(s);
			m.addAttribute("total_products", list.size());
	       return new ModelAndView("Seller/Seller_Dashboard", "Seller", s);
		   }
		   else {
			   return new ModelAndView("Login", "error", "Credentials Not Matched");
		   }
		   }
	   
	   @RequestMapping("products/new")
	   public String newproducts() {
		     
		    return "Seller/Seller_Product";
	   }
	   @RequestMapping(value = "addproducts",method = RequestMethod.POST)
	   public String addProducts(@ModelAttribute Product product,HttpServletRequest request) {
		   /*@SessionAttribute(name = "Seller") Seller s*/
		     // Seller s= (Seller) m.getAttribute("Seller");
              
		     HttpSession session=(HttpSession)request.getSession(false);
		     Seller s=(Seller)session.getAttribute("Seller");
		     Company c=s.getSeller_company();
		     product.setCompany(c);   
		     String uploadir=request.getServletContext().getRealPath("/Seller_upload_images/");
		        //Seller s=(Seller)m.getAttribute("Seller");
             System.out.println(s);
		     String status= services.addProduct(product,uploadir);
		     System.out.println(status);
		     List<Product>  products= services.getProducts(s);
		     request.setAttribute("productList", products);
		     return "Seller/Seller_MyProducts";
	   }

	   @RequestMapping("dashboard")
	   public String getdashboard(HttpSession session,ModelMap m) {
		   Seller s=(Seller)session.getAttribute("Seller");
		   List<Product> list= services.getProducts(s);
			m.addAttribute("total_products", list.size());
		   return "Seller/Seller_Dashboard";
	   }
	    @RequestMapping("products")
	    public ModelAndView products(HttpServletRequest request ) {
	    	    HttpSession session=request.getSession(false);
	    	    Seller s=(Seller)session.getAttribute("Seller");
	    	    List<Product>  product= services.getProducts(s);
	    	    for (Product product2 : product) {
					System.out.println(product2.getProduct_name());
				}
	    	   return new ModelAndView("Seller/Seller_MyProducts", "productList", services.getProducts(s));
	    	   //return "Seller/Seller_MyProducts";
	    }
	
	    @RequestMapping(value = "products/edit", method = RequestMethod.GET)
	    public String editProductForm(@RequestParam("id") int id, Model model) {
	        
	        Product product = services.getProductById(id); 
	        model.addAttribute("product", product);
	        return "Seller/Seller_Product_Edit";
	    } 
	    @RequestMapping(value = "products/update", method = RequestMethod.POST)
	    public String updateProduct(@ModelAttribute Product product,HttpSession session,HttpServletRequest request) {
	    	Seller s=(Seller)session.getAttribute("Seller");
	    	String uploadDirPath = request.getServletContext().getRealPath("/Seller_upload_images/");
	    	services.updateProduct(product,s.getSeller_company().getCompany_id(),uploadDirPath); 
	        return "redirect:/seller/products";
	    }
	    
	    @RequestMapping("delete")
	    public String deleteProduct(@RequestParam("id") int product_id,Model map,HttpSession session,HttpServletRequest request) {
	    	String uploadDirPath = request.getServletContext().getRealPath("/Seller_upload_images/");
	    	System.out.println("controller :"+uploadDirPath);
	    	services.deleteproduct(product_id,uploadDirPath);
	    	Seller s=(Seller)session.getAttribute("Seller");
	    	List<Product>  product= services.getProducts(s);
	    	map.addAttribute(product);
	    	return "Seller/Seller_MyProducts";
	    }
	    
	   }

     