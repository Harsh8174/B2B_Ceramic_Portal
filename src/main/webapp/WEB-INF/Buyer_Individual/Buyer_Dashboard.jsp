<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.app.model.Product_Image"%>
<%@page import="com.app.model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"
    import="java.util.*" %>
<%
    // IMPORTANT: this JSP only *displays* whatever productList the servlet
    // sends it - it does not filter products by seller type itself.
    // Your servlet must do the actual filtering, e.g.:
    //
    //   SELECT p.* FROM product p
    //   JOIN seller s ON p.company_id = s.company_id
    //   WHERE (? = 'all' OR s.seller_type = ?)
    //     AND (? = '' OR p.product_category = ?)
    //     AND (? = '' OR p.product_name LIKE CONCAT('%', ?, '%'))
    //
    // using the sellerType/category/keyword request parameters this page
    // sends back via the GET form below. This page then just renders the
    // (already-filtered) result set plus the seller-type badge lookup.

    // Expecting the servlet to set these request attributes before forwarding here:
    //
    //   request.setAttribute("productList", someListOfProductObjects);
    //   request.setAttribute("sellerTypeByCompanyId", someMapOfCompanyIdToSellerType);
    //
    // Product and Seller are linked via a shared "company_id" foreign key
    // (both tables have company_id, no direct Product->Seller object
    // reference). So instead of joining entities, the servlet is expected
    // to build a simple lookup map:
    //
    //   Map<Integer, String> sellerTypeByCompanyId = new HashMap<>();
    //   for (Seller s : sellerList) {
    //       sellerTypeByCompanyId.put(s.getCompany_id(), s.getSeller_type());
    //   }
    //   request.setAttribute("sellerTypeByCompanyId", sellerTypeByCompanyId);
    //
    // This JSP then looks up each product's seller type via
    // product.getCompany_id() against that map - see the loop below.
    //
    // Each product object is your Product entity, exposed via
    // Eclipse-style getters matching the field names exactly
    // (getProduct_id(), getProduct_name(), ...) - used through
    // scriptlet calls below, NOT JSTL/EL. This assumes Product also
    // has a "company_id" column/field (getCompany_id()) - add it if
    // it isn't already there, since the filter needs it to tie a
    // product back to its seller's type.
    //
    // NOTE: there is still no image column on Product, so a placeholder
    // image path is used below - swap in your real field/logic once
    // you add one.
    //
    // Filter values (sellerType, category, keyword) are read back from
    // request.getParameter(...) so the current filter state can be
    // re-selected in the form after the page reloads.

    List productList = (List) request.getAttribute("productList");
    Map sellerTypeByCompanyId = (Map) request.getAttribute("sellerTypeByCompanyId");
    if (sellerTypeByCompanyId == null) {
        sellerTypeByCompanyId = new HashMap();
    }

    String selectedSellerType = request.getParameter("sellerType");
    if (selectedSellerType == null || selectedSellerType.trim().isEmpty()) {
        selectedSellerType = "all";
    }

    String selectedCategory = request.getParameter("category");
    if (selectedCategory == null) selectedCategory = "";

    String keyword = request.getParameter("keyword");
    if (keyword == null) keyword = "";

    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>CeramicTile B2B Portal – Browse Products</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Buyer_Dashboard.css" />

</head>
<body>

  <header>
    <div class="container">
      <nav class="nav">
        <a href="<%= ctx %>/" class="logo">Ceramic<span>Tile</span> B2B</a>
        
        <div>
          <a href="<%= ctx %>/orders" class="btn btn-outline">My Orders</a>
          <a href="<%= ctx %>/logout" class="btn btn-primary">Logout</a>
        </div>
      </nav>
    </div>
  </header>

  <div class="container">

    <div class="page-heading">
      <h1 class="page-title">Browse Products</h1>
      <p class="page-subtitle">Find ceramic tiles from verified traders, distributors, retailers, and manufacturers.</p>
    </div>

    <!-- FILTER BAR -->
    <div class="filter-bar">
      <!--
        Plain GET form: on submit, the browser itself builds the URL
        query string (?sellerType=...&category=...&keyword=...) and
        reloads this same JSP with those params. No fetch/AJAX, no JSON -
        the server reads everything back via request.getParameter(...).
      -->
      <form action="<%= ctx %>/buyer/individual/products" method="get" id="filterForm">

        <div class="seller-type-group">
          <label>Seller Type</label>
          <div class="seller-type-options">

            <input type="radio" id="sellerAll" name="sellerType" value="all"
                   <%= "all".equals(selectedSellerType) ? "checked" : "" %> />
            <label class="pill" for="sellerAll">All Sellers</label>

            <input type="radio" id="sellerTrader" name="sellerType" value="trader"
                   <%= "trader".equals(selectedSellerType) ? "checked" : "" %> />
            <label class="pill" for="sellerTrader">Trader</label>

            <input type="radio" id="sellerDistributor" name="sellerType" value="distributor"
                   <%= "distributor".equals(selectedSellerType) ? "checked" : "" %> />
            <label class="pill" for="sellerDistributor">Distributor</label>

            <input type="radio" id="sellerRetailer" name="sellerType" value="retailer"
                   <%= "retailer".equals(selectedSellerType) ? "checked" : "" %> />
            <label class="pill" for="sellerRetailer">Retailer</label>

            <input type="radio" id="sellerManufacturer" name="sellerType" value="manufacturer"
                   <%= "manufacturer".equals(selectedSellerType) ? "checked" : "" %> />
            <label class="pill" for="sellerManufacturer">Manufacturer</label>

          </div>
        </div>

        <div class="filter-group">
          <label for="category">Category</label>
          <select id="category" name="product_category">
            <option value="" <%= selectedCategory.isEmpty() ? "selected" : "" %>>All Categories</option>
            <option value="floor" <%= "floor".equals(selectedCategory) ? "selected" : "" %>>Floor Tiles</option>
            <option value="wall" <%= "wall".equals(selectedCategory) ? "selected" : "" %>>Wall Tiles</option>
            <option value="outdoor" <%= "outdoor".equals(selectedCategory) ? "selected" : "" %>>Outdoor Tiles</option>
            <option value="bathroom"<%= "bathroom".equals(selectedCategory) ? "selected" : "" %>>Bathroom Tiles</option>
            <option value="kitchen"<%= "kitchen".equals(selectedCategory) ? "selected" : "" %>>Kitchen Tiles</option>
            <option value="mosaic"<%= "mosaic".equals(selectedCategory) ? "selected" : "" %>>Mosaic Tiles</option>
          </select>
        </div>

        <div class="filter-group">
          <label for="material">Material</label>
          <select id="material" name="product_material" required>
          <option value="">Select material</option>
          <option value="ceramic">Ceramic</option>
          <option value="vitrified">Vitrified</option>
          <option value="porcelain">Porcelain</option>
          <option value="marble">Marble Look</option>
          <option value="granite">Granite Look</option>
          </select>
        </div>

         <div class="filter-group">
          <label for="size">Size (mm)</label>
          <input type="text" id="size" name="product_size" placeholder="e.g. 600x600" required>
          </div> 
         
         <div class="filter-group">
         <label for="thickness">Thickness (mm)</label>
         <input type="number" id="thickness" name="product_thickness" min="0" step="0.1" placeholder="e.g. 8">
         </div>
         
         <div class="filter-group">
         <label for="finish">Finish</label>
         <select id="finish" name="product_finish" required>
         <option value="">Select finish</option>
         <option value="glossy">Glossy</option>
         <option value="matte">Matte</option>
         <option value="textured">Textured</option>
         <option value="polished">Polished</option>
         </select>
         </div>
         
          <div class="filter-group">
            <label for="piecesPerBox">Pieces per Box</label>
            <input type="number" id="piecesPerBox" name="product_pieces_per_box" min="1" placeholder="e.g. 4">
          </div>
         
         <div class="filter-group">
         <label for="coverageAreaPerBox">Coverage per Box (sq.ft)</label>
         <input type="number" id="coverageAreaPerBox" name="product_coverage_area"
                                min="0" step="0.01" placeholder="e.g. 15.5">
         </div>
         
         <div class="filter-group">
         <label for="price">Price</label>
           <div class="input-suffix-row">
           <input type="number" id="price" name="product_price" min="0" step="0.01"
                                    placeholder="e.g. 45.00" required>
           <select id="priceUnit" name="product_price_unit" required>
           <option value="per_sqft">per sq.ft</option>
           <option value="per_box">per box</option>
           <option value="per_piece">per piece</option>
           </select>
         
         </div>
         </div>
         
        <div class="filter-actions">
          <button type="submit" class="btn btn-primary">Apply Filters</button>
          <a href="<%= ctx %>/products" class="btn btn-outline">Reset</a>
        </div>

      </form>
    </div>

    <!-- PRODUCT GRID -->
    <section class="product-section">

      <p class="results-meta">
        <%
            if (productList != null && !productList.isEmpty()) {
        %>
                Showing <%= productList.size() %> product(s)
                <% if (!"all".equals(selectedSellerType)) { %>
                    from <strong><%= selectedSellerType %></strong>
                <% } %>
        <%
            } else {
        %>
                No products found.
        <%
            }
        %>
      </p>

      <%
          if (productList != null && !productList.isEmpty()) {
      %>
          <div class="product-grid">
          <%
              for (int i = 0; i < productList.size(); i++) {

                  Product p= (Product) productList.get(i);

                  // Look up this product's seller type via the shared
                  // company_id, using the map the servlet built from the
                  // Seller table. Falls back to "seller" if not found.
                  Object sellerTypeObj = sellerTypeByCompanyId.get(p.getCompany().getSeller().getSeller_type());
                  String sellerType = (sellerTypeObj != null) ? sellerTypeObj.toString() : "seller";
                  List<Product_Image> product_img=p.getProduct_image_name();
                  Iterator<Product_Image> itr=product_img.iterator();
                  Product_Image pro_img=null;
                  while(itr.hasNext()){
                	  pro_img=itr.next();
                  }
                  // No image column on Product yet - placeholder path.
                  // Swap in a real field (or a join to a Seller/Product
                  // image table) once available.
                  String imagePath = "Seller_upload_images/"+pro_img.getProduct_image_name();
          %>
              <div class="product-card">
                <div class="product-image">
                  <img src="<%= ctx %>/<%= imagePath %>" alt="<%= p.getProduct_name() %>" />
                  <span class="seller-badge"><%= sellerType %></span>
                </div>
                <div class="product-content">
                  <div class="product-name"><%= p.getProduct_name() %></div>
                  <div class="product-category"><%= p.getProduct_category() %></div>

                  <div class="product-specs">
                    <span><%= p.getProduct_material() %></span>
                    <span>&bull;</span>
                    <span><%= p.getProduct_size() %></span>
                    <span>&bull;</span>
                    <span><%= p.getProduct_thickness() %></span>
                  </div>

                  <div class="product-finish">Finish: <%= p.getProduct_finish() %></div>

                  <div class="product-desc"><%= p.getProduct_description() %></div>

                  <div class="product-price">
                    &#8377;<%= p.getProduct_price() %> / <%= p.getProduct_price_unit() %>
                  </div>

                  <div class="product-moq">
                    MOQ: <%= p.getProduct_minimum_order() %> <%= p.getProduct_minimum_order_unit() %>
                  </div>

                  <div class="product-meta">
                    <span><%= p.getProduct_pieces_per_box() %> pcs/box</span>
                    <span>&bull;</span>
                    <span><%= p.getProduct_coverage_area() %> sq.ft coverage</span>
                  </div>

                  <div class="product-stock <%= p.getProduct_available_stock() > 0 ? "" : "out-of-stock" %>">
                    <%= p.getProduct_available_stock() > 0
                          ? p.getProduct_available_stock() + " units in stock"
                          : "Out of stock" %>
                  </div>

                  <div class="product-actions">
                    <!-- ORDER: plain GET carrying product_id as a URL param -->
                    <form action="<%= ctx %>/order" method="get">
                      <input type="hidden" name="productId" value="<%= p.getProduct_id() %>" />
                      <button type="submit" class="btn btn-primary btn-full"
                              <%= p.getProduct_available_stock() > 0 ? "" : "disabled" %>>
                        Order
                      </button>
                    </form>

                    <!-- ENQUIRY: plain GET carrying product_id as a URL param -->
                    <form action="<%= ctx %>/enquiry" method="get">
                      <input type="hidden" name="productId" value="<%= p.getProduct_id() %>" />
                      <button type="submit" class="btn btn-outline btn-full">Enquire</button>
                    </form>
                  </div>
                </div>
              </div>
          <%
              }
          %>
          </div>
      <%
          } else {
      %>
          <div class="empty-state">
            No products match your filters. Try adjusting the seller type or category.
          </div>
      <%
          }
      %>

    </section>

  </div>

  <script>
    // No JSON / AJAX anywhere. All filter state travels as plain URL
    // query params via the standard GET form submit above. This script
    // only handles optional cosmetic behavior that doesn't need any
    // server round-trip logic of its own.

    // Uncomment to auto-submit the filter form the moment a seller-type
    // pill or the category dropdown changes, instead of waiting for the
    // "Apply Filters" button:
    //
    // document.querySelectorAll('input[name="sellerType"]').forEach(function (radio) {
    //   radio.addEventListener('change', function () {
    //     document.getElementById('filterForm').submit();
    //   });
    // });
    //
    // document.getElementById('category').addEventListener('change', function () {
    //   document.getElementById('filterForm').submit();
    // });
    
    
    document.getElementById("filterForm").addEventListener("submit", function(event) {

    const sellerType = document.querySelector('input[name="sellerType"]:checked')?.value;
    const category = document.getElementById("category").value;
    const material = document.getElementById("material").value;
    const size = document.getElementById("size").value;
    const thickness = document.getElementById("thickness").value;
    const finish = document.getElementById("finish").value;
    const piecesPerBox = document.getElementById("piecesPerBox").value;
    const coverageAreaPerBox = document.getElementById("coverageAreaPerBox").value;
    const price = document.getElementById("price").value;
    const priceUnit = document.getElementById("priceUnit").value;
    
    console.log("Seller Type:", sellerType);
    console.log("Category:", category);
    console.log("Material:", material);
    console.log("Size:", size);
    console.log("Thickness:", thickness);
    console.log("Finish:", finish);
    console.log("Pieces per Box:", piecesPerBox);
    console.log("Coverage Area:", coverageAreaPerBox);
    console.log("Price:", price);
    console.log("Price Unit:", priceUnit);

});
  </script>

</body>
</html>
