<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

	<!-- directive của JSTL -->
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

				<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

					<head>
						<link rel="stylesheet" href="${classpath }/frontend/fontawesome-free-6.5.1-web/css/all.min.css">
					</head>

					<header>
						<div class="container-fluid">
							<div class="row line1">
								<div class="tuyendung background">
									<a href="">Tuyển dụng</a>
								</div>
								<div class="hotline background">
									<a href="">Hotline</a>
								</div>
							</div>
							<!-- Thanh logo -->
							<div class="row line2">
								<div class="col-lg-3 img">
									<img src="${classpath}/frontend/images/icon/Logo-shop.png" class="logo">
									<h3>MOBILE WORLD</h3>
								</div>
								<div class="col-lg-6 slogan">
									<p>❤Uy tín chất lượng - Kết nối yêu thương❤</p>
								</div>

								<div class="col-lg-3 icons-social">
									<i class="fa-brands fa-facebook facebook"></i> <i
										class="fa-brands fa-youtube youtube"></i> <i
										class="fa-brands fa-instagram insta"></i>

								</div>
							</div>
						</div>
					</header>

					<nav>
						<div class="container-fluid menu">
							<div class="icon-items">
								<ul>
									<li><a href="${classpath }/index"> <i class="fa-solid fa-house"></i>
											<span>Home</span>
										</a></li>
									<li><a href="${classpath }/product"> <i class="fa-solid fa-mobile-screen"></i>
											<span>Điện thoại</span>
										</a></li>
									<li>
										<c:choose>
											<c:when test="${isLogined }">
												<a href="${classpath }/order/${loginedUser.id }"> <i
														class="fa-regular fa-file-lines"></i> <span>Đơn hàng</span>
												</a>
											</c:when>
											<c:otherwise>
												<a href="#" id="donhang"> <i class="fa-regular fa-file-lines"></i>
													<span>Đơn hàng</span>
												</a>
											</c:otherwise>
										</c:choose>
									</li>
									<li><a href="${classpath }/contact"> <i class="fa-solid fa-comment-dots"></i>
											<span>Liên hệ</span>
										</a></li>
								</ul>
							</div>

							<div class="search">
								<div class="border">
									<form class="form-inline justify-content-center">
										<input type="text" class="form-control" placeholder="Nhập sản phẩm cần tìm"
											id="keyword" name="keyword" value="${productSearch.keyword }">
										<button class="btn btn-danger" type="submit" id="btnSearch" name="btnSearch">
											<i class="fa-solid fa-magnifying-glass" style="background: none;"></i>
										</button>
									</form>
								</div>
								<div class="search-result">
									<div class="suggest-search" style="background-color: aliceblue; display: block;">
										<c:forEach items="${searchProducts }" var="product">
											<!-- San Pham 1 -->
											<div class="suggest-product" style="background-color: aliceblue;">
												<a href="${classpath }/product-detail/${product.id}">
													<div class="item-img">
														<img src="${classpath }/FileUploads/${product.avatar }" alt="">
													</div>
													<div class="item-info">
														<h3 class="namespsearch">${product.name }</h3>
														<p class="price">
															<fmt:formatNumber value="${product.salePrice }"
																minFractionDigits="0"></fmt:formatNumber>
															<sup>vnđ</sup>
														</p>
														<p class="price-old black">
															<fmt:formatNumber value="${product.price }"
																minFractionDigits="0"></fmt:formatNumber>
															<sup>vnđ</sup>
														</p>
													</div>
												</a>
											</div>
											<!--End San Pham 1 -->
										</c:forEach>
									</div>
								</div>
							</div>

							<div class="background icons-right">
								<a class="btn-favorite" href="${classpath }/favorite-view"> <span class="quantity"
										id="totalFavoriteProductsId">${totalFavoriteProducts }</span>
									<i class="fa-regular fa-heart background"></i>
								</a> 
								<a class="btn-cart" href="${classpath }/cart-view"> <span class="quantity"
										id="totalCartProductsId">${totalCartProducts }</span>
									<i class="fa-solid fa-bag-shopping background"></i>
									<c:choose>
										<c:when test="${isLogined }">
											<a id="dropdownToggle" class="btn-login mr-3" href="#"> <i
													class="fa-regular fa-user background"></i>
											</a>
											<div class="dropdown">
												<ul id="dropdownMenu" class="dropdown-menu"
													aria-labelledby="dropdownMenuLink" style="display: none;">
													<li><a class="dropdown-item" style="display: block;" href="#"> 
																Xin chào,<br> ${loginedUser.name }
														</a></li>
													<li><a class="dropdown-item" style="display: block;" href="#"> <i
																class="fa-solid fa-gear"
																style="font-size: 20px;"></i>&nbsp; Đổi mật khẩu
														</a></li>
													<hr style="margin: 0; padding: 0;">
													<li><a class="dropdown-item" style="display: block;"
															href="${classpath}/logout"> <i
																class="fa-solid fa-right-from-bracket"
																style="font-size: 20px;"></i>&nbsp;Đăng xuất
														</a></li>
												</ul>
											</div>
										</c:when>
										<c:otherwise>
											<a id="dropdownToggle" class="btn-login mr-3" href="#"> <i
													class="fa-regular fa-user background"></i>
											</a>
											<div class="dropdown">
												<ul id="dropdownMenu" class="dropdown-menu"
													aria-labelledby="dropdownMenuLink" style="display: none;">
													<hr style="margin: 0; padding: 0;">
													<li><a class="dropdown-item" style="display: block;"
															href="${classpath}/login"> <i
																class="fa-solid fa-right-from-bracket"
																style="font-size: 20px;"></i>Đăng nhập
														</a></li>
												</ul>
											</div>
										</c:otherwise>
									</c:choose>
							</div>
						</div>
					</nav>

					<script type="text/javascript">
						document.getElementById('keyword').addEventListener('keyup', function () {

							if (this.value === '') {
								document.querySelector('.search-result').style.display = 'none';
							}
							else {
								document.querySelector('.search-result').style.display = 'block';
								searchProducts(this.value);

							}
						});

						function searchProducts(keyword) {
							// Lọc danh sách sản phẩm dựa trên từ khóa
							var products = document.querySelectorAll('.suggest-product');
							for (var i = 0; i < products.length; i++) {
								var productName = products[i].querySelector('.namespsearch').textContent.toLowerCase();
								if (productName.includes(keyword.toLowerCase())) {
									products[i].style.display = 'flex';
								} else {
									products[i].style.display = 'none';
								}
							}
						}
					</script>

					<script type="text/javascript">
						// Lấy thẻ a bằng id
						var donHangLink = document.getElementById('donhang');

						// Thêm sự kiện click
						donHangLink.addEventListener('click', function (event) {
							event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ a

							// Hiển thị thông báo
							alert('Vui lòng đăng nhập để xem đơn hàng !');
						});
					</script>

					<script type="text/javascript">
						// Lấy thẻ a và dropdown menu
						var dropdownToggle = document.getElementById('dropdownToggle');
						var dropdownMenu = document.getElementById('dropdownMenu');

						// Thêm sự kiện click vào thẻ a
						dropdownToggle.addEventListener('click', function (event) {
							event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ a
							if (dropdownMenu.style.display === 'none' || dropdownMenu.style.display === '') {
								dropdownMenu.style.display = 'block';
							} else {
								dropdownMenu.style.display = 'none';
							}
						});

					</script>