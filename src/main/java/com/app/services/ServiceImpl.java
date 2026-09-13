package com.app.services;

import java.io.File;
import java.io.FileOutputStream;
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

import com.app.dao.Companydao;
import com.app.dao.Dao;
import com.app.model.Company;
import com.app.model.Product;
import com.app.model.Product_Image;
import com.app.model.Seller;

@org.springframework.stereotype.Service("services")
public class ServiceImpl implements Service {
    
	@Autowired
	private Dao sellerdao;
	@Autowired
	private Companydao companydao;
	
	public void setSellerdao(Dao sellerdao) {
		this.sellerdao = sellerdao;
	}

	public void setCompanydao(Companydao companydao) {
		this.companydao = companydao;
	}


	@Override
	public void sendOTP(String toEmail, int otp) throws MessagingException {
		final String fromEmail = "bbceramicportal@gmail.com"; // sender email
		final String password = "xypmsozdnjreobhx"; // use App Password if 2FA enabled

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
	public String addProduct(Product product) {
		 System.out.println("========== addProduct() SERVICE CALLED ==========");
		 String status="";
		 List<MultipartFile> list=product.getProduct_file();
		 System.out.println("Number of files = " + list.size());
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
		    	 list_image.add(product_img);
		         try { 
		    	 	 
		    	 FileOutputStream fro=new FileOutputStream("F:\\Ceramic_B2B_Portal\\Ceramic_B2B_Project\\src\\main\\webapp\\WEB-INF\\Seller\\Seller_upload_images\\"+cleanFileName);
		    	 b=file.getBytes();
		    	 fro.write(b);
		    	 fro.close();
		    	 System.out.println(count++);
		    	 }catch (Exception e) {
					e.printStackTrace();
				    return "failure";
		    	 }
		    	 
		     }
		     
		     product.setProduct_image_name(list_image);
		     status =companydao.addProduct(product);
		     Iterator<Product_Image> imlr=list_image.iterator();
		     while(imlr.hasNext()) {
		    	product_img=imlr.next();
		    	product_img.setProduct(product);
		    	companydao.addProductimage(product_img);
		     }
		     
	 		  
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
	    public String updateProduct(Product product,int company_id) {
	    	List<MultipartFile> uploaded_file=product.getProduct_file();
	        List<Product_Image> database_file =companydao.getProductsallImages(product);
	        Iterator<MultipartFile> itr=uploaded_file.iterator(); 
	        int total_size=6;
            int current_size=database_file.size();
            int index=0;
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
	            	  Product_Image  product_image=new Product_Image();
	 	             product_image.setProduct_image_name(cleanFileName);
	 	             product_image.setProduct(product);
	             companydao.updateProductimage(product_image);
	             }else {
	            	      Product_Image product_Image=database_file.get(index);
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
	    	
	    
	      }


