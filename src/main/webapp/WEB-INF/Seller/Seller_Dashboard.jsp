<%@page import="java.util.Map"%>
<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@page import="org.springframework.ui.ModelMap"%>
<%@page import="com.app.model.Seller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard – CeramicTile B2B Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Seller_Dashboard.css" >
</head>
<% HttpSession Session=(HttpSession) request.getSession(false);
    Seller Seller=(Seller)Session.getAttribute("Seller");
%>
<body>

    <!-- Common Header -->
    <jsp:include page="/WEB-INF/common/Header.jsp"/>

    <div class="dashboard-shell">

        <!-- ================= SIDEBAR ================= -->
        <aside class="sidebar">

            <div class="brand">Seller Menu</div>

            <nav>
                <a href="${pageContext.request.contextPath}/seller/dashboard" class="active">
                    <span class="ic">📊</span> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/seller/products">
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
                    <h1>Welcome back, <span id="sellerName"></span></h1>
                    <div class="sub" id="sellerCompany"></div>
                </div>

                <span class="status-pill pending" id="verificationPill">
                    <span class="dot"></span>
                    <span id="verificationText">Verification pending</span>
                </span>
            </div>


            <!-- ================= WELCOME / SETUP BANNER ================= -->
            <div class="welcome-banner" id="welcomeBanner">
                <div>
                    <h2>Your seller account was created successfully 🎉</h2>
                    <p>
                        Add your first product listing so buyers can discover
                        your tiles and start sending inquiries.
                    </p>
                </div>
                <button class="cta-btn" onclick="location.href = contextPath + '/seller/products/new'">
                    + Add Product
                </button>
            </div>


            <!-- ================= STATS ================= -->
            <div class="stats-grid">

                <div class="stat-card">
                    <div class="label">Total Products</div>
                    <div class="value" id="statProducts"></div>
                    <div class="delta flat" id="deltalisting">No listings yet</div>
                </div>

                <div class="stat-card">
                    <div class="label">Pending Orders</div>
                    <div class="value" id="statPendingOrders">0</div>
                    <div class="delta flat">—</div>
                </div>

                <div class="stat-card">
                    <div class="label">Buyer Inquiries</div>
                    <div class="value" id="statInquiries">0</div>
                    <div class="delta flat">—</div>
                </div>

                <div class="stat-card">
                    <div class="label">Total Revenue</div>
                    <div class="value" id="statRevenue">₹0</div>
                    <div class="delta flat">—</div>
                </div>

            </div>


            <!-- ================= PANELS ================= -->
            <div class="panel-row">

                <!-- RECENT ORDERS -->
                <div class="panel">
                    <div class="panel-head">
                        <h3>Recent Orders</h3>
                        <a href="${pageContext.request.contextPath}/seller/orders">View all</a>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Buyer</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody id="ordersTableBody">
                            <tr>
                                <td colspan="4" class="empty-row">
                                    No orders yet. Orders will show up here once buyers start purchasing.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>


                <!-- SETUP CHECKLIST -->
                <div class="panel">
                    <div class="panel-head">
                        <h3>Finish Setting Up</h3>
                    </div>

                    <ul class="todo-list" id="setupChecklist">

                        <li>
                            <span class="check done">✓</span>
                            <div class="text">
                                <div class="title">Create account</div>
                                <div class="desc">Personal & business details submitted</div>
                            </div>
                        </li>

                        <li>
                            <span class="check pending" id="checkEmailVerified">•</span>
                            <div class="text">
                                <div class="title">Verify company email</div>
                                <div class="desc">Confirms your business identity to buyers</div>
                            </div>
                        </li>

                        <li>
                            <span class="check pending" id="checkProductlisting" >•</span>
                            <div class="text">
                                <div class="title">Add your first product</div>
                                <div class="desc">Buyers can't find you without listings</div>
                            </div>
                        </li>

                        <li>
                            <span class="check pending">•</span>
                            <div class="text">
                                <div class="title">Add payment details</div>
                                <div class="desc">Needed before you can receive payouts</div>
                            </div>
                        </li>

                    </ul>
                </div>

            </div>

        </main>

    </div>


    <script>

        var contextPath = "${pageContext.request.contextPath}";
        // ---------------------------------------------------------------
        // This section renders values passed from the server after a
        // successful registration / on dashboard load. Replace this block
        // with real data — e.g. values rendered via JSTL/EL from the
        // logged-in seller's session, or fetched from a
        // GET /seller/dashboard-summary endpoint.
        // ---------------------------------------------------------------

        function renderSellerHeader(seller) {
            document.getElementById('sellerName').textContent = seller.name || 'Seller';
            document.getElementById('sellerCompany').textContent = seller.companyName || '';

            var pill = document.getElementById('verificationPill');
            var pillText = document.getElementById('verificationText');
            var checkEmail = document.getElementById('checkEmailVerified');
            var checklisting=document.getElementById('checkProductlisting') ; 
            if (seller.companyEmailVerified) {
                pill.classList.remove('pending');
                pill.classList.add('verified');
                pillText.textContent = 'Verified seller';
                checkEmail.classList.remove('pending');
                checkEmail.classList.add('done');
                checkEmail.textContent = '✓';
            } else {
                pill.classList.remove('verified');
                pill.classList.add('pending');
                pillText.textContent = 'Verification pending';
            }
            
            if(stats.productCount>0){
            	seller.checkProductlisting=true;
                checklisting.classList.remove('pending');
                checklisting.classList.add('done');
                checklisting.textContent = '✓';
            }else{
            	pill.classList.remove('verified');
                pill.classList.add('pending');
                pillText.textContent = 'Product Listing pending';
            }
        }

        function renderStats(stats) {
            document.getElementById('statProducts').textContent = stats.productCount || 0;
            document.getElementById('statPendingOrders').textContent = stats.pendingOrders || 0;
            document.getElementById('statInquiries').textContent = stats.inquiries || 0;
            document.getElementById('statRevenue').textContent = '₹' + (stats.revenue || 0).toLocaleString('en-IN');
        
            if(stats.productCount>0){
            	document.getElementById('deltalisting').textContent="Total Products";   
            }
        
        }

        function renderOrders(orders) {
            var tbody = document.getElementById('ordersTableBody');

            if (!orders || orders.length === 0) {
                return; // empty-row placeholder already in the markup
            }

            tbody.innerHTML = '';

            orders.forEach(function (order) {
                var statusClass = (order.status || '').toLowerCase();
                var row = document.createElement('tr');
                row.innerHTML =
                    '<td>#' + order.id + '</td>' +
                    '<td>' + order.buyerName + '</td>' +
                    '<td>₹' + order.amount.toLocaleString('en-IN') + '</td>' +
                    '<td><span class="order-status ' + statusClass + '">' + order.status + '</span></td>';
                tbody.appendChild(row);
            });
        }

        // Example wiring against a real backend summary endpoint:
        //
        // fetch(contextPath + '/seller/dashboard-summary')
        //     .then(function (res) { return res.json(); })
        //     .then(function (data) {
        //         renderSellerHeader(data.seller);
        //         renderStats(data.stats);
        //         renderOrders(data.recentOrders);
        //     })
        //     .catch(function () {
        //         // fall back to defaults already in the markup
        //     });

        // Placeholder data so the page is usable stand-alone during development:
        var seller={
                name: '${Seller.seller_name}',
                companyName: '${Seller.seller_company.company_name}',
                companyEmailVerified: true,
                checkProductlisting:false
            }
        	
        	
        var stats={
                productCount: '${total_products}',
                pendingOrders: 0,
                inquiries: 0,
                revenue: 0
            }
        renderSellerHeader(seller);
        renderStats(stats);
        
    </script>

</body>

</html>
