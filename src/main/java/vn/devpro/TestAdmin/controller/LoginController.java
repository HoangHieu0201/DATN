package vn.devpro.TestAdmin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.TestAdmin.model.Role;
import vn.devpro.TestAdmin.model.User;
import vn.devpro.TestAdmin.service.RoleService;
import vn.devpro.TestAdmin.service.UserService;

@Controller
public class LoginController extends BaseController{

	@Autowired
	private RoleService roleService;
	
	@Autowired
	private UserService userService;
	
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login() throws IOException{
		return "login";
	}
	
	//Đưa tới trang đăng ký
	@RequestMapping(value="/signup", method = RequestMethod.GET)
	public String signAccount() throws IOException{
		return "signup";
	}
	
	//Hoàn thành form đăng ký
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String register(final Model model, final HttpServletRequest request,
	        final HttpServletResponse response) throws IOException {

	    List<User> users = userService.findAll();

	    // Validate username, email, mobile
	    String username = request.getParameter("username");
	    String email = request.getParameter("email");
	    String mobile = request.getParameter("mobile");
	    String password = request.getParameter("password");
	    String retypepassword = request.getParameter("retypepassword");
	    String name = request.getParameter("name");
	    String address = request.getParameter("address");

	    model.addAttribute("username", username);
	    model.addAttribute("name", name);
	    model.addAttribute("password", password);
	    model.addAttribute("retypepassword", retypepassword);
	    model.addAttribute("mobile", mobile);
	    model.addAttribute("address", address);
	    model.addAttribute("email", email);
	    
	    for(User user : users) {
	        if (username.equals(user.getUsername())) {
	            // Username đã tồn tại
	            String errorMessage1 = "*Tên người dùng đã tồn tại!";
	            model.addAttribute("errorMessage1", errorMessage1);
	            return "signup";
	        }

	        if (email.equals(user.getEmail())) {
	            // Email đã tồn tại
	            String errorMessage2 = "*Email đã được sử dụng!";
	            model.addAttribute("errorMessage2", errorMessage2);
	            return "signup";
	        }
	       
	        if (mobile.equals(user.getMobile())) {
	            // Số điện thoại đã tồn tại
	            String errorMessage3 = "*Số điện thoại đã được sử dụng!";
	            model.addAttribute("errorMessage3", errorMessage3);
	            return "signup";
	        }
	    }
	    
        // Kiểm tra xem email có đúng định dạng @gmail.com
        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            String errorMessage2 = "*Email không hợp lệ! Vui lòng sử dụng email có định dạng @gmail.com";
            model.addAttribute("errorMessage", errorMessage2);
            return "signup";
        }
	    // Kiểm tra xem hai mật khẩu nhập vào có giống nhau không
	    if (!request.getParameter("password").equals(request.getParameter("retypepassword"))) {
	        // Mật khẩu không giống nhau
	        String errorMessage = "*Mật khẩu không đồng bộ!";
	        model.addAttribute("errorMessage", errorMessage);
	        return "signup";
	    } else {
	        // Mật khẩu giống nhau, tiếp tục đăng ký
	        User user = new User();
	        user.setUsername(username);
	        user.setName(request.getParameter("name"));
	        user.setPassword(new BCryptPasswordEncoder(4).encode(request.getParameter("password")));
	        user.setEmail(email);
	        user.setMobile(mobile);
	        user.setAddress(request.getParameter("address"));

	        // Set role cho người dùng mới, mặc định là GUEST
	        Role role = roleService.getRoleByName("GUEST");
	        user.addRelationalUserRole(role);
	        userService.saveOrUpdate(user);
	        return "redirect:/login";
	    }
	    
	}

}
