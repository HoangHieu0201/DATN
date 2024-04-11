package vn.devpro.TestAdmin.controller;

import java.math.BigInteger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.devpro.TestAdmin.model.User;
import vn.devpro.TestAdmin.dto.Cart;
import vn.devpro.TestAdmin.dto.Favorite;


@Configuration
public class BaseController {
	
	
	@ModelAttribute("title")
	public String projectTitle() {
		return "Mobile World";
	}
	
	@ModelAttribute("totalCartProducts")
	public BigInteger getTotalCartProducts(final HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("cart") == null) {
			return BigInteger.ZERO;
		}
		
		Cart cart = (Cart)session.getAttribute("cart");
		return cart.totalCartProduct();
	}
	
	@ModelAttribute("totalFavoriteProducts")
	public int gettotalFavoriteProducts(final HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("favorite") == null) {
			return 0;
		}
		
		Favorite favorite = (Favorite)session.getAttribute("favorite");
		return favorite.totalFavoriteProduct();
	}
	
	@ModelAttribute("checkout")
	public boolean checkout(final HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("cart") == null) {
			return false;
		}
		
		Cart cart = (Cart)session.getAttribute("cart");
		return true;
	}
	
	// Lay thong tin cua user dang nhap
	@ModelAttribute("loginedUser")
	public User getLoginedUser() {
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			return user;
		}

		return new User();
	}

	// Kiem tra da login hay chua?
	@ModelAttribute("isLogined")
	public Boolean isLogined() {
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			return true;
		}

		return false;
	}
}