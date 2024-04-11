package vn.devpro.TestAdmin.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "tbl_user")
public class User extends BaseModel implements UserDetails{
	
	@Column(name = "username", length = 120, nullable = false)
	private String username;
	
	@Column(name = "password", length = 120, nullable = false)
	private String password;
	
	@Column(name = "name", length = 120, nullable = true)
	private String name;
	
	@Column(name = "email", length = 200, nullable = true)
	private String email;
	
	@Column(name = "mobile", length = 60, nullable = true)
	private String mobile;
	
	@Column(name = "address", length = 300, nullable = true)
	private String address;
	
	@Column(name = "avatar", length = 300, nullable = true)
	private String avatar;
	
	@Column(name = "description", length = 500, nullable = true)
	private String Description;
	
//	-----------Mapping many-to-many: tbl_user-to-tbl_role--------------------------
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "users")
	private List<Role> roles = new ArrayList<Role>();	
	
	//Add and mremove elements out of relational user-role list
	public void addRelationalUserRole(Role role) {
		role.getUsers().add(this);
		roles.add(role);
	}
	
	public void removeRelationalUserRole(Role role) {
		role.getUsers().remove(this);
		roles.remove(null);
	}
	
	
//	-----------Mapping one-to-many: user-to-sale_order (user in saleOder)--------------------------
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	private Set<SaleOrder> saleOrders = new HashSet<SaleOrder>();	
	
	//Method add and remove elements in relational product list
	public void addRelationalUserInSaleOrder(SaleOrder saleOrder) {
		saleOrders.add(saleOrder);
		saleOrder.setUserCreateSaleOrder(this);
	}	
	
	
//	-----------Mapping one-to-many: user-to-sale_order (user create saleOder)--------------------------
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateSaleOrder")
	private Set<SaleOrder> userCreateSaleOrders = new HashSet<SaleOrder>();
	
	//Method add and remove elements in relational product list
	public void addRelationalUserCreateSaleOrder(SaleOrder saleOrder) {
		userCreateSaleOrders.add(saleOrder);
		saleOrder.setUserCreateSaleOrder(this);
	}
	
	public void removeRelationalUserCreateSaleOrder(SaleOrder saleOrder) {
		userCreateSaleOrders.remove(saleOrder);
		saleOrder.setUserCreateSaleOrder(null);
	}
	
//	-----------Mapping one-to-many: user-to-sale_order (user update saleOder)--------------------------
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateSaleOrder")
	private Set<SaleOrder> userUpdateSaleOrders = new HashSet<SaleOrder>();
	
	//Method add and remove elements in relational product list
	public void addRelationalUserUpdateSaleOrder(SaleOrder saleOrder) {
		userUpdateSaleOrders.add(saleOrder);
		saleOrder.setUserUpdateSaleOrder(this);
	}
	
	public void removeRelationalUserUpdateSaleOrder(SaleOrder saleOrder) {
		userCreateSaleOrders.remove(saleOrder);
		saleOrder.setUserUpdateSaleOrder(null);
	}	

//	 Mapping one-to-many: tbl_user-to-tbl_category (user create category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateCategory")
	private Set<Category> userCreateCategories = new HashSet<Category>();

	public void addRelationalUserCreateCategory(Category category) {
		userCreateCategories.add(category);
		category.setUserCreateCategory(this);
	}

	public void removeRelationalUserCreateCategory(Category category) {
		userCreateCategories.remove(category);
		category.setUserCreateCategory(null);
	}

//	 Mapping one-to-many: tbl_user-to-tbl_category (user update category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateCategory")
	private Set<Category> userUpdateCategories = new HashSet<Category>();

	public void addRelationalUserUpdateCategory(Category category) {
		userUpdateCategories.add(category);
		category.setUserUpdateCategory(this);
	}

	public void removeRelationalUserUpdateCategory(Category category) {
		userUpdateCategories.remove(category);
		category.setUserUpdateCategory(null);
	}
	
	
	// -------------------------Mapping one-to-many: tbl_user-to-tbl_product (user create product)-------------------------------
	//
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateProduct")
	private Set<Product> userCreateProducts = new HashSet<Product>();

	public void addRelationalUserCreateProduct(Product product) {
		userCreateProducts.add(product);
		product.setUserCreateProduct(this);
	}

	public void removeRelationalUserCreateProduct(Product product) {
		userCreateProducts.remove(product);
		product.setUserCreateProduct(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_product (user update product)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateProduct")
	private Set<Product> userUpdateProducts = new HashSet<Product>();

	public void addRelationalUserUpdateProduct(Product product) {
		userUpdateProducts.add(product);
		product.setUserUpdateProduct(this);
	}

	public void removeRelationalUserUpdateProduct(Product product) {
		userUpdateProducts.remove(product);
		product.setUserUpdateProduct(null);
	}
	
	
	// Mapping many-to-one: tbl_user-to-tbl_user (for create user)
		@ManyToOne(fetch = FetchType.EAGER)
		@JoinColumn(name = "create_by")
		private User userCreateUser;

		// Mapping many-to-one: tbl_user-to-tbl_user (for update user)
		@ManyToOne(fetch = FetchType.EAGER)
		@JoinColumn(name = "update_by")
		private User userUpdateUser;

	
	
//-----------------------------------------------------------------------------------------------------------------------
	
	public User() {
		super();
	}

	
	
	public User(Integer id, Date createDate, Date updateDate, Boolean status, String username, String password, String name,
		String email, String mobile, String address, String avatar, String description, List<Role> roles,
		Set<Category> userCreateCategories, Set<Category> userUpdateCategories, Set<Product> userCreateProducts,
		Set<Product> userUpdateProducts, User userCreateUser, User userUpdateUser) {
	super(id, createDate, updateDate, status);
	this.username = username;
	this.password = password;
	this.name = name;
	this.email = email;
	this.mobile = mobile;
	this.address = address;
	this.avatar = avatar;
	Description = description;
	this.roles = roles;
	this.userCreateCategories = userCreateCategories;
	this.userUpdateCategories = userUpdateCategories;
	this.userCreateProducts = userCreateProducts;
	this.userUpdateProducts = userUpdateProducts;
	this.userCreateUser = userCreateUser;
	this.userUpdateUser = userUpdateUser;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public Set<Category> getUserCreateCategories() {
		return userCreateCategories;
	}

	public void setUserCreateCategories(Set<Category> userCreateCategories) {
		this.userCreateCategories = userCreateCategories;
	}

	public Set<Category> getUserUpdateCategories() {
		return userUpdateCategories;
	}

	public void setUserUpdateCategories(Set<Category> userUpdateCategories) {
		this.userUpdateCategories = userUpdateCategories;
	}

	public Set<Product> getUserCreateProducts() {
		return userCreateProducts;
	}

	public void setUserCreateProducts(Set<Product> userCreateProducts) {
		this.userCreateProducts = userCreateProducts;
	}

	public Set<Product> getUserUpdateProducts() {
		return userUpdateProducts;
	}

	public void setUserUpdateProducts(Set<Product> userUpdateProducts) {
		this.userUpdateProducts = userUpdateProducts;
	}

	public User getUserCreateUser() {
		return userCreateUser;
	}

	public void setUserCreateUser(User userCreateUser) {
		this.userCreateUser = userCreateUser;
	}

	public User getUserUpdateUser() {
		return userUpdateUser;
	}

	public void setUserUpdateUser(User userUpdateUser) {
		this.userUpdateUser = userUpdateUser;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return this.roles;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

	
	
}
