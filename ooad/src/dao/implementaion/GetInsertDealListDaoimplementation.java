package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import dao.DBConnection;

import model.Item;

public class GetInsertDealListDaoimplementation {
	public ArrayList <Item> itemList = new ArrayList<>();
	DBConnection dbConnection;
	String sql=" ";
	Map<String, Object> session = ActionContext.getContext().getSession();
	int seller_id = Integer.parseInt((String)(session.get("surrogate")));
	//int seller_id=19;
	public ArrayList<Item> getItemList() {
		System.out.println("In DealDaoImplementation --getItemList");
		
		try{
			dbConnection =new DBConnection();
			
			//insert seller id here with help of session
			
			sql="SELECT items_id,item_name,item_id FROM items WHERE item_seller_id= "+seller_id+"	 AND is_deal_item = 0 ;";
			PreparedStatement preparedStatement = dbConnection.connect().prepareStatement(sql);
			//preparedStatement.setInt(1, 1);
			System.out.println(sql);
			ResultSet rs =preparedStatement.executeQuery();
			
			 //preparedStatement.executeQuery("SELECT items_id,item_name FROM items");
			System.out.println("In ResultSet");
			System.out.println("___________________");
			while(rs.next()){
				Item item = new Item();
				item.setSurrogateItemId(rs.getInt("items_id"));
				item.setItemName(rs.getString("item_name"));
				item.setItemId(rs.getString("item_id"));
				
				System.out.println("items_id is = "+rs.getInt("items_id"));
				System.out.println("itemName is = "+rs.getString("item_name"));
				itemList.add(item);
			}
			System.out.println("___________________");
			System.out.println("Out of DealDaoImplementation --getItemList");
			
			return itemList;
		}catch(Exception e){
			System.out.println(e);
			return null;
		}

	}
	

}
