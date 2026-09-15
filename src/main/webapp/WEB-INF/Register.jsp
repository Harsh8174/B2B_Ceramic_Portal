<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<% String Accounttype=""; %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Register – CeramicTile B2B Portal</title>
    <link rel="stylesheet" href="./CSS/Register.css" />
</head>


<body>


   <!-- Common Header -->
   <jsp:include page="/WEB-INF/common/Header.jsp"/>

    <!-- ================= REGISTER ================= -->

    <section class="register-section">

        <div class="register-card">

            <!-- REGISTER HEADING -->
            <div class="register-header">
                <h1>Create Your Account</h1>
                <p id="headerSubtext">
                    Join CeramicTile B2B and connect with trusted tile suppliers.
                </p>
            </div>

            <!-- STEP PROGRESS -->
            <div class="step-progress" id="stepProgress">
                <div class="dot active" data-step="1">1</div>
                <div class="bar" id="bar1"></div>
                <div class="dot" data-step="2">2</div>
                <div class="bar" id="bar2"></div>
                <div class="dot" data-step="3">3</div>
            </div>

            <form id="registerForm" action="${pageContext.request.contextPath}/register/${Accountype}" method="post" novalidate>

                <!-- hidden fields carrying the choices made in step 1 -->
                <input type="hidden" id="userType" name="userType" value="">
                <input type="hidden" id="buyerCategory" name="buyerCategory" value="">

                <!-- ============ STEP 1: ACCOUNT TYPE ============ -->
                <div class="step-panel active" data-panel="1">

                    <div class="type-grid">
                        <div class="type-card" id="cardBuyer" onclick="selectAccountType('buyer')">
                            <div class="icon">🛒</div>
                            <div class="label">Buyer</div>
                            <div class="desc">Purchase tiles for a project or personal use</div>
                        </div>
                        <div class="type-card" id="cardSeller" onclick="selectAccountType('seller')">
                            <div class="icon">🏭</div>
                            <div class="label">Seller</div>
                            <div class="desc">List and sell tiles to businesses</div>
                        </div>
                    </div>

                    <div class="sub-choice" id="buyerSubChoice">
                        <div class="heading">Are you buying as a business or as an individual customer?</div>
                        <div class="radio-row">
                            <label class="radio-option" id="optBusiness" onclick="selectBuyerCategory('business')">
                                <input type="radio" name="buyerCategoryRadio" value="business">
                                I represent a business (B2B)
                            </label>
                            <label class="radio-option" id="optIndividual" onclick="selectBuyerCategory('individual')">
                                <input type="radio" name="buyerCategoryRadio" value="individual">
                                I'm an individual customer (B2C)
                            </label>
                        </div>
                    </div>

                    <div class="btn-row">
                        <button type="button" class="register-btn" id="step1NextBtn" disabled onclick="goToStep(2)">
                            Continue
                        </button>
                    </div>

                </div>


                <!-- ============ STEP 2: PERSONAL DETAILS ============ -->
                <div class="step-panel" data-panel="2">

                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <div class="verify-row">
                            <input type="email" id="email" name="email" placeholder="Enter your email address" required
                                oninput="resetEmailVerification()">
                            <button type="button" class="verify-btn" id="sendEmailOtpBtn" onclick="sendOtp('email')">
                                Send Code
                            </button>
                        </div>
                        <div class="otp-block" id="emailOtpBlock">
                            <input type="text" id="emailOtp"  maxlength="6" placeholder="6-digit code">
                            <button type="button" class="verify-btn" onclick="verifyOtp('email')">Verify</button>
                        </div>
                        <div class="field-msg" id="emailMsg"></div>
                    </div>

                    <!--
                        Seller Type field:
                        - visible when userType === 'seller'
                        - visible when userType === 'buyer' AND buyerCategory === 'business'
                        - hidden when userType === 'buyer' AND buyerCategory === 'individual'
                        Visibility is toggled by updateTypeFieldVisibility() in the script below,
                        which runs whenever the account type or buyer category changes.
                    -->
                    <div class="form-group" id="sellerTypeWrap" style="display:none;">
                        <label for="seller_type">Seller Type</label>
                        <select id="seller_type" name="seller_type">
                            <option value="">-- Select Seller Type --</option>
                            <option value="manufacturer">Manufacturer</option>
                            <option value="job_worker">Job Worker</option>
                        </select>
                       
                        <div class="field-msg" id="sellerTypeMsg"></div>
                    </div>
                    <div class="form-group" id="buyerTypeWrap" style="display:none;">
                     <select id="buyer_business_type" name="buyer_type" >
                            <option value="">-- Select Seller Type --</option>
                            <option value="Trader">Trader</option>
                            <option value="Distributor">Distributor</option>
                            <option value="Retailer">Retailer</option>
                            <option value="wholesaler">wholesaler</option>
                        </select>
                        <div class="field-msg" id="sellerTypeMsg"></div>
                    </div>
                    <div class="form-group">
                        <label for="mobile">Mobile Number</label>
                        <input type="tel" id="mobile" name="mobile" placeholder="Enter mobile number" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="Create password" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                placeholder="Confirm password" required oninput="checkPasswordMatch()">
                        </div>
                    </div>
                    <div class="field-msg" id="passwordMsg"></div>

                    <div class="terms" id="termsStep2Wrap">
                        <input type="checkbox" id="termsStep2" onclick="syncTerms(this)">
                        <label for="termsStep2">
                            I agree to the <a href="terms.html">Terms &amp; Conditions</a>
                            and <a href="privacy.html">Privacy Policy</a>.
                        </label>
                    </div>

                    <div class="btn-row">
                        <button type="button" class="back-btn" onclick="goToStep(1)">Back</button>
                        <button type="button" class="register-btn" id="step2ActionBtn" disabled onclick="handleStep2Action()">
                            Next
                        </button>
                    </div>

                </div>


                <!-- ============ STEP 3: BUSINESS DETAILS ============ -->
                <div class="step-panel" data-panel="3">

                    <div class="form-group">
                        <label for="company">Company Name</label>
                        <input type="text" id="company" name="company_name" placeholder="Enter company name">
                    </div>

                    <div class="form-group">
                        <label for="companyEmail">Company Email</label>
                        <div class="verify-row">
                            <input type="email" id="companyEmail" name="company_email"
                                placeholder="Enter company email address" oninput="resetCompanyEmailVerification()">
                            <button type="button" class="verify-btn" id="sendCompanyOtpBtn" onclick="sendOtp('companyEmail')">
                                Send Code
                            </button>
                        </div>
                        <div class="otp-block" id="companyEmailOtpBlock">
                            <input type="text" id="companyEmailOtp" maxlength="6" placeholder="6-digit code">
                            <button type="button" class="verify-btn" onclick="verifyOtp('companyEmail')">Verify</button>
                        </div>
                        <div class="field-msg" id="companyEmailMsg"></div>
                    </div>

                    <div class="terms" id="termsStep3Wrap" style="display:none;">
                        <input type="checkbox" id="termsStep3" onclick="syncTerms(this)">
                        <label for="termsStep3">
                            I agree to the <a href="terms.html">Terms &amp; Conditions</a>
                            and <a href="privacy.html">Privacy Policy</a>.
                        </label>
                    </div>

                    <div class="btn-row">
                        <button type="button" class="back-btn" onclick="goToStep(2)">Back</button>
                        <button type="submit" class="register-btn" id="step3SubmitBtn" disabled>
                            Create Account
                        </button>
                    </div>

                </div>

            </form>

            <!-- LOGIN -->
            <div class="login-link">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login">Login here</a>
            </div>

        </div>

    </section>


    <!-- ================= FOOTER ================= -->
    <footer>
        <p>© 2026 CeramicTile B2B Portal. All rights reserved.</p>
    </footer>


    <script>
    var contextPath = "${pageContext.request.contextPath}";
    var form = document.getElementById('registerForm');
 // ---------------- state ----------------
 var state = {
     userType: null,          // 'buyer' | 'seller'
     buyerCategory: null,     // 'business' | 'individual' (buyer only)
     isBusinessFlow: false,   // seller OR buyer+business
     emailVerified: false,
     companyEmailVerified: false,
     pendingOtp: { email: null, companyEmail: null }
 };


 // ---------------- form action endpoints ----------------
 // Adjust these to match your actual servlet/controller mappings.
 var FORM_ACTIONS = {
     seller: contextPath + '/seller',
     buyerBusiness: contextPath + '/buyer/business',
     buyerIndividual: contextPath + '/buyer/customer'
 };

 function updateFormAction() {
     var form = document.getElementById('registerForm');

     if (state.userType === 'seller') {
         form.action = FORM_ACTIONS.seller;
     } else if (state.userType === 'buyer' && state.buyerCategory === 'business') {
         form.action = FORM_ACTIONS.buyerBusiness;
     } else if (state.userType === 'buyer' && state.buyerCategory === 'individual') {
         form.action = FORM_ACTIONS.buyerIndividual;
     }
     
     // if userType is buyer but no category chosen yet, leave the
     // previous action in place until the sub-choice is made.
 }


 // ---------------- Seller Type field visibility ----------------
 // Shown for: seller, and buyer+business.
 // Hidden for: buyer+individual (and before any choice is made).
 function updateTypeFieldVisibility() {
     var show = computeIsBusinessFlow();
     var wrap = document.getElementById('sellerTypeWrap'); 
     var buyer_wrap=document.getElementById('buyerTypeWrap'); 
     var select = document.getElementById('seller_type');
     var select_business = document.getElementById('buyer_business_type'); 
     if(state.userType === 'seller'){
     wrap.style.display = show ? 'block' : 'none';
     select.required = show;
     select_business.display='none';
     }
     else if(state.userType === 'buyer' && state.buyerCategory === 'business'){
    	 buyer_wrap.style.display = show ? 'block' : 'none';
         select_business.required = show;
         select_business.display=show ? 'block' : 'none';
         select_business.required=show;
         select.display='none';
     }

     if (!show) {
         // clear any previously chosen value and its message when hidden
         select.value = '';
         document.getElementById('sellerTypeMsg').textContent = '';
     }

     evaluateStep2Button();
 }


 // ---------------- STEP 1: account type ----------------
 function selectAccountType(type) {
     state.userType = type;
     document.getElementById('userType').value = type;

     document.getElementById('cardBuyer').classList.toggle('selected', type === 'buyer');
     document.getElementById('cardSeller').classList.toggle('selected', type === 'seller');

     var subChoice = document.getElementById('buyerSubChoice');

     if (type === 'buyer') {
         subChoice.classList.add('visible');
         // require the sub-choice before allowing continue
         state.buyerCategory = null;
         document.getElementById('buyerCategory').value = '';
         document.getElementById('optBusiness').classList.remove('selected');
         document.getElementById('optIndividual').classList.remove('selected');
         document.getElementById('step1NextBtn').disabled = true;
     } else {
         // seller is always a business account
         subChoice.classList.remove('visible');
         state.buyerCategory = null;
         document.getElementById('step1NextBtn').disabled = false;
     }

     updateFormAction();
     updateTypeFieldVisibility();
 }

 function selectBuyerCategory(category) {
     state.buyerCategory = category;
     document.getElementById('buyerCategory').value = category;

     document.getElementById('optBusiness').classList.toggle('selected', category === 'business');
     document.getElementById('optIndividual').classList.toggle('selected', category === 'individual');

     document.getElementById('step1NextBtn').disabled = false;

     updateFormAction();
     updateTypeFieldVisibility();
 }

 function computeIsBusinessFlow() {
     return state.userType === 'seller' ||
            (state.userType === 'buyer' && state.buyerCategory === 'business');
 }


 // ---------------- step navigation ----------------
 function goToStep(stepNum) {
	  if (stepNum === 3) {
	        form.action = contextPath + "/seller/createaccount";
	        console.log("Form URL:", form.action);
	    }
     if (stepNum === 2) {
         state.isBusinessFlow = computeIsBusinessFlow();

         var subtext = document.getElementById('headerSubtext');
         if (state.userType === 'seller') {
             subtext.textContent = 'Set up your seller account to start listing tiles.';
         } else if (state.buyerCategory === 'business') {
             subtext.textContent = 'Set up your business buyer account.';
         } else {
             subtext.textContent = 'Set up your customer account in a couple of minutes.';
         }

         // step progress: 3rd dot only relevant for business flow
         document.getElementById('stepProgress').style.display = state.isBusinessFlow ? 'flex' : 'none';

         // show terms checkbox on step 2 only when there is no step 3 after it
         document.getElementById('termsStep2Wrap').style.display = state.isBusinessFlow ? 'none' : 'flex';
         document.getElementById('termsStep3Wrap').style.display = state.isBusinessFlow ? 'flex' : 'none';

         document.getElementById('step2ActionBtn').textContent = state.isBusinessFlow ? 'Next' : 'Create Account';
         document.getElementById('step2ActionBtn').setAttribute(
             'type', state.isBusinessFlow ? 'button' : 'submit'
         );

         // re-check seller type field visibility every time step 2 is (re)entered
         updateTypeFieldVisibility();
     }

     document.querySelectorAll('.step-panel').forEach(function (panel) {
         panel.classList.toggle('active', panel.getAttribute('data-panel') === String(stepNum));
     });

     updateProgressDots(stepNum);
     evaluateStep2Button();
     evaluateStep3Button();
 }

 function updateProgressDots(stepNum) {
     document.querySelectorAll('.step-progress .dot').forEach(function (dot) {
         var n = parseInt(dot.getAttribute('data-step'), 10);
         dot.classList.toggle('active', n === stepNum);
         dot.classList.toggle('done', n < stepNum);
     });
     document.getElementById('bar1').classList.toggle('done', stepNum > 1);
     document.getElementById('bar2').classList.toggle('done', stepNum > 2);
 }


 // ---------------- OTP endpoints (computed fresh on every call) ----------------
 function getOtpEndpoints() {
     if (state.userType === 'seller') {
         return {
             send: contextPath + '/seller/sendotp',
             verify: contextPath + '/seller/verifyotp'
         };
     }
     // buyer — uses whatever state.buyerCategory is *right now*
     return {
         send: contextPath + '/buyer/' + state.buyerCategory + '/sendotp',
         verify: contextPath + '/buyer/' + state.buyerCategory + '/verifyotp'
     };
 }

 // ---------------- send OTP ----------------
 function sendOtp(fieldKey) {
     var emailInput = document.getElementById(fieldKey);
     var email = emailInput.value.trim();

     if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
         showMsg(fieldKey + 'Msg', 'Enter a valid email address first.', 'error');
         return;
     }

     var sendBtn = document.getElementById(
         fieldKey === 'email' ? 'sendEmailOtpBtn' : 'sendCompanyOtpBtn'
     );
     sendBtn.disabled = true;

     var params = new URLSearchParams();
     params.append('email', email);
     console.log(getOtpEndpoints().send);
     fetch(getOtpEndpoints().send, {
         method: 'POST',
         headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
         body: params.toString()
     })
     .then(function (response) {
         sendBtn.disabled = false;

         if (response.status === 200) {
             document.getElementById(fieldKey + 'OtpBlock').classList.add('visible');
             sendBtn.textContent = 'Resend Code';
             showMsg(fieldKey + 'Msg', 'A verification code was sent to ' + email + '.', 'success');
         } else {
             showMsg(fieldKey + 'Msg', 'Email Already Exist.', 'error');
         }
     })
     .catch(function () {
         sendBtn.disabled = false;
         showMsg(fieldKey + 'Msg', 'Could not send code. Try again.', 'error');
     });
 }

 // ---------------- verify OTP ----------------
 function verifyOtp(fieldKey) {
	 var enteredOtp = document.getElementById(fieldKey + 'Otp').value.trim();
	 var email = document.getElementById(fieldKey).value.trim();
	 var params = new URLSearchParams();
     params.append('email',email);
     params.append('otp', enteredOtp);
     if (!enteredOtp) {
         showMsg(fieldKey + 'Msg', 'Enter the code you received.', 'error');
         return;
     }
     //console.log("company =", company);
     //console.log("companyEmail =", companyEmail);

     console.log(params.toString());
     fetch(getOtpEndpoints().verify, {
         method: 'POST',
         headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
         body: params.toString()
     })
     .then(function (response) {
         if (response.status === 200) {
             if (fieldKey === 'email') {
                 state.emailVerified = true;
             } else {
                 state.companyEmailVerified = true;
             }

             var btn = document.getElementById(
                 fieldKey === 'email' ? 'sendEmailOtpBtn' : 'sendCompanyOtpBtn'
             );
             btn.textContent = 'Verified';
             btn.classList.add('verified');
             btn.disabled = true;

             document.getElementById(fieldKey + 'OtpBlock').classList.remove('visible');
             document.getElementById(fieldKey).readOnly = true;
             showMsg(fieldKey + 'Msg', 'Email verified.', 'success');
         } else {
             showMsg(fieldKey + 'Msg', 'Incorrect code. Please try again.', 'error');
         }

         evaluateStep2Button();
         evaluateStep3Button();
     })
     .catch(function () {
         showMsg(fieldKey + 'Msg', 'Verification failed. Try again.', 'error');
     });
 }

 function resetEmailVerification() {
     state.emailVerified = false;
     var btn = document.getElementById('sendEmailOtpBtn');
     btn.textContent = 'Send Code';
     btn.classList.remove('verified');
     btn.disabled = false;
     document.getElementById('emailOtpBlock').classList.remove('visible');
     document.getElementById('emailMsg').textContent = '';
     evaluateStep2Button();
 }

 function resetCompanyEmailVerification() {
     state.companyEmailVerified = false;
     var btn = document.getElementById('sendCompanyOtpBtn');
     btn.textContent = 'Send Code';
     btn.classList.remove('verified');
     btn.disabled = false;
     document.getElementById('companyEmailOtpBlock').classList.remove('visible');
     document.getElementById('companyEmailMsg').textContent = '';
     evaluateStep3Button();
 }

 function showMsg(elId, text, kind) {
     var el = document.getElementById(elId);
     el.textContent = text;
     el.className = 'field-msg ' + kind;
 }


 // ---------------- password match ----------------
 function checkPasswordMatch() {
     var pw = document.getElementById('password').value;
     var cpw = document.getElementById('confirmPassword').value;

     if (cpw.length === 0) {
         showMsg('passwordMsg', '', '');
     } else if (pw !== cpw) {
         showMsg('passwordMsg', 'Passwords do not match.', 'error');
     } else {
         showMsg('passwordMsg', 'Passwords match.', 'success');
     }
     evaluateStep2Button();
 }


 // ---------------- terms checkbox kept in sync across steps ----------------
 function syncTerms(source) {
     var checked = source.checked;
     document.getElementById('termsStep2').checked = checked;
     document.getElementById('termsStep3').checked = checked;
     evaluateStep2Button();
     evaluateStep3Button();
 }


 // ---------------- enable/disable step 2 & 3 action buttons ----------------
 function evaluateStep2Button() {
     var name = document.getElementById('name').value.trim();
     var mobile = document.getElementById('mobile').value.trim();
     var password = document.getElementById('password').value;
     var confirmPassword = document.getElementById('confirmPassword').value;
     var termsOk = document.getElementById('termsStep2').checked || document.getElementById('termsStep3').checked;

     // if the seller type field is currently visible, it must have a value
     var sellerTypeWrap = document.getElementById('sellerTypeWrap');
     var sellerTypeOk = true;
     if (sellerTypeWrap.style.display !== 'none') {
         sellerTypeOk = document.getElementById('seller_type').value.trim() !== '';
     }

     var basicsOk = name && mobile && password && confirmPassword &&
                    password === confirmPassword && state.emailVerified && sellerTypeOk;

     var ready = state.isBusinessFlow ? basicsOk : (basicsOk && termsOk);

     document.getElementById('step2ActionBtn').disabled = !ready;
 }

 function evaluateStep3Button() {
     if (!state.isBusinessFlow) return;

     var company = document.getElementById('company').value.trim();
     var termsOk = document.getElementById('termsStep3').checked;
     var ready = company && state.companyEmailVerified && termsOk;
     document.getElementById('step3SubmitBtn').disabled = !ready;
     
 
     
 }

 // live-check step 2 required text fields as the user types
 ['name', 'mobile'].forEach(function (id) {
     document.getElementById(id).addEventListener('input', evaluateStep2Button);
 });
 document.getElementById('seller_type').addEventListener('change', evaluateStep2Button);
 document.getElementById('company').addEventListener('input', evaluateStep3Button);


 // ---------------- step 2 action: Next (business) or submit (individual) ----------------
 function handleStep2Action() {
     if (state.isBusinessFlow) {
         goToStep(3);
     }
     // when not a business flow, the button is type="submit" and the
     // form posts normally (see goToStep, which swaps the button type).
 }
 
 
 form.addEventListener("submit", function(event) {

     // Get all values FIRST
     var name = document.getElementById("name").value.trim();
     var mobile = document.getElementById("mobile").value.trim();
     var confirmPassword = document.getElementById("confirmPassword").value.trim();
     var email = document.getElementById("email").value.trim();

     var seller_type = document.getElementById("seller_type").value.trim();
     var company = document.getElementById("company").value.trim();
     var companyEmail = document.getElementById("companyEmail").value.trim();

     // Remove previously added dynamic hidden fields
     document.querySelectorAll(".dynamic-param").forEach(function(element) {
         element.remove();
     });

     // Create hidden input
     function addParam(name, value) {
         var input = document.createElement("input");

         input.type = "hidden";
         input.name = name;
         input.value = value;
         input.classList.add("dynamic-param");

         form.appendChild(input);
     }


     // ================= SELLER =================
     if (state.userType === "seller") {

         form.action = contextPath + "/seller/createaccount";

         addParam("name", name);
         addParam("mobile", mobile);
         addParam("password", confirmPassword);
         addParam("email", email);
         addParam("seller_type", seller_type);
         addParam("company_name", company);
         addParam("company_email", companyEmail);

         console.log("SELLER");
     }


     // ================= BUYER BUSINESS =================
     else if (
         state.userType === "buyer" &&
         state.buyerCategory === "business"
     ) {

         form.action = contextPath + "/buyer/business/createaccount";

         addParam("buyer_name", name);
         addParam("buyer_contact", mobile);
         addParam("buyer_password", confirmPassword);
         addParam("buyer_email", email);
         addParam("buyer_type", state.buyerCategory);
         addParam("company_name", company);
         addParam("company_email", companyEmail);

         console.log("BUYER BUSINESS");
     }


     // ================= BUYER INDIVIDUAL =================
     else if (
         state.userType === "buyer" &&
         state.buyerCategory === "individual"
     ) {

         form.action = contextPath + "/buyer/individual/createaccount";

         addParam("buyer_name", name);
         addParam("buyer_contact", mobile);
         addParam("buyer_password", confirmPassword);
         addParam("buyer_email", email);
         addParam("buyer_type", state.buyerCategory);

         console.log("BUYER INDIVIDUAL");
     }

     console.log("Final Form Action:", form.action);
 });
 

    </script>

</body>

</html>
