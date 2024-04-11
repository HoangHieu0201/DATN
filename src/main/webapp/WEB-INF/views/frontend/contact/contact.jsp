<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title}</title>
<link rel="stylesheet" type="text/css" media="screen"
	href="${classpath}/frontend/bootstrap/bootstrap.min.css">
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>

</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>


	<main class="main" style="padding: 1% 0% 0 0%;">
		<div class="main__contact">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12 col-lg-6">
						<div class="contact__title">
							<h2 class="title">Liên lạc</h2>
						</div>
						<div class="contact__form">
							<div class="notice" style="margin-left: 5%">
								<p class="text-red-900 mb-2" style="color: red;">${message }</p>
							</div>
							<form class="form" action="/contact-send" method="post">
								<div class="row">
									<div class="col-md-6">
										<div class="contact__form-input">
											<input type="text" class="form-input"
												placeholder="Họ tên..." id="txtName" name="txtName"
												value="${loginedUser.name }">
										</div>
									</div>
									<div class="col-md-6">
										<div class="contact__form-input">
											<input type="email" class="form-input" placeholder="Email..."
												id="txtEmail" name="txtEmail" value="${loginedUser.email }">
										</div>
									</div>
									<div class="col-md-6">
										<div class="contact__form-input">
											<input type="text" class="form-input"
												placeholder="Số điện thoại..." id="txtMobile" name="txtMobile"
												value="${loginedUser.mobile }">
										</div>
									</div>
									<div class="col-md-6">
										<div class="contact__form-input">
											<input type="text" class="form-input"
												placeholder="Địa chỉ..." id="txtAddress"
												name="txtAddress" value="${loginedUser.address }">
										</div>
									</div>
									<div class="col-12">
										<div class="contact__form-input">
											<textarea cols="30" rows="5" class="form__textarea"
												id="txtMessage" name="txtMessage"
												placeholder="Để lại lời nhắn..."></textarea>
										</div>
									</div>
									<div class="col-12">
										<div class="contact__btn">
											<!-- <a href="#">Send</a> -->
											<button class="btn btn-primary">Gửi</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="col-12 col-lg-6">
						<div class="contact__title">
							<h2 class="title">Liên hệ với chúng tôi</h2>
						</div>
						<p class="contact__description">Chúng tôi cam kết cung cấp
							dịch vụ tốt nhất và luôn sẵn lòng giải đáp mọi thắc mắc của bạn.
							Bất kể bạn đang cần hỗ trợ về sản phẩm, dịch vụ hoặc có bất kỳ
							câu hỏi nào, đừng ngần ngại liên hệ với chúng tôi. Đội ngũ nhân
							viên của chúng tôi luôn ở đây để hỗ trợ bạn. Vui lòng điền vào
							biểu mẫu dưới đây hoặc liên hệ trực tiếp với chúng tôi qua số
							điện thoại hoặc email để được hỗ trợ nhanh chóng và chuyên
							nghiệp. Cảm ơn bạn đã lựa chọn chúng tôi!</p>
						<ul class="contact__address">
							<li><i class='bx bx-phone'></i> 0233489943</li>
							<li><i class='bx bx-envelope'></i> mobileworld@gmail.com</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>

	<script type="text/javascript">
		function _contactSend() {
			//javascript object
			let data = {
				txtName : jQuery("#txtName").val(),
				txtEmail : jQuery("#txtEmail").val(), //Get by Id
				txtMobile : jQuery("#txtMobile").val(),
				txtAddress : jQuery("#txtAddress").val(),
				txtMessage : jQuery("#txtMessage").val(),
			};

			//$ === jQuery
			jQuery.ajax({
				url : "/contact-send",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json

				success : function(jsonResult) {
					alert(jsonResult.code + ": " + jsonResult.message);
					//$("#placeOrderSuccess").html(jsonResult.message);
				},

				error : function(jqXhr, textStatus, errorMessage) {
					alert("An error occur");
				}
			});
		}
	</script>
</body>
</html>