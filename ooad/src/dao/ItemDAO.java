package dao;

import java.util.ArrayList;

import model.Buyer;
import model.Item;
import model.ItemDetails;

public interface ItemDAO {

	public boolean addItem(ItemDetails itemDetails);
	
	public boolean updateItem(ItemDetails itemDetails);
	
	public String deleteItem(Item item);
	
	public ItemDetails getItem(Item item);
	
	public boolean getItems(ArrayList<Item> items, int subCategory);
	
	public boolean getItemsInRange(ArrayList<Item> items, double from, double to);
	
	public ArrayList<Buyer> getOrderHistory(String userId);
	
	public ArrayList<Buyer> getSellHistory(String userId);
	
	public boolean searchItems(ArrayList<Item> items, String searchText,String selectedCategory);
	
}
