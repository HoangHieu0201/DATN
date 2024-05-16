<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title }</title>
    <link rel="stylesheet" href="${classpath}/frontend/fontawesome-free-6.5.1-web/css/all.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="${classpath}/frontend/bootstrap/bootstrap.min.css">
	<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
	

    <style>
		*{
   			 background: #f4f4f4;
		}
    </style>
</head>

<body id="page-top">

	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

    <section>
        <div class="container-fluid padding-top">
            <div class="slider_bar">
                <div class="slider">
                    <img src="${classpath}/frontend/images/slider/slider_1.png" alt="" class="slide">
                    <img src="${classpath}/frontend/images/slider/slider_2.jpg" alt="" class="slide">
                    <img src="${classpath}/frontend/images/slider/slider_3.jpg" alt="" class="slide">
                    <img src="${classpath}/frontend/images/slider/slider_4.png" alt="" class="slide">
                    <button id="prevBtn" class="arrow-btn prev-btn">&#10094;</button>
                    <button id="nextBtn" class="arrow-btn next-btn">&#10095;</button>
                </div>
                <div class="image_demo">
                    <a href="">
                        <img src="${classpath}/frontend/images/slider/demo1.png" alt="">
                    </a>
                    <a href="">
                        <img src="${classpath}/frontend/images/slider/demo2.png" alt="">
                    </a>
                    <a href="">
                        <img src="${classpath}/frontend/images/slider/demo3.png" alt="">
                    </a>
                    <a href="">
                        <img src="${classpath}/frontend/images/slider/demo4.png" alt="">
                    </a>
                </div>
            </div>
        </div>
    </section>

    <main>
        <div class="container-fluid">
            <!-- hot product -->
            <div class="hotProducts">
                <div class="header">
                    <h3>
                        HOT PRODUCT
                        <i class="fa-solid fa-fire"></i>
                    </h3>
                    <div class="timer" data-hours="1" data-minutes="30" data-seconds="0">
                        <strong class="hours">23</strong><span>:</span><strong class="minutes">30</strong><span>:</span><strong class="seconds">00</strong>
                    </div>
                </div>
                <!-- Cac san pham hot-->
                <div class="products">
                    <div class="row">
                    	<c:forEach items="${hotProducts }" var="product">
	                        <!-- Sản phẩm 1 -->
	                        <div class="col-12 col-lg-2 col-md-6 mt-1 mb-4 dienthoai">
	                            <div class="card">
	                                <a href="${classpath }/product-detail/${product.id}"> <img class="card-img-top"
	                                        src="${classpath }/FileUploads/${product.avatar }" 
	                                        style="width: 188.75px;height: 200px;" alt="avatar">
	                                </a>
	                                <div class="card-body">
	                                    <h2 class="card-title">
	                                        <a href="${classpath }/product-detail/${product.id}">${product.name }</a>
	                                    </h2>
	
	                                    <p class="card-text">
	                                        <fmt:formatNumber value="${product.salePrice }" minFractionDigits="0">
	                                            </fmt:formatNumber>
	                                        <sup>vnđ</sup>
	                                    </p>
	                                    <div class="buttons">
	                                        <a class="btn-favorite"
	                                            onclick="addToFavorite(${product.id },1, '${product.name }')">
	                                            <i class="fa-regular fa-heart"></i></a>
	                                        <a class="btn-cart" role="button"
	                                            onclick="addToCart(${product.id },1, '${product.name }')">
	                                            <i class="fa-solid fa-cart-plus"></i></a>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <!-- End san pham 1 -->
	                    </c:forEach>    
                        
                    </div>
                </div>
            </div>
            <div class="banner">
                <img src="${classpath}/frontend/images/slider/banner1.png" alt="">
            </div>

            <!-- Flash sale -->
            <div class="flash-sales">
                <div class="header">
                    <h3>
                        F
                        <i class="fa-solid fa-bolt-lightning"></i>
                        ASH SALE ONLINE
                    </h3>
                    <div class="timer" data-hours="1" data-minutes="30" data-seconds="0">
                        <strong class="hours">23</strong><span>:</span><strong class="minutes">30</strong><span>:</span><strong class="seconds">00</strong>
                    </div>
                </div>
                <!-- Cac san pham flash sale-->
                <div class="products">
                    <div class="row">
                    	<c:forEach items="${searchProducts }" var="product">
	                        <!-- Sản phẩm 1 -->
	                        <div class="col-12 col-lg-2 col-md-6 mt-1 mb-4 dienthoai">
	                            <div class="card">
	                                <a href="${classpath }/product-detail/${product.id}"> <img class="card-img-top"
	                                        src="${classpath }/FileUploads/${product.avatar }"
	                                        style="width: 188.75px;height: 200px;" alt="avatar">
	                                </a>
	                                <div class="card-body">
	                                    <h2 class="card-title">
	                                        <a href="${classpath }/product-detail/${product.id}">${product.name }</a>
	                                    </h2>
	
	                                    <p class="card-text">
	                                        <fmt:formatNumber value="${product.salePrice }" minFractionDigits="0">
	                                            </fmt:formatNumber>
	                                        <sup>vnđ</sup>
	                                    </p>
	                                    <div class="buttons">
	                                        <a class="btn-favorite"
	                                            onclick="addToFavorite(${product.id },1, '${product.name }')">
	                                            <i class="fa-regular fa-heart"></i></a>
	                                        <a class="btn-cart" role="button"
	                                            onclick="addToCart(${product.id },1, '${product.name }')">
	                                            <i class="fa-solid fa-cart-plus"></i></a>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <!-- End san pham 1 -->
	                    </c:forEach>    
                        
                    </div>
                </div>
            </div>
            <div class="banner">
                <img src="${classpath}/frontend/images/slider/banner2.png" alt="">
            </div>
            <div class="corevalue">
                <div class="item">
                    <span class="icon">
                        <i class="fa-regular fa-circle-check"></i>
                    </span>
                    <div class="text">
                        <span>Sản phẩm</span>
                        <strong>CHÍNH HÃNG</strong>
                    </div>
                </div>
                <div class="item">
                    <span class="icon">
                        <i class="fa-solid fa-truck"></i>
                    </span>
                    <div class="text">
                        <span>Miễn phí vận chuyển</span>
                        <strong>TOÀN QUỐC</strong>
                    </div>
                </div>
                <div class="item">
                    <span class="icon">
                        <i class="fa-solid fa-headset"></i>
                    </span>
                    <div class="text">
                        <span>Hotline hỗ trợ</span>
                        <strong>1900.2091</strong>
                    </div>
                </div>
                <div class="item">
                    <span class="icon">
                        <i class="fa-solid fa-retweet"></i>
                    </span>
                    <div class="text">
                        <span>Thủ tục đổi trả</span>
                        <strong>DỄ DÀNG</strong>
                    </div>
                </div>
            </div>
        </div>
    </main>

	 <!-- Scroll to Top Button-->
    <!-- <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a> -->
   
 	<!-- Footer -->
    <jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
    
    <jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>

    <script>
        function startCountdown(timerDiv) {
            var hoursSpan = timerDiv.querySelector('.hours');
            var minutesSpan = timerDiv.querySelector('.minutes');
            var secondsSpan = timerDiv.querySelector('.seconds');

            var hours = 23; // Đặt giờ bắt đầu
            var minutes = 30; // Đặt phút bắt đầu
            var seconds = 0; // Đặt giây bắt đầu

            var countdown = setInterval(function() {
                if (hours === 0 && minutes === 0 && seconds === 0) {
                    clearInterval(countdown);
                } else {
                    if (seconds === 0) {
                        if (minutes === 0) {
                            hours--;
                            minutes = 59;
                        } else {
                            minutes--;
                        }
                        seconds = 59;
                    } else {
                        seconds--;
                    }

                    hoursSpan.textContent = hours < 10 ? '0' + hours : hours;
                    minutesSpan.textContent = minutes < 10 ? '0' + minutes : minutes;
                    secondsSpan.textContent = seconds < 10 ? '0' + seconds : seconds;
                }
            }, 1000);
        }

        // Start the countdown for each timer when the page loads
        window.onload = function() {
            var timerDivs = document.querySelectorAll('.timer');
            timerDivs.forEach(timerDiv => {
                startCountdown(timerDiv);
            })
        };
    </script>

  
    <!-- Add to cart -->
    <script type="text/javascript">
        addToCart = function (_productId, _quantity, _productName) {
            //alert("Thêm "  + _quantity + " sản phẩm '" + _productName + "' vào giỏ hàng ");
            let data = {
                productId: _productId, //lay theo id
                quantity: _quantity,
                productName: _productName,
            };

            //$ === jQuery
            jQuery.ajax({
                url: "/add-to-cart",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "json", //Kieu du lieu tra ve tu controller la json

                success: function (jsonResult) {
                    alert(jsonResult.code + ": " + jsonResult.message);
                    let totalProducts = jsonResult.totalCartProducts;
                    $("#totalCartProductsId").html(totalProducts);
                },

                error: function (jqXhr, textStatus, errorMessage) {
                    alert(jsonResult.code + ': Đã có lỗi xay ra...!')
                },
            });
        }
    </script>
    
    <!-- Add to favorite -->
    <script type="text/javascript">
    	addToFavorite = function (_productId, _quantity, _productName) {
            //alert("Thêm "  + _quantity + " sản phẩm '" + _productName + "' vào giỏ hàng ");
            let data = {
                productId: _productId, //lay theo id
                quantity: _quantity,
                productName: _productName,
            };

            //$ === jQuery
            jQuery.ajax({
                url: "/add-to-favorite",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "json", //Kieu du lieu tra ve tu controller la json

                success: function (jsonResult) {
                    alert(jsonResult.code + ": " + jsonResult.message);
                    let totalFavoriteProducts = jsonResult.totalFavoriteProducts;
                    $("#totalFavoriteProductsId").html(totalFavoriteProducts);
                },

                error: function (jqXhr, textStatus, errorMessage) {
                    alert(jsonResult.code + ': Đã có lỗi xay ra...!')
                },
            });
        }
    </script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let currentSlide = 0;
            const slides = document.querySelectorAll(".slide");
            const prevBtn = document.getElementById("prevBtn");
            const nextBtn = document.getElementById("nextBtn");

            function showSlide(n) {
                slides.forEach(slide => slide.classList.remove("active_slider"));
                slides[n].classList.add("active_slider");
            }

            function nextSlide() {
                currentSlide = (currentSlide + 1) % slides.length;
                showSlide(currentSlide);
            }

            function prevSlide() {
                currentSlide = (currentSlide - 1 + slides.length) % slides.length;
                showSlide(currentSlide);
            }

            nextBtn.addEventListener("click", nextSlide);
            prevBtn.addEventListener("click", prevSlide);

            setInterval(nextSlide, 3000); // Chuyển đổi slide tự động sau mỗi 3 giây

            // Hiển thị slide đầu tiên khi trang được tải
            showSlide(0);
        });

    </script>
</body>

</html>