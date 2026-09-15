# B2B Ceramic Portal - Complete Project Documentation

## Project Overview

A comprehensive Spring MVC-based B2B e-commerce platform for ceramic products with role-based access for:
- **Individual Buyers** - Browse and purchase ceramic products
- **Business Buyers** - Can buy and sell ceramic products to other businesses
- **Sellers/Manufacturers** - Upload products, manage inventory, and track orders

## Architecture

```
                    Ceramic B2B Portal
                           │
             ┌─────────────┴─────────────┐
             │                           │
          SELLERS                   BUSINESS BUYERS
             │                           │
      Manufacturer /                 Can BUY
       Job Worker                       +
             │                       Can SELL
             │                           │
             └──────────────┬────────────┘
                            │
                     PRODUCT DATABASE
                            │
                 ┌──────────┴──────────┐
                 │                     │
          Individual Buyer       Business Buyer
                 │                     │
              SEE ALL              SEE PRODUCTS
              PRODUCTS             FROM SELLERS
```

## Technology Stack

- **Backend**: Spring Framework 5.3.0, Hibernate ORM, MySQL Database
- **Frontend**: JSP, Bootstrap, jQuery
- **Build Tool**: Maven 3.x
- **Java Version**: 11
- **Web Container**: Apache Tomcat
- **Email Service**: SMTP (Gmail)
- **File Upload**: Apache Commons FileUpload

## Database Schema

### Core Tables

1. **Seller** - Seller/Manufacturer information
   - seller_id (PK)
   - seller_name, email, contact, password, type
   - seller_company (FK)

2. **Company** - Business entity information
   - company_id (PK)
   - company_name, email
   - One-to-many: Products
   - One-to-one: Seller, Buyer_Business

3. **Product** - Ceramic product catalog
   - product_id (PK)
   - product_name, category, material, description
   - product_size, thickness, finish
   - product_price, price_unit
   - product_pieces_per_box, coverage_area
   - product_minimum_order, available_stock
   - company_id (FK)
   - One-to-many: Product_Image, Orders

4. **Product_Image** - Product images
   - image_id (PK)
   - product_image_name (file path)
   - product_id (FK)

5. **Buyer_Individual** - Individual customers
   - buyer_id (PK)
   - buyer_name, email, contact, password, type
   - One-to-many: Orders

6. **Buyer_Business** - Business customers
   - buyer_id (PK)
   - buyer_name, email, contact, password, type
   - company_id (FK)
   - One-to-many: Orders

7. **Orders** - Purchase orders
   - order_id (PK)
   - order_date, quantity, total_price
   - order_status (PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED)
   - delivery_address, notes
   - buyer_id (FK) / buyer_business_id (FK)
   - product_id (FK)

## Project Structure

```
B2B_Ceramic_Portal/
├── src/
│   └── main/
│       ├── java/com/app/
│       │   ├── controllers/
│       │   │   ├── MainController.java
│       │   │   ├── Buyer_Individual_Controller.java
│       │   │   ├── Buyer_Business_Controller.java
│       │   │   ├── SellerController.java
│       │   │   └── OrderController.java
│       │   ├── services/
│       │   │   ├── Service.java (Interface)
│       │   │   └── ServiceImpl.java
│       │   ├── dao/
│       │   │   ├── Dao.java / DaoImpl.java (Seller)
│       │   │   ├── BuyerDao.java / BuyerDaoImpl.java
│       │   │   ├── BuyerBusinessDao.java / BuyerBusinessDaoImpl.java
│       │   │   ├── Companydao.java / CompanyDaoImpl.java
│       │   │   ├── OrderDao.java / OrderDaoImpl.java
│       │   │   └── SellerDaoImpl.java
│       │   └── model/
│       │       ├── Seller.java
│       │       ├── Company.java
│       │       ├── Product.java
│       │       ├── Product_Image.java
│       │       ├── Buyer_Individual.java
│       │       ├── Buyer_Business.java
│       │       └── Order.java
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── jsp/
│           │   │   ├── Login.jsp
│           │   │   ├── Buyer_Individual/
│           │   │   ├── Buyer_Business/
│           │   │   ├── Seller/
│           │   │   ├── Order/
│           │   │   └── Admin/
│           │   ├── spring-servlet.xml
│           │   └── web.xml
│           ├── css/
│           ├── js/
│           ├── images/
│           └── Seller_upload_images/
├── pom.xml
└── README.md
```

## Key Features

### 1. Authentication & Authorization
- OTP-based email verification for registration
- Role-based access control (Individual Buyer, Business Buyer, Seller)
- Session management with @SessionAttributes
- Password-based login

### 2. Seller Features
- Product upload with multiple images
- Product management (CRUD operations)
- Inventory management
- Order tracking
- Seller type categorization (Manufacturer, Job Worker)

### 3. Individual Buyer Features
- Browse all products from all sellers
- Filter products by specifications (size, material, finish, category)
- View product details and images
- Place orders
- Order history
- Cancel pending orders

### 4. Business Buyer Features
- Browse products from all or specific seller types
- Create business company profile
- Place orders
- Order management
- Access to order history by company
- Can potentially sell products (future feature)

### 5. Order Management
- Order creation with validation
- Stock availability checking
- Order status tracking (PENDING → CONFIRMED → SHIPPED → DELIVERED)
- Order cancellation (only for PENDING)
- Order history for individual and business buyers
- Admin order management

## API Endpoints

### Seller Endpoints
```
POST   /seller/sendotp                    - Send OTP to email
POST   /seller/verifyotp                  - Verify OTP
POST   /seller/createaccount              - Create seller account
POST   /seller/login                      - Login seller
GET    /seller/dashboard                  - Seller dashboard
POST   /seller/addproducts                - Add new product
GET    /seller/products                   - Get seller's products
GET    /seller/products/edit?id=X         - Edit product form
POST   /seller/products/update            - Update product
GET    /seller/delete?id=X                - Delete product
```

### Individual Buyer Endpoints
```
POST   /buyer/individual/sendotp          - Send OTP
POST   /buyer/individual/verifyotp        - Verify OTP
POST   /buyer/individual/createaccount    - Create account
GET    /buyer/individual/products         - Get products with filter
```

### Business Buyer Endpoints
```
POST   /buyer/business/sendotp            - Send OTP
POST   /buyer/business/verifyotp          - Verify OTP
POST   /buyer/business/createaccount      - Create business account
GET    /buyer/business/products           - Get filtered products
GET    /buyer/business/product/details    - Product details
POST   /buyer/business/login              - Business buyer login
```

### Order Endpoints
```
POST   /order/create/individual           - Create order (individual)
POST   /order/create/business             - Create order (business)
GET    /order/history/individual          - Order history (individual)
GET    /order/history/business            - Order history (business)
GET    /order/details?orderId=X           - Order details
POST   /order/cancel?orderId=X            - Cancel order
POST   /order/updatestatus                - Update order status (Admin)
GET    /order/all                         - All orders (Admin)
```

## Service Methods

### Core Business Logic
```java
// Authentication
void sendOTP(String email, int otp)

// Seller Management
String Insert_Seller(Seller seller)
Seller Get_Seller(Seller seller)
String Update_Seller(Seller seller)

// Product Management
String addProduct(Product product, String path)
List<Product> getProducts(Seller seller)
Product getProductById(int product_id)
String updateProduct(Product product, int company_id, String path)
void deleteproduct(int product_id, String path)
List<Product> getallProducts()
List<Product> getFilteredProducts(Product product, String seller_type)

// Buyer Management
String insertbuyer(Buyer_Individual buyer)
Buyer_Individual getbuyer(Buyer_Individual buyer)
String insertBuyerBusiness(Buyer_Business buyer)
Buyer_Business getBuyerBusiness(Buyer_Business buyer)

// Order Management
String createOrder(Order order)
Order getOrderById(int order_id)
List<Order> getOrdersByBuyer(int buyer_id)
List<Order> getOrdersByBusinessBuyer(int buyer_business_id)
String updateOrderStatus(int order_id, String status)
void deleteOrder(int order_id)
List<Order> getAllOrders()
```

## Configuration Files

### pom.xml
- Spring WebMVC 5.3.0
- Spring ORM 5.3.0
- Hibernate Core 5.3.24
- MySQL Connector 8.0.33
- JavaMail 1.6.2
- Commons FileUpload 1.6.0
- Commons IO 2.16.1
- JAXB API and Implementation

### spring-servlet.xml
- Component scanning for @Controller, @Service, @Repository
- View resolver for JSP files
- DataSource configuration
- Hibernate SessionFactory
- Transaction management

## Frontend Structure (To Be Created)

### JSP Pages Needed
```
WEB-INF/jsp/
├── Login.jsp                          - Login page
├── Registration.jsp                   - Registration page
├── Buyer_Individual/
│   ├── Registration.jsp              - Individual registration
│   ├── Buyer_Dashboard.jsp           - Main dashboard
│   ├── Product_List.jsp              - Browse products
│   ├── Product_Details.jsp           - Product details
│   ├── Cart.jsp                      - Shopping cart
│   ├── Checkout.jsp                  - Order checkout
│   └── Order_History.jsp             - Order history
├── Buyer_Business/
│   ├── Registration.jsp              - Business registration
│   ├── Buyer_Dashboard.jsp           - Business dashboard
│   ├── Product_List.jsp              - Browse with seller filter
│   ├── Product_Details.jsp           - Product details
│   ├── Checkout.jsp                  - Order checkout
│   └── Order_History.jsp             - Order history
├── Seller/
│   ├── Registration.jsp              - Seller registration
│   ├── Seller_Dashboard.jsp          - Dashboard overview
│   ├── Seller_Product.jsp            - Add product form
│   ├── Seller_MyProducts.jsp         - Product management
│   ├── Seller_Product_Edit.jsp       - Edit product form
│   └── Orders.jsp                    - Order tracking
├── Order/
│   ├── Order_Details.jsp             - Order details view
│   └── Order_Confirmation.jsp        - Order confirmation
└── Admin/
    ├── Dashboard.jsp                 - Admin dashboard
    ├── All_Orders.jsp                - All orders management
    └── User_Management.jsp           - User management
```

## Installation & Setup

### Prerequisites
- JDK 11 or higher
- MySQL 8.0
- Apache Tomcat 9.0
- Maven 3.6+

### Steps
1. Clone repository
2. Create MySQL database
3. Configure `spring-servlet.xml` with database credentials
4. Update email credentials in `ServiceImpl.java`
5. Build: `mvn clean install`
6. Deploy to Tomcat
7. Access at `http://localhost:8080/Ceramic_B2B_Project`

## Email Configuration
Update these values in `ServiceImpl.java`:
```java
final String fromEmail = "your-email@gmail.com";
final String password = "your-app-password"; // Use Gmail App Password
```

## Future Enhancements
- Payment gateway integration (Razorpay/PayPal)
- Shopping cart functionality
- Product reviews and ratings
- Seller ratings
- Advanced product search and filtering
- Bulk order management
- Invoice generation
- Notification system (Email/SMS)
- Dashboard analytics
- Mobile app
- API documentation (Swagger)

## Security Considerations
- Implement password encryption (BCrypt)
- Add CSRF protection
- Input validation on all forms
- SQL injection prevention (use prepared statements)
- XSS protection
- HTTPS enforcement
- Rate limiting on OTP generation
- Session timeout

## Testing
- Unit tests for services
- Integration tests for DAOs
- Controller tests for endpoints
- End-to-end testing

## Contributors
- Harsh (Harsh8174)

## License
MIT License

---
**Last Updated**: September 15, 2026
