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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.Buyer_Business;
import com.app.model.Product;
import com.app.model.Company;
import com.app.services.Service;

@SessionAttributes(names = {"sys_otp", "buyer_business"})
@Controller
@RequestMapping("buyer/business")
public class Buyer_Business_Controller {

    @Autowired
    private Service services;

    public void setServices(Service services) {
        this.services = services;
    }

    /**
     * Send OTP to buyer's business email
     */
    @RequestMapping(value = "sendotp", method = RequestMethod.POST)
    public ResponseEntity<String> sendotp(@RequestParam("email") String email, ModelMap m) {
        Random r = new Random();
        int sys_otp = r.nextInt(900000) + 100000;
        try {
            System.out.println("OTP Generated: " + sys_otp);
            // services.sendOTP(email, sys_otp); // Uncomment when email service is ready
            m.addAttribute("sys_otp", sys_otp);

            // Check if buyer already exists
            Buyer_Business buyer = new Buyer_Business();
            buyer.setBuyer_email(email);
            buyer = services.getBuyerBusiness(buyer);
            
            if (buyer == null) {
                return ResponseEntity.status(HttpStatus.OK).body("OTP sent successfully");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email Already Exists");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to send OTP");
        }
    }

    /**
     * Verify OTP entered by buyer
     */
    @RequestMapping(value = "verifyotp", method = RequestMethod.POST)
    public ResponseEntity<String> verifyotp(@RequestParam("email") String email, 
                                            @RequestParam("otp") String user_otp, 
                                            ModelMap m, 
                                            HttpSession session) {
        try {
            int sys_otp = (Integer) m.getAttribute("sys_otp");
            int us_otp = Integer.parseInt(user_otp);
            
            if (sys_otp == us_otp) {
                return ResponseEntity.status(HttpStatus.OK).body("OTP Verified Successfully!");
            } else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid OTP");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error verifying OTP");
        }
    }

    /**
     * Create business buyer account
     */
    @RequestMapping(value = "createaccount", method = RequestMethod.POST)
    public ModelAndView createaccount(@ModelAttribute Buyer_Business buyer) {
        try {
            // Create or get company
            Company company = new Company();
            company.setCompany_name(buyer.getBuyer_name());
            company.setCompany_email(buyer.getBuyer_email());
            buyer.setCompany(company);
            
            // Insert buyer into database
            services.insertBuyerBusiness(buyer);
            
            // Redirect to product listing with seller type filter
            return new ModelAndView("redirect:/products?sellerType=all");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error", "message", "Failed to create account");
        }
    }

    /**
     * Get filtered products for business buyer
     */
    @RequestMapping("products")
    public ModelAndView getFilteredProducts(@ModelAttribute Product product, 
                                           @RequestParam(value = "sellerType", defaultValue = "all") String seller_type) {
        try {
            ModelAndView mav = new ModelAndView();
            List<Product> productList = services.getFilteredProducts(product, seller_type);
            mav.addObject("productList", productList);
            mav.addObject("sellerType", seller_type);
            mav.setViewName("Buyer_Business/Buyer_Dashboard");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error", "message", "Error loading products");
        }
    }

    /**
     * View product details
     */
    @RequestMapping("product/details")
    public ModelAndView getProductDetails(@RequestParam("productId") int productId) {
        try {
            Product product = services.getProductById(productId);
            ModelAndView mav = new ModelAndView();
            mav.addObject("product", product);
            mav.setViewName("Buyer_Business/Product_Details");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error", "message", "Product not found");
        }
    }

    /**
     * Login for existing business buyer
     */
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public ModelAndView login(@ModelAttribute Buyer_Business buyer, ModelMap m) {
        try {
            Buyer_Business existingBuyer = services.getBuyerBusiness(buyer);
            if (existingBuyer != null && existingBuyer.getBuyer_password().equals(buyer.getBuyer_password())) {
                m.addAttribute("buyer_business", existingBuyer);
                return new ModelAndView("Buyer_Business/Buyer_Dashboard");
            } else {
                return new ModelAndView("Login", "error", "Invalid credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("Login", "error", "Login failed");
        }
    }

    /**
     * Logout business buyer
     */
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
