package vn.devpro.TestAdmin.controller.frontend;

import java.io.IOException;
import java.math.BigInteger;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.TestAdmin.dto.FinalConstant;
import vn.devpro.TestAdmin.controller.BaseController;
import vn.devpro.TestAdmin.dto.Cart;
import vn.devpro.TestAdmin.dto.ProductCart;
import vn.devpro.TestAdmin.model.Product;
import vn.devpro.TestAdmin.service.ProductService;
import vn.devpro.TestAdmin.service.SaleOrderService;
import vn.devpro.TestAdmin.service.UserService;
import vn.devpro.TestAdmin.dto.Customer;
import vn.devpro.TestAdmin.dto.Favorite;
import vn.devpro.TestAdmin.dto.FavoriteProduct;
import vn.devpro.TestAdmin.model.SaleOrder;
import vn.devpro.TestAdmin.model.SaleOrderProduct;
import vn.devpro.TestAdmin.model.User;

@Controller
public class FavoriteController extends BaseController implements FinalConstant {

	@Autowired
	private ProductService productService;

	@Autowired
	private SaleOrderService saleOrderService;
	
	@Autowired
	private UserService userService;
	

//	// Them mot san pham vao gio hang
	@RequestMapping(value = "/add-to-favorite", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addToFavorite(final Model model, final HttpServletRequest request,
			@RequestBody FavoriteProduct addProduct) throws IOException {

		Map<String, Object> jsonResult = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		Favorite favorite = null;

		// Lay ds yeu thich trong sesstion
		// + Kiem tra ds yeu thích da dc tao trong session chua?
		if (session.getAttribute("favorite") != null) { // da co 
			favorite = (Favorite) session.getAttribute("favorite"); // Lay ds
		} else { // Chua tao gio hang
			favorite = new Favorite();
			session.setAttribute("favorite", favorite);
		}

		// Lay san pham trong db
		Product dbProduct = productService.getById(addProduct.getProductId());

		// Kiem tra san pham thêm vào co trong gio ds
		int index = favorite.findProductById(dbProduct.getId());
		if (index != -1) // San pham da co trong ds ==> ko cho thêm và đưa ra thông báo
		{
			jsonResult.put("message", "Đã có sản phẩm " + addProduct.getProductName() + " trong danh sách yêu thích");
		} 
		else // Chua co trong ds
		{
			addProduct.setProductName(dbProduct.getName());
			addProduct.setAvatar(dbProduct.getAvatar());
			addProduct.setSalePrice(dbProduct.getSalePrice());

			favorite.getFavoriteProducts().add(addProduct); // Them san pham moi vao ds
			jsonResult.put("message", "Đã thêm sản phẩm " + addProduct.getProductName() + " vào danh sách yêu thích");
			
			// Thiet lap lai gio hang trong session
			session.setAttribute("favorite", favorite);
			// Tra ve du lieu cho view
			jsonResult.put("code", 200);
			jsonResult.put("totalFavoriteProducts", favorite.totalFavoriteProduct());
		}

		return ResponseEntity.ok(jsonResult);
	}

	// Hien thi favorite
	@RequestMapping(value = "/favorite-view", method = RequestMethod.GET)
	public String cartView(final Model model,
			final HttpServletRequest request) throws IOException {

		// Lấy sp gợi ý
		List<Product> searchProducts = productService.findAllActive();
		model.addAttribute("searchProducts", searchProducts);

		HttpSession session = request.getSession();
		if (session.getAttribute("favorite") != null) {
			Favorite favorite = (Favorite) session.getAttribute("favorite");

			String message = "Có tổng cộng " + favorite.totalFavoriteProduct() + " sản phẩm trong danh sách yêu thích";
			model.addAttribute("message", message);
		} else {
			String errorMessage = "Không có sản phẩm nào trong danh sách yêu thích";
			model.addAttribute("errorMessage", errorMessage);
		}
		
		return "frontend/favorite-view";
	}


	// xoa san pham vao gio hang
		@RequestMapping(value = "/deleteFavoriteProduct", method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> deleteCartProduct(final Model model, final HttpServletRequest request,
				@RequestBody FavoriteProduct deleteProduct) throws IOException {

			HttpSession session = request.getSession();
			Favorite favorite = (Favorite) session.getAttribute("favorite"); // Lay ds yt

			// Tìm vị trí sp trong ds
			int index = favorite.findProductById(deleteProduct.getProductId());
			// Xoá sp
			favorite.getFavoriteProducts().remove(index);

			// Thiet lap lai gio hang trong session
			session.setAttribute("favorite", favorite);

			// Tra ve du lieu cho view
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			// Lay san pham trong db
			Product dbProduct = productService.getById(deleteProduct.getProductId());
			jsonResult.put("message", "Đã xoá sản phẩm " + dbProduct.getName() + " khỏi danh sách yêu thích");

			return ResponseEntity.ok(jsonResult);
		}

	
}
