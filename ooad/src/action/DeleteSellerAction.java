package action;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.DBConnection;

public class DeleteSellerAction extends ActionSupport{
	
	
	public String execute() {
		
		Map<String, Object> session = ActionContext.getContext().getSession();
		String email = (String)(session.get("email"));
		int sellerid = Integer.parseInt((String)session.get("surrogate"));
		String name =  (String) session.get("username");
		ArrayList<Integer> list = new ArrayList<Integer>();
		
		DBConnection cs = new DBConnection();
		try {
			PreparedStatement ps = cs.connect().prepareStatement("SELECT items_id FROM items where item_seller_id=?");
			ps.setInt(1, sellerid);		  
			   //status=rs.next();  
				ResultSet rs=ps.executeQuery();
				System.out.println("Inside Attributes");
				while(rs.next())
				{
					list.add(rs.getInt(1));	
					System.out.println("Inside List");
				  
				}
				 cs.disconnect();
					ps.close();
				//to delete from attributes
					for (Integer i : list)
							{ps = cs.connect().prepareStatement("DELETE FROM attributes where attribute_item_id=?");
								ps.setInt(1, i);		  
							   //status=rs.next();  
								ps.executeUpdate();
								 cs.disconnect();
									ps.close();
									System.out.println("Deleting List");
							}
				
					//deleting buyer item id
					for (Integer i : list)
					{ps = cs.connect().prepareStatement("DELETE FROM buyers where buyer_item_id=?");
						ps.setInt(1, i);		  
					   //status=rs.next();  
						ps.executeUpdate();
						 cs.disconnect();
							ps.close();
							System.out.println("Deleting buyer item id");
					}
					//deleting cart item id
					for (Integer i : list)
					{ps = cs.connect().prepareStatement("DELETE FROM carts where cart_item_id=?");
					ps.setInt(1, i);		  
				   //status=rs.next();  
					ps.executeUpdate();
					 cs.disconnect();
						ps.close();
						System.out.println("Deleting cart item id");
					}
					
					//deleting from items
					 ps = cs.connect().prepareStatement("DELETE FROM items where item_seller_id=?");
					 ps.setInt(1, sellerid);
					 ps.executeUpdate();
					 System.out.println("Deleting Items");
						   //status=rs.next();  
						  		   
				  
					// deleting from sellers
			   
			   ps = cs.connect().prepareStatement("DELETE FROM sellers where seller_email=?");
			ps.setString(1,email);			  
			   //status=rs.next();  
			   if( ps.executeUpdate() != 0 )
			   {
				   cs.disconnect();
					ps.close();
					
			   }
			   System.out.println("Deleting from seller");
			   //finally deleting from users
			   ps = cs.connect().prepareStatement("DELETE FROM users where user_email=?");
				ps.setString(1,email);			  
				   //status=rs.next();  
				   if( ps.executeUpdate() != 0 )
				   {
					   cs.disconnect();
						ps.close();
						
				   }
				   System.out.println("Deleting from users");
			   session.put("usertype",null);
			   session.put("username",null);
			   session.put("email",null);
			   session.put("password", null);
			   session.put("userid",null);
			   session.put("login","deleted");
			   
			   String message = "Hello "+name+" your account has been deleted successfully.";
				ps = cs.connect().prepareStatement("INSERT INTO logs(log_message) VALUES(?)");
				ps.setString(1, message);
				ps.execute();
				cs.disconnect();
				ps.close();
			  
			}
			   catch(Exception e) {
					e.printStackTrace();
					System.out.println("Seller Account Update exception");
				}
		return SUCCESS;	
		
		//return ERROR;
	}

}
