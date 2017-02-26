package dao.implementaion;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.imageio.ImageIO;

import com.opensymphony.xwork2.ActionContext;

import dao.DBConnection;
import dao.ItemDAO;
import model.AttributeList;
import model.Buyer;
import model.Category;
import model.Item;
import model.ItemDetails;
import model.Seller;
import model.SubCategory;
//import model.Seller;

public class ItemDAOImplementation implements ItemDAO {

	@Override
	public ItemDetails getItem(Item item) {
		
		ItemDetails itemDetails = new ItemDetails();
		itemDetails.setSeller(new Seller());
		itemDetails.setCategory(new Category());
		itemDetails.setSubCategory(new SubCategory());
		try {
			
			DBConnection dbConnection = new DBConnection();
		    String sql = "SELECT i.*, c.*, s.* "
			    		+ "FROM items i, categories c, subcategories s "
			    		+ "WHERE i.item_cat_id = c.category_id "
			    		+ "AND i.item_subcat_id = s.subcategory_id "
			    		+ "AND i.item_id = '" + item.getItemId() + "'";
			    
		    PreparedStatement ps = dbConnection.connect().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				item.setSurrogateItemId(rs.getInt("items_id"));
				item.setItemId(rs.getString("item_id"));
				item.setItemName(rs.getString("item_name"));
				item.setItemDescription(rs.getString("item_desc"));
				item.setItemPrice(rs.getDouble("item_price"));
				item.setItemPictureString(rs.getString("item_picture"));
				item.setCategoryId(rs.getInt("item_cat_id"));
				item.setItemAdvertisement(rs.getString("item_adv"));
				item.setSubCategoryId(rs.getInt("item_subcat_id"));
				item.setItemDiscount(rs.getDouble("item_discount"));
				item.setItemQuantityAvailable(rs.getInt("item_quantity_available"));
				item.setItemSold(rs.getInt("item_sold"));
				item.setItemWarrantyPeriod(rs.getString("item_warranty_period"));
				item.setItemColor(rs.getString("item_color"));
				item.setItemCondition(rs.getString("item_condition"));
				item.setItemWeight(rs.getString("item_weight"));
				item.setItemBrand(rs.getString("item_brand"));
				item.setItemExpiryDate(rs.getDate("item_expiry_date"));
				
				itemDetails.getSeller().setSurrogateSellerId(rs.getInt("item_seller_id"));
				itemDetails.setItem(item);
				itemDetails.getCategory().setCategoryId(rs.getInt("category_id"));
				itemDetails.getCategory().setCategoryName(rs.getString("category_name"));
				itemDetails.getSubCategory().setSubCategoryId(rs.getInt("subcategory_id"));
				itemDetails.getSubCategory().setSubCategoryName(rs.getString("subcategory_name"));
				
				
			}
			ps.close();
			rs.close();
			dbConnection.disconnect();
			
		    dbConnection = new DBConnection();
		    sql = "SELECT a.attribute_key, a.attribute_value "
	    		+ "FROM items i,  attributes a "
	    		+ "WHERE i.items_id = a.attribute_item_id "
	    		+ "AND i.item_id = '" + item.getItemId() + "'";
			    
		    ps = dbConnection.connect().prepareStatement(sql);
			rs = ps.executeQuery();
			itemDetails.setAttributeLists(new ArrayList<AttributeList>());
			while(rs.next())
			{
				itemDetails.getAttributeLists()
					.add(new AttributeList(
							rs.getString("attribute_key"), 
							rs.getString("attribute_value")));
			}
		
			ps.close();
			rs.close();
			dbConnection.disconnect();
			
			dbConnection = new DBConnection();
		    sql = "SELECT s.*, u.user_id "
	    		+ "FROM sellers s, users u "
	    		+ "WHERE s.seller_id = u.users_id "
	    		+ "AND s.seller_id = " + itemDetails.getSeller().getSurrogateSellerId();	// + " "
//		    	+ "OR s.seller_category_id = " + itemDetails.getCategory().getCategoryId();
    		
		    System.out.println(sql);
		    ps = dbConnection.connect().prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
			{
				itemDetails.getSeller().setSellerId(rs.getString("user_id"));
				itemDetails.getSeller().setSellerName(rs.getString("seller_name"));
				itemDetails.getSeller().setSellerContactNo(rs.getString("seller_contact_no"));
				itemDetails.getSeller().setSellerEmail(rs.getString("seller_email"));
				itemDetails.getSeller().setSellerNOB(rs.getString("seller_nature_of_business"));
				itemDetails.getSeller().setSellerOneStar(rs.getInt("seller_one_star"));
				itemDetails.getSeller().setSellerTwoStar(rs.getInt("seller_two_star"));
				itemDetails.getSeller().setSellerThreeStar(rs.getInt("seller_three_star"));
				itemDetails.getSeller().setSellerFourStar(rs.getInt("seller_four_star"));
				itemDetails.getSeller().setSellerFiveStar(rs.getInt("seller_five_star"));
			}
		
			ps.close();
			rs.close();
			dbConnection.disconnect();
		}
		catch(Exception e) {
			System.out.println("SQL Error");
			e.printStackTrace();
			return null;	//false;
		}
		return itemDetails;	//true;
	}
	
	/*@Override
	public boolean deleteItem(Item item) {
		try {
			
//			int surrogateItemId = 0;
			
		    DBConnection cs = new DBConnection();
			PreparedStatement ps;	// = cs.connect().prepareStatement("SELECT items_id FROM items WHERE item_id = ?");
//			ps.setString(1, item.getItemId());
//			ResultSet rs;	// = ps.executeQuery();
//			if(rs.next())
//				surrogateItemId = rs.getInt(1);
			/*
			ps = cs.connect().prepareStatement("DELETE FROM item_sellers WHERE item_id = ?");
			ps.setInt(1, surrogateItemId);
			ps.execute();
			cs.disconnect();
			ps.close();
			
			System.out.println("Hello");
		    String sql =  "DELETE "
						+ "FROM items "
						+ "WHERE item_id = ?";
//						+ "WHERE items_id = ?";
		    ps = cs.connect().prepareStatement(sql);
			ps.setString(1, item.getItemId());	//surrogateItemId);
			ps.execute();
			cs.disconnect();
			ps.close();

			String message = "Item with ID : " + item.getItemId() + " is deleted";
			ps = cs.connect().prepareStatement("INSERT INTO logs(log_message) VALUES(?)");
			ps.setString(1, message);
			ps.execute();
			cs.disconnect();
			ps.close();
		}
		catch(Exception e) {
			System.out.println("SQL Error");
			e.printStackTrace();
			return false;
		}
		return true;
	}*/

	@Override
	public String deleteItem(Item item) {
		int itemsId = 0;
		Map<String, Object> session = ActionContext.getContext().getSession();
		int sellerid = Integer.parseInt((String)session.get("surrogate"));
		int checkSellerId = 0;
		try {
			
		    DBConnection cs = new DBConnection();
		    PreparedStatement ps = cs.connect().prepareStatement("SELECT items_id , item_seller_id FROM items where item_id=?");
		    ps.setString(1, item.getItemId());		  
			   //status=rs.next();  
				ResultSet rs=ps.executeQuery();
				System.out.println("Inside Attributes");
				if(rs.next())
				{
					itemsId = rs.getInt(1);	
					checkSellerId = rs.getInt(2);
					System.out.println("Got the item surrogate id , sellerid ="+sellerid+", obtained id = "+checkSellerId);
					if(checkSellerId != sellerid)
					return "wrongItemDelete";
					
				  
				}
				 cs.disconnect();
					ps.close();
				//to delete from attributes
					ps = cs.connect().prepareStatement("DELETE FROM attributes where attribute_item_id=?");
								ps.setInt(1, itemsId);		  
							   //status=rs.next();  
								ps.executeUpdate();
								 cs.disconnect();
									ps.close();
									System.out.println("Deleting Item attributes");
				
					//deleting buyer item id
					ps = cs.connect().prepareStatement("DELETE FROM buyers where buyer_item_id=?");
						ps.setInt(1, itemsId);		  
					   //status=rs.next();  
						ps.executeUpdate();
						 cs.disconnect();
							ps.close();
							System.out.println("Deleting buyer item id");
					
					//deleting cart item id
					ps = cs.connect().prepareStatement("DELETE FROM carts where cart_item_id=?");
					ps.setInt(1, itemsId);		  
				   //status=rs.next();  
					ps.executeUpdate();
					 cs.disconnect();
						ps.close();
						System.out.println("Deleting cart item id");
						
			System.out.println("Hello");
		    String sql =  "DELETE "
						+ "FROM items "
						+ "WHERE item_id = ?";
		    ps = cs.connect().prepareStatement(sql);
			ps.setString(1, item.getItemId());	//surrogateItemId);
			ps.execute();
			cs.disconnect();
			ps.close();

			String message = "Item with ID : " + item.getItemId() + " is deleted";
			ps = cs.connect().prepareStatement("INSERT INTO logs(log_message) VALUES(?)");
			ps.setString(1, message);
			ps.execute();
			cs.disconnect();
			ps.close();
		}
		catch(Exception e) {
			System.out.println("SQL Error");
			e.printStackTrace();
			return "false";
		}
		return "true";
	}
	
	@Override
	public boolean getItems(ArrayList<Item> items, int subCategoryId) {
		try {
			
			Item item;
//			Seller seller;
		    DBConnection dbConnection = new DBConnection();
		    String sql =  "SELECT * "
						+ "FROM items "
						+ "WHERE item_subcat_id = " + subCategoryId + " AND item_quantity_available > 0";
			PreparedStatement ps = dbConnection.connect().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				item = new Item();
//				seller = new Seller();
				item.setSurrogateItemId(rs.getInt(1));
				item.setItemId(rs.getString(2));
				item.setItemName(rs.getString(3));
				item.setItemDescription(rs.getString(4));
				item.setItemPrice(rs.getDouble(5));
				item.setItemPictureString(rs.getString(6));
				item.setItemDiscount(rs.getDouble(11));
				System.out.println("---------" + item.getItemPictureString());
				
//				seller.setSellerName(rs.getString(7));
//				item.setSeller(seller);
				
				/*String sql1 = "SELECT item_image FROM item_images WHERE item_id = ?";
				DBConnection dbConnection2 = new DBConnection();
				PreparedStatement ps1 = dbConnection2.connect().prepareStatement(sql1);
				ps1.setInt(1, item.getSurrogateItemId());
				ResultSet rs1 = ps1.executeQuery();
				while(rs1.next()) {
					item.setItemPictureString(rs1.getString(1));
					System.out.println("---------" + item.getItemPictureString());
				}*/
				items.add(item);
			}
			
			dbConnection.disconnect();
		}
		catch(Exception e) {
			System.out.println("SQL Error");
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean getItemsInRange(ArrayList<Item> items, double from, double to) {
		try {
			
			Item item;
		    DBConnection dbConnection = new DBConnection();
		    String sql =  "SELECT * "
						+ "FROM items "
						+ "WHERE item_price >= " + from + " "
						+ "AND item_price <= " + to;
						
			PreparedStatement ps = dbConnection.connect().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				item = new Item();
				item.setItemId(rs.getString(2));
				item.setSellerID(rs.getString(10));
				item.setItemPrice(rs.getDouble(5));
				item.setItemPictureString(rs.getString(6));
				if(rs.getInt(7) == 1)
					item.setItemAdvertisement("YES");
				else
					item.setItemAdvertisement("NO");
				items.add(item);
			}
			
			dbConnection.disconnect();
		}
		catch(Exception e) {
			System.out.println("SQL Error");
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@SuppressWarnings("deprecation")
	@Override
	public boolean addItem(ItemDetails itemDetails) {
		try {
			
			String workingDir = System.getProperty("user.dir")+"/eclipse";		// get current working directory
//			workingDir = workingDir;
			System.out.println(workingDir);
			Item item = itemDetails.getItem();
			System.out.println(item.getItemPictureString());
			/*
			 *	File currentDirFile = new File(".");
			 *	String helper = currentDirFile.getAbsolutePath();
			 *	String currentDir = helper.substring(0, helper.length - currentDirFile.getCanonicalPath().length); 
			 *
			 */
		
			DBConnection cs = new DBConnection();
			PreparedStatement ps1;	// = cs.connect().prepareStatement("SELECT MAX(item_images_id) FROM item_images");
			ResultSet rs1;	// = ps1.executeQuery();
			/*
			if(rs1.next()) {
				fileName = (rs1.getInt(1) + 1) + "";
			}
			
			cs.disconnect();
			ps1.close();
			rs1.close();
			*/
			BufferedImage bi = ImageIO.read(item.getItemPicture());
			File saveFile = new File(workingDir + item.getItemId() + ".png");
			ImageIO.write(bi, "png", saveFile);
			
			item.setItemPictureString("eclipse" + item.getItemId() + ".png");
			
			System.out.println("new " + item.getItemPictureString());
			
			ps1 = cs.connect().prepareStatement("SELECT users_id FROM users WHERE user_id = ?");
			ps1.setString(1, itemDetails.getSeller().getSellerId());
			rs1 = ps1.executeQuery();
			if(rs1.next())
			{
				itemDetails.getSeller().setSurrogateSellerId(rs1.getInt(1));
			}
			cs.disconnect();
			ps1.close();
			rs1.close();
			
			
            cs = new DBConnection();
            String sql = "INSERT INTO items"
        			+ "(item_id, item_name, item_cat_id, item_subcat_id, "
        			+ "item_price, item_desc, item_adv, item_picture, "
        			+ "item_seller_id, item_discount, item_quantity_available, "
        			+ "item_warranty_period"
        			+ ", item_color, item_condition, item_weight, item_brand"
        			+ ", item_expiry_date" 
        			+ ", item_advertisement_cost, item_advertisement_from, item_advertisement_to"
        			+ ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?"
        			+ ", ?, ?, ?, ?, ?, ?, ?, ?)";
			
            ps1 = cs.connect().prepareStatement(sql);
			ps1.setString(1, item.getItemId());
			ps1.setString(2, item.getItemName());
			ps1.setInt(3, item.getCategoryId());
			ps1.setInt(4, item.getSubCategoryId());
			ps1.setDouble(5,item.getItemPrice());
			ps1.setString(6,item.getItemDescription());
			ps1.setString(8, item.getItemPictureString());
			ps1.setInt(9, itemDetails.getSeller().getSurrogateSellerId());
			ps1.setDouble(10, item.getItemDiscount());
			ps1.setInt(11, item.getItemQuantityAvailable());
			ps1.setString(12, item.getItemWarrantyPeriod());
			ps1.setString(13, item.getItemColor());
			ps1.setString(14, item.getItemCondition());
			System.out.println("weight = "+item.getItemWeight());
			if(item.getItemWeight().equals(""))
			ps1.setDouble(15, 0);
			else
			ps1.setString(15, item.getItemWeight());
			ps1.setString(16, item.getItemBrand());
			
			boolean b;
            if(item.getItemAdvertisement().equals("Yes")){
        		b = true;
			}
			
			else {
				b = false;
			}
        	ps1.setBoolean(7,b);
			
        	Date date;
        	int year, month, day;
        	
        	if(item.getItemExpiryDate() != null) {
				year = item.getItemExpiryDate().getYear();
				month = item.getItemExpiryDate().getMonth();
				day = item.getItemExpiryDate().getDate();
				date = new Date(year, month, day);
        	}
        	else
        		date = null;
        	
			ps1.setDate(17, date);	//	expiryDate

			ps1.setDouble(18, item.getItemAdvtCost());
        	
			if(item.getItemAdvtFrom() != null) {
				year = item.getItemAdvtFrom().getYear();
				month = item.getItemAdvtFrom().getMonth();
				day = item.getItemAdvtFrom().getDate();
				date = new Date(year, month, day);
			}
	    	else
	    		date = null;
			
			ps1.setDate(19, date);	//	advfrom
			
			if(item.getItemAdvtTo() != null) {
					
				year = item.getItemAdvtTo().getYear();
				month = item.getItemAdvtTo().getMonth();
				day = item.getItemAdvtTo().getDate();
				
				date = new Date(year, month, day);
			}
			else {
				date = null;
			}
			ps1.setDate(20, date);	//	advto
	
			//System.out.println("Rohit:"+item.getCategoryId()+" "+item.getSubCategoryId());

			ps1.execute();
			
			/*if(!ps1.execute())
			{
				cs.disconnect();
				*/
				System.out.println("First");
				PreparedStatement ps = cs.connect().prepareStatement("SELECT items_id FROM items WHERE item_id = ?");
				ps.setString(1, item.getItemId());
				ResultSet rs = ps.executeQuery();
				if(rs.next())
					item.setSurrogateItemId(rs.getInt(1));
				cs.disconnect();
				ps.close();
				rs.close();
				
				sql = "";
				System.out.println("First first");
				if(itemDetails.getAttributeLists() != null) {
					for (AttributeList attributeList : itemDetails.getAttributeLists()) {
						sql = "INSERT INTO attributes(attribute_item_id, attribute_key, attribute_value) "
								+ "VALUES (" + item.getSurrogateItemId() + ", "
										+ "'" + attributeList.getAttributeKey() + "', "
										+ "'" + attributeList.getAttributeValue() + "');";
						ps = cs.connect().prepareStatement(sql);
						ps.execute();
						cs.disconnect();
						ps.close();
						
						System.out.println(attributeList.getAttributeKey() + " => " + attributeList.getAttributeValue());
						System.out.println(sql);
					}
				}
				
				/*
				System.out.println("Second " + item.getSurrogateItemId());
				
				Seller seller = itemDetails.getSeller();
				System.out.println("Third " + item.getSurrogateItemId() + " " + seller.getSurrogateSellerId());
				ps = cs.connect().prepareStatement("INSERT INTO sellers(item_id, seller_id) VALUES (?, ?)");
				ps.setInt(1, item.getSurrogateItemId());
				ps.setInt(2, seller.getSurrogateSellerId());
				ps.execute();
				cs.disconnect();
				ps.close();
			*/
				//System.out.println("Fourth " + item.getSurrogateItemId() + " " + itemDetails.getSeller().getSellerId());
				String logMessage = "Item with ID : " + item.getSurrogateItemId() + " is added";
				ps1 = cs.connect().prepareStatement("INSERT INTO logs(log_message) VALUES (?)");
				ps1.setString(1, logMessage);
				ps1.execute();
				cs.disconnect();
				ps1.close();
//			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	@Override
	public ArrayList<Buyer> getOrderHistory(String userId) {
		
		ArrayList<Buyer> buyers = new ArrayList<>();
		Buyer buyer;
		try {
			int usersId = 0;
			
			String sql = "SELECT users_id FROM users WHERE user_id = '" + userId + "'";
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			System.out.println(ps.toString());
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				usersId = rs.getInt(1);
			}
			ps.close();
			rs.close();
			cs.disconnect();
			
			sql = "SELECT b.*, i.item_name, i.item_picture, s.* "
					+ "FROM buyers b, items i, sellers s "
					+ "WHERE b.buyer_item_id = i.items_id "
					+ "AND s.seller_id = b.buyer_seller_id "
					+ "AND buyer_id = " + usersId;
		
			cs = new DBConnection();
			ps = cs.connect().prepareStatement(sql);
			System.out.println(ps.toString());
			rs = ps.executeQuery();
			while(rs.next()) {
				buyer = new Buyer();
				buyer.setBuyerSurrogateId(rs.getInt("buyers_id"));
				buyer.setBuyerAddress(rs.getString("buyer_address"));
				buyer.setBuyerItemId(rs.getInt("buyer_item_id"));
				buyer.setBuyerItemName(rs.getString("item_name"));
				buyer.setBuyerStatus(rs.getInt("buyer_status"));
				buyer.setBuyerMoneyPaid(rs.getDouble("buyer_money_paid"));
				buyer.setBuyerItemQuantity(rs.getInt("buyer_item_quantity"));
				buyer.setBuyerImageName(rs.getString("item_picture"));
				buyer.setBuyerSellerSurrogateId(rs.getInt("sellers_id"));
				buyer.setIsSellerRated(rs.getInt("is_seller_rated"));
				
				int count = rs.getInt("seller_one_star") + 
							rs.getInt("seller_two_star") + 
							rs.getInt("seller_three_star") +
							rs.getInt("seller_four_star") +
							rs.getInt("seller_five_star");	
				
				if(count == 0)
					count = 1;
				
				int avg = ( 	1 * rs.getInt("seller_one_star") + 
								2 * rs.getInt("seller_two_star") + 
								3 * rs.getInt("seller_three_star") +
								4 * rs.getInt("seller_four_star") + 
								5 * rs.getInt("seller_five_star") ) / count;
				
				buyer.setBuyerSellerRating(avg);
				buyer.setBuyerSellerName(rs.getString("seller_name"));
				
				buyers.add(buyer);				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
		return buyers;
	}

	@Override
	public ArrayList<Buyer> getSellHistory(String userId) {
		
		ArrayList<Buyer> buyers = new ArrayList<>();
		Buyer buyer;
		try {
			
			System.out.println(userId);
			int sellersId = new PaymentDAOImplementation().getSeller(userId);
			
			String sql = "SELECT b.*, i.item_name, i.item_picture, s.sellers_id , s.seller_name "
						+ "FROM buyers b, items i, sellers s "
						+ "WHERE b.buyer_item_id = i.items_id "
						+ "AND s.seller_id = b.buyer_seller_id "
						+ "AND s.seller_id IN (SELECT seller_id FROM sellers WHERE sellers_id = " + sellersId + ")";
		
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			System.out.println(ps.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				buyer = new Buyer();
				buyer.setBuyerSurrogateId(rs.getInt("buyers_id"));
				buyer.setBuyerAddress(rs.getString("buyer_address"));
				buyer.setBuyerItemId(rs.getInt("buyer_item_id"));
				buyer.setBuyerItemName(rs.getString("item_name"));
				buyer.setBuyerStatus(rs.getInt("buyer_status"));
				buyer.setBuyerMoneyPaid(rs.getDouble("buyer_money_paid"));
				buyer.setBuyerImageName(rs.getString("item_picture"));
				buyer.setBuyerSellerSurrogateId(rs.getInt("sellers_id"));
				//buyer.setBuyerSellerRating(rs.getInt("seller_rating"));
				buyer.setBuyerSellerName(rs.getString("seller_name"));
				
				buyers.add(buyer);				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
		return buyers;
	}

	@Override
	public boolean searchItems(ArrayList<Item> items, String searchText,String searchCategory) {
		try {
			 System.out.println("TEst in itemDao1");
			Item item ;

		    
			DBConnection dbConnection = new DBConnection();
			PreparedStatement ps=null;
			if(searchText.equals("") && searchCategory.equals("All Categories")){
			      ps = dbConnection.connect().prepareStatement("SELECT * FROM items ");
			      ResultSet rs = ps.executeQuery();
			      while(rs.next()){
			    	  item = new Item();
			    	  
			    	  item.setSurrogateItemId(rs.getInt(1));
						item.setItemId(rs.getString(2));
						item.setItemName(rs.getString(3));
						item.setItemDescription(rs.getString(4));
						item.setItemPrice(rs.getDouble(5));
						item.setItemPictureString(rs.getString(6));
						items.add(item);
			      }
			      ps.close();rs.close();
			}
			
			else if(searchText.equals("")){
				 int i = 0;
				 ps = dbConnection.connect().prepareStatement("SELECT * FROM categories where category_name='"+searchCategory+"'");
			      ResultSet rs = ps.executeQuery();
			      while(rs.next()){
			    	  System.out.println("t1");
			    	  i++;
			    	  PreparedStatement p = dbConnection.connect().prepareStatement("SELECT * FROM items where item_cat_id=?");
			    	  System.out.println("t2");
			    	  p.setInt(1,rs.getInt(1));
			    	  System.out.println("t3");
			    	  ResultSet r = p.executeQuery();
			    	  System.out.println("t4");
			    	  while(r.next()){
			    		  item = new Item();
			    		  item.setSurrogateItemId(r.getInt(1));
							item.setItemId(r.getString(2));
							item.setItemName(r.getString(3));
							item.setItemDescription(r.getString(4));
							item.setItemPrice(r.getDouble(5));
							item.setItemPictureString(r.getString(6));
							items.add(item);
			    	  }
			    	  p.close();r.close();
			      }
			      ps.close();rs.close();
			      if(i == 0){
			    	  ps = dbConnection.connect().prepareStatement("SELECT * FROM subcategories where subcategory_name='"+searchCategory+"'");
				      ResultSet r1 = ps.executeQuery();
				      while(r1.next()){
				    	  PreparedStatement p = dbConnection.connect().prepareStatement("SELECT * FROM items where item_subcat_id=?");
				    	  p.setInt(1,r1.getInt(1));
				    	  ResultSet r = p.executeQuery();
				    	  while(r.next()){
				    		  item = new Item();
				    		  item.setSurrogateItemId(r.getInt(1));
								item.setItemId(r.getString(2));
								item.setItemName(r.getString(3));
								item.setItemDescription(r.getString(4));
								item.setItemPrice(r.getDouble(5));
								item.setItemPictureString(r.getString(6));
								items.add(item);
								}
				    	  p.close();r.close();
				      }
				      ps.close();r1.close();
			      }
			}
			
			else if(!searchText.isEmpty() && searchCategory.equals("All Categories")){
				 
				 String s="SELECT * FROM items where item_name LIKE '%"+searchText+"%'";
				 System.out.println("................"+s);
				 ps = dbConnection.connect().prepareStatement(s);
				// ps.setString(1,"'%"+ searchText + "%'");
				 System.out.println("NEWTEST");
			      ResultSet rs = ps.executeQuery();
			      System.out.println("NEWTEST2");
			      while(rs.next()){
			    	  item = new Item();
			    	  System.out.println("NEWTEST3");
			    	  item.setSurrogateItemId(rs.getInt(1));
						item.setItemId(rs.getString(2));
						item.setItemName(rs.getString(3));
						item.setItemDescription(rs.getString(4));
						item.setItemPrice(rs.getDouble(5));
						item.setItemPictureString(rs.getString(6));
						items.add(item);
			      }
			      ps.close();rs.close();
			}
			
			else if(!searchText.isEmpty()){
				 	
				 
				 int i = 0;
				 ps = dbConnection.connect().prepareStatement("SELECT * FROM categories where category_name='"+searchCategory+"'");
			      ResultSet rs = ps.executeQuery();
			      while(rs.next()){
			    	  i++;
			    	  String g="SELECT * FROM items where item_cat_id="+rs.getInt(1)+" AND item_name LIKE '%"+searchText+"%'";
			    	  System.out.println("////////////////"+g);
			    	  PreparedStatement p = dbConnection.connect().prepareStatement(g);
			    	//  p.setInt(1,rs.getInt(1));
			    	  ResultSet r = p.executeQuery();
			    	  while(r.next()){
			    		  item = new Item();
			    		  item.setSurrogateItemId(rs.getInt(1));
							item.setItemId(r.getString(2));
							item.setItemName(r.getString(3));
							item.setItemDescription(r.getString(4));
							item.setItemPrice(r.getDouble(5));
							item.setItemPictureString(r.getString(6));
							items.add(item);
			    	  }
			    	  p.close();r.close();
			      }
			      ps.close();rs.close();
			      if(i == 0){
			    	  ps = dbConnection.connect().prepareStatement("SELECT * FROM subcategories where subcategory_name='"+searchCategory+"'");
				      ResultSet r1 = ps.executeQuery();
				      while(r1.next()){
				    	  String h="SELECT * FROM items where item_subcat_id="+r1.getInt(1)+" AND item_name LIKE '%"+searchText+"%'";
				    	  PreparedStatement p = dbConnection.connect().prepareStatement(h);
				    	//  p.setInt(1,r1.getInt(1));
				    	  ResultSet r = p.executeQuery();
				    	  while(r.next()){
				    		  item = new Item();
				    		  item.setSurrogateItemId(r.getInt(1));
								item.setItemId(r.getString(2));
								item.setItemName(r.getString(3));
								item.setItemDescription(r.getString(4));
								item.setItemPrice(r.getDouble(5));
								item.setItemPictureString(r.getString(6));
								items.add(item);
				    	  }
				    	  p.close();r.close();
				      }
				      ps.close();r1.close();
			      }
			      

			}
			/*DBConnection dbConnection = new DBConnection();
		    String sql =  "SELECT * "
						+ "FROM items "
						+ "WHERE item_subcat_id = " + subCategoryId;
			PreparedStatement ps = dbConnection.connect().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				item = new Item();

				item.setSurrogateItemId(rs.getInt(1));
				item.setItemId(rs.getString(2));
				item.setItemName(rs.getString(3));
				item.setItemDescription(rs.getString(4));
				item.setItemPrice(rs.getDouble(5));
				item.setItemPictureString(rs.getString(6));
				System.out.println("---------" + item.getItemPictureString());
				
//				seller.setSellerName(rs.getString(7));
//				item.setSeller(seller);
				
				String sql1 = "SELECT item_image FROM item_images WHERE item_id = ?";
				DBConnection dbConnection2 = new DBConnection();
				PreparedStatement ps1 = dbConnection2.connect().prepareStatement(sql1);
				ps1.setInt(1, item.getSurrogateItemId());
				ResultSet rs1 = ps1.executeQuery();
				while(rs1.next()) {
					item.setItemPictureString(rs1.getString(1));
					System.out.println("---------" + item.getItemPictureString());
				}
				items.add(item);
			}
			
			dbConnection.disconnect();
*/		}
		catch(Exception e) {
			System.out.println("SQL Error");
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@SuppressWarnings("deprecation")
	@Override
	public boolean updateItem(ItemDetails itemDetails) {
		
		Item item = itemDetails.getItem();
		
		DBConnection dbConnection = new DBConnection();
	    
	    PreparedStatement ps;
		
		
		String sql = "";
		sql = "UPDATE items SET item_name='"+ item.getItemName() + "', " +
				"item_desc='" + item.getItemDescription() + "', " +
				"item_price=" + item.getItemPrice() + ", " +
				"item_discount=" + item.getItemDiscount() + ", " +
				"item_quantity_available=" + item.getItemQuantityAvailable() + ", " +
				"item_warranty_period='" + item.getItemWarrantyPeriod() + "', " +
				"item_color='" + item.getItemColor() + "', " +
				"item_condition='" + item.getItemCondition() + "', " +
				"item_weight='" + item.getItemWeight() + "', " +
				"item_brand='" + item.getItemBrand() + "'";	

		Date expdate;
    	int year, month, day;
    	
    	if(item.getItemExpiryDate() != null) {
			year = item.getItemExpiryDate().getYear();
			month = item.getItemExpiryDate().getMonth();
			day = item.getItemExpiryDate().getDate();
			expdate = new Date(year, month, day);
    	}
    	else
    		expdate = null;
    	
		sql += ", item_expiry_date=?";
		
		int b;
        if(item.getItemAdvertisement().equals("Yes"))
    		b = 1;
		else 
			b = 0;

        sql += ", item_adv=" + b 
				+ ", item_advertisement_cost=" + item.getItemAdvtCost();
    	
        Date advfrom, advto;
		if(item.getItemAdvtFrom() != null) {
			year = item.getItemAdvtFrom().getYear();
			month = item.getItemAdvtFrom().getMonth();
			day = item.getItemAdvtFrom().getDate();
			advfrom = new Date(year, month, day);
		}
    	else
    		advfrom = null;

		sql += ", item_advertisement_from=?";

		if(item.getItemAdvtTo() != null) {
			year = item.getItemAdvtTo().getYear();
			month = item.getItemAdvtTo().getMonth();
			day = item.getItemAdvtTo().getDate();
			advto = new Date(year, month, day);
		}
    	else
    		advto = null;

		sql += ", item_advertisement_to=?";

//		System.out.println("updateItem : " + sql);
		
		if(itemDetails.getItem().getItemPicture() != null) {	
			String workingDir = System.getProperty("user.dir");		// get current working directory
			System.out.println(workingDir);
			System.out.println(item.getItemPictureString());
			
			BufferedImage bi;
			try {
			
				bi = ImageIO.read(item.getItemPicture());
				File saveFile = new File(workingDir + item.getItemId() + ".png");
				ImageIO.write(bi, "png", saveFile);
			
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			item.setItemPictureString("eclipse" + item.getItemId() + ".png");
			
			System.out.println("new " + item.getItemPictureString());
			
			sql += ", item_picture='" + item.getItemPictureString() + "'";
		}
		
		sql +=	" WHERE item_id='" + item.getItemId() + "'";
		
		try {
			
			 dbConnection = new DBConnection();
			    
		     ps = dbConnection.connect().prepareStatement(sql);
		     
		     ps.setDate(1, expdate);
		     ps.setDate(2, advfrom);
		     ps.setDate(3, advto);
		     
//		     System.out.println("ps : " + ps.toString());

		     ps.execute();
			
		     ps.close();
		     
		     dbConnection.disconnect();
		}
		catch(Exception e) {
			e.printStackTrace();
			
			/*dbConnection = new DBConnection();
		    sql = "SELECT a.attribute_key, a.attribute_value "
	    		+ "FROM items i,  attributes a "
	    		+ "WHERE i.items_id = a.attribute_item_id "
	    		+ "AND i.item_id = '" + item.getItemId() + "'";
			    
		    ps = dbConnection.connect().prepareStatement(sql);
			rs = ps.executeQuery();
			*/
			return false;
		}
		
		System.out.println("First");
		try {
			ps = dbConnection.connect().prepareStatement("SELECT items_id FROM items WHERE item_id = ?");
			ps.setString(1, item.getItemId());
			ResultSet rs = ps.executeQuery();
			if(rs.next())
				item.setSurrogateItemId(rs.getInt(1));
			dbConnection.disconnect();
			ps.close();
			rs.close();
			
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		 try
		    {
		    ps = dbConnection.connect().prepareStatement("DELETE from attributes WHERE attribute_item_id = ?");
		    ps.setInt(1, item.getSurrogateItemId());
			ps.execute();
			
			ps.close();
			dbConnection.disconnect();
		    }
			catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		
		sql = "";
		System.out.println("First first");
		if(itemDetails.getAttributeLists() != null) {
			for (AttributeList attributeList : itemDetails.getAttributeLists()) {
				sql = "INSERT INTO attributes(attribute_item_id, attribute_key, attribute_value) "
						+ "VALUES (" + item.getSurrogateItemId() + ", "
								+ "'" + attributeList.getAttributeKey() + "', "
								+ "'" + attributeList.getAttributeValue() + "');";
				try {
					ps = dbConnection.connect().prepareStatement(sql);
					ps.execute();
					dbConnection.disconnect();
					ps.close();
				}
				catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				System.out.println(attributeList.getAttributeKey() + " => " + attributeList.getAttributeValue());
				System.out.println(sql);
			}
		
	}
		return true;
}
}
