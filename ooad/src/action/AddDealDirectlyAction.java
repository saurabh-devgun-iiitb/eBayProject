package action;

import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.implementaion.CartDAOImplementation;
import model.Cart;
import model.DealComboItem;

public class AddDealDirectlyAction extends ActionSupport implements ModelDriven<DealComboItem>{
	
	
 DealComboItem dealComboItem = new DealComboItem();
 
 Map<String, Object> session = ActionContext.getContext().getSession();
	public ArrayList<Cart> cart_items_list = new ArrayList<Cart>();

	public CartDAOImplementation cartdaoimp = new CartDAOImplementation();
	//private Map m;	
	
	public String execute() {
		
		//String userid = (String)sessionmap.getAttribute("userId");
		//System.out.println(userid);
			
		System.out.println("this is the item id" + dealComboItem.getItem_one().getItem_id());
		System.out.println(Integer.parseInt((String)session.get("surrogate")));
		
		cartdaoimp.addCartItem(dealComboItem.getItem_one().getItem_id(), 1 ,Integer.parseInt((String)session.get("surrogate")));
		cartdaoimp.addCartItem(dealComboItem.getItem_two().getItem_id(), 1 ,Integer.parseInt((String)session.get("surrogate")));
		cartdaoimp.addCartItem(dealComboItem.getItem_three().getItem_id(), 1 ,Integer.parseInt((String)session.get("surrogate")));
		
		
		cart_items_list = cartdaoimp.getCartItem(Integer.parseInt((String)session.get("surrogate")));
		
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
	
 
 
 
 
 
 
 
 
 

@Override
public DealComboItem getModel() {
	// TODO Auto-generated method stub
	return dealComboItem;
}
 
 

}
