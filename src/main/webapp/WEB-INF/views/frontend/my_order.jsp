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
<link rel="stylesheet" type="text/css" media="screen"
	href="${classpath}/frontend/bootstrap/bootstrap.min.css">
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>


</head>

<body id="page-top">
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>
	

	<!-- Begin Page Content -->
	<div class="page-wrapper">
		<h3 style="margin: 10px 0 0 20px;">Các đơn hàng của bạn:</h3>
		<c:forEach var="saleOrder" items="${saleOrders}"
			varStatus="orderStatus">
			<!-- Đơn hàng -->
			<div class="container-fluid" style="padding: 30px 50px;">
				<!-- ============================================================== -->
				<!-- Start Page Content -->
				<!-- ============================================================== -->
				<!-- basic table -->
				<div class="row justify-content-center">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<div class="row">
									<div class="col-md-12">
										<div class="form-group mb-4 justify-content-center"
											style="display: flex">
											<table class="Purchased_Products ml-3">
												<thead>
													<tr>
														<th scope="col" class="text-center">No.</th>
														<th scope="col" class="text-center">Sản phẩm</th>
														<th scope="col" class="text-center">Hình ảnh</th>
														<th scope="col" class="text-center pl-4">Số lượng</th>
														<th scope="col" class="text-center pl-4">Đơn giá</th>
														<th scope="col" class="text-center pl-4">Thành tiền</th>
													</tr>
												</thead>
												<tbody>
													<!-- Lặp qua các sản phẩm của đơn hàng -->
													<c:forEach var="item"
														items="${allSaleOrderProducts[orderStatus.index]}"
														varStatus="productStatus">
														<tr>
															<th scope="row">${productStatus.index +
                                                                                    1}</th>
															<td>${item.product.name}</td>
															<td><img width="40px" height="40px" 
															src="${classpath }/FileUploads/${item.product.avatar }" class="light-logo">
															</td>
															<td align="center">${item.quantity}</td>
															<td align="center"><fmt:formatNumber
																	value="${item.product.salePrice}" minFractionDigits="0">
																</fmt:formatNumber></td>
															<td align="center"><fmt:formatNumber
																	value="${item.product.salePrice * item.quantity}"
																	minFractionDigits="0">
																</fmt:formatNumber></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group mb-4">
											<h4>Tổng tiền:</h4>
											<p>
												<fmt:formatNumber value="${saleOrder.total}"
													minFractionDigits="0">
												</fmt:formatNumber>
											</p>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group mb-4">
											<h4>Trạng thái:</h4>
											<p>
												<c:choose>
													<c:when test="${saleOrder.status}">
                                                                            Đã giao hàng✔
                                                                        </c:when>
													<c:otherwise>Chưa giao hàng</c:otherwise>
												</c:choose>
											</p>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group mb-4">
											<h4>Ngày đặt:</h4>
											<p>${saleOrder.createDate}</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End đơn hàng -->
		</c:forEach>
	</div>
	<!-- End Begin Page Content  -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>

	<div class="scroll__top">
		<i class='bx bx-up-arrow-alt'></i>
	</div>

	</div>
	<!-- js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>


</body>

</html>