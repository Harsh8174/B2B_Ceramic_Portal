package com.app.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.transaction.annotation.Transactional;

import com.app.model.Company;
import com.app.model.Product;
import com.app.model.Product_Image;

public class CompanyDaoImpl implements Companydao {

	private HibernateTemplate hibernateTemplate;

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Transactional(readOnly = false)
	@Override
	public String addProduct(Product product) {
	    try {
	    	hibernateTemplate.save(product);
	    	return "success";
	    }catch (Exception e) {
			e.printStackTrace();
		}	
		return null;
	}
	@Transactional(readOnly = false)
    @Override
    public String addProductimage(Product_Image product_img) {
    	try {
    		hibernateTemplate.save(product_img);
    	}
    	catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
    }
	
	
    @Override
    public List<Product> getallProducts(int company_id) {
    	try {
    		String hql = "from Product where company_id=:company_id";
             
    		List products=hibernateTemplate.findByNamedParam(hql, "company_id", company_id);
    		List<Product> add_product=new ArrayList<Product>();
    		for(Object obj : products) {
    		    Product p = (Product)obj;
    		    
    		    add_product.add(p);
    		}
    		return add_product;
    	}
    	catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
    }
    
    @Override
    public List<Product_Image> getProductsallImages(Product product) {
    	try {
    		String hql = "from Product_Image where product=:product";
             
    		List products=hibernateTemplate.findByNamedParam(hql, "product", product);
    		List<Product_Image> product_img=new ArrayList<Product_Image>();
    		for(Object obj : products) {
    		    Product_Image p = (Product_Image)obj;
    		    product_img.add(p);
    		}
    		return product_img;
    	}
    	catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
    }
    
    @Override
    public Product getProductById(int product_id) {
          try {
           Product	product=  hibernateTemplate.get(Product.class,product_id);
          return product;
          }catch (Exception e) {
			e.printStackTrace();
		}    	
    	return null;
    }
    
    @Transactional(readOnly = false)
    @Override
    public String updateProduct(Product product) {
    	try {
    		
    		hibernateTemplate.update(product);
    		return "success";
    	}catch (Exception e) {
			e.printStackTrace();
		}
    	return "failure";
    }
    
    @Override
    public Company getCompany(int company_id) {
    	Company company=hibernateTemplate.get(Company.class, company_id);  
    	return company;
    }
    @Transactional(readOnly = false)
    @Override
    public void updateProductimage(Product_Image product_img) {
    	
    	hibernateTemplate.saveOrUpdate(product_img);
    	
    }
    @Transactional(readOnly = false)
    @Override
    public void deleteProductimage(Product_Image product_img) {
    	hibernateTemplate.delete(product_img);
    	
    }
    @Transactional(readOnly = false)
    @Override
    public void deleteproduct(Product product) {
    	hibernateTemplate.delete(product);
    }
    
    @Override
    public List<Product> getallProducts() {

        String hql = "from Product";

        List<Product> list_product =
                (List<Product>) hibernateTemplate.find(hql);

        for (Product p : list_product) {

            String hql_img =
                    "from Product_Image pi " +
                    "where pi.product.product_id = :product_id";
             
            List<Product_Image> images =
                    (List<Product_Image>) hibernateTemplate.findByNamedParam(
                            hql_img,
                            "product_id",
                            p.getProduct_id()
                    );

            p.setProduct_image_name(images);
        
          Company company=hibernateTemplate.get(Company.class, p.getCompany().getCompany_id());
          p.setCompany(company);
        }

        return list_product;
    }
}
