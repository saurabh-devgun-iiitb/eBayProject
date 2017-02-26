package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;

public class DeleteDealDaoImplementation {
	DBConnection dbConnection;
	String sql=" ";
	public boolean deleteDeal(int surrogateDealId){
		try{
			System.out.println("In DeleteDealDaoImplementaion");
			dbConnection = new DBConnection();
			
			sql="SELECT * from deals WHERE deal_id="+surrogateDealId;
			
			PreparedStatement preparedStatement = dbConnection.connect().prepareStatement(sql);
			ResultSet rs = preparedStatement.executeQuery();
			System.out.println("From ResultSet----------------------");
			while(rs.next()){
				sql="UPDATE items SET  is_deal_item = 0 WHERE  items_id ="+rs.getInt("deal_item_one");
				preparedStatement =  dbConnection.connect().prepareStatement(sql);
				preparedStatement.executeUpdate();
				System.out.println(sql);
				sql="UPDATE items SET  is_deal_item = 0 WHERE  items_id ="+rs.getInt("deal_item_two");
				preparedStatement =  dbConnection.connect().prepareStatement(sql);
				preparedStatement.executeUpdate();
				System.out.println(sql);
				sql="UPDATE items SET  is_deal_item = 0 WHERE  items_id ="+rs.getInt("deal_item_free");
				preparedStatement =  dbConnection.connect().prepareStatement(sql);
				preparedStatement.executeUpdate();
				System.out.println(sql);
			}
			System.out.println("-----------------------------");
			sql="DELETE FROM deals WHERE deal_id="+surrogateDealId;
			preparedStatement =  dbConnection.connect().prepareStatement(sql);
			preparedStatement.executeUpdate();
			
			String message = "Deal with Deal_Id : "+ " "+ surrogateDealId+" "+ " is deleted";
			preparedStatement = dbConnection.connect().prepareStatement("INSERT INTO logs(log_message) VALUES(?)");
			preparedStatement.setString(1, message);
			preparedStatement.execute();
			dbConnection.disconnect();
			preparedStatement.close();
			
			
			System.out.println("Out of DeleteDealDaoImplementaion");
			return true;
		}catch(Exception e){
			System.out.println(e);
		}
		return false;
	}

}
