package vn.devpro.TestAdmin.dto;

import java.math.BigDecimal;
import java.math.BigInteger;

public class FavoriteProduct {

	private int productId;
	private String productName;
	private BigInteger quantity;
	private String avatar;
	private BigDecimal salePrice;

	public FavoriteProduct() {
		super();
	}

	public FavoriteProduct(int productId, String productName, BigInteger quantity, String avatar,
			BigDecimal salePrice) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.quantity = quantity;
		this.avatar = avatar;
		this.salePrice = salePrice;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public BigDecimal getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}

	public BigInteger getQuantity() {
		return quantity;
	}

	public void setQuantity(BigInteger quantity) {
		this.quantity = quantity;
	}

	
}
