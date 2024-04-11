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
                            <div class="col-12 align-self-center">
                                <h2
                                    class="page-title text-truncate text-dark font-weight-medium mb-1">Phản hồi khách hàng</h2>
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
                        <form action="${classpath }/admin/contact/list" method="get">
                            
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    
                                                    <!-- Tìm kiếm -->
                                                    <div class="row">
                                                        <div class="col-md-2">
                                                            <div class="form-group mb-4">
                                                                <select class="form-control"
                                                                    id="status" name="status">
                                                                        <option value="2">Tất cả feedback</option>
                                                                        <option value="1">Đã xử lý</option>
                                                                        <option value="0">Chưa xử lý</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="col-md-2">
                                                            <input class="form-control" type="date" 
                                                                id="beginDate" name="beginDate"/>		
                                                        </div>
                                                        <div class="col-md-2">
                                                            <input class="form-control"
                                                                            type="date" id="endDate" name="endDate" />		
                                                        </div>
                                                        
                                                        <div class="col-md-3">
                                                            <input type="text" class="form-control" id="keyword"
                                                                    name="keyword" placeholder="Search keyword" />		
                                                        </div>
                                                        
                                                        <div class="col-md-1 pl-0">
                                                            <button type="submit" id="btnSearch" name="btnSearch" class="btn btn-primary">Tìm</button>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input id="currentPage" name="currentPage" type="hidden"
                                                                                class="form-control" value="${searchModel.currentPage }">
                                                        </div>
                                                    </div>
                                                    <!-- Hết tìm kiếm -->
                
                                                    <table id="zero_config"
                                                        class="table table-striped table-bcontacted no-wrap">
                                                        <thead>
                                                            <tr align="center">
                                                                <th scope="col">No.</th>
                                                                <th scope="col">Khách hàng</th>
                                                                <th scope="col">Email</th>
                                                                <th scope="col">Điện thoại</th>
                                                                <th scope="col">Ngày tạo</th>
                                                                <th scope="col">Trạng thái</th>
                                                                <th scope="col">Hành động</th>
            
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="contact" items="${contacts }"
                                                                varStatus="loop">
                                                                <tr>
                                                                    <th scope="row">${loop.index + 1 }</th>
            														
                                                                    <td>${contact.name }</td>
                                                                    <td>${contact.email }</td>
                                                                    <td align="center">${contact.mobile }</td>
                                                                    <td><fmt:formatDate pattern="dd-MM-yyyy"
                                                                            value="${contact.createDate}" /></td>
            
                                                                    <td><c:choose>
                                                                            <c:when test="${contact.status }">
                                                                                Đã xử lý
                                                                            </c:when>
                                                                            <c:otherwise>Chưa xử lý</c:otherwise>
                                                                        </c:choose></td>
            
                                                                    <td>
                                                                        <a href="${classpath }/admin/contact/detail/${contact.id }"
                                                                        role="button" class="btn btn-primary">Detail</a>
                                                                        <a href="${classpath }/admin/contact/edit/${contact.id }"
                                                                        role="button" class="btn btn-secondary">Edit</a>
                                                                        <a href="${classpath }/admin/contact/delete/${contact.id }"
                                                                        role="button" class="btn btn-warning">Delete</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
        
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group mb-4">
                                                                <h3>
                                                                    Total feedback:${totalContacts }
                                                                </h3>
                                                            </div>
                                                        </div>
            
                                                        <div class="col-md-6" >
                                                            <!-- Phan trang -->
                                                            <div class="pagination float-right">
                                                                <div id="paging"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            
                        </form>
                    </div>
                    <!-- ============================================================== -->
                    <!-- End Container fluid  -->
                </div>
                <!-- ============================================================== -->
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
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Js -->
	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>

    <script type="text/javascript">
		$( document ).ready(function() {
			//Dat gia tri cua status ung voi dieu kien search truoc do
			$("#status").val(${searchModel.status});
			$("#keyword").val(${searchModel.keyword});
			
			
			$("#paging").pagination({
				currentPage: ${searchModel.currentPage}, //Trang hien tai
				items: ${searchModel.totalItems}, //Tong so don hang (total contacts)
				itemsOnPage: ${searchModel.sizeOfPage},
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					$('#currentPage').val(pageNumber);
					$('#btnSearch').trigger('click');
				},
			});
		});
	</script>
</body>

</html>