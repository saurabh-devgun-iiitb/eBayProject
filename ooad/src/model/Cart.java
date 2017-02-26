package model;

public class Cart{

	private int cart_item_id;
	private String cart_item_name;
	private int cart_quantity;
	private int carts_user_id;
	private String cart_item_picture;
	private String cart_seller_name;
	private double cart_item_price;
	private double item_price;
	private int cart_quantity_valid;
	
	public int getCart_item_id() {
		return cart_item_id;
	}

	public void setCart_item_id(int cart_item_id) {
		this.cart_item_id = cart_item_id;
	}

	public int getCart_quantity() {
		return cart_quantity;
	}

	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}

	public int getCarts_user_id() {
		return carts_user_id;
	}

	public void setCarts_user_id(int carts_user_id) {
		this.carts_user_id = carts_user_id;
	}

	public String getCart_item_picture() {
		return cart_item_picture;
	}

	public void setCart_item_picture(String cart_item_picture) {
		this.cart_item_picture = cart_item_picture;
	}

	public String getCart_seller_name() {
		return cart_seller_name;
	}

	public void setCart_seller_name(String cart_seller_name) {
		this.cart_seller_name = cart_seller_name;
	}

	public double getCart_item_price() {
		return cart_item_price;
	}

	public void setCart_item_price(double cart_item_price) {
		this.cart_item_price = cart_item_price;
	}

	public String getCart_item_name() {
		return cart_item_name;
	}

	public void setCart_item_name(String cart_item_name) {
		this.cart_item_name = cart_item_name;
	}

	public int getCart_quantity_valid() {
		return cart_quantity_valid;
	}

	public void setCart_quantity_valid(int cart_quantity_valid) {
		this.cart_quantity_valid = cart_quantity_valid;
	}

	public double getItem_price() {
		return item_price;
	}

	public void setItem_price(double item_price) {
		this.item_price = item_price;
	}
	
	
}
