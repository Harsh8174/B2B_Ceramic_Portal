<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.app.model.Product_Image"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"
    import="java.util.List, com.app.model.Product"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Products – CeramicTile B2B Portal</title>

  <link rel="stylesheet"  href="${pageContext.request.contextPath}/CSS/Seller_MyProduct.css" />

</head>


<body>

    <!-- Common Header -->
    <jsp:include page="/WEB-INF/common/Header.jsp"/>

    <div class="dashboard-shell">

        <!-- ================= SIDEBAR ================= -->
        <aside class="sidebar">

            <div class="brand">Seller Menu</div>

            <nav>
                <a href="${pageContext.request.contextPath}/seller/dashboard">
                    <span class="ic">📊</span> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/seller/products" class="active">
                    <span class="ic">🧱</span> My Products
                </a>
                <a href="${pageContext.request.contextPath}/seller/orders">
                    <span class="ic">📦</span> Orders
                </a>
                <a href="${pageContext.request.contextPath}/seller/inquiries">
                    <span class="ic">💬</span> Buyer Inquiries
                </a>
                <a href="${pageContext.request.contextPath}/seller/payments">
                    <span class="ic">💳</span> Payments
                </a>

                <div class="divider"></div>

                <a href="${pageContext.request.contextPath}/seller/profile">
                    <span class="ic">🏢</span> Company Profile
                </a>
                <a href="${pageContext.request.contextPath}/seller/settings">
                    <span class="ic">⚙️</span> Settings
                </a>
                <a href="${pageContext.request.contextPath}/logout">
                    <span class="ic">🚪</span> Logout
                </a>
            </nav>

        </aside>


        <!-- ================= MAIN ================= -->
        <main class="main">

            <div class="topbar">
                <div>
                    <h1>My Products</h1>
                    <div class="sub">Manage the tile listings buyers can see.</div>
                </div>
                <a href="${pageContext.request.contextPath}/seller/products/new" class="btn btn-primary">
                    + Add Product
                </a>
            </div>

            <div class="stats-strip">
                <div class="stat"><strong id="statTotal">0</strong>Total</div>
                <div class="stat"><strong id="statLowStock">0</strong>Low Stock</div>
            </div>

            <!--
                Filtering happens entirely client-side in JS against the cards
                already rendered below (no fetch, no JSON). The current filter
                values are also reflected in the URL as query params
                (?search=&category=&status=) purely for bookmarking / sharing —
                changing them does NOT reload the page.
            -->
            <div class="filter-bar">
                <input type="text" id="searchInput" placeholder="Search by product name...">

                <select id="categoryFilter">
                    <option value="">All Categories</option>
                    <option value="floor">Floor Tiles</option>
                    <option value="wall">Wall Tiles</option>
                    <option value="bathroom">Bathroom Tiles</option>
                    <option value="kitchen">Kitchen Tiles</option>
                    <option value="outdoor">Outdoor / Parking Tiles</option>
                    <option value="mosaic">Mosaic Tiles</option>
                </select>
            </div>


            <%--
                productList: request attribute set by the controller, e.g.
                request.setAttribute("productList", services.getProductsForSeller(seller));
                or model.addAttribute("productList", ...) in a Spring MVC controller
                (Spring copies Model attributes into request attributes automatically).

                Adjust the getter calls below (getProduct_name(), etc.) to match
                your actual Product.java field/getter names.
            --%>
            <%
                List<Product> productList = (List<Product>) request.getAttribute("productList");
                if (productList == null) {
                    productList = new java.util.ArrayList<Product>();
                }
            %>

            <div class="product-grid" id="productGrid">

                <%
                    for (Product p : productList) {
                        String name = p.getProduct_name();
                        String category = p.getProduct_category();
                        String material = p.getProduct_material();
                        String size = p.getProduct_size();
                        String finish = p.getProduct_finish();
                        double price = p.getProduct_price();
                        String priceUnit = p.getProduct_price_unit();
                        int stockQty = p.getProduct_available_stock();
                        int minOrderQty = p.getProduct_minimum_order();
                        String minOrderUnit = p.getProduct_minimum_order_unit();
                        boolean isLowStock = stockQty < minOrderQty;
                        List<Product_Image> product_image_name=p.getProduct_image_name();
                        Product_Image img =   product_image_name.get(0);
                        String img_name = img.getProduct_image_name(); 
                        String nameLower = name == null ? "" : name.toLowerCase();
                          System.out.println(img_name);
                %>

                    <div class="product-card"
                         data-name="<%= nameLower %>"
                         data-category="<%= category %>">

                        <div class="thumb">
                            <span class="placeholder"><img id="card_img" src="<%= request.getContextPath() %>/Seller_upload_images/<%= img_name %>" /></span>
                        </div>

                        <div class="body">
                            <div class="name"><%= name %></div>
                            <div class="meta"><%= category %> &middot; <%= material %> &middot; <%= size %>mm &middot; <%= finish %></div>

                            <div class="price-row">
                                <span class="price">
                                    &#8377;<%= String.format("%,.2f", price) %>
                                    <span class="unit">/ <%= priceUnit %></span>
                                </span>
                            </div>

                            <div class="meta">MOQ: <%= minOrderQty %> <%= minOrderUnit %></div>

                            <div class="stock <%= isLowStock ? "low" : "" %>">
                                <%= isLowStock ? "&#9888; Low stock: " : "Stock: " %><%= stockQty %>
                            </div>

                            <div class="card-actions">
                                <a class="edit-btn"
                                   href="${pageContext.request.contextPath}/seller/products/edit?id=<%= p.getProduct_id() %>">
                                    Edit
                                </a>
                                <a class="delete-btn"
                                   href="${pageContext.request.contextPath}/seller/products/delete?id=<%= p.getProduct_id() %>"
                                   onclick="return confirm('Delete this product? This can\'t be undone.');">
                                    Delete
                                </a>
                            </div>
                        </div>

                    </div>

                <% } %>

            </div>

            <div class="empty-state hidden" id="emptyState">
                <div class="icon">🧱</div>
                <h3 id="emptyTitle">No products yet</h3>
                <p id="emptyDesc">Add your first tile listing so buyers can start discovering it.</p>
                <a href="${pageContext.request.contextPath}/seller/products/new" class="btn btn-primary" id="emptyCta">
                    + Add Your First Product
                </a>
            </div>

        </main>

    </div>


    <script>

        var contextPath = "${pageContext.request.contextPath}";
        console.log(contextPath);
        var allCards = Array.prototype.slice.call(document.querySelectorAll('.product-card'));
        var totalProductCount = allCards.length;

        // ---------------- read current filters from the URL on page load ----------------
        function getQueryParam(name) {
            var params = new URLSearchParams(window.location.search);
           // console.log(params.get(name));
            return params.get(name) || '';
        }

        document.getElementById('searchInput').value = getQueryParam('search');
        console.log(document.getElementById('searchInput').value);
        document.getElementById('categoryFilter').value = getQueryParam('category');
        console.log(document.getElementById('categoryFilter').value);

        // ---------------- apply filters against the already-rendered cards ----------------
        function applyFilters() {
            var search = document.getElementById('searchInput').value.trim().toLowerCase();
            var category = document.getElementById('categoryFilter').value;

            var visibleCount = 0;

            allCards.forEach(function (card) {
                var matchesSearch = !search || card.getAttribute('data-name').indexOf(search) !== -1;
                var matchesCategory = !category || card.getAttribute('data-category') === category;

                var visible = matchesSearch && matchesCategory;
                card.classList.toggle('hidden', !visible);

                if (visible) visibleCount++;
            });

            updateStats();
            updateEmptyState(visibleCount);
            reflectFiltersInUrl(search, category);
        }

        // ---------------- keep the URL in sync as query params, no reload ----------------
        function reflectFiltersInUrl(search, category) {
            var params = new URLSearchParams();
            if (search) params.set('search', search);
            if (category) params.set('category', category);

            var newUrl = window.location.pathname + (params.toString() ? '?' + params.toString() : '');
            window.history.replaceState(null, '', newUrl);
        }

        // ---------------- stats strip, computed from the DOM ----------------
        function updateStats() {
            var lowStock = allCards.filter(function (c) {
                return c.querySelector('.stock').classList.contains('low');
            }).length;

            document.getElementById('statTotal').textContent = totalProductCount;
            document.getElementById('statLowStock').textContent = lowStock;
        }

        // ---------------- empty state toggling ----------------
        function updateEmptyState(visibleCount) {
            var grid = document.getElementById('productGrid');
            var emptyState = document.getElementById('emptyState');
            var emptyTitle = document.getElementById('emptyTitle');
            var emptyDesc = document.getElementById('emptyDesc');
            var emptyCta = document.getElementById('emptyCta');

            if (totalProductCount === 0) {
                grid.style.display = 'none';
                emptyState.classList.remove('hidden');
                emptyTitle.textContent = 'No products yet';
                emptyDesc.textContent = 'Add your first tile listing so buyers can start discovering it.';
                emptyCta.textContent = '+ Add Your First Product';
                emptyCta.href = contextPath + '/seller/products/new';
                return;
            }

            if (visibleCount === 0) {
                grid.style.display = 'grid';
                emptyState.classList.remove('hidden');
                emptyTitle.textContent = 'No products match your filters';
                emptyDesc.textContent = 'Try adjusting your search or filters.';
                emptyCta.textContent = 'Clear Filters';
                emptyCta.href = contextPath + '/seller/products';
            } else {
                emptyState.classList.add('hidden');
                grid.style.display = 'grid';
            }
        }

        document.getElementById('searchInput').addEventListener('input', applyFilters);
        document.getElementById('categoryFilter').addEventListener('change', applyFilters);

        // initial render
       applyFilters();

    </script>

</body>

</html>
