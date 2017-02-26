package dao;

import java.util.ArrayList;

import model.Cart;

public interface CartDAO {

	public ArrayList<Cart> getCartItem(int cart_user_id);
	public void addCartItem(String cart_item_id, int cart_quantity, int cart_user_id );
	public boolean delCartItem(String cart_item_id, int cart_quantity, int cart_user_id);
	public boolean updateCartItem(int cart_item_id, int cart_quantity, int cart_user_id);
	
}
