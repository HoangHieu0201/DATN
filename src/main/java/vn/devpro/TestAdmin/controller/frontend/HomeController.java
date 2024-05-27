package vn.devpro.TestAdmin.controller.frontend;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.RedirectView;

import com.google.gson.Gson;

import vn.devpro.TestAdmin.model.Category;
import vn.devpro.TestAdmin.model.Product;
import vn.devpro.TestAdmin.model.ProductImage;
import vn.devpro.TestAdmin.model.Role;
import vn.devpro.TestAdmin.model.SaleOrder;
import vn.devpro.TestAdmin.model.SaleOrderProduct;
import vn.devpro.TestAdmin.model.User;
import vn.devpro.TestAdmin.service.CategoryService;
import vn.devpro.TestAdmin.service.ProductImageService;
import vn.devpro.TestAdmin.service.ProductService;
import vn.devpro.TestAdmin.service.SaleOrderProductService;
import vn.devpro.TestAdmin.service.SaleOrderService;
import vn.devpro.TestAdmin.service.UserService;
import vn.devpro.TestAdmin.controller.BaseController;
import vn.devpro.TestAdmin.dto.FinalConstant;
import vn.devpro.TestAdmin.dto.SearchModel;
import org.springframework.util.StringUtils;

@Controller
public class HomeController extends BaseController implements FinalConstant {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private ProductImageService productImageService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	// @RequestMapping : ánh xạ 1 action đến 1 action method trong controller
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// Sp trên thanh gợi ý, sp flash sale
		List<Product> searchProducts = productService.findAllActive();
		model.addAttribute("searchProducts", searchProducts);

		// Sp hot
		List<Product> hotProducts = productService.hotProducts();
		model.addAttribute("hotProducts", hotProducts);

//        List<Product> hotProducts = productService.hotProducts();
//        model.addAttribute("hotProducts", hotProducts);

		return "frontend/index";
	}

	@RequestMapping(value = "/product", method = RequestMethod.GET)
	// @RequestMapping : ánh xạ 1 action đến 1 action method trong controller
	public String product(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		//Tìm sản phẩm gợi ý
		List<Product> searchProducts = productService.findAllActive();
		model.addAttribute("searchProducts", searchProducts);

		// Tìm theo status
		SearchModel productSearch = new SearchModel();
		productSearch.setStatus(1); // Active

		// Tim theo category
		productSearch.setCategoryId(0); // ALL
		String categoryId = request.getParameter("categoryId");
		if (!StringUtils.isEmpty(categoryId)) { // Co chon category
			productSearch.setCategoryId(Integer.parseInt(categoryId));
			List<Product> products = productService.findByCategory(productSearch);
			model.addAttribute("products", products);
		} else {
			// Nếu không có cái nào được chọn, hiển thị tất cả sản phẩm
			List<Product> products = productService.searchProduct(productSearch);
			model.addAttribute("products", products);
		}

		// Tim theo keyword
		productSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			productSearch.setKeyword(keyword);
			List<Product> products = productService.findByKeyword(productSearch);
			model.addAttribute("products", products);
		} else {
			// Nếu không có keyword nào được chọn, hiển thị tất cả sản phẩm
			List<Product> products = productService.searchProduct(productSearch);
			model.addAttribute("products", products);
		}

		// Ktra tieu chi tim kkiem tu năm den năm
		String beginYear = null;
		String endYear = null;
		if (!StringUtils.isEmpty(request.getParameter("beginYear"))
				&& !StringUtils.isEmpty(request.getParameter("endYear"))) {
			beginYear = request.getParameter("beginYear");
			endYear = request.getParameter("endYear");
			productSearch.setBeginYear(beginYear);
			productSearch.setEndYear(endYear);
			List<Product> products = productService.findByReleaseYear(productSearch);
			model.addAttribute("products", products);
		} else {
			// Nếu không có mức giá nào được chọn, hiển thị tất cả sản phẩm
			List<Product> products = productService.searchProduct(productSearch);
			model.addAttribute("products", products);
		}


		// Tìm theo mức giá
		String[] priceRanges = request.getParameterValues("priceRange");
		if (priceRanges != null && priceRanges.length > 0) {
			List<Product> products = productService.findByPriceRange(priceRanges);
			model.addAttribute("products", products);
		} else {
			// Nếu không có mức giá nào được chọn, hiển thị tất cả sản phẩm
			List<Product> products = productService.searchProduct(productSearch);
			model.addAttribute("products", products);
		}

		List<Category> categories = categoryService.findAllActive();
		model.addAttribute("categories", categories);

//				List<Product> products = productService.searchProduct(productSearch);
//				model.addAttribute("products", products);
		model.addAttribute("productSearch", productSearch);

		return "frontend/product";
	}

	@RequestMapping(value = "/product-detail/{productId}", method = RequestMethod.GET)
	public String detail(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("productId") int productId) {

		// Lấy sp gợi ý
		List<Product> searchProducts = productService.findAllActive();
		model.addAttribute("searchProducts", searchProducts);

		Product product = productService.getById(productId);
		model.addAttribute("product", product);

		// Lay toan bo anh của sp cần tìm
		List<ProductImage> productImages = productImageService.getProductImagesByProductId(productId);
		model.addAttribute("productImages", productImages);

		return "frontend/product-detail";
	}

	@RequestMapping(value = "/order/{loginedUserId}", method = RequestMethod.GET)
	public String getOdersByUser(@PathVariable("loginedUserId") int loginedUserId, final Model model)
			throws IOException {

		// Lấy sp gợi ý
		List<Product> searchProducts = productService.findAllActive();
		model.addAttribute("searchProducts", searchProducts);

		List<SaleOrder> saleOrders = saleOrderService.getOrdersByUserId(loginedUserId);

		// Tạo một danh sách để chứa các danh sách sản phẩm của từng đơn hàng
		List<List<SaleOrderProduct>> allSaleOrderProducts = new ArrayList<>();

		for (SaleOrder saleOrder : saleOrders) {
			List<SaleOrderProduct> saleOrderProducts = saleOrderProductService.findAllProductInOrder(saleOrder.getId());
			// Thêm danh sách sản phẩm của từng đơn hàng vào danh sách chung
			allSaleOrderProducts.add(saleOrderProducts);
		}

		// Thêm danh sách các đơn hàng và danh sách sản phẩm tương ứng vào mô hình
		model.addAttribute("saleOrders", saleOrders);
		model.addAttribute("allSaleOrderProducts", allSaleOrderProducts);

		// Trả về tên của view để hiển thị danh sách sản phẩm
		return "frontend/my_order";
	}

	@GetMapping(value = "/change-password")
	public String changePassword(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		// Lấy sp gợi ý
		List<Product> searchProducts = productService.findAllActive();
		model.addAttribute("searchProducts", searchProducts);

		return "frontend/change_password";
	}

	@PostMapping(value = "/confirmChangePassword")
	public ResponseEntity<Map<String, Object>> confirmChangePassword(@RequestBody Map<String, String> requestData,
			final Model model,
			final HttpServletRequest request) throws IOException {

		Map<String, Object> jsonResult = new HashMap<String, Object>();

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
		// Lấy dữ liệu từ ajax gửi sang
		String oldPassword = requestData.get("oldPassword");
		String newPassword = requestData.get("newPassword");
		String confirmPassword = requestData.get("confirmPassword");

		//Nội dung nhắn sang view
		String message = "";
		
		// Ktra xem 2 password mới nhâp giống nhau chưa 
		// + Khác nhau
		if (!newPassword.equals(confirmPassword)) {
			message = "*Mật khẩu mới không đồng bộ !";
		} 
		else { // Giống nhau ==> Check tiếp xem password cũ đúng như trong csdl chưa
			if(!passwordEncoder.matches(oldPassword, getLoginedUser().getPassword())) {
				message = "*Mật khẩu không đúng !";
			}
			else {
				//Nhập đúng mk rồi=>Check tiếp xem mk cũ có giống mk mới ko
				if(newPassword.equals(oldPassword)) {
					message = "*Mật khẩu mới giống mật khẩu cũ, vui lòng nhập mật khẩu khác !";
				}
				else {
					User user = userService.getById(getLoginedUser().getId()); 
					user.setPassword(new BCryptPasswordEncoder(4).encode(newPassword));
					userService.saveOrUpdate(user);
					message = "*Đổi mật khẩu thành công !";      
				}
			}
		}

		jsonResult.put("code", 200);
		jsonResult.put("message", message);

		return ResponseEntity.ok(jsonResult);
	}
}
