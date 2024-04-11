<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>${title }</title>

<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>

<!-- Custome css resource file -->
<jsp:include page="/WEB-INF/views/backend/layout/css.jsp"></jsp:include>


<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Left sidebar -->
		<jsp:include page="/WEB-INF/views/backend/layout/left-slide-bar.jsp"></jsp:include>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Header -->
				<jsp:include page="/WEB-INF/views/backend/layout/header.jsp"></jsp:include>

				<!-- Begin Page Content -->
				<div class="page-wrapper">
					<!-- ============================================================== -->
					<!-- Bread crumb and right sidebar toggle -->
					<!-- ============================================================== -->
					<div class="page-breadcrumb">
						<div class="row">
							<div class="col-7 align-self-center">
								<h2
									class="page-title text-truncate text-dark font-weight-medium mb-1">Chi tiết đơn hàng</h2>
							</div>
						</div>
					</div>
					<!-- ============================================================== -->
					<!-- End Bread crumb and right sidebar toggle -->
					<!-- ============================================================== -->
					<!-- ============================================================== -->
					<!-- Container fluid  -->
					<!-- ============================================================== -->
					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<!-- basic table -->
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">
										<div class="form-body">

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<h4>Code:</h4>
														<p>${saleOrder.code }</p>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Khách hàng:</h4>
														<p>${saleOrder.customerName }</p>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Điện thoại:</h4>
														<p>${saleOrder.customerMobile }</p>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Email:</h4>
														<p>${saleOrder.customerEmail }</p>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Địa chỉ:</h4>
														<p>${saleOrder.customerAddress }</p>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Ngày đặt:</h4>
														<p>${saleOrder.createDate }</p>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Ngày cập nhật:</h4>
														<p>${saleOrder.updateDate }</p>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Người lên đơn:</h4>
														<p>${saleOrder.userCreateSaleOrder.username }</p>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group mb-4">
														<h4>Người cập nhật đơn:</h4>
														<p>${saleOrder.userUpdateSaleOrder.username }</p>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<h4>Các sản phẩm mua:</h4>
														<br />
														<table class="Purchased_Products ml-3">
															<thead>
																<tr>
																	<th scope="col" class="text-center">No.</th>
																	<th scope="col" class="text-center">Sản phẩm</th>
																	<th scope="col" class="text-center">Số lượng</th>
																	<th scope="col" class="text-center">Đơn giá</th>
																	<th scope="col" class="text-center">Thành tiền</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="item" items="${saleOrderProducts }"
																	varStatus="loop">
																	<tr>
																		<th scope="row">${loop.index + 1 }</th>

																		<td>${item.product.name }</td>
																		<td align="center">${item.quantity }</td>
																		<td align="right"><fmt:formatNumber
																				value="${item.product.salePrice }"
																				minFractionDigits="0" /></td>
																		<td align="right"><fmt:formatNumber
																				value="${item.product.salePrice * item.quantity }"
																				minFractionDigits="0" /></td>
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
														<p>${saleOrder.total }</p>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<h4>Trạng thái:</h4>
														<p>
															<c:choose>
																<c:when test="${saleOrder.status }">
                                                                                Đã giao hàng
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
														<a href="${classpath }/admin/order/list"
															class="btn btn-secondary active" role="button"
															aria-pressed="true"> Back to list </a> <a
															href="${classpath }/admin/order/edit/${saleOrder.id }"
															class="btn btn-secondary" role="button"
															aria-pressed="true"> Edit </a> <a
															href="${classpath }/admin/order/delete/${saleOrder.id }"
															class="btn btn-secondary" role="button"
															aria-pressed="true"> Delete </a>
													</div>
												</div>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- ============================================================== -->
						<!-- End Container fluid  -->
						<!-- ============================================================== -->
					</div>
					<!-- ============================================================== -->
					<!-- End Page wrapper  -->
					<!-- ============================================================== -->
				</div>
				<!-- End Begin Page Content  -->
			</div>
			<!-- End Main Content -->

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/backend/layout/footer.jsp"></jsp:include>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="login.html">Logout</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Js -->
	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>


</body>

</html>