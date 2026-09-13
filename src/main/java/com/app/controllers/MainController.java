package com.app.controllers;




import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {

    
	@RequestMapping("register")
	public String Register() {
      
		System.out.println("inside");
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
}
