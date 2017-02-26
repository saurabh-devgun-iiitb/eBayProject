package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import dao.CartDAO;
import dao.DBConnection;
import model.Cart;
import model.Item;
import model.ItemDetails;

public class CartDAOImplementation implements CartDAO {

	public ArrayList<Cart> cart_list = new ArrayList<Cart>();
	
	@Override
	public ArrayList<Cart> getCartItem(int cart_user_id) {
		// TODO Auto-generated method stub
		
try {
		
			DBConnection dbConnection = new DBConnection();
		    String sql = "SELECT * FROM carts where cart_user_id=" + cart_user_id ;
		        
		    PreparedStatement ps = dbConnection.connect().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
		    while(rs.next()){		    	
				System.out.println("The item added to the cart here-------------------------");
			    Cart individual_item = new Cart();		   
			    individual_item.setCarts_user_id(rs.getInt("cart_user_id")); 
			    individual_item.setCart_item_id(rs.getInt("cart_item_id"));
			    individual_item.setCart_quantity(rs.getInt("cart_quantity"));
			    individual_item.setCart_item_price(rs.getInt("cart_price"));
			    System.out.println("The item added to the cart here----------------" + individual_item.getCart_item_price() +"---------");
			    
			    //here the code for adding one item to the cart goes
			    sql="SELECT item_picture,item_price,seller_name,item_name from items,sellers WHERE items.items_id=? and items.item_seller_id=sellers.seller_id";
			    PreparedStatement ps1=dbConnection.connect().prepareStatement(sql);
			    ps1.setInt(1,rs.getInt("cart_item_id"));
			   
			    ResultSet rs1= ps1.executeQuery();
			    while(rs1.next())
			    {
				    individual_item.setCart_item_picture(rs1.getString("item_picture"));
				    individual_item.setCart_seller_name(rs1.getString("seller_name")); 
				    individual_item.setCart_item_name(rs1.getString("item_name"));
			    }
			      
			    cart_list.add(individual_item);
		    }
		    ps.close();
			dbConnection.disconnect();
			
			checkDeal(cart_list, cart_user_id);
		//return true;
	}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return cart_list;
	}

	@Override
	public void addCartItem(String cart_item_id, int cart_quantity, int cart_user_id) {
		// TODO Auto-generated method stub
		
		try {
			
			int items_id = 0;
			/*Item item = new Item();
			item.setItemId(cart_item_id);
			ItemDetails itemDetails = new ItemDAOImplementation().getItem(item);
		*/
			double item_price = 0.0;
			
			DBConnection dbConnection = new DBConnection();
			String ssql = "SELECT items_id, item_price FROM items where item_id='" + cart_item_id + "'";
			//System.out.println(ssql);
			PreparedStatement sps = dbConnection.connect().prepareStatement(ssql);
			System.out.println(sps.toString());
			ResultSet rs = sps.executeQuery();
			if(rs.next()) { 
				items_id = rs.getInt(1);
				item_price = rs.getDouble(2);
			}
			sps.close();
			rs.close();
			dbConnection.disconnect();
			
			//pushps
			System.out.println(items_id);
			
			boolean newItem = true; 
			
			ssql = "SELECT cart_quantity FROM carts where cart_item_id=" + items_id +" AND cart_user_id="+cart_user_id;
			//System.out.println(ssql);
			sps = dbConnection.connect().prepareStatement(ssql);
			System.out.println(sps.toString());
			rs = sps.executeQuery();
			
			
			if (rs.next()) { 
				
				newItem = false; 
				int new_cart_quantity = cart_quantity + rs.getInt("cart_quantity");
				System.out.println(cart_quantity);
				String usql = "UPDATE carts SET cart_quantity= "+ new_cart_quantity +", cart_price=" + new_cart_quantity*item_price + " where cart_item_id = "+ items_id + " AND cart_user_id=" + cart_user_id;
		        //System.out.println(usql);
			    PreparedStatement ups = dbConnection.connect().prepareStatement(usql);
			    System.out.println(ups.toString());
			    ups.execute();
			    ups.close();
				//dbConnection.disconnect();
				
				} 
			else {
			
			    String isql = "INSERT INTO carts (cart_user_id, cart_item_id, cart_quantity, cart_price) VALUES (?, ?, ?, ?)";
			    //System.out.println(isql + "iid = " + items_id); 
			    
			    PreparedStatement ips = dbConnection.connect().prepareStatement(isql);
				ips.setInt(1, cart_user_id);
				ips.setInt(2, items_id);
				ips.setInt(3, cart_quantity);
				ips.setDouble(4, cart_quantity*item_price);
				
				System.out.println(ips.toString());
			    ips.execute();
			    ips.close();
				dbConnection.disconnect();
				
		//System.out.println("The item added to the cart here-------------------------");
		//return true;
				}// else ends
			
			//getCartItem(cart_user_id);
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		//return false;
	}
	
	
	//delete item functions
	
	@Override
	public boolean delCartItem(String cart_item_id, int cart_quantity, int cart_user_id){
		
		try {
			
			DBConnection dbConnection = new DBConnection();
			String dsql = "DELETE FROM carts where cart_item_id=" + cart_item_id +" AND cart_user_id="+cart_user_id;
			System.out.println(dsql);
			PreparedStatement dps = dbConnection.connect().prepareStatement(dsql);
			//ResultSet rs = dps.executeQuery();
	
			    dps.execute();
			    dps.close();
				//dbConnection.disconnect();
				return true;
				
				}catch(Exception e) {	e.printStackTrace();
					return false;
				}
		
	}//delCartItem ends here
	
	//update item functions
	
		@Override
		public void updateCartItem(String cart_item_id, int cart_quantity, int cart_user_id){
			
			try {

				Item item = new Item();
				item.setItemId(cart_item_id);
				ItemDetails itemDetails = new ItemDAOImplementation().getItem(item);
							
				DBConnection dbConnection = new DBConnection();
				String usql = "UPADTE carts SET cart_quantity = " + cart_quantity +" WHERE cart_item_id =" + itemDetails.getItem().getSurrogateItemId() + " AND cart_user_id="+cart_user_id;
				System.out.println(usql);
				PreparedStatement ups = dbConnection.connect().prepareStatement(usql);
				//ResultSet rs = dps.executeQuery();
		
				    ups.execute();
				    ups.close();
					//dbConnection.disconnect();
					
					}catch(Exception e) {	e.printStackTrace();	}
			
		}//updateCartItem ends here
		
		public void checkDeal(ArrayList<Cart> cart, int cart_user_id ){
			HashMap<Integer, Integer> h1 = new HashMap<>();
			HashMap<Integer, Integer> h2 = new HashMap<>();
			HashMap<Integer, Integer> h3 = new HashMap<>();

			String sql = "";
			PreparedStatement ps;
			ResultSet rs;
			
			for (Cart cartItem : cart) {
				System.out.println(cartItem.getCart_item_name() + " " + cartItem.getCart_quantity());
				try {
					sql = "SELECT is_deal_item FROM items where items_id=" + cartItem.getCart_item_id();
					ps = new DBConnection().connect().prepareStatement(sql);
					rs = ps.executeQuery();
						
					if (rs.next()) { 
						if(rs.getInt(1) == 	1) {
							sql = "SELECT deal_id FROM deals WHERE deal_item_one=" + cartItem.getCart_item_id();
							ResultSet rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery(); 
							if(rs1.next()) 
								h1.put(rs1.getInt(1), cartItem.getCart_quantity());
							rs1.close();
							
							sql = "SELECT deal_id FROM deals WHERE deal_item_two=" + cartItem.getCart_item_id();
							rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery();
							if(rs1.next()) 
								h2.put(rs1.getInt(1), cartItem.getCart_quantity());
							rs1.close();
							
							sql = "SELECT deal_id FROM deals WHERE deal_item_free=" + cartItem.getCart_item_id();
							rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery();
							if(rs1.next()) 
								h3.put(rs1.getInt(1), cartItem.getCart_quantity());
						}
					}
					rs.close();
				}
				catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			try {
			System.out.println("Hash1 Values");
			for (int dealId : h1.keySet()) {
				int min = 0;
				System.out.println(dealId + " " + h1.get(dealId));
				
				if(h2.containsKey(dealId)) {
					System.out.println("Valid");
					min = Integer.MAX_VALUE;
					if(h1.get(dealId) <= min)
						min = h1.get(dealId);
					if(h2.get(dealId) <= min) 
						min = h2.get(dealId);
					//min = Integer.min(h1.get(dealId), h2.get(dealId));
					System.out.println("--="+min);
					if(h3.containsKey(dealId)) {
						sql = "SELECT deal_item_free FROM deals WHERE deal_id=" + dealId;
						rs = new DBConnection().connect().prepareStatement(sql).executeQuery();
						min = min - h3.get(dealId);
						System.out.println(sql);
						System.out.println("Quantity : " + min);
						if(min >= 0 && rs.next()) {
							sql = "UPDATE carts SET cart_quantity = cart_quantity + " + min + " , cart_price = 0.0 WHERE cart_item_id=" + rs.getInt(1);
							System.out.println(sql);
							new DBConnection().connect().prepareStatement(sql).execute();
						}
						if (min < 0 && rs.next()) {
							sql = "SELECT item_price FROM items WHERE items_id = " + rs.getInt(1);
							ResultSet rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery(); 
							System.out.println(rs1.toString());
							double price = 0.0;
							if(rs1.next()) {
								price = Math.abs(min) * rs1.getDouble(1);
							}
							sql = "UPDATE carts SET cart_price = " + price + " WHERE cart_item_id=" + rs.getInt(1);
							System.out.println(sql);
							new DBConnection().connect().prepareStatement(sql).execute();
						}
						h3.remove(dealId);
					}
					else {
						sql = "SELECT deal_item_free FROM deals WHERE deal_id=" + dealId;
						rs = new DBConnection().connect().prepareStatement(sql).executeQuery();
						
						if(rs.next()) {
							sql = "INSERT INTO carts (cart_user_id, cart_item_id, cart_quantity, cart_price) VALUES (?, ?, ?, ?)";
						    PreparedStatement ps1 = new DBConnection().connect().prepareStatement(sql); 
						    ps1.setInt(1, cart_user_id);
							ps1.setInt(2, rs.getInt(1));
							ps1.setInt(3, min);
							
							sql = "SELECT item_price FROM items WHERE items_id = " + rs.getInt(1);
							ResultSet rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery(); 
							System.out.println(rs1.toString());
							double price = 0.0;
							/*if(rs1.next()) {
								price = Math.abs(min) * rs.getDouble(1);
							}*/
							ps1.setDouble(4, price);
							
							System.out.println(ps1.toString());
							ps1.execute();
							
						}
					}
					h2.remove(dealId);
					//h3.put(dealId, value)
				}
				else {
					System.out.println("Invalid");
					if(h3.containsKey(dealId)) {
						sql = "SELECT deal_item_free FROM deals WHERE deal_id=" + dealId;
						rs = new DBConnection().connect().prepareStatement(sql).executeQuery();
						
						if(rs.next()) {
							sql = "SELECT item_price, cart_quantity FROM items, carts WHERE cart_item_id = items_id AND items_id = " + rs.getInt(1);
							ResultSet rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery(); 
							System.out.println(rs1.toString());
							double price = 0.0;
							if(rs1.next()) {
								price = rs1.getInt(2) * rs1.getDouble(1);
							}
							sql = "UPDATE carts SET cart_price = " + price + " WHERE cart_item_id=" + rs.getInt(1);
							System.out.println(sql);
							new DBConnection().connect().prepareStatement(sql).execute();
						}
					}
				}
				
			}
			
			System.out.println("Hash2 Values");
			
			for (int dealId : h2.keySet()) {
				System.out.println(dealId + " " + h2.get(dealId));
			
				System.out.println("Invalid");
				if(h3.containsKey(dealId)) {
					sql = "SELECT deal_item_free FROM deals WHERE deal_id=" + dealId;
					rs = new DBConnection().connect().prepareStatement(sql).executeQuery();
					
					if(rs.next()) {
						sql = "SELECT item_price, cart_quantity FROM items, carts WHERE cart_item_id = items_id AND items_id = " + rs.getInt(1);
						ResultSet rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery(); 
						System.out.println(rs1.toString());
						double price = 0.0;
						if(rs1.next()) {
							price = rs1.getInt(2) * rs1.getDouble(1);
						}
						sql = "UPDATE carts SET cart_price = " + price + " WHERE cart_item_id=" + rs.getInt(1);
						System.out.println(sql);
						new DBConnection().connect().prepareStatement(sql).execute();
					}
				}
			}
			
			System.out.println("Hash3 Values");
			for (int dealId : h3.keySet()) {
				System.out.println(dealId + " " + h3.get(dealId));
			}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}

}


