package action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.ItemDAO;
import dao.implementaion.CartDAOImplementation;
import dao.implementaion.ItemDAOImplementation;
import model.Cart;
import model.Item;
import model.ItemDetails;
import java.sql.*;

@SuppressWarnings("serial")
public class CartAction extends ActionSupport implements ModelDriven<Item>,SessionAware{

	Item newItem = new Item();
	
	private Map<String, Object> sessionMap;
	public ArrayList<Cart> cart_items_list = new ArrayList<Cart>();

	public CartDAOImplementation cartdaoimp = new CartDAOImplementation();
	//private Map m;	

	private int qty;
	private String id;
	
	private String address;
	
	public String execute(){
		
		//String userid = (String)sessionmap.getAttribute("userId");
		//System.out.println(userid);		
		System.out.println("this is the item id" + newItem.getItemId());
		System.out.println("this is the item quantity" + newItem.getItemQuantityToPurchase());
		System.out.println("this is the surrogate id of user" + sessionMap.get("surrogate"));
		
		cartdaoimp.addCartItem(newItem.getItemId(), newItem.getItemQuantityToPurchase(),Integer.parseInt((String)sessionMap.get("surrogate")));
		
		cart_items_list = cartdaoimp.getCartItem(Integer.parseInt((String)sessionMap.get("surrogate")));
		
		System.out.println("THis will display the items of this user");
		for(Cart c:cart_items_list){
			System.out.println("item id"+c.getCart_item_id());
			System.out.println("item picture"+c.getCart_item_picture());
			System.out.println("item price"+c.getCart_item_price());
			System.out.println("item quantity"+c.getCart_quantity());
			System.out.println("item seller name"+c.getCart_seller_name());
			System.out.println("item user id"+c.getCarts_user_id());
			
			
		}
		
		return "success";

		// System.out.println(m.get("userId"));
		//String itemId=newItem.getItemId();
		 
		// int rtitemQuantity = newItem.getItemQuantityToPurchase();
		 
		// here we will try to store this data into the cart table
		 
		 
		 
		
		//int quantity = request.getParameter("itemQuantity");
		
		//request.get
		
		 
		
		
	}
	
	public String getCart(){
		
		cart_items_list = cartdaoimp.getCartItem(Integer.parseInt((String)sessionMap.get("surrogate")));
		if(cart_items_list==null)
		{
		return "error";
		}
		else
		{
			return "success";
		}
	}
	
	public String updateCart() {
		System.out.println("Update Cart in cartaction " + id + " " + qty);
		if(cartdaoimp.updateCartItem(Integer.parseInt(id), qty, Integer.parseInt((String)sessionMap.get("surrogate")))) {
			return SUCCESS;
		}
		return ERROR;
	}
	
	public String payCart(){
		
		sessionMap.put("address", getAddress());
		
		return getCart();
	}
	
	public String delCart() {

		System.out.println("this is the item id" + id);
		System.out.println("this is the item quantity" + qty);
		System.out.println("this is the surrogate id of user" + sessionMap.get("surrogate"));

		if(new CartDAOImplementation().delCartItem(id, qty, Integer.parseInt((String) sessionMap.get("surrogate")))) {
			return "success";
		}
		return "error";
	}
//	public String addDealCart(){
//		
//		
//	}

//	
//
//public synchronized int getNumberOfItems() { 
//	setNumberOfItems(0); 
//	for (Item scItem : this.getItems()) { 
//		setNumberOfItems(scItem.getQuantity()); 
//		} 
//	
//	return getNumberOfItems(); 
//	}
//
//public synchronized double getSubtotal() { 
//	
//	double amount = 0; 
//	for (Item scItem : items) { 
//			Product product = (Product) scItem.getProduct(); 
//			amount += (scItem.getQuantity() * product.getPrice().doubleValue());
//			} 
//	return amount;
//	
//  }
//
//public synchronized void calculateTotal(String surcharge) { 
//	
//	double amount = 0; 
//	
//	// cast surcharge as double 
//		double s = Double.parseDouble(surcharge); 
//		amount = this.getSubtotal(); 
//		amount += s; 
//		total = amount;
//		
//	}
//
//public synchronized double getTotal() { 
//	
//	return total; 
//	}
//
//public synchronized void clear() { 
//	items.clear(); 
//	numberOfItems = 0; 
//	total = 0;
//	} 

@Override
public Item getModel() {
	return newItem;
}



@Override
public void setSession(Map<String, Object> map) {
	// TODO Auto-generated method stub
	this.sessionMap=map;
	
	//System.out.println("The user id in setSession is " + map.get("userid"));
}

public int getQty() {
	return qty;
}

public void setQty(int qty) {
	this.qty = qty;
}

public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}

}




