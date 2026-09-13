<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product – CeramicTile B2B Portal</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Seller_Product.css">
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

            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/seller/dashboard">Dashboard</a>
                &nbsp;/&nbsp;
                <a href="${pageContext.request.contextPath}/seller/products">My Products</a>
                &nbsp;/&nbsp; Add New
            </div>

            <div class="topbar">
                <div>
                    <h1>Add New Product</h1>
                    <div class="sub">List a new tile product for buyers to discover.</div>
                </div>
            </div>


            <form id="addProductForm"
                  action="${pageContext.request.contextPath}/seller/addproducts"
                  method="post"
                  enctype="multipart/form-data">

                <!-- ============ BASIC INFO ============ -->
                <div class="form-card">

                    <div class="section-title">Basic Information</div>
                    <div class="section-desc">General details buyers see first.</div>

                    <div class="form-group">
                        <label for="productName">Product Name</label>
                        <input type="text" id="productName" name="product_name"
                            placeholder="e.g. Carrara Gloss Vitrified Floor Tile" required>
                    </div>

                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <select id="category" name="product_category" required>
                                <option value="">Select category</option>
                                <option value="floor">Floor Tiles</option>
                                <option value="wall">Wall Tiles</option>
                                <option value="bathroom">Bathroom Tiles</option>
                                <option value="kitchen">Kitchen Tiles</option>
                                <option value="outdoor">Outdoor / Parking Tiles</option>
                                <option value="mosaic">Mosaic Tiles</option>
                            </select>
                        </div>

                        <div class="form-group">
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
                    </div>

                    <div class="form-group">
                        <label for="description">
                            Description <span class="hint">(finish, usage, key features)</span>
                        </label>
                        <textarea id="description" name="product_description" maxlength="600"
                            placeholder="Describe the tile's finish, ideal use case, and any standout qualities..."
                            oninput="updateCharCount()" required></textarea>
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
                            <input type="text" id="size" name="product_size" placeholder="e.g. 600x600" required>
                        </div>

                        <div class="form-group">
                            <label for="thickness">Thickness (mm)</label>
                            <input type="number" id="thickness" name="product_thickness" min="0" step="0.1" placeholder="e.g. 8">
                        </div>

                        <div class="form-group">
                            <label for="finish">Finish</label>
                            <select id="finish" name="product_finish" required>
                                <option value="">Select finish</option>
                                <option value="glossy">Glossy</option>
                                <option value="matte">Matte</option>
                                <option value="textured">Textured</option>
                                <option value="polished">Polished</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="piecesPerBox">Pieces per Box</label>
                            <input type="number" id="piecesPerBox" name="product_pieces_per_box" min="1" placeholder="e.g. 4">
                        </div>

                        <div class="form-group">
                            <label for="coverageAreaPerBox">Coverage per Box (sq.ft)</label>
                            <input type="number" id="coverageAreaPerBox" name="product_coverage_area"
                                min="0" step="0.01" placeholder="e.g. 15.5">
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

                        <div class="form-group">
                            <label for="minOrderQty">Minimum Order Quantity</label>
                            <div class="input-suffix-row">
                                <input type="number" id="minOrderQty" name="product_minimum_order" min="1"
                                    placeholder="e.g. 100" required>
                                <select id="minOrderUnit" name="product_minimum_order_unit" required>
                                    <option value="sqft">sq.ft</option>
                                    <option value="box">box</option>
                                    <option value="piece">piece</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="stockQty">
                            Available Stock <span class="hint">(in the same unit as MOQ)</span>
                        </label>
                        <input type="number" id="stockQty" name="product_available_stock" min="0" placeholder="e.g. 5000" required>
                    </div>

                </div>


                <!-- ============ IMAGES ============ -->
                <div class="form-card">

                    <div class="section-title">Product Images</div>
                    <div class="section-desc">Add up to 6 images. The first image is used as the cover.</div>

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


                <!-- ============ STATUS ============ -->
                <div class="form-card">

                    <div class="section-title">Listing Status</div>
                    <div class="section-desc">Choose whether to publish now or save for later.</div>

                    <input type="hidden" id="status" name="status" value="published">

                    <div class="status-options">
                        <div class="status-option selected" id="statusPublished" onclick="selectStatus('published')">
                            <div class="title">Publish Now</div>
                            <div class="desc">Visible to buyers immediately</div>
                        </div>
                        <div class="status-option" id="statusDraft" onclick="selectStatus('draft')">
                            <div class="title">Save as Draft</div>
                            <div class="desc">Keep hidden until you're ready</div>
                        </div>
                    </div>

                </div>


                <div class="action-bar">
                    <button type="button" class="btn btn-secondary"
                        onclick="location.href = contextPath + '/seller/products'">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        Publish Product
                    </button>
                </div>

            </form>

        </main>

    </div>


    <script>

        var contextPath = "${pageContext.request.contextPath}";
        var MAX_IMAGES = 6;
        var MAX_FILE_SIZE_MB = 5;
        var selectedFiles = [];

        // ---------------- character counter ----------------
        function updateCharCount() {
            var textarea = document.getElementById('description');
            document.getElementById('charCount').textContent = textarea.value.length;
        }

        // ---------------- status toggle ----------------
        function selectStatus(status) {
            document.getElementById('status').value = status;

            document.getElementById('statusPublished').classList.toggle('selected', status === 'published');
            document.getElementById('statusDraft').classList.toggle('selected', status === 'draft');

            document.getElementById('submitBtn').textContent =
                status === 'draft' ? 'Save as Draft' : 'Publish Product';
        }

        // ---------------- drag & drop ----------------
        var uploadZone = document.getElementById('uploadZone');

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

        // ---------------- file handling ----------------
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

                    if (index === 0) {
                        var badge = document.createElement('span');
                        badge.className = 'cover-badge';
                        badge.textContent = 'Cover';
                        thumb.appendChild(badge);
                    }

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

        // rebuild the actual <input type="file"> FileList from selectedFiles
        // so removed images are excluded and the array order (cover image
        // first) is preserved on submit.
        function syncFileInput() {
            var dataTransfer = new DataTransfer();
            selectedFiles.forEach(function (file) {
                dataTransfer.items.add(file);
            });
            document.getElementById('productImages').files = dataTransfer.files;
        }

        // ---------------- submit validation ----------------
        document.getElementById('addProductForm').addEventListener('submit', function (e) {
            if (selectedFiles.length === 0) {
                e.preventDefault();
                var msg = document.getElementById('imageMsg');
                msg.textContent = 'Add at least one product image.';
                msg.className = 'field-msg error';
                uploadZone.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });

    </script>

</body>

</html>



