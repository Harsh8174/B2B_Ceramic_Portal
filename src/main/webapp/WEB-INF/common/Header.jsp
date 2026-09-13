<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<style>
/* ================= HEADER ================= */

        header {
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 16px;
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
            align-items: center;
            gap: 24px;
            list-style: none;
        }

        .nav-links a {
            font-size: 14px;
            color: #374151;
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
            cursor: pointer;
            border: none;
        }

        .btn-outline {
            background: #ffffff;
            color: #2563eb !important;
            border: 1px solid #2563eb;
        }

        .btn-primary {
            background: #2563eb;
            color: #ffffff !important;
        }


</style>
</head>
<body>
     <!-- ================= HEADER ================= -->

    <header>

        <div class="container">

            <nav class="nav">

                <a href="${pageContext.request.contextPath}/home" class="logo">
                    Ceramic<span>Tile</span> B2B
                </a>

                <ul class="nav-links">

                    <li>
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/products">Products</a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/categories">Categories</a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/aboutus">About Us</a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/contact">Contact</a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/login"
                           class="btn btn-outline">
                            Login
                        </a>
                    </li>

                </ul>

            </nav>

        </div>

    </header>
    
