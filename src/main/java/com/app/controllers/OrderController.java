package com.app.controllers;

import java.time.LocalDateTime;
import java.util.List;

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
import com.app.model.Buyer_Individual;
import com.app.model.Order;
import com.app.model.Product;
import com.app.services.Service;

@SessionAttributes(names = {"order"})
@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    private Service services;

    public void setServices(Service services) {
        this.services = services;
    }

    /**
     * Create order for individual buyer
     */
    @RequestMapping(value = "create/individual", method = RequestMethod.POST)
    public ResponseEntity<String> createOrderIndividual(
            @RequestParam("productId") int productId,
            @RequestParam("quantity") int quantity,
            @RequestParam("deliveryAddress") String deliveryAddress,
            @RequestParam(value = "notes", required = false) String notes,
            HttpSession session) {
        try {
            Buyer_Individual buyer = (Buyer_Individual) session.getAttribute("buyer");
            if (buyer == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please login first");
            }

            Product product = services.getProductById(productId);
            if (product == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found");
            }

            // Check stock availability
            if (product.getProduct_available_stock() < quantity) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Insufficient stock. Available: " + product.getProduct_available_stock());
            }

            Order order = new Order();
            order.setBuyer_individual(buyer);
            order.setProduct(product);
            order.setOrder_quantity(quantity);
            order.setOrder_total_price(product.getProduct_price() * quantity);
            order.setDelivery_address(deliveryAddress);
            order.setOrder_notes(notes);

            String status = services.createOrder(order);
            if (status.equals("success")) {
                return ResponseEntity.status(HttpStatus.OK).body("Order created successfully");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to create order");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating order");
        }
    }

    /**
     * Create order for business buyer
     */
    @RequestMapping(value = "create/business", method = RequestMethod.POST)
    public ResponseEntity<String> createOrderBusiness(
            @RequestParam("productId") int productId,
            @RequestParam("quantity") int quantity,
            @RequestParam("deliveryAddress") String deliveryAddress,
            @RequestParam(value = "notes", required = false) String notes,
            HttpSession session) {
        try {
            Buyer_Business buyer = (Buyer_Business) session.getAttribute("buyer_business");
            if (buyer == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please login first");
            }

            Product product = services.getProductById(productId);
            if (product == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found");
            }

            if (product.getProduct_available_stock() < quantity) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Insufficient stock. Available: " + product.getProduct_available_stock());
            }

            Order order = new Order();
            order.setBuyer_business(buyer);
            order.setProduct(product);
            order.setOrder_quantity(quantity);
            order.setOrder_total_price(product.getProduct_price() * quantity);
            order.setDelivery_address(deliveryAddress);
            order.setOrder_notes(notes);

            String status = services.createOrder(order);
            if (status.equals("success")) {
                return ResponseEntity.status(HttpStatus.OK).body("Order created successfully");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to create order");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating order");
        }
    }

    /**
     * Get orders for individual buyer
     */
    @RequestMapping("history/individual")
    public ModelAndView getOrderHistoryIndividual(HttpSession session) {
        try {
            Buyer_Individual buyer = (Buyer_Individual) session.getAttribute("buyer");
            if (buyer == null) {
                return new ModelAndView("Login", "error", "Please login first");
            }

            List<Order> orders = services.getOrdersByBuyer(buyer.getBuyer_id());
            ModelAndView mav = new ModelAndView();
            mav.addObject("orders", orders);
            mav.setViewName("Buyer_Individual/Order_History");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error", "message", "Error loading order history");
        }
    }

    /**
     * Get orders for business buyer
     */
    @RequestMapping("history/business")
    public ModelAndView getOrderHistoryBusiness(HttpSession session) {
        try {
            Buyer_Business buyer = (Buyer_Business) session.getAttribute("buyer_business");
            if (buyer == null) {
                return new ModelAndView("Login", "error", "Please login first");
            }

            List<Order> orders = services.getOrdersByBusinessBuyer(buyer.getBuyer_id());
            ModelAndView mav = new ModelAndView();
            mav.addObject("orders", orders);
            mav.setViewName("Buyer_Business/Order_History");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error", "message", "Error loading order history");
        }
    }

    /**
     * View order details
     */
    @RequestMapping("details")
    public ModelAndView getOrderDetails(@RequestParam("orderId") int orderId) {
        try {
            Order order = services.getOrderById(orderId);
            if (order == null) {
                return new ModelAndView("error", "message", "Order not found");
            }

            ModelAndView mav = new ModelAndView();
            mav.addObject("order", order);
            mav.setViewName("Order/Order_Details");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error", "message", "Error loading order details");
        }
    }

    /**
     * Cancel order (only if status is PENDING)
     */
    @RequestMapping(value = "cancel", method = RequestMethod.POST)
    public ResponseEntity<String> cancelOrder(@RequestParam("orderId") int orderId) {
        try {
            Order order = services.getOrderById(orderId);
            if (order == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order not found");
            }

            if (!order.getOrder_status().equals("PENDING")) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Can only cancel orders with PENDING status");
            }

            String status = services.updateOrderStatus(orderId, "CANCELLED");
            if (status.equals("success")) {
                return ResponseEntity.status(HttpStatus.OK).body("Order cancelled successfully");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to cancel order");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error cancelling order");
        }
    }

    /**
     * Get all orders (Admin functionality)
     */
    @RequestMapping("all")
    public ModelAndView getAllOrders() {
        try {
            List<Order> orders = services.getAllOrders();
            ModelAndView mav = new ModelAndView();
            mav.addObject("orders", orders);
            mav.setViewName("Admin/All_Orders");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error", "message", "Error loading orders");
        }
    }

    /**
     * Update order status (Admin functionality)
     */
    @RequestMapping(value = "updatestatus", method = RequestMethod.POST)
    public ResponseEntity<String> updateOrderStatus(@RequestParam("orderId") int orderId,
                                                    @RequestParam("status") String status) {
        try {
            String validStatuses[] = {"PENDING", "CONFIRMED", "SHIPPED", "DELIVERED", "CANCELLED"};
            boolean isValid = false;
            for (String validStatus : validStatuses) {
                if (validStatus.equals(status)) {
                    isValid = true;
                    break;
                }
            }

            if (!isValid) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid order status");
            }

            String result = services.updateOrderStatus(orderId, status);
            if (result.equals("success")) {
                return ResponseEntity.status(HttpStatus.OK).body("Order status updated successfully");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update order status");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating order status");
        }
    }
}
