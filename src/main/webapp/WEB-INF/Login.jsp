<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - CeramicTile B2B</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f5f7fa;
            color: #1f2937;
        }

        .login-section {
            min-height: calc(100vh - 160px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }

        .login-card {
            width: 100%;
            max-width: 450px;
            background: white;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }

        .login-title {
            text-align: center;
            margin-bottom: 10px;
            font-size: 30px;
            color: #111827;
        }

        .login-subtitle {
            text-align: center;
            color: #6b7280;
            margin-bottom: 30px;
        }

        /* ================= ACCOUNT TYPE TOGGLE ================= */
        .type-toggle {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            background: #f3f4f6;
            padding: 5px;
            border-radius: 10px;
            margin-bottom: 26px;
        }

        .type-toggle button {
            border: none;
            background: transparent;
            padding: 12px 0;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            color: #6b7280;
            cursor: pointer;
            font-family: Arial, sans-serif;
            transition: background 0.2s ease, color 0.2s ease;
        }

        .type-toggle button.active {
            background: #ffffff;
            color: #2563eb;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .form-group input {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        .form-group input:focus {
            border-color: #2563eb;
        }

        .forgot-password {
            text-align: right;
            margin-top: -10px;
            margin-bottom: 20px;
        }

        .forgot-password a {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #1d4ed8;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #6b7280;
        }

        .register-link a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .error-message {
            background: #fee2e2;
            color: #b91c1c;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }

        .success-message {
            background: #dcfce7;
            color: #15803d;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>

<body>

    <!-- Common Header -->
    <jsp:include page="/WEB-INF/common/Header.jsp"/>


    <!-- Login Section -->
    <section class="login-section">

        <div class="login-card">

            <h1 class="login-title">Welcome Back</h1>

            <p class="login-subtitle" id="loginSubtitle">
                Login to your CeramicTile B2B account
            </p>


            <!-- Error message from Controller -->
            <% if (request.getAttribute("error") != null) { %>

                <div class="error-message">
                    ${error}
                </div>

            <% } %>


            <!-- Success message -->
            <% if (request.getAttribute("message") != null) { %>

                <div class="success-message">
                    ${message}
                </div>

            <% } %>


            <!-- ACCOUNT TYPE TOGGLE -->
            <div class="type-toggle">
                <button type="button" id="toggleSeller" onclick="selectLoginType('seller')">
                    Seller Login
                </button>
                <button type="button" id="toggleBuyer" onclick="selectLoginType('buyer')">
                    Buyer Login
                </button>
            </div>


            <!-- Login Form -->
            <form id="loginForm"
                  action="${pageContext.request.contextPath}/login"
                  method="post">

                

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="Enter your email"
                           required>

                </div>


                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Enter your password"
                           required>

                </div>


                <div class="forgot-password">

                    <a href="${pageContext.request.contextPath}/forgot-password">
                        Forgot Password?
                    </a>

                </div>


                <button type="submit" class="login-btn" id="loginSubmitBtn">
                    Login as Buyer
                </button>

            </form>


            <div class="register-link">

                Don't have an account?

                <a href="${pageContext.request.contextPath}/register">
                    Register
                </a>

            </div>

        </div>

    </section>


    <script>
        var form=document.getElementById('loginForm');
        var contextpath="${pageContext.request.contextPath}"; 
        function selectLoginType(type) {
             if(type==="seller"){
            	 form.action=contextpath+ "/seller/login";
            	 document.getElementById('email').name="seller_email";
            	  document.getElementById('password').name="seller_password";
            	 console.log(form.action);
             }
             else if(type==="buyer"){
            	 
             }
            //document.getElementById('userType').value = type;
            document.getElementById('toggleSeller').classList.toggle('active', type === 'seller');
            document.getElementById('toggleBuyer').classList.toggle('active', type === 'buyer');

            document.getElementById('loginSubmitBtn').textContent =
                type === 'seller' ? 'Login as Seller' : 'Login as Buyer';

            document.getElementById('loginSubtitle').textContent =
                type === 'seller'
                    ? 'Login to manage your seller account and listings'
                    : 'Login to your CeramicTile B2B account';
        }

        // default to buyer on page load
        selectLoginType('buyer');

    </script>

</body>

</html>
