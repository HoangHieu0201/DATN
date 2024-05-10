<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>	
	
<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>	
		

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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

<body class="bg-gradient-primary">

    <div class="container-fluid">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block ">
                                <img src="${classpath}/backend/img/banner2.jpg" style="width:110% ;border-radius: 8px 0px 0px 8px;" alt="">
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Xin chào!</h1>
                                    </div>
                                    
                                    <c:if test="${not empty param.login_error }">
										<div class="alert alert-danger" role="alert">
											Sai tài khoản hoặc mật khẩu, xin thử lại!!!</div>
									</c:if>
                                    
                                    <form class="user" method="POST" action="${classpath }/login_processing_url">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                aria-describedby="emailHelp"
                                                placeholder="Enter Username..."
                                                id="username" name="username">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="password" name="password" placeholder="Password">
                                        </div>
                                        <div class="form-group" style="display: flex;">
                                            <div class="col-6 custom-control custom-checkbox small">
                                                <input class="form-check-input" type="checkbox"
													id="remember-me" name="remember-me" /> 
												<label class="form-check-label" for="remember-me"> Nhớ mật khẩu </label>
                                            </div>
                                            <div class="col-6 custom-control custom-checkbox small">
                                                <input class="form-check-input" type="checkbox"
													id="showPass" name="showPass" /> 
												<label class="form-check-label" for="showPass"> Hiện mật khẩu </label>
                                            </div>
                                        </div>
										<button type="submit" class="btn btn-primary btn-user btn-block"
											style="width: 100%; margin: 10px 0 2px 0;">
											Đăng nhập
										</button>
                                    </form>
                                    <hr>
                                    <div class="text-center" style="border-radius: 50px;background-color: royalblue;">
                                        <a class="small" href="${classpath }/signup" style="color: white">Tạo tài khoản!</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Js -->
	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>

	<script>
		// Lấy ra checkbox "Hiện mật khẩu"
		const showPassCheckbox = document.getElementById('showPass');
	
		// Lấy ra input chứa mật khẩu
		const passwordInput = document.getElementById('password');
	
		// Định nghĩa hàm để hiển thị hoặc ẩn mật khẩu
		function togglePasswordVisibility() {
		    // Nếu checkbox được chọn, hiển thị mật khẩu
		    if (showPassCheckbox.checked) {
		        passwordInput.type = 'text';
		    } else {
		        // Ngược lại, ẩn mật khẩu
		        passwordInput.type = 'password';
		    }
		}
	
		// Đăng ký sự kiện khi người dùng thay đổi trạng thái của checkbox
		showPassCheckbox.addEventListener('change', togglePasswordVisibility);
	</script>

</body>

</html>