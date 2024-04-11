package vn.devpro.TestAdmin.controller.backend;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.devpro.TestAdmin.controller.BaseController;
import vn.devpro.TestAdmin.model.Role;
import vn.devpro.TestAdmin.model.User;
import vn.devpro.TestAdmin.service.CategoryService;
import vn.devpro.TestAdmin.service.ProductService;
import vn.devpro.TestAdmin.service.RoleService;
import vn.devpro.TestAdmin.service.UserService;


@Controller
@RequestMapping("/admin/admins/")
public class AdminListController extends BaseController{
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model) {
		
		//List<User> users = userService.findAll();
		List<User> users = userService.getAdmins();
		model.addAttribute("users", users);
		
		return "backend/admin-list";
	}
	
}

