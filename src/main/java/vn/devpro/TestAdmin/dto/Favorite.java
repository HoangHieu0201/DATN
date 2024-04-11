package vn.devpro.TestAdmin.dto;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import vn.devpro.TestAdmin.model.BaseModel;

public class Favorite{

	//Danh sacsh cac san pham trong gio hang
	private List<FavoriteProduct> favoriteProducts = new ArrayList<FavoriteProduct>();
	
	//Tinh tong so san pham trong gio hang
	public int totalFavoriteProduct() {		
		int total = favoriteProducts.size();
		return total;
	}
	
	
	//Tim san phamtrong gio hang theo id
	public int findProductById(int id) {
		for(int index = 0; index < favoriteProducts.size(); index ++) {
			if(favoriteProducts.get(index).getProductId() == id) {
				return index;
			}
		}
		return -1;
	}
	
	public Favorite() {
		super();
	}


	public Favorite(List<FavoriteProduct> favoriteProducts) {
		super();
		this.favoriteProducts = favoriteProducts;
	}


	public List<FavoriteProduct> getFavoriteProducts() {
		return favoriteProducts;
	}


	public void setFavoriteProducts(List<FavoriteProduct> favoriteProducts) {
		this.favoriteProducts = favoriteProducts;
	}

	
	
}
