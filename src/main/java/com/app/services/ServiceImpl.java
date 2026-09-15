package com.app.services;

import java.io.File;
import java.io.FileOutputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.app.dao.BuyerDao;
import com.app.dao.BuyerBusinessDao;
import com.app.dao.Companydao;
import com.app.dao.Dao;
import com.app.dao.OrderDao;
import com.app.model.Buyer_Business;
import com.app.model.Buyer_Individual;
import com.app.model.Company;
import com.app.model.Order;
import com.app.model.Product;
import com.app.model.Product_Image;
import com.app.model.Seller;

@org.springframework.stereotype.Service("services")
public class ServiceImpl implements Service {
    
	@Autowired
	private Dao sellerdao;
	@Autowired
	private Companydao companydao;
	@Autowired
	private BuyerDao buyerdao;
	@Autowired
	private BuyerBusinessDao buyerBusinessDao;
	@Autowired
	private OrderDao orderDao;
	
	public void setSellerdao(Dao sellerdao) {
		this.sellerdao = sellerdao;
	}

	public void setCompanydao(Companydao companydao) {
		this.companydao = companydao;
	}
	
	public void setBuyerdao(BuyerDao buyerdao) {
		this.buyerdao = buyerdao;
	}
	
	public void setBuyerBusinessDao(BuyerBusinessDao buyerBusinessDao) {
		this.buyerBusinessDao = buyerBusinessDao;
	}
	
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	@Override
	public void sendOTP(String toEmail, int otp) throws MessagingException {
		final String fromEmail = "doctorfinder008@gmail.com"; // sender email
		final String password = "tkynknbbwqkelgxq"; // use App Password if 2FA enabled

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});

		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(fromEmail));
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		msg.setSubject("Your OTP Code");
		msg.setText("Your OTP is: " + otp);
		System.out.println(msg);
		Transport.send(msg);
	}

	
	@Override
	public String Insert_Seller(Seller seller) {
		String status = sellerdao.Insert_Seller(seller);
		return status;
	}

	@Override
	public Seller Get_Seller(Seller seller) {
		Seller s=sellerdao.Get_Seller(seller);
		if(s!=null) {
			return s;
		}
		else 
		{
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
    
	 @Override
	public String addProduct(Product product,String Path) {
		
		 String status="";
		 List<MultipartFile> list=product.getProduct_file();
		     List<Product_Image> list_image=new ArrayList<Product_Image>(); 
		     Iterator<MultipartFile> itr=list.iterator();
		     Product_Image product_img;
		     int count=0;
		     while(itr.hasNext()) {
		    	 MultipartFile file=itr.next();
		    	 String file_name=file.getOriginalFilename();
		    	 System.out.println(file_name);
		    	 String baseName = file_name;
		         String extension = "";
		         int dotIndex = file_name.lastIndexOf('.');
		         
		         byte b[];
		         if (dotIndex > 0) {
		             baseName = file_name.substring(0, dotIndex);
		             extension = file_name.substring(dotIndex); 
		         }
		         String cleanFileName = baseName + "_" + System.currentTimeMillis() + extension;
		         product_img=new Product_Image();
		    	 product_img.setProduct_image_name(cleanFileName);
		    	 product_img.setProduct(product);
		    	 list_image.add(product_img);
		         try { 
		    	 	 
		    	 FileOutputStream fro=new FileOutputStream(Path+cleanFileName);
		    	 b=file.getBytes();
		    	 fro.flush();
		    	 fro.write(b);
		    	 fro.close();
		    	 System.out.println(count++);
		    	 }catch (Exception e) {
					e.printStackTrace();
				    return "failure";
		    	 }
		    	 
		     }
		     
		     product.setProduct_image_name(list_image);
		     Iterator<Product_Image> imlr=list_image.iterator();
		     status =companydao.addProduct(product);
		    
		     return status;
	}  
	    
	      @Override
	    public List<Product> getProducts(Seller seller) {
	    	int company_id=seller.getSeller_company().getCompany_id();
	    	 List<Product> products= companydao.getallProducts(company_id);
	    	 for (Product product : products) {
				product.setProduct_image_name(companydao.getProductsallImages(product));
			}
	    	 return products;
	    }
	      
	      @Override
	    public Product getProductById(int product_id) {
	    	
	    	return companydao.getProductById(product_id);
	    }
	      @Override
	    public String updateProduct(Product product,int company_id,String path) {
	    	List<MultipartFile> uploaded_file=product.getProduct_file();
	        List<Product_Image> database_file =companydao.getProductsallImages(product);
	        Iterator<MultipartFile> itr=uploaded_file.iterator(); 
	        int total_size=6;
             int current_size=database_file.size();
             int index=0;
             System.out.println(path);
             File file;
             FileOutputStream fro;
             byte b[];
	        while(itr.hasNext()) {
		        MultipartFile obj=itr.next();
		        String file_name =  obj.getOriginalFilename();
		        String baseName = file_name;
		        String extension = "";
		        int dotIndex = file_name.lastIndexOf('.');
		        if (dotIndex > 0) {
		             baseName = file_name.substring(0, dotIndex);
		             extension = file_name.substring(dotIndex); 
		         }
		         String cleanFileName = baseName + "_" + System.currentTimeMillis() + extension;
	             
	             if(current_size<total_size) {
	            	 current_size++;
	            	 
	            	 try {b=obj.getBytes();
	            		 fro=new FileOutputStream(path+cleanFileName);
	            	     fro.write(b);
	            	     fro.close();
	            	 }catch (Exception e) {
						e.printStackTrace();
					}
	            	  Product_Image  product_image=new Product_Image();
	 	             product_image.setProduct_image_name(cleanFileName);
	 	             product_image.setProduct(product);
	             companydao.updateProductimage(product_image);
	             }else {  
	            	      Product_Image product_Image=database_file.get(index);
	            	      File f=new File(path+product_Image.getProduct_image_name());
	            	      f.delete();
						  product_Image.setProduct_image_name(cleanFileName);
						  product_Image.setProduct(product);
						  companydao.updateProductimage(product_Image);
					      index++;
	             }
	        }
	        Company company=companydao.getCompany(company_id);
	    	product.setCompany(company);
	    	return companydao.updateProduct(product);
	        }
	    	
	    @Override
	    public void deleteproduct(int product_id,String path) {
	    	   Product product= companydao.getProductById(product_id); 
	    	    List<Product_Image> list= companydao.getProductsallImages(product); 
	    	    boolean status=false;
	            for (Product_Image product_Image : list) {
	            	System.out.println(path+product_Image.getProduct_image_name());
	            	  File file=new File(path+product_Image.getProduct_image_name());
					  status =file.delete();
					  System.out.println(status);
					 }
	            if(status) {
	            	companydao.deleteproduct(product);
	            }
	    }
	    
	    @Override
	    public String insertbuyer(Buyer_Individual buyer) {
	    	return buyerdao.inserbuyer(buyer);
	    }
	    
	    @Override
	    public List<Product> getallProducts() {
	    	return companydao.getallProducts();
	    }
	    
	    @Override
	    public List<Product> getFilteredProducts(Product product,String seller_type) {
	    List<Product> list = companydao.getallProducts();
	    List<Product> selected_pro=new ArrayList<Product>(); 
	    int i=0;
	    for (Product product2 : list) {
	    	i++;
	 	    
		if(seller_type.equalsIgnoreCase("all")) {
	    	if(product2.getProduct_category().equals(product.getProduct_category()) 
				 && product2.getProduct_material().equals(product.getProduct_material())
				 && product2.getProduct_size().equalsIgnoreCase(product.getProduct_size())
			     &&	product2.getProduct_finish().equals(product.getProduct_finish()) ) {	   
				  selected_pro.add(product2);
			  }   
		}
		else if(product2.getProduct_category().equals(product.getProduct_category()) 
				 && product2.getProduct_material().equals(product.getProduct_material())
				 && product2.getProduct_size().equalsIgnoreCase(product.getProduct_size())
			     &&	product2.getProduct_finish().equals(product.getProduct_finish())
			     && product2.getCompany().getSeller().getSeller_type().equals(seller_type) 
				){
					  selected_pro.add(product2);
		}		     
		
			}
	    	return selected_pro;
	    }
	    
	    @Override
	    public Buyer_Individual getbuyer(Buyer_Individual buyer) {
	    	return buyerdao.getbuyer(buyer);
	    }
	    
	    // Business Buyer Methods
	    @Override
	    public String insertBuyerBusiness(Buyer_Business buyer) {
	    	return buyerBusinessDao.insertBuyerBusiness(buyer);
	    }
	    
	    @Override
	    public Buyer_Business getBuyerBusiness(Buyer_Business buyer) {
	    	return buyerBusinessDao.getBuyerBusiness(buyer);
	    }
	    
	    @Override
	    public List<Buyer_Business> getAllBusinessBuyers() {
	    	return buyerBusinessDao.getAllBuyerBusiness();
	    }
	    
	    // Order Methods
	    @Override
	    public String createOrder(Order order) {
	    	order.setOrder_date(LocalDateTime.now());
	    	order.setOrder_status("PENDING");
	    	return orderDao.createOrder(order);
	    }
	    
	    @Override
	    public Order getOrderById(int order_id) {
	    	return orderDao.getOrderById(order_id);
	    }
	    
	    @Override
	    public List<Order> getOrdersByBuyer(int buyer_id) {
	    	return orderDao.getOrdersByBuyerId(buyer_id);
	    }
	    
	    @Override
	    public List<Order> getOrdersByBusinessBuyer(int buyer_business_id) {
	    	return orderDao.getOrdersByBusinessBuyerId(buyer_business_id);
	    }
	    
	    @Override
	    public String updateOrderStatus(int order_id, String status) {
	    	Order order = orderDao.getOrderById(order_id);
	    	if(order != null) {
	    		order.setOrder_status(status);
	    		return orderDao.updateOrder(order);
	    	}
	    	return "failure";
	    }
	    
	    @Override
	    public void deleteOrder(int order_id) {
	    	orderDao.deleteOrder(order_id);
	    }
	    
	    @Override
	    public List<Order> getAllOrders() {
	    	return orderDao.getAllOrders();
	    }
}
