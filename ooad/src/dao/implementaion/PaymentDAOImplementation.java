package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import dao.PaymentDAO;

public class PaymentDAOImplementation implements PaymentDAO {

	public double getBalance(String userId) {
		double balance = 0.0;
		try {
			String sql = "SELECT user_balance FROM users WHERE user_id = ?";
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				balance = rs.getDouble(1);
			}
			ps.close();
			rs.close();
			cs.disconnect();
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0.0;
		}
		return balance;
	}
	
	@Override
	public boolean payment(String userId, String sellerId, String itemId, String address, double totalPrice) {

		try {
			double userBalance = 0.0;
			int users_id = 0;
			int items_id = 0;
			
			String sql = "SELECT user_balance, users_id FROM users WHERE user_id = ?";
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				userBalance = rs.getDouble(1);
				users_id = rs.getInt(2);
			}
			ps.close();
			rs.close();
			cs.disconnect();
			
			double discount = 0.0;
			
			sql = "SELECT items_id, item_discount FROM items WHERE item_id = ?";
			cs = new DBConnection();
			ps = cs.connect().prepareStatement(sql);
			ps.setString(1, itemId);
			rs = ps.executeQuery();
			if(rs.next()) {
				items_id = rs.getInt(1);
				discount = rs.getDouble(2);
			}
			ps.close();
			rs.close();
			cs.disconnect();
			
			if(userBalance >= totalPrice) {
				sql = "UPDATE users SET user_balance = ? WHERE user_id = ?";
				ps = cs.connect().prepareStatement(sql);
				ps.setDouble(1, userBalance - totalPrice);
				ps.setString(2, userId);
				ps.execute();
				ps.close();
				cs.disconnect();
				
				sql = "UPDATE users SET user_balance = user_balance + ? WHERE user_type = 0";
				ps = cs.connect().prepareStatement(sql);
				ps.setDouble(1, totalPrice);
				ps.execute();
				ps.close();
				cs.disconnect();
				
				int sellers_id = 0;
				System.out.println(sellerId);
				sellers_id = getSeller(sellerId);
				
				System.out.println("Sellers_id = " + sellers_id);
				sql = "INSERT INTO buyers(buyer_id, buyer_address, buyer_item_id, buyer_status, buyer_money_paid, buyer_seller_id) VALUES (?, ?, ?, ?, ?, ?)";
				ps = cs.connect().prepareStatement(sql);
				ps.setDouble(1, users_id);
				ps.setString(2, address);
				ps.setInt(3, items_id);
				ps.setInt(4, 1);
				ps.setDouble(5, totalPrice*(1-discount/100));
				ps.setInt(6, sellers_id);
				ps.execute();
				ps.close();
				cs.disconnect();
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;		
		}
		return true;
	}
	
	@Override
	public int getSeller(String sellerId) {
		int sellers_id = 0;
		try {
			String sql = "SELECT sellers_id FROM sellers WHERE seller_id = (SELECT users_id FROM users WHERE user_id = ?)";
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			ps.setString(1, sellerId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				sellers_id = rs.getInt(1);
			}
			System.out.println("getSeller " + sellers_id);
			ps.close();
			rs.close();
			cs.disconnect();
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		return sellers_id;
	}

	@Override
	public boolean paymentCart(String userId, int usersId, String address, double totalPrice) {
		
		try {
			
			double userBalance = 0.0;
			int users_id = 0;
			
			String sql = "SELECT user_balance, users_id FROM users WHERE user_id = ?";
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				userBalance = rs.getDouble(1);
				users_id = rs.getInt(2);
			}
			ps.close();
			rs.close();
			cs.disconnect();
			
			sql = "UPDATE users SET user_balance = user_balance + ? WHERE user_type = 0";
			ps = cs.connect().prepareStatement(sql);
			ps.setDouble(1, totalPrice);
			ps.execute();
			ps.close();
			cs.disconnect();
			
			sql = "UPDATE users SET user_balance = ? WHERE user_id = ?";
			ps = new DBConnection().connect().prepareStatement(sql);
			ps.setDouble(1, userBalance - totalPrice);
			ps.setString(2, userId);
			ps.execute();
			ps.close();
			cs.disconnect();
				
			DBConnection dbConnection = new DBConnection();
			PreparedStatement ps1 = dbConnection.connect().prepareStatement("select c.*, i.*, user_id as seller_id from items i, carts c, users  where c.cart_item_id = i.items_id AND c.cart_user_id = " + usersId + " AND i.item_seller_id = users_id");
			ResultSet rs1 = ps1.executeQuery();
			while(rs1.next()) {
				
				sql = "INSERT INTO buyers(buyer_id, buyer_address, buyer_item_id, buyer_status, buyer_money_paid, buyer_seller_id, buyer_item_quantity) VALUES (?, ?, ?, ?, ?, ?, ?)";
				ps = cs.connect().prepareStatement(sql);
				ps.setDouble(1, users_id);
				ps.setString(2, address);
				ps.setInt(3, rs1.getInt("cart_item_id"));
				ps.setInt(4, 1);
				ps.setDouble(5, rs1.getDouble("cart_price")*(1-rs1.getDouble("item_discount")/100));
				ps.setInt(6, rs1.getInt("item_seller_id"));
				ps.setInt(7, rs1.getInt("cart_quantity"));//(int)(rs1.getDouble("cart_price") / rs1.getDouble("item_price")));
				System.out.println(ps.toString());
				ps.execute();
				ps.close();
				cs.disconnect();
				
				int qty = rs1.getInt("cart_quantity");
				
				sql = "UPDATE items SET item_sold = ?, item_quantity_available = ? WHERE items_id = ?";
				ps = cs.connect().prepareStatement(sql);
				ps.setInt(1, rs1.getInt("item_sold") + qty);
				ps.setInt(2, rs1.getInt("item_quantity_available") - qty);
				ps.setInt(3, rs1.getInt("cart_item_id"));
				System.out.println(ps.toString());
				ps.execute();
				ps.close();
				cs.disconnect();
					
			}
			
			sql = "DELETE FROM carts WHERE cart_user_id = "+usersId;
			ps1 = dbConnection.connect().prepareStatement(sql);
			ps1.execute();
			ps1.close();
			dbConnection.disconnect();
			
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;	
	}	
}		
		
		/*System.out.println(ps.toString());
				ps.execute();
				ps.close();
				cs.disconnect();
	
				
					sql = "SELECT items_id FROM items WHERE item_id = ?";
					cs = new DBConnection();
					ps = cs.connect().prepareStatement(sql);
					ps.setString(1, rs1.getString("item_id"));
					rs = ps.executeQuery();
					if(rs.next()) {
						items_id = rs.getInt(1);
					}
					ps.close();
					rs.close();
					cs.disconnect();
					
					if(userBalance >= totalPrice) {
						sql = "UPDATE users SET user_balance = ? WHERE user_id = ?";
						ps = cs.connect().prepareStatement(sql);
						ps.setDouble(1, userBalance - totalPrice);
						ps.setString(2, userId);
						ps.execute();
						ps.close();
						cs.disconnect();
						
						sql = "UPDATE users SET user_balance = user_balance + ? WHERE user_type = 0";
						ps = cs.connect().prepareStatement(sql);
						ps.setDouble(1, totalPrice);
						ps.execute();
						ps.close();
						cs.disconnect();
						
						int sellers_id = 0;
						System.out.println(sellerId);
						sellers_id = getSeller(sellerId);
						
						System.out.println("Sellers_id = " + sellers_id);
						sql = "INSERT INTO buyers(buyer_id, buyer_address, buyer_item_id, buyer_status, buyer_money_paid, buyer_seller_id) VALUES (?, ?, ?, ?, ?, ?)";
						ps = cs.connect().prepareStatement(sql);
						ps.setDouble(1, users_id);
						ps.setString(2, address);
						ps.setInt(3, items_id);
						ps.setInt(4, 1);
						ps.setDouble(5, totalPrice);
						ps.setInt(6, sellers_id);
						ps.execute();
						ps.close();
						cs.disconnect();
					}
*/			
		

