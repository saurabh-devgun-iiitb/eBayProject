package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
				    individual_item.setItem_price(rs1.getDouble("item_price"));
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
			int quantity = 0;
			DBConnection dbConnection = new DBConnection();
			String ssql = "SELECT items_id, item_price, item_quantity_available FROM items where item_id='" + cart_item_id + "'";
			//System.out.println(ssql);
			PreparedStatement sps = dbConnection.connect().prepareStatement(ssql);
			System.out.println(sps.toString());
			ResultSet rs = sps.executeQuery();
			if(rs.next()) { 
				items_id = rs.getInt(1);
				item_price = rs.getDouble(2);
				quantity = rs.getInt(3);
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
			
			    String isql = "INSERT INTO carts (cart_user_id, cart_item_id, cart_quantity, cart_price, cart_item_quantity) VALUES (?, ?, ?, ?, ?)";
			    //System.out.println(isql + "iid = " + items_id); 
			    
			    PreparedStatement ips = dbConnection.connect().prepareStatement(isql);
				ips.setInt(1, cart_user_id);
				ips.setInt(2, items_id);
				ips.setInt(3, cart_quantity);
				ips.setDouble(4, cart_quantity*item_price);
				ips.setInt(5, quantity);
				
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
		public boolean updateCartItem(int cart_item_id, int cart_quantity, int cart_user_id){
			
	        try {
	        	int quantity = 0;
	        	int item_quantity = 0;
	        	
	        	String sql = "SELECT cart_quantity, cart_item_quantity FROM carts WHERE cart_item_id=" + cart_item_id + " AND cart_user_id = " + cart_user_id;
	        	PreparedStatement ps2 = new DBConnection().connect().prepareStatement(sql);
				ResultSet rs2 = ps2.executeQuery();
				if(rs2.next()) {
					quantity = rs2.getInt(1);
					item_quantity = rs2.getInt(2);
				}
				
				System.out.println(ps2.toString() + " qty=" + quantity + " qtyAvail=" + item_quantity);
				ps2.close();
				rs2.close();
				
				sql = "SELECT item_id FROM items WHERE items_id=" + cart_item_id + " AND item_quantity_available >= " + cart_quantity;	//	surrogate id
	        	System.out.println(sql);
				ps2 = new DBConnection().connect().prepareStatement(sql);
				rs2 = ps2.executeQuery();
				
				if(rs2.next()) {
					sql = "SELECT item_price FROM items WHERE items_id=" + cart_item_id;	//	surrogate id
		        	System.out.println(sql);
					PreparedStatement ps = new DBConnection().connect().prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					if(rs.next()) {

						String usql;
						
						if(cart_quantity == 0) {
							usql = "DELETE FROM carts WHERE cart_item_id=" + cart_item_id + " AND cart_user_id="+cart_user_id;
							System.out.println(usql);
							PreparedStatement ups = new DBConnection().connect().prepareStatement(usql);
							ups.execute();
						    ups.close();
						}
						else {
							usql = "UPDATE carts SET cart_quantity=" + cart_quantity +", cart_price=" + cart_quantity * rs.getDouble(1) + 
									" WHERE cart_item_id=" + cart_item_id + " AND cart_user_id="+cart_user_id;
							System.out.println(usql);
							PreparedStatement ups = new DBConnection().connect().prepareStatement(usql);
							ups.execute();
						    ups.close();
						}						
					}
				   	ps.close();	
				}
	        }
		    catch(Exception e){
		        e.printStackTrace();
		        return false;
		    }

			return true;
			
/*			try {

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
*/			
		}//updateCartItem ends here
		
		public void checkDeal(ArrayList<Cart> cart, int cart_user_id ){
		
			System.out.println("CheckDeal ------------------");
			
			HashMap<Integer, Integer> h1 = new HashMap<>();
			HashMap<Integer, Integer> h2 = new HashMap<>();
			HashMap<Integer, Integer> h3 = new HashMap<>();
			int count =0;
			int rahul =0;
			int d1=0;
			int d2=0;
			int d3=0;
			int c1 =0;
			int c2 =0;
			HashMap<Integer, Integer> case1 = new HashMap<>();
			HashMap<Integer, Integer> case2 = new HashMap<>(); 

			String sql = "";
			PreparedStatement ps;
			ResultSet rs;
			double anubhav;
			
			
			for (Cart cartItem : cart) {
				anubhav = 0;
				System.out.println(cartItem.getCart_item_name() + " " + cartItem.getCart_quantity());
				try {
					sql = "SELECT is_deal_item,item_price FROM items where items_id=" + cartItem.getCart_item_id();
					ps = new DBConnection().connect().prepareStatement(sql);
					System.out.println(ps.toString());
					rs = ps.executeQuery();
						count =0;
						rahul = 0;
						c1 =0;
						c2 =0;
					if (rs.next()) { 
						anubhav = rs.getDouble(2);
						if(rs.getInt(1) == 	1) {
							sql = "SELECT deal_id FROM deals WHERE deal_item_one=" + cartItem.getCart_item_id();
							ResultSet rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery(); 
							if(rs1.next()) 
							{   d1 = rs1.getInt(1);
								count ++;
								rahul ++;
								c1++;
								h1.put(d1, cartItem.getCart_quantity());
							}
							rs1.close();
							
							sql = "SELECT deal_id FROM deals WHERE deal_item_two=" + cartItem.getCart_item_id();
							rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery();
							if(rs1.next()) 
							{	d2 = rs1.getInt(1);
								count ++;
								rahul ++;
								c2++;
								h2.put(rs1.getInt(1), cartItem.getCart_quantity());
							}
							rs1.close();
							
							sql = "SELECT deal_id FROM deals WHERE deal_item_free=" + cartItem.getCart_item_id();
							rs1 = new DBConnection().connect().prepareStatement(sql).executeQuery();
							if(rs1.next()) 
							{	d3 = rs1.getInt(1);
								count ++;
								c1++;
								c2++;
								h3.put(rs1.getInt(1), cartItem.getCart_quantity());
							}
							rs1.close();
							if(count == 3)
							{ 
								int qty = (cartItem.getCart_quantity());
								
								System.out.println("qty = "+qty);
								int qty1  = qty;
								int free = 0;					
								while(qty1>0)
								{System.out.println("qty = "+qty);
										if(qty1-3 >= -1)
										{
											free++;
											qty1 = qty1 -3;
											
										}
										else
											break;
										System.out.println("While loop");
								}
								
								if(qty1 < 1)
								{
									cartItem.setCart_quantity((free*3));
									cartItem.setCart_item_price((((free*3)-free)*anubhav));
								}
								else
								{
									cartItem.setCart_item_price((qty-free)*anubhav);
								}	
								/*int noOfDeals;
								int noOfItems;
								if(qty == 1)
								{						
										h1.put(d1, cartItem.getCart_quantity());
										cartItem.setCart_item_price(anubhav);
										h2.put(d2, 0);
										h3.put(d3, 0);	
								}
								else
								{   
									noOfDeals = qty/2;
									noOfItems = (noOfDeals*2)+noOfDeals;
									System.out.println("Quantity = "+qty+" No of items = "+noOfItems+" No of dels ="+noOfDeals);
									cartItem.setCart_quantity(noOfItems);
									h1.remove(d1);
									double cp = cartItem.getCart_item_price();
									double newprice = anubhav*(noOfDeals*2);
									System.out.println(cartItem.getCart_item_price());
									System.out.println(newprice);
									cartItem.setCart_item_price(newprice);
								}*/
								h1.remove(d1);
								h1.remove(d2);
								h1.remove(d3);
							
								
							}
							System.out.println("CheckDeal --------------888888888----");
							if(count != 3 && rahul ==2)
							{ 
								System.out.println("CheckDeal ----------------333333333--");
								int qty = (cartItem.getCart_quantity());
								System.out.println(d1 +" "+ d2 +"Quantity = "+qty+" "+(qty/2)+" "+(qty-(qty/2)));
										h1.put(d1, (qty/2));
										h2.put(d2, (qty-(qty/2)));	
								
							}
							if(count != 3 && c1 ==2)
							{ 
								System.out.println("CheckDeal -----------44444444444-------");
								case1.put(cartItem.getCart_item_id(),d1);
								h1.remove(d1);
								h3.remove(d1);
								
									
								
							}
							if(count != 3 && c2 ==2)
							{ 
								System.out.println("CheckDeal -----------555555555-------");
								case2.put(cartItem.getCart_item_id(), d2);	
								h2.remove(d2);
								h3.remove(d2);
								
							}
							
								
						}
					}
					rs.close();
					sql = "UPDATE carts set cart_quantity = ? , cart_price = ? WHERE cart_item_id = ?";
					PreparedStatement pcs = new DBConnection().connect().prepareStatement(sql);
					pcs.setInt(1, cartItem.getCart_quantity());
					pcs.setDouble(2, cartItem.getCart_item_price());
					pcs.setInt(3, cartItem.getCart_item_id());
					pcs.execute();
					pcs.close();
				}
				catch(Exception e) {
					e.printStackTrace();
				}
				
				
			}
			
			System.out.println("CheckDeal -----------666666-------");
			for (int key : case1.keySet()) {
				
				System.out.println("Case One ---------------------------");
				int c  = case1.get(key);
				int q2,qty2;
				int q1,qty1;
				int free;
				double price;
				sql = "SELECT deal_item_two,deal_item_one,item_price FROM deals,items WHERE deal_item_one= items_id AND deal_id=" + c;
				try {
					rs = new DBConnection().connect().prepareStatement(sql).executeQuery();
					if(rs.next())
					{	anubhav = rs.getFloat(3);
						q1 = q2 = 0;
						double p1, p2;
						p1 = p2 = 0.0;
						for (Cart cart2 : cart) {
							if(cart2.getCart_item_id() == rs.getInt(1)) {
								q1 = cart2.getCart_quantity();
								p1 = cart2.getCart_item_price();
							}	
							if(cart2.getCart_item_id() == rs.getInt(2)) {
								q2 = cart2.getCart_quantity();
							}
						}
						for (Cart cart2 : cart) {
											if(cart2.getCart_item_id() == rs.getInt(2)) {
												
												qty1  = q1;
												qty2 = q2;
												free = 0;
												
												while(qty1>0)
												{
														qty1--;
														qty2--;
														if(qty2>=0)
														{
															free++;
															qty2--;
															
														}
												}
												
												if(qty2<0)
												{
													cart2.setCart_quantity((free*2));
													cart2.setCart_item_price((free*anubhav));
												}
												else
												{
													cart2.setCart_item_price((q2-free)*anubhav);
												}	
												
											sql = "UPDATE carts set cart_quantity = ? , cart_price = ? WHERE cart_item_id = ?";
											PreparedStatement pcs = new DBConnection().connect().prepareStatement(sql);
											pcs.setInt(1, cart2.getCart_quantity());
											pcs.setDouble(2, cart2.getCart_item_price());
											pcs.setInt(3, cart2.getCart_item_id());
											pcs.execute();
											pcs.close();
											
											}					
						}
					/*	q1 = cart.get(cart.indexOf(rs.getInt(1))).getCart_quantity(); 
					 	q2 = cart.get(cart.indexOf(rs.getInt(2))).getCart_quantity();
					*/ 
												
					}
					rs.close();
					
									
				} 
				
				
				
				
				catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				
				
				
			}
			
			
	for (int key : case2.keySet()) {
		System.out.println("Case two ---------------------------");
				
		int c  = case2.get(key);
		int q2,qty2;
		int q1,qty1;
		int free;
		double price;
		sql = "SELECT deal_item_one,deal_item_two,item_price FROM deals,items WHERE deal_item_two = items_id AND deal_id=" + c;
		try {
			rs = new DBConnection().connect().prepareStatement(sql).executeQuery();
			if(rs.next())
			{	anubhav = rs.getFloat(3);
				q1 = q2 = 0;
				double p1, p2;
				p1 = p2 = 0.0;
				for (Cart cart2 : cart) {
					if(cart2.getCart_item_id() == rs.getInt(1)) {
						q1 = cart2.getCart_quantity();
						p1 = cart2.getCart_item_price();
					}	
					if(cart2.getCart_item_id() == rs.getInt(2)) {
						q2 = cart2.getCart_quantity();
					}
				}
				System.out.println("Q1 ="+q1+" Q2 ="+q2+" Anubhav ="+anubhav);
				for (Cart cart2 : cart) {
									if(cart2.getCart_item_id() == rs.getInt(2)) {
										
									qty1  = q1;
									qty2 = q2;
									free = 0;
									
									while(qty1>0)
									{
											qty1--;
											qty2--;
											if(qty2>=0)
											{
												free++;
												qty2--;
												
											}
									}
									
									if(qty2<0)
									{
										cart2.setCart_quantity((free*2));
										cart2.setCart_item_price((free*anubhav));
									}
									else
									{
										cart2.setCart_item_price((q2-free)*anubhav);
									}
									
									sql = "UPDATE carts set cart_quantity = ? , cart_price = ? WHERE cart_item_id = ?";
									PreparedStatement pcs = new DBConnection().connect().prepareStatement(sql);
									pcs.setInt(1, cart2.getCart_quantity());
									pcs.setDouble(2, cart2.getCart_item_price());
									pcs.setInt(3, cart2.getCart_item_id());
									pcs.execute();
									pcs.close();
			
									}
				}
			/*	q1 = cart.get(cart.indexOf(rs.getInt(1))).getCart_quantity(); 
			 	q2 = cart.get(cart.indexOf(rs.getInt(2))).getCart_quantity();
			*/ 
										
			}
			rs.close();
		} 
		
		
		
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
				
				
				
				
			}
			
			
			System.out.println("CheckDeal END ------------------");
			
			
			
			
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


