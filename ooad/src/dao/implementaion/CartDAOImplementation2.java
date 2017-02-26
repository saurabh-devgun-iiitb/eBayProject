package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
		    //here the code for adding one item to the cart goes
		    sql="SELECT item_picture,item_price,seller_name,item_name from items,sellers WHERE items.items_id=? and items.item_seller_id=sellers.seller_id";
		    ps=dbConnection.connect().prepareStatement(sql);
		    ps.setInt(1,rs.getInt("cart_item_id"));
		   
		    ResultSet rs1= ps.executeQuery();
		    while(rs1.next())
		    {

		    individual_item.setCart_item_picture(rs1.getString("item_picture"));
		    individual_item.setCart_item_price(rs1.getDouble("item_price"));		    
		    individual_item.setCart_seller_name(rs1.getString("seller_name")); 
		    individual_item.setCart_item_name(rs1.getString("item_name"));
		    }
		      
		    cart_list.add(individual_item);
		    }
		    ps.close();
			dbConnection.disconnect();
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
			DBConnection dbConnection = new DBConnection();
			String ssql = "SELECT items_id FROM items where item_id='" + cart_item_id + "'";
			System.out.println(ssql);
			PreparedStatement sps = dbConnection.connect().prepareStatement(ssql);
			ResultSet rs = sps.executeQuery();
			if(rs.next()) 
				items_id = rs.getInt(1);
			sps.close();
			rs.close();
			dbConnection.disconnect();
			
			//pushps
			System.out.println(items_id);
			
			boolean newItem = true; 
			
			ssql = "SELECT cart_quantity FROM carts where cart_item_id=" + items_id +" AND cart_user_id="+cart_user_id;
			System.out.println(ssql);
			sps = dbConnection.connect().prepareStatement(ssql);
			rs = sps.executeQuery();
			
			
			if (rs.next()) { 
				
				newItem = false; 
				int new_cart_quantity = cart_quantity + rs.getInt("cart_quantity");
				System.out.println(cart_quantity);
				String usql = "UPDATE carts SET cart_quantity= "+ new_cart_quantity +" where cart_item_id = "+ items_id + " AND cart_user_id=" + cart_user_id;
		        System.out.println(usql);
			    PreparedStatement ups = dbConnection.connect().prepareStatement(usql);
			    ups.execute();
			    ups.close();
				//dbConnection.disconnect();
				
				} else {
			
		    String isql = "INSERT INTO carts (cart_user_id, cart_item_id, cart_quantity) VALUES (?, ?, ?)";
		    System.out.println(isql + "iid = " + items_id); 
		    
		    PreparedStatement ips = dbConnection.connect().prepareStatement(isql);
			ips.setInt(1, cart_user_id);
			ips.setInt(2, items_id);
			ips.setInt(3, cart_quantity);
			
		    ips.execute();
		    ips.close();
			dbConnection.disconnect();
		//System.out.println("The item added to the cart here-------------------------");
		//return true;
				}// else ends
	}
		catch(Exception e) {
			e.printStackTrace();
		}
		//return false;
	}
	
	
	//delete item functions
	
	@Override
	public void delCartItem(String cart_item_id, int cart_quantity, int cart_user_id){
		
		try {
		
			Item item = new Item();
			item.setItemId(cart_item_id);
			ItemDetails itemDetails = new ItemDAOImplementation().getItem(item);	

			DBConnection dbConnection = new DBConnection();
			String dsql = "DELETE FROM carts where cart_item_id=" + itemDetails.getItem().getSurrogateItemId() +" AND cart_user_id="+cart_user_id;
			System.out.println(dsql);
			PreparedStatement dps = dbConnection.connect().prepareStatement(dsql);
			//ResultSet rs = dps.executeQuery();
	
			    dps.execute();
			    dps.close();
				//dbConnection.disconnect();
				
				}catch(Exception e) {	e.printStackTrace();	}
		
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
	
}


