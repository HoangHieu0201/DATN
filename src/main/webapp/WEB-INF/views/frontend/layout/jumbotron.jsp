<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="jumbotron text-center">
        <!-- cho vào box có size lớn -->
        <h1 style="color: crimson;">𝕄𝕆𝔹𝕀𝕃𝔼 𝕎𝕆ℝ𝕃𝔻</h1>
        <p>❤Uy tín chất lượng - Kết nối yêu thương❤</p>
        <form class="form-inline justify-content-center form-search">
            <input type="text" class="form-control" style="width: 34%;" size="50" placeholder="Nhập sản phẩm cần tìm" id="keyword"
                name="keyword" value="${productSearch.keyword }">
            <button type="submit" id="btnSearch" name="btnSearch" class="btn btn-danger">Tìm</button>
        </form>
        <div class="search-result" style="display: none;">
            <ul class="suggest-search">
            	<c:forEach items="${searchProducts }" var="product">
	                <!-- San Pham 1 -->
	                <li class="suggest-product">
	                    <a href="${classpath }/product-detail/${product.id}">
	                        <div class="item-img">
	                            <img src="${classpath }/FileUploads/${product.avatar }" alt="">
	                        </div>
	                        <div class="item-info">
	                            <h3 class="namespsearch">${product.name }</h3>
	                            <strong class="price" style="margin: -5px 0 0 -140px;">${product.salePrice }₫</strong>
	                            <p class="price-old black">${product.price }</p>
	                        </div>
	                    </a>
	                </li>
	                <!-- End San Pham 1 -->
	            </c:forEach>    
            </ul>
        </div>
    </div>
<script type="text/javascript">
document.getElementById('keyword').addEventListener('keyup', function() {
	
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