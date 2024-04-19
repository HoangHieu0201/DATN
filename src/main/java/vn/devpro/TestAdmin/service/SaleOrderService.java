package vn.devpro.TestAdmin.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import vn.devpro.TestAdmin.dto.SearchModel;
import vn.devpro.TestAdmin.model.SaleOrder;
import vn.devpro.TestAdmin.model.User;

@Service
public class SaleOrderService extends BaseService<SaleOrder> {

	@Autowired
	private UserService userService;

	@Override
	public Class<SaleOrder> clazz() {
		return SaleOrder.class;
	}

//	@Transactional
//	public SaleOrder saveOrder(SaleOrder saleOrder) {
//		return super.saveOrUpdate(saleOrder);
//	}

	@Transactional
	public SaleOrder saveOrder(SaleOrder saleOrder) {
		// Kiểm tra và thiết lập giá trị cho trường user trước khi lưu
		if (saleOrder.getUser() == null && saleOrder.getUserCreateSaleOrder() != null) {
			// Lấy thông tin người dùng từ UserService (hoặc từ nguồn dữ liệu phù hợp)
			User user = saleOrder.getUserCreateSaleOrder();
			// Thiết lập giá trị user cho saleOrder
			saleOrder.setUser(user);
		}
		return super.saveOrUpdate(saleOrder);
	}

//	@Transactional
//	public SaleOrder saveOrder(SaleOrder saleOrder) {
//		// Kiểm tra và thiết lập giá trị cho trường user trước khi lưu
//		if (saleOrder.getUser() == null && saleOrder.getUserCreateSaleOrder() != null) {
//			// Lấy thông tin người dùng từ UserService (hoặc từ nguồn dữ liệu phù hợp)
//			User user = userService.getById(saleOrder.getUserCreateSaleOrder().getId());
//			// Thiết lập giá trị user cho saleOrder
//			saleOrder.setUser(user);
//		}
//		return super.saveOrUpdate(saleOrder);
//	}

	public List<SaleOrder> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_sale_order WHERE status = 1");
	}

	@Transactional
	public void deleteSaleOrderId(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveSaleOrder(SaleOrder saleOrder) {
		super.saveOrUpdate(saleOrder);
	}

	// ------------------------------------Search
	// sale-order---------------------------------------------

	public List<SaleOrder> searchSaleOrder(SearchModel saleOrderSearch) {
		// Tao cau lenhj sql
		String sql = "SELECT * FROM tbl_sale_order p WHERE 1 = 1";

		// Tim kiem tvoi tieu chi status
		if (saleOrderSearch.getStatus() != 2) { // co chon active/inavtive
			sql += " AND p.status=" + saleOrderSearch.getStatus();
		}

		// Tim kiem voi tieu chi keyword
		if (!StringUtils.isEmpty(saleOrderSearch.getKeyword())) {

			String keyword = saleOrderSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(p.code) like '%" + keyword + "%'" + " OR LOWER(p.customer_name) like '%" + keyword
					+ "%'" + " OR LOWER(p.customer_mobile) like '%" + keyword + "%')";
		}

		// tim kiem voi ngay thang
		if (!StringUtils.isEmpty(saleOrderSearch.getBeginDate())
				&& !StringUtils.isEmpty(saleOrderSearch.getEndDate())) {
			String beginDate = saleOrderSearch.getBeginDate();
			String endDate = saleOrderSearch.getEndDate();

			sql += " AND p.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}

		return super.executeNativeSql(sql);
	}

	// Lấy các đơn hàng của 1 khách hàng
	public List<SaleOrder> getOrdersByUserId(int userId) {
		String sql = "SELECT * FROM tbl_sale_order WHERE user_id ='" + userId + "' ORDER BY create_date DESC";

		return super.executeNativeSql(sql);
	}
	

	public List<BigDecimal> getMoneyByMonths(int year) {
		List<BigDecimal> dashboardRevenue = new ArrayList<>();

		for (int i = 1; i <= 12; i++) {
			BigDecimal revenue = (BigDecimal) entityManager.createNativeQuery(
					"SELECT COALESCE(SUM(total), 0) FROM tbl_sale_order WHERE status = 1 AND YEAR(create_date) = :year AND MONTH(create_date) = :month")
					.setParameter("year", year).setParameter("month", i).getSingleResult();
			dashboardRevenue.add(revenue);
		}
		return dashboardRevenue;
	}
}
