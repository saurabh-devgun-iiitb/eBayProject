package dao.implementaion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.DBConnection;
import model.DealComboItem;
import model.DealIndividualItem;

public class GetBuyOneGetTwoDealsDaoImplementation {

	public ArrayList<DealComboItem> getDealsList(){
	
		ArrayList<DealComboItem> dealsList=new ArrayList<DealComboItem>();
		 
		 // now here goes the code to extract each item from the database and then populate it in the dealsList
		 // now we check here what we find it out
		 
		 //create a connection to the database
		try{
		DBConnection cs = new DBConnection();
		PreparedStatement ps = cs.connect().prepareStatement("Select * from deals;");
		System.out.println(ps);
		ResultSet rs = ps.executeQuery();
		
		// now here we get the list of all the deals we need here
		
		// so what we will do here is we will select one item_id each time from the deals table and execute each one of them manually and get the description with us
		
		while(rs.next())
		{ 
			// yes we have received eveything here now, we have the items who are in the buy 2 get 1 deal
			// make a deal combo item here
			
			DealComboItem dealcombo = new DealComboItem();
			DealIndividualItem individualitem1 = new DealIndividualItem();
			DealIndividualItem individualitem2 = new DealIndividualItem();
			DealIndividualItem individualitem3 = new DealIndividualItem();

			System.out.println("Item id one: " +rs.getInt("deal_item_one"));
			System.out.println("Item id two: " +rs.getInt("deal_item_two"));
			System.out.println("Item id three: " +rs.getInt("deal_item_free"));
			int item_id_one =rs.getInt("deal_item_one");
			int item_id_two =rs.getInt("deal_item_two");
			int item_id_three=rs.getInt("deal_item_free");
			// we are getting a problem in this part, let us see now what we want to do in this case
			// let us see dude, let us see
			
			
			
			//DBConnection cs1 = new DBConnection();
			//below we are getting details of all the items, then after checking and getting the deals 
			// we will add each of then to the objects which we are getting here.
			// thus what to do now here
			
			ps = cs.connect().prepareStatement("SELECT item_id,item_picture,item_discount,item_quantity_available,item_desc,item_price,item_name from items where items_id=?;");
			System.out.println(ps);
			ps.setInt(1,item_id_one);			
			ResultSet rs1 = ps.executeQuery();
			rs1.next();			
			System.out.println(rs1.getString("item_id"));
			System.out.println(rs1.getString("item_name"));
			System.out.println(rs1.getString("item_desc"));
			System.out.println(rs1.getDouble("item_price"));
			System.out.println(rs1.getString("item_picture"));				

			individualitem1.setItems_id(item_id_one);
			individualitem1.setItem_id(rs1.getString("item_id"));
			individualitem1.setItem_name(rs1.getString("item_name"));
			individualitem1.setItem_desc(rs1.getString("item_desc"));			
			individualitem1.setItem_discount(rs1.getDouble("item_discount"));			
			individualitem1.setItem_price(rs1.getDouble("item_price"));;
			individualitem1.setItem_picture(rs1.getString("item_picture"));
			individualitem1.setItem_quantity_available(rs1.getInt("item_quantity_available"));
			
			
			// now add this individual item to the deal combo item one
			
			dealcombo.setItem_one(individualitem1);
			
			
			
			ps = cs.connect().prepareStatement("Select item_id,item_picture,item_discount,item_quantity_available,item_desc,item_price,item_name from items where items_id=?");
			ps.setInt(1,item_id_two);
			ResultSet rs2 = ps.executeQuery();
			rs2.next();
			System.out.println(rs2.getString("item_id"));
			System.out.println(rs2.getString("item_name"));
			System.out.println(rs2.getString("item_desc"));
			System.out.println(rs2.getDouble("item_price"));
			System.out.println(rs2.getString("item_picture"));
			
			individualitem2.setItems_id(item_id_two);
			individualitem2.setItem_id(rs2.getString("item_id"));
			individualitem2.setItem_name(rs2.getString("item_name"));
			individualitem2.setItem_desc(rs2.getString("item_desc"));			
			individualitem2.setItem_discount(rs2.getDouble("item_discount"));	
			individualitem2.setItem_price(rs2.getDouble("item_price"));;
			individualitem2.setItem_picture(rs2.getString("item_picture"));
			individualitem2.setItem_quantity_available(rs2.getInt("item_quantity_available"));
			
			dealcombo.setItem_two(individualitem2);
			
			
			ps = cs.connect().prepareStatement("Select item_id,item_picture,item_discount,item_quantity_available,item_desc,item_price,item_name from items where items_id=?");
			ps.setInt(1,item_id_three);
			ResultSet rs3 = ps.executeQuery();
			rs3.next();
			System.out.println(rs3.getString("item_id"));
			System.out.println(rs3.getString("item_name"));
			System.out.println(rs3.getString("item_desc"));
			System.out.println(rs3.getDouble("item_price"));
			System.out.println(rs3.getString("item_picture"));
			
			individualitem3.setItems_id(item_id_three);
			individualitem3.setItem_id(rs3.getString("item_id"));
			individualitem3.setItem_name(rs3.getString("item_name"));
			individualitem3.setItem_desc(rs3.getString("item_desc"));
			individualitem3.setItem_discount(rs3.getDouble("item_discount"));				
			individualitem3.setItem_price(rs3.getDouble("item_price"));;
			individualitem3.setItem_picture(rs3.getString("item_picture"));
			individualitem3.setItem_quantity_available(rs3.getInt("item_quantity_available"));
			
			dealcombo.setItem_three(individualitem3);
			
			
			dealsList.add(dealcombo);
			
			}		
	
	}
	
		catch(SQLException e)
		{
			System.out.println("This is an error in the GetBuyOneGetTwoDealsDaoImplementation "  + e);
			
		}
		
		
		return dealsList;
	}
	
}
