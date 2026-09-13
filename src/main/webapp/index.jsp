<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>CeramicTile B2B Portal – Home</title>
  <style>
    /* ====== RESET & BASE ====== */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
      line-height: 1.5;
      color: #1f2937;
      background: #ffffff;
    }

    a {
      text-decoration: none;
      color: inherit;
    }

    ul {
      list-style: none;
    }

    img {
      max-width: 100%;
      display: block;
    }

    .container {
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 16px;
    }

    /* ====== HEADER & NAV ====== */
    header {
      position: sticky;
      top: 0;
      z-index: 50;
      background: #ffffff;
      border-bottom: 1px solid #e5e7eb;
    }

    .nav {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 14px 0;
    }

    .logo {
      font-size: 20px;
      font-weight: 700;
      color: #111827;
    }

    .logo span {
      color: #2563eb;
    }

    .nav-links {
      display: flex;
      gap: 24px;
      align-items: center;
    }

    .nav-links a {
      font-size: 14px;
      color: #374151;
      transition: color 0.2s ease;
    }

    .nav-links a:hover {
      color: #2563eb;
    }

    .btn {
      display: inline-block;
      padding: 10px 18px;
      border-radius: 6px;
      font-size: 14px;
      font-weight: 600;
      text-align: center;
      transition: background 0.2s ease, transform 0.1s ease;
      cursor: pointer;
      border: none;
    }

    .btn-primary {
      background: #2563eb;
      color: #ffffff;
    }

    .btn-primary:hover {
      background: #1d4ed8;
    }

    .btn-outline {
      background: #ffffff;
      color: #2563eb;
      border: 1px solid #2563eb;
    }

    .btn-outline:hover {
      background: #eff6ff;
    }

    .mobile-menu-btn {
      display: none;
      background: transparent;
      border: none;
      font-size: 24px;
      color: #111827;
      cursor: pointer;
    }

    /* ====== HERO SECTION ====== */
    .hero {
      background: linear-gradient(135deg, #eff6ff, #ffffff);
      padding: 64px 0 48px;
    }

    .hero-grid {
      display: grid;
      grid-template-columns: 1.1fr 0.9fr;
      gap: 40px;
      align-items: center;
    }

    .hero-title {
      font-size: 36px;
      font-weight: 800;
      line-height: 1.2;
      color: #111827;
      margin-bottom: 16px;
    }

    .hero-subtitle {
      font-size: 16px;
      color: #4b5563;
      margin-bottom: 24px;
    }

    .hero-cta {
      display: flex;
      gap: 12px;
      flex-wrap: wrap;
    }

    .hero-image {
  width: 100%;
  height: 260px;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 10px 25px rgba(0,0,0,0.08);
  background: #e5e7eb;
}

.hero-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
  display: block;
}

    /* ====== CATEGORIES ====== */
    .categories {
      padding: 56px 0;
    }

    .section-title {
      font-size: 26px;
      font-weight: 700;
      color: #111827;
      margin-bottom: 12px;
    }

    .section-subtitle {
      font-size: 15px;
      color: #6b7280;
      margin-bottom: 28px;
    }

    .category-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
    }

    .category-card {
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  background: #ffffff;

  display: flex;
  flex-direction: column;
}

    .category-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.06);
    }

   .category-image {
  width: 100%;
  height: 140px;
  overflow: hidden;
  background: #f3f4f6;
}

.category-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
  display: block;
}

    .category-content {
  padding: 16px;
  flex: 1;
}

    .category-name {
      font-size: 16px;
      font-weight: 600;
      color: #111827;
      margin-bottom: 6px;
    }

    .category-desc {
      font-size: 13px;
      color: #6b7280;
    }

    /* ====== WHY CHOOSE US ====== */
    .why-us {
      background: #f9fafb;
      padding: 56px 0;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
    }

    .feature-card {
      background: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 10px;
      padding: 20px;
    }

    .feature-icon {
      width: 40px;
      height: 40px;
      border-radius: 8px;
      background: #eff6ff;
      color: #2563eb;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      margin-bottom: 12px;
    }

    .feature-title {
      font-size: 16px;
      font-weight: 600;
      color: #111827;
      margin-bottom: 6px;
    }

    .feature-desc {
      font-size: 14px;
      color: #6b7280;
    }

    /* ====== STATS ====== */
    .stats {
      padding: 56px 0;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      text-align: center;
    }

    .stat-item {
      padding: 20px 10px;
      border: 1px solid #e5e7eb;
      border-radius: 10px;
    }

    .stat-value {
      font-size: 28px;
      font-weight: 700;
      color: #111827;
      margin-bottom: 6px;
    }

    .stat-label {
      font-size: 14px;
      color: #6b7280;
    }

    /* ====== CTA ====== */
    .cta {
      background: #1d4ed8;
      color: #ffffff;
      padding: 48px 0;
    }

    .cta-grid {
      display: grid;
      grid-template-columns: 1.2fr 0.8fr;
      gap: 24px;
      align-items: center;
    }

    .cta-title {
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 8px;
    }

    .cta-desc {
      font-size: 14px;
      color: #dbeafe;
      margin-bottom: 16px;
    }

    .btn-white {
      background: #ffffff;
      color: #1d4ed8;
    }

    .btn-white:hover {
      background: #f3f4f6;
    }

    /* ====== FOOTER ====== */
    footer {
      border-top: 1px solid #e5e7eb;
      padding: 40px 0 24px;
      background: #ffffff;
    }

    .footer-grid {
      display: grid;
      grid-template-columns: 1.2fr repeat(3, 1fr);
      gap: 24px;
      margin-bottom: 24px;
    }

    .footer-title {
      font-size: 15px;
      font-weight: 600;
      color: #111827;
      margin-bottom: 10px;
    }

    .footer-links li {
      margin-bottom: 6px;
    }

    .footer-links a {
      font-size: 14px;
      color: #4b5563;
    }

    .footer-links a:hover {
      color: #2563eb;
    }

    .footer-bottom {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 13px;
      color: #6b7280;
      border-top: 1px solid #e5e7eb;
      padding-top: 16px;
    }

    /* ====== RESPONSIVE ====== */
    @media (max-width: 900px) {
      .hero-grid,
      .cta-grid,
      .footer-grid {
        grid-template-columns: 1fr;
      }

      .category-grid,
      .features-grid {
        grid-template-columns: repeat(2, 1fr);
      }

      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }

    @media (max-width: 640px) {
      .nav-links {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background: #ffffff;
        border-bottom: 1px solid #e5e7eb;
        flex-direction: column;
        padding: 12px 16px;
        gap: 12px;
      }

      .nav-links.open {
        display: flex;
      }

      .mobile-menu-btn {
        display: block;
      }

      .hero-title {
        font-size: 28px;
      }

      .category-grid,
      .features-grid {
        grid-template-columns: 1fr;
      }

      .stats-grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>

  <!-- HEADER -->
  <header>
    <div class="container">
      <nav class="nav">
        <a href="index.html" class="logo">Ceramic<span>Tile</span> B2B</a>

        <button class="mobile-menu-btn" id="mobileMenuBtn" aria-label="Toggle menu">
          ☰
        </button>

        <ul class="nav-links" id="navLinks">
          <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
          <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
          <li><a href="${pageContext.request.contextPath}/categories">Categories</a></li>
          <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
          <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
          <li><a href="${pageContext.request.contextPath}/login" class="btn btn-outline">Login</a></li>
          <li><a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <!-- HERO -->
  <section class="hero">
    <div class="container">
      <div class="hero-grid">
        <div>
          <h1 class="hero-title">
            Your Trusted B2B Portal for Premium Ceramic Tiles
          </h1>
          <p class="hero-subtitle">
            Connect directly with verified manufacturers and wholesalers. Browse thousands of ceramic tile designs, compare prices, and place bulk orders with confidence.
          </p>
          <div class="hero-cta">
            <a href="products.html" class="btn btn-primary">Browse Products</a>
            <a href="register.html" class="btn btn-outline">Become a Seller</a>
          </div>
        </div>
        <div class="hero-image">
          <!-- Replace with your real image later -->
          <img  src="images/Hero_Image3.jpg"/>
        </div>
      </div>
    </div>
  </section>

  <!-- CATEGORIES -->
  <section class="categories">
    <div class="container">
      <h2 class="section-title">Popular Tile Categories</h2>
      <p class="section-subtitle">
        Explore our most in-demand ceramic tile categories for residential and commercial projects.
      </p>

      <div class="category-grid">
        <!-- Category 1 -->
        <a href="category.html?id=floor" class="category-card">
          <div class="category-image">
            <img  src="images/Floor_Tiles_Image1.jpg">
          </div>
          <div class="category-content">
            <div class="category-name">Floor Tiles</div>
            <div class="category-desc">
              Durable ceramic floor tiles for homes, offices, and retail spaces.
            </div>
          </div>
        </a>

        <!-- Category 2 -->
        <a href="category.html?id=wall" class="category-card">
          <div class="category-image">
           <img src="images/Wall_Image2.png">
          </div>
          <div class="category-content">
            <div class="category-name">Wall Tiles</div>
            <div class="category-desc">
              Decorative wall tiles for kitchens, bathrooms, and feature walls.
            </div>
          </div>
        </a>

        <!-- Category 3 -->
        <a href="category.html?id=outdoor" class="category-card">
          <div class="category-image">
            <img  src="images/Outdoortiles_Image1.jpg">
          </div>
          <div class="category-content">
            <div class="category-name">Outdoor Tiles</div>
            <div class="category-desc">
              Weather-resistant tiles for patios, balconies, and facades.
            </div>
          </div>
        </a>
      </div>
    </div>
  </section>

  <!-- WHY CHOOSE US -->
  <section class="why-us">
    <div class="container">
      <h2 class="section-title">Why Choose Our B2B Portal?</h2>
      <p class="section-subtitle">
        Built specifically for tile distributors, retailers, and project contractors.
      </p>

      <div class="features-grid">
        <div class="feature-card">
          <div class="feature-icon">V</div>
          <div class="feature-title">Verified Suppliers</div>
          <div class="feature-desc">
            All manufacturers and wholesalers are verified for quality and reliability.
          </div>
        </div>

        <div class="feature-card">
          <div class="feature-icon">P</div>
          <div class="feature-title">Transparent Pricing</div>
          <div class="feature-desc">
            See bulk prices, MOQs, and shipping terms directly from suppliers.
          </div>
        </div>

        <div class="feature-card">
          <div class="feature-icon">S</div>
          <div class="feature-title">Secure Transactions</div>
          <div class="feature-desc">
            Safe payment options and order tracking for every B2B transaction.
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- STATS -->
  <section class="stats">
    <div class="container">
      <div class="stats-grid">
        <div class="stat-item">
          <div class="stat-value">500+</div>
          <div class="stat-label">Verified Suppliers</div>
        </div>
        <div class="stat-item">
          <div class="stat-value">10,000+</div>
          <div class="stat-label">Tile Products</div>
        </div>
        <div class="stat-item">
          <div class="stat-value">50+</div>
          <div class="stat-label">Countries Served</div>
        </div>
        <div class="stat-item">
          <div class="stat-value">24/7</div>
          <div class="stat-label">Support</div>
        </div>
      </div>
    </div>
  </section>

  <!-- CTA -->
  <section class="cta">
    <div class="container">
      <div class="cta-grid">
        <div>
          <h2 class="cta-title">Ready to Source Ceramic Tiles at Wholesale?</h2>
          <p class="cta-desc">
            Join thousands of retailers and contractors who trust our B2B portal for their tile procurement.
          </p>
          <a href="register.html" class="btn btn-white">Create Free Account</a>
        </div>
        <div>
          <!-- Optional: small illustration or trust badges -->
        </div>
      </div>
    </div>
  </section>

  <!-- FOOTER -->
  <footer>
    <div class="container">
      <div class="footer-grid">
        <div>
          <div class="logo" style="margin-bottom: 8px;">
            Ceramic<span>Tile</span> B2B
          </div>
          <p style="font-size: 14px; color: #6b7280;">
            The dedicated B2B marketplace for ceramic tiles, connecting buyers and suppliers worldwide.
          </p>
        </div>

        <div>
          <div class="footer-title">Marketplace</div>
          <ul class="footer-links">
            <li><a href="products.html">All Products</a></li>
            <li><a href="categories.html">Categories</a></li>
            <li><a href="suppliers.html">Suppliers</a></li>
          </ul>
        </div>

        <div>
          <div class="footer-title">Company</div>
          <ul class="footer-links">
            <li><a href="about.html">About Us</a></li>
            <li><a href="contact.html">Contact</a></li>
            <li><a href="terms.html">Terms & Conditions</a></li>
          </ul>
        </div>

        <div>
          <div class="footer-title">Support</div>
          <ul class="footer-links">
            <li><a href="help.html">Help Center</a></li>
            <li><a href="faq.html">FAQ</a></li>
            <li><a href="privacy.html">Privacy Policy</a></li>
          </ul>
        </div>
      </div>

      <div class="footer-bottom">
        <div>© 2026 CeramicTile B2B Portal. All rights reserved.</div>
        <div>Built with HTML, CSS, JavaScript</div>
      </div>
    </div>
  </footer>

  <script>
    // Mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const navLinks = document.getElementById('navLinks');

    mobileMenuBtn.addEventListener('click', () => {
      navLinks.classList.toggle('open');
    });

    // Optional: close menu when a link is clicked (mobile)
    navLinks.addEventListener('click', (e) => {
      if (e.target.tagName === 'A' && window.innerWidth <= 640) {
        navLinks.classList.remove('open');
      }
    });
  </script>
</body>
</html>