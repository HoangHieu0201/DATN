<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>	

<head>
	<link rel="stylesheet" href="${classpath }/frontend/fontawesome-free-6.5.1-web/css/all.min.css">
</head>
<header>
        <div class="container-fluid p-0">
            <div class="row">
                <div class="col-lg-3">
                    <img src="${classpath}/frontend/images/icon/Logo-shop.png" class="rounded float-left logo" >
                </div>
                <div class="col-lg-6 text-center storeName">
                    MOBILE WORLD
                </div>
                <div class="col-lg-3">
                    <div class="login text-right">
                    	<!-- Yêu thích -->
                    	<a class="btn-favorite" href="favotite-view.html">
                            <span class="quantity" id="totalFavoriteProductsId"></span>
                            <i class="fa-regular fa-heart" style="color: aliceblue; font-size: 30px;"></i>
                        </a>
                        <!-- Giỏ hàng -->
                        <a class="btn-cart" href="${classpath }/cart-view">
                            <span class="quantity" id="totalCartProductsId">${totalCartProducts }</span>
                            <i class="fa-solid fa-bag-shopping" style="color: aliceblue; font-size: 30px;"></i>
                        </a>
                        <!-- Login -->
                        <a class="btn-login mr-3" href="${classpath }/login">
                            <i class="fa-solid fa-circle-user" style="color: aliceblue; font-size: 30px;"></i>
                        </a> 
                    </div>
                </div>               
            </div>
        </div>
    </header>