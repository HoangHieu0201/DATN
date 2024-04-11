<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title }</title>
<link rel="stylesheet" type="text/css" media="screen"
	href="${classpath}/frontend/bootstrap/bootstrap.min.css">
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>

<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>


</head>

</head>

<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>
	<div class="wrapper">


		<!-- content -->
		<main class="main" style="padding: 1% 0% 0 0%;">

			<!-- Danh mục sản phẩm -->
			<div class="main__products">
				<div class="container" id="cartView">
					<div class="main__products-title">
						<p>Danh sách yêu thích</p>
					</div>
					<c:choose>
						<c:when test="${totalFavoriteProducts > 0}">
							<form method="get">
								<div class="page-breadcrumb">

									<div class="row">

										<div class="col-12">
											<h3 align="center"
												class="page-title text-truncate text-dark font-weight-medium mb-1">
												<span id="placeOrderSuccess"> Your cart: ${message }
												</span>
											</h3>
										</div>

									</div>

									<div class="row">
										<div class="col-12">
											<div class="card">
												<div class="card-body">
													<div class="row">

														<div class="col-12">
															<table id="zero_config"
																class="table table-striped table-bordered no-wrap">
																<thead>
																	<tr>
																		<th scope="col" class="text-center">No.</th>
																		<th scope="col" class="text-center">Hình ảnh</th>
																		<th scope="col" class="text-center">Sản phẩm</th>
																		<th scope="col" class="text-center">Đơn giá</th>
																		<th colspan="2" scope="col" class="text-center">
																		</th>
																	</tr>
																</thead>
																<tbody>
																	<c:forEach var="item" items="${favorite.favoriteProducts }"
																		varStatus="loop">
																		<tr>
																			<th align="center" scope="row">${loop.index + 1 }</th>
																			<td align="center">
																				<a href="${classpath }/product-detail/${item.productId }"><img width="60px" height="60px"
																				src="${classpath}/FileUploads/${item.avatar }"
																				class="light-logo">
																				</a>
																			</td>
																			<td align="center">
																				<a href="${classpath }/product-detail/${item.productId }">${item.productName }</a>
																			</td>
																			<td align="center"><fmt:formatNumber
																					value="${item.salePrice }" minFractionDigits="0" />
																			</td>
																			<td align="center">	
																				<a onclick="addToCart(${item.productId },1, '${item.productName }')"
																				role="button" class="btn btn-primary">
																					<i class="fa-solid fa-cart-plus"></i>
																				</a>
																			<td align="center">
																				<a href="" onclick="deleteFavoriteProduct(${item.productId })"
																				role="button" class="btn btn-danger">
																					<i class="fa-solid fa-trash-can"></i>
																				</a>
																		</tr>
																	</c:forEach>
																</tbody>

															</table>
														</div>

													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>
						</c:when>
						<c:otherwise>
							<div class="row">
								<div class="col-12">
									<h3 align="center"
										class="page-title text-truncate text-dark font-weight-medium mb-1">
										<span id="placeOrderSuccess">Bạn chưa có sản phẩm yêu
											thích !</span>
									</h3>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" align="center">
									<div class="form-group mb-4">
										<a href="${classpath }/index" class="btn btn-primary active"
											role="button" aria-pressed="true"> Back to shop </a>
									</div>
								</div>
							</div>

						</c:otherwise>
					</c:choose>
				</div>
			</div>

		</main>

		<!-- footer -->
		<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>

		<div class="scroll__top">
			<i class='bx bx-up-arrow-alt'></i>
		</div>

		<!-- mobile menu -->

	</div>
	<!-- js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>

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

		<script type="text/javascript">
					deleteFavoriteProduct = function (_productId) {
						let data = {
							productId: _productId
						};

							//$ === jQuery
						jQuery.ajax({
							url: "/deleteFavoriteProduct",
							type: "POST",
							contentType: "application/json",
							data: JSON.stringify(data),
							dataType: "json", //Kieu du lieu tra ve tu controller la json

							success: function (jsonResult) {
								alert(jsonResult.code + ": " + jsonResult.message);
							},

							error: function (jqXhr, textStatus, errorMessage) {
								alert("An error occur");
							}
						});
					}
		</script>

</body>

</html>