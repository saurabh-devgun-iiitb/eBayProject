package action;

import java.util.ArrayList;

import com.opensymphony.xwork2.ActionSupport;

import dao.implementaion.GetBuyOneGetTwoDealsDaoImplementation;
import model.DealComboItem;
import model.DealIndividualItem;

public class GetBuyTwoGetOneItemsAction extends ActionSupport{

	// here we dont need to write anything to pojo as we dont need any input from the user thus, only action support is enough
	
	public ArrayList<DealComboItem> dealsItemList = new ArrayList<>();
	// this array list will be having every item in the deal
	
	// calling the dao implementation in execute which will then return us the arraylist of the deal items.
	
	public String execute(){
		
		System.out.println("In Get buy two action");
		GetBuyOneGetTwoDealsDaoImplementation getlist = new GetBuyOneGetTwoDealsDaoImplementation();
		
		dealsItemList =getlist.getDealsList();
		
		// yes finally we are getting everything inside the arraylist
		
		for(DealComboItem c:dealsItemList)
		{
		DealIndividualItem one = c.getItem_one();
		System.out.println("item one in action"+one.getItems_id());
		System.out.println(one.getItem_id());
		System.out.println(one.getItem_name());
		System.out.println(one.getItem_desc());
		System.out.println(one.getItem_picture());
		System.out.println(one.getItem_price());
		
		
		DealIndividualItem two = c.getItem_two();
		System.out.println("item two in action"+two.getItems_id());
		
		DealIndividualItem three = c.getItem_three();
		System.out.println("item three in action"+three.getItems_id());
		
		}
		return "success";
	}
	
	
	
}
