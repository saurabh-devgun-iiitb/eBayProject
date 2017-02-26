package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import model.Deal;
import dao.DBConnection;

public class GetDeleteDealListDaoImplementation {
	public ArrayList<Deal> deleteDealList = new ArrayList<>();
	int seller_id=19;
	
	public ArrayList<Deal> getDealList(){
		DBConnection dbConnection;
		String sql = " ";
		Map<String, Object> session = ActionContext.getContext().getSession();
		int seller_id = Integer.parseInt((String)(session.get("surrogate")));
		try{
			System.out.println("In GetDeleteDealListDaoImplementation----------------------");
			dbConnection = new DBConnection();
			
			//insert seller id here by session ( to do)
			
			sql="SELECT deal_id,deal_item_one,deal_item_two,deal_item_free FROM deals WHERE deal_seller_id = "+seller_id+";";
			PreparedStatement preparedStatement = dbConnection.connect().prepareStatement(sql);
			ResultSet rs = preparedStatement.executeQuery();
			while(rs.next()){
				Deal deal = new Deal();
				
				int surrogateDealId=rs.getInt("deal_id");
				System.out.println(surrogateDealId);
				
				int dealItemOne=rs.getInt("deal_item_one");
				String item1=getItemName(dealItemOne,"one",seller_id);
				System.out.println(item1);
				
				int dealItemTwo=rs.getInt("deal_item_two");
				String item2=getItemName(dealItemTwo,"two",seller_id);
				System.out.println(item2);
				
				
				int dealItemFree=rs.getInt("deal_item_free");
				String item3=getItemName(dealItemFree,"free",seller_id);
				System.out.println(item3);
				
				
				
				deal.setDealItemOne(dealItemOne);
				deal.setDealItemTwo(dealItemTwo);
				deal.setDealItemFree(dealItemFree);
				deal.setSurrogateDealId(surrogateDealId);
				deal.setDealItemOneName(item1);
				deal.setDealItemTwoName(item2);
				deal.setDealItemFreeName(item3);
				
				
				
				deleteDealList.add(deal); 
				
				
			}
			System.out.println("In GetDeleteDealListDaoImplementation----------------------");
			dbConnection.disconnect();
			return deleteDealList;
		}catch(Exception e){
			System.out.println(e);
		}
		return null; 
	}
	public String getItemName(int a,String b,int c){
		DBConnection db =new DBConnection();
		String k=" ";
		String sql="SELECT item_name from items,deals where deal_item_"+b+" = items_id and deal_seller_id = item_seller_id and deal_item_"+b+"="+a+" and deal_seller_id="+c+";";
		try{
		PreparedStatement preparedStatement = db.connect().prepareStatement(sql);
		ResultSet rs = preparedStatement.executeQuery();
		while(rs.next()){
			k=rs.getString("item_name");
			//System.out.println(rs.getString("item_name"));
		}
		db.disconnect();
		return k;
		}catch(Exception e){
			System.out.println(e);
		}
		return null;
	}

}
