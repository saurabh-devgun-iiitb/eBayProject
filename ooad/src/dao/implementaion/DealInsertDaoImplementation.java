package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import dao.DBConnection;

public class DealInsertDaoImplementation {
	
	public boolean insertDeal(int itemOne,int itemTwo,int itemFree){
		DBConnection dbConnection;
		String sql;
		int dealId=0;
		Map<String, Object> session = ActionContext.getContext().getSession();
		int seller_id = Integer.parseInt((String)(session.get("surrogate")));
		try{
			System.out.println("In DealInsertDaoImplementation");
			dbConnection =new DBConnection();
			sql="INSERT INTO deals(deal_item_one,deal_item_two,deal_item_free,deal_seller_id) VALUES(?,?,?,?);";
			PreparedStatement preparedStatement =  dbConnection.connect().prepareStatement(sql);
			preparedStatement.setInt(1, itemOne);
			preparedStatement.setInt(2, itemTwo);
			preparedStatement.setInt(3, itemFree);
			preparedStatement.setInt(4,seller_id);  			//insert seller id here by session ( to do)
			preparedStatement.executeUpdate();
			
			sql = "SELECT deal_id FROM deals WHERE deal_item_one = "+itemOne;
			System.out.println(sql);
			preparedStatement =  dbConnection.connect().prepareStatement(sql);
			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next()){
				dealId=rs.getInt("deal_id");
			System.out.println(sql + " rs = " +rs.getInt("deal_id") );
			}
			sql="UPDATE  items SET is_deal_item = 1 , item_deal_id ="+dealId+" WHERE items_id="+itemOne;
			System.out.println("******************"+sql);
			preparedStatement =  dbConnection.connect().prepareStatement(sql);
			preparedStatement.executeUpdate();
			System.out.println(sql);
			
			sql="UPDATE  items SET is_deal_item = 1 , item_deal_id ="+dealId+" WHERE items_id="+itemTwo;
			preparedStatement =  dbConnection.connect().prepareStatement(sql);
			preparedStatement.executeUpdate();
			System.out.println(sql);
			
			sql="UPDATE  items SET is_deal_item = 1 , item_deal_id ="+dealId+" WHERE items_id="+itemFree;
			preparedStatement =  dbConnection.connect().prepareStatement(sql);
			preparedStatement.executeUpdate();
			System.out.println(sql);
			
			String message = "Deal with IDs : "+ " "+itemOne+", "+itemTwo+", "+itemFree+" " + " is Added";
			preparedStatement = dbConnection.connect().prepareStatement("INSERT INTO logs(log_message) VALUES(?)");
			preparedStatement.setString(1, message);
			preparedStatement.execute();
			dbConnection.disconnect();
			preparedStatement.close();  
			
			System.out.println("Out of DealInsertDaoImplementation");
			return true;
		}catch(Exception e){
			System.out.println(e);
			return false;
		}
		
		
	}

}
