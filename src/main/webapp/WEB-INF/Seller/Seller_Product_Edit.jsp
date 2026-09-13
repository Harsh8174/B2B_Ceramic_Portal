<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"
    import="com.app.model.Product"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product – CeramicTile B2B Portal</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Seller_Product_Edit.css" />

</head>


<body>

    <!-- Common Header -->
    <jsp:include page="/WEB-INF/common/Header.jsp"/>

    <%
        // The controller for GET /seller/products/edit?id=... should look up
        // the product and place it in the request as "product". If it's
        // missing (bad id, or someone else's product), we show a fallback
        // message instead of a broken form.
        Product product = (Product) request.getAttribute("product");
    %>

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

            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/seller/dashboard">Dashboard</a>
                &nbsp;/&nbsp;
                <a href="${pageContext.request.contextPath}/seller/products">My Products</a>
                &nbsp;/&nbsp; Edit
            </div>

            <div class="topbar">
                <div>
                    <h1>Edit Product</h1>
                    <div class="sub">Update your tile listing details.</div>
                </div>
            </div>

            <%
                if (product == null) {
            %>

                <div class="not-found">
                    <h3>Product not found</h3>
                    <p>This listing may have been removed, or doesn't belong to your account.</p>
                    <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-primary">
                        Back to My Products
                    </a>
                </div>

            <%
                } else {
            %>

            <form id="editProductForm"
                  action="${pageContext.request.contextPath}/seller/products/update"
                  method="post"
                  enctype="multipart/form-data">

                <input type="hidden" name="product_id" value="<%= product.getProduct_id() %>">

                <!-- ============ BASIC INFO ============ -->
                <div class="form-card">

                    <div class="section-title">Basic Information</div>
                    <div class="section-desc">General details buyers see first.</div>

                    <div class="form-group">
                        <label for="productName">Product Name</label>
                        <input type="text" id="productName" name="product_name"
                            value="<%= product.getProduct_name() != null ? product.getProduct_name() : "" %>" required>
                    </div>

                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <%
                                String currentCategory = product.getProduct_category() != null ? product.getProduct_category() : "";
                            %>
                            <select id="category" name="product_category" required>
                                <option value="">Select category</option>
                                <option value="floor"    <%= "floor".equals(currentCategory) ? "selected" : "" %>>Floor Tiles</option>
                                <option value="wall"     <%= "wall".equals(currentCategory) ? "selected" : "" %>>Wall Tiles</option>
                                <option value="bathroom" <%= "bathroom".equals(currentCategory) ? "selected" : "" %>>Bathroom Tiles</option>
                                <option value="kitchen"  <%= "kitchen".equals(currentCategory) ? "selected" : "" %>>Kitchen Tiles</option>
                                <option value="outdoor"  <%= "outdoor".equals(currentCategory) ? "selected" : "" %>>Outdoor / Parking Tiles</option>
                                <option value="mosaic"   <%= "mosaic".equals(currentCategory) ? "selected" : "" %>>Mosaic Tiles</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="material">Material</label>
                            <%
                                String currentMaterial = product.getProduct_material() != null ? product.getProduct_material() : "";
                            %>
                            <select id="material" name="product_material" required>
                                <option value="">Select material</option>
                                <option value="ceramic"    <%= "ceramic".equals(currentMaterial) ? "selected" : "" %>>Ceramic</option>
                                <option value="vitrified"  <%= "vitrified".equals(currentMaterial) ? "selected" : "" %>>Vitrified</option>
                                <option value="porcelain"  <%= "porcelain".equals(currentMaterial) ? "selected" : "" %>>Porcelain</option>
                                <option value="marble"     <%= "marble".equals(currentMaterial) ? "selected" : "" %>>Marble Look</option>
                                <option value="granite"    <%= "granite".equals(currentMaterial) ? "selected" : "" %>>Granite Look</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">
                            Description <span class="hint">(finish, usage, key features)</span>
                        </label>
                        <textarea id="description" name="product_description" maxlength="600"
                            oninput="updateCharCount()" required><%= product.getProduct_description() != null ? product.getProduct_description() : "" %></textarea>
                        <div class="char-count"><span id="charCount">0</span>/600</div>
                    </div>

                </div>


                <!-- ============ SPECIFICATIONS ============ -->
                <div class="form-card">

                    <div class="section-title">Specifications</div>
                    <div class="section-desc">Size, finish, and packaging details.</div>

                    <div class="form-row-3">
                        <div class="form-group">
                            <label for="size">Size (mm)</label>
                            <input type="text" id="size" name="product_size"
                                value="<%= product.getProduct_size() != null ? product.getProduct_size() : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label for="thickness">Thickness (mm)</label>
                            <input type="text" id="thickness" name="product_thickness"
                                value="<%= product.getProduct_thickness() != null ? product.getProduct_thickness() : "" %>">
                        </div>

                        <div class="form-group">
                            <label for="finish">Finish</label>
                            <%
                                String currentFinish = product.getProduct_finish() != null ? product.getProduct_finish() : "";
                            %>
                            <select id="finish" name="product_finish" required>
                                <option value="">Select finish</option>
                                <option value="glossy"    <%= "glossy".equals(currentFinish) ? "selected" : "" %>>Glossy</option>
                                <option value="matte"     <%= "matte".equals(currentFinish) ? "selected" : "" %>>Matte</option>
                                <option value="textured"  <%= "textured".equals(currentFinish) ? "selected" : "" %>>Textured</option>
                                <option value="polished"  <%= "polished".equals(currentFinish) ? "selected" : "" %>>Polished</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="piecesPerBox">Pieces per Box</label>
                            <input type="number" id="piecesPerBox" name="product_pieces_per_box" min="1"
                                value="<%= product.getProduct_pieces_per_box() %>">
                        </div>

                        <div class="form-group">
                            <label for="coverageAreaPerBox">Coverage per Box (sq.ft)</label>
                            <input type="number" id="coverageAreaPerBox" name="product_coverage_area"
                                min="0" step="0.01" value="<%= product.getProduct_coverage_area() %>">
                        </div>
                    </div>

                </div>


                <!-- ============ PRICING & STOCK ============ -->
                <div class="form-card">

                    <div class="section-title">Pricing &amp; Stock</div>
                    <div class="section-desc">Set your price, minimum order, and available stock.</div>

                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="price">Price</label>
                            <%
                                String currentPriceUnit = product.getProduct_price_unit() != null ? product.getProduct_price_unit() : "";
                            %>
                            <div class="input-suffix-row">
                                <input type="number" id="price" name="product_price" min="0" step="0.01"
                                    value="<%= product.getProduct_price() %>" required>
                                <select id="priceUnit" name="product_price_unit" required>
                                    <option value="per_sqft"  <%= "per_sqft".equals(currentPriceUnit) ? "selected" : "" %>>per sq.ft</option>
                                    <option value="per_box"   <%= "per_box".equals(currentPriceUnit) ? "selected" : "" %>>per box</option>
                                    <option value="per_piece" <%= "per_piece".equals(currentPriceUnit) ? "selected" : "" %>>per piece</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="minOrderQty">Minimum Order Quantity</label>
                            <%
                                String currentMinOrderUnit = product.getProduct_minimum_order_unit() != null ? product.getProduct_minimum_order_unit() : "";
                            %>
                            <div class="input-suffix-row">
                                <input type="number" id="minOrderQty" name="product_minimum_order" min="1"
                                    value="<%= product.getProduct_minimum_order() %>" required>
                                <select id="minOrderUnit" name="product_minimum_order_unit" required>
                                    <option value="sqft"  <%= "sqft".equals(currentMinOrderUnit) ? "selected" : "" %>>sq.ft</option>
                                    <option value="box"   <%= "box".equals(currentMinOrderUnit) ? "selected" : "" %>>box</option>
                                    <option value="piece" <%= "piece".equals(currentMinOrderUnit) ? "selected" : "" %>>piece</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="stockQty">
                            Available Stock <span class="hint">(in the same unit as MOQ)</span>
                        </label>
                        <input type="number" id="stockQty" name="product_available_stock" min="0"
                            value="<%= product.getProduct_available_stock() %>" required>
                    </div>

                </div>


                <!-- ============ IMAGES ============ -->
                <div class="form-card">

                    <div class="section-title">Product Images</div>
                    <div class="section-desc">
                        Upload new images to replace the current ones, or leave empty to keep them unchanged.
                    </div>

                    <div class="upload-zone" id="uploadZone" onclick="document.getElementById('productImages').click()">
                        <div class="icon">🖼️</div>
                        <div class="title">Click to upload, or drag and drop</div>
                        <div class="desc">PNG or JPG, up to 5MB each</div>
                    </div>

                    <input type="file" id="productImages" name="product_file"
                        accept="image/png, image/jpeg" multiple onchange="handleFileSelect(this.files)">

                    <div class="image-preview-grid" id="imagePreviewGrid"></div>
                    <div class="field-msg" id="imageMsg"></div>

                </div>


                <div class="action-bar">
                    <button type="button" class="btn btn-secondary"
                        onclick="location.href = contextPath + '/seller/products'">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        Save Changes
                    </button>
                </div>

            </form>

            <%
                }
            %>

        </main>

    </div>


    <script>

        var contextPath = "${pageContext.request.contextPath}";
        var MAX_IMAGES = 6;
        var MAX_FILE_SIZE_MB = 5;
        var selectedFiles = [];

        function updateCharCount() {
            var textarea = document.getElementById('description');
            if (!textarea) return;
            document.getElementById('charCount').textContent = textarea.value.length;
        }
        updateCharCount();

        var uploadZone = document.getElementById('uploadZone');

        if (uploadZone) {

            uploadZone.addEventListener('dragover', function (e) {
                e.preventDefault();
                uploadZone.classList.add('drag-over');
            });

            uploadZone.addEventListener('dragleave', function () {
                uploadZone.classList.remove('drag-over');
            });

            uploadZone.addEventListener('drop', function (e) {
                e.preventDefault();
                uploadZone.classList.remove('drag-over');
                handleFileSelect(e.dataTransfer.files);
            });
        }

        function handleFileSelect(fileList) {
            var msg = document.getElementById('imageMsg');
            msg.textContent = '';

            for (var i = 0; i < fileList.length; i++) {
                var file = fileList[i];

                if (selectedFiles.length >= MAX_IMAGES) {
                    msg.textContent = 'You can upload up to ' + MAX_IMAGES + ' images.';
                    msg.className = 'field-msg error';
                    break;
                }

                if (!/^image\/(png|jpeg)$/.test(file.type)) {
                    msg.textContent = 'Only PNG or JPG images are allowed.';
                    msg.className = 'field-msg error';
                    continue;
                }

                if (file.size > MAX_FILE_SIZE_MB * 1024 * 1024) {
                    msg.textContent = 'Each image must be under ' + MAX_FILE_SIZE_MB + 'MB.';
                    msg.className = 'field-msg error';
                    continue;
                }

                selectedFiles.push(file);
            }

            renderPreviews();
            syncFileInput();
        }

        function renderPreviews() {
            var grid = document.getElementById('imagePreviewGrid');
            grid.innerHTML = '';

            selectedFiles.forEach(function (file, index) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    var thumb = document.createElement('div');
                    thumb.className = 'image-thumb';

                    var img = document.createElement('img');
                    img.src = e.target.result;
                    thumb.appendChild(img);

                    var removeBtn = document.createElement('button');
                    removeBtn.type = 'button';
                    removeBtn.className = 'remove-btn';
                    removeBtn.textContent = '✕';
                    removeBtn.onclick = function () { removeImage(index); };
                    thumb.appendChild(removeBtn);

                    grid.appendChild(thumb);
                };

                reader.readAsDataURL(file);
            });
        }

        function removeImage(index) {
            selectedFiles.splice(index, 1);
            renderPreviews();
            syncFileInput();
        }

        function syncFileInput() {
            var dataTransfer = new DataTransfer();
            selectedFiles.forEach(function (file) {
                dataTransfer.items.add(file);
            });
            document.getElementById('productImages').files = dataTransfer.files;
        }

    </script>

</body>

</html>
