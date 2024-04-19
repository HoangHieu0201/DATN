
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
<link rel="stylesheet"
	href="${classpath}/frontend/fontawesome-free-6.5.1-web/css/all.min.css">
<link rel="stylesheet" type="text/css" media="screen"
	href="${classpath}/frontend/bootstrap/bootstrap.min.css">
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
<style>
</style>
</head>

<body id="page-top">

	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<main style="padding: 1% 0 0 0;">
		<div class="container containerCP">
			<div class="row" style="padding: 20px 0 20px 0; width: 60%;">
				<div class="col-md-12">
					<div class="card cardCP">
						<div class="card-header card-headerCP">
							<h3 class="card-title card-titleCP">Thay đổi mật khẩu</h3>
						</div>
						<div class="card-body card-bodyCP">
							<form>
								<div class="form-group">
									<label for="oldPassword">Mật khẩu cũ:</label> <input
										type="password" class="form-control" id="oldPassword"
										name="oldPassword" required>
								</div>
								<div class="form-group">
									<label for="newPassword">Mật khẩu mới:</label> <input
										type="password" class="form-control" id="newPassword"
										name="newPassword" required>
								</div>
								<div class="form-group">
									<label for="confirmPassword">Nhập lại mật khẩu mới:</label> <input
										type="password" class="form-control" id="confirmPassword"
										name="confirmPassword" required>
								</div>
								<div class="form-group form-check">
									<input type="checkbox" class="form-check-input"
										id="showPassword"> <label class="form-check-label"
										for="showPassword">Hiện mật khẩu</label>
								</div>
								<div class="form-group">
									<p id="message" style="color: red;">${message }</p>
								</div>
								<div class="form-group">
									<button type="submit" class="btn btn-primary btn-primaryCP">Đổi
										mật khẩu</button>
									<a href="${classpath}/index " role="button"
										class="btn btn-secondary btn-secondaryCP">Huỷ</a>
								</div>
							</form>
						</div>
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
		document.getElementById("showPassword").addEventListener(
				"change",
				function() {
					var oldPasswordInput = document
							.getElementById("oldPassword");
					var newPasswordInput = document
							.getElementById("newPassword");
					var confirmPasswordInput = document
							.getElementById("confirmPassword");

					if (this.checked) {
						oldPasswordInput.type = "text";
						newPasswordInput.type = "text";
						confirmPasswordInput.type = "text";
					} else {
						oldPasswordInput.type = "password";
						newPasswordInput.type = "password";
						confirmPasswordInput.type = "password";
					}
				});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('form').submit(function(event) {
				event.preventDefault(); // Ngăn chặn gửi form theo cách thông thường

				// Lấy giá trị từ các trường nhập
				var oldPassword = $('#oldPassword').val();
				var newPassword = $('#newPassword').val();
				var confirmPassword = $('#confirmPassword').val();

				// Tạo đối tượng dữ liệu để gửi đi
				var data = {
					oldPassword : oldPassword,
					newPassword : newPassword,
					confirmPassword : confirmPassword
				};

				// Gửi yêu cầu AJAX đến controller
				$.ajax({
					url : "/confirmChangePassword",
					type : "POST",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json", //Kieu du lieu tra ve tu controller la json
					success : function(response) {
						// Xử lý phản hồi từ controller
						$('#message').text(response.message);
						// Xóa giá trị của các ô input
					    $('#oldPassword').val('');
					    $('#newPassword').val('');
					    $('#confirmPassword').val('');
					},
					error : function(xhr, status, error) {
						// Xử lý lỗi nếu có
						console.error(error);
					}
				});
			});
		});
	</script>
	
	<script>
	    document.querySelector("form").addEventListener("submit", function() {
	        document.getElementById("oldPassword").value = "";
	        document.getElementById("newPassword").value = "";
	        document.getElementById("confirmPassword").value = "";
	    });
	</script>

</body>

</html>