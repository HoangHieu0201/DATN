package vn.devpro.TestAdmin.controller.backend;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.TestAdmin.controller.BaseController;
import vn.devpro.TestAdmin.model.SaleOrder;
import vn.devpro.TestAdmin.model.SaleOrderProduct;
import vn.devpro.TestAdmin.model.User;
import vn.devpro.TestAdmin.service.SaleOrderProductService;
import vn.devpro.TestAdmin.service.SaleOrderService;
import vn.devpro.TestAdmin.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/")
public class HomeAdminController extends BaseController {

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;
	
	@Autowired
	private UserService userService;

	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(final Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Tổng doanh thu
			List<SaleOrder> saleOrders = saleOrderService.findAll();
	
			// Tính tổng doanh số bán hàng
			BigDecimal totalSales = BigDecimal.ZERO;
	
			// Duyệt qua danh sách đơn hàng và cộng dồn giá trị total của mỗi đơn
			for (SaleOrder saleOrder : saleOrders) {
				BigDecimal orderTotal;
	
				if (saleOrder.getTotal() == null) {
					orderTotal = BigDecimal.ZERO;
				} else {
					orderTotal = saleOrder.getTotal();
				}
	
				totalSales = totalSales.add(orderTotal);
			}
			model.addAttribute("totalSales", totalSales);

		//Tổng sôs đơn hàng
			int totalOrders = saleOrders.size();
			model.addAttribute("totalOrders", totalOrders);
			
		// Tổng sản phẩm đã bán
			int totalSoldProducts = 0;
	
			for (int i = 0; i < saleOrders.size(); i++) {
				// Lấy các sp trong từng đơn hàng
				List<SaleOrderProduct> saleOrderProducts = saleOrderProductService
						.findAllProductInOrder(saleOrders.get(i).getId());
				// Tổng tất cả các sp
				for (int j = 0; j < saleOrderProducts.size(); j++) {
					totalSoldProducts += saleOrderProducts.get(j).getQuantity();
				}
			}
			model.addAttribute("totalSoldProducts", totalSoldProducts);

		//	Tổng số user
			List<User> users = userService.getAllUsers();
			int totalUsers = users.size();
			model.addAttribute("totalUsers", totalUsers);

		//	Thống kê doanh thu theo tháng từ cơ sở dữ liệu
			List<BigDecimal> dashboardRevenue = saleOrderService.getMoneyByMonths(LocalDate.now().getYear());
			System.out.println("Doanh thu từng tháng: " + dashboardRevenue);
			//	Đưa dữ liệu vào model
			model.addAttribute("dashboardRevenue", dashboardRevenue);

		//	Thống kê doanh thu theo năm từ db
			List<String> years = saleOrderService.getYearsFromSaleOrders();
			System.out.println("Các năm: " + years);
			model.addAttribute("years", years);
			List<BigDecimal> revenueByYear = saleOrderService.getMoneyByYear();
			System.out.println("Doanh thu từng năm: " + revenueByYear);
			model.addAttribute("revenueByYear", revenueByYear);

			List<String> colors = Arrays.asList("#4e73df", "#1cc88a", "#36b9cc");
			model.addAttribute("colors", colors);
			return "backend/home";
	}

	
}
