package action;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.DBConnection;
import dao.ItemDAO;
import dao.implementaion.ItemDAOImplementation;
import model.Item;
import model.ItemDetails;

public class UpdateItemAction extends ActionSupport implements ModelDriven<ItemDetails>{

	public ItemDetails itemDetails = new ItemDetails();
	private String itemId;
	private String itemName;
	
	
	public String execute() {
		
		Map<String, Object> session = ActionContext.getContext().getSession();
		int sellerid = Integer.parseInt((String) session.get("surrogate"));
		
		DBConnection cs = new DBConnection();
		try {
			
			PreparedStatement ps = cs.connect().prepareStatement("SELECT item_seller_id FROM items where item_id=?");
			ps.setString(1,getItemId());			  
			 
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				if(sellerid != rs.getInt(1))
					return ERROR;
			}
				   cs.disconnect();
					ps.close();
					
			   
			   session.put("updateItem",getItemId());
			   Item item = new Item();
			   item.setItemId(getItemId());
			   itemDetails = new ItemDAOImplementation().getItem(item);
			   System.out.println(itemDetails.getCategory().getCategoryName());
			}
			   catch(Exception e) {
					e.printStackTrace();
					System.out.println("User Account Update exception");
				}
		return SUCCESS;	
		
		//return ERROR;
	}

	
	public String updateItemDetails() {
		if(new ItemDAOImplementation().updateItem(itemDetails))
			return SUCCESS;
		return ERROR;
	}
	
	
	
	
	
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}


	@Override
	public ItemDetails getModel() {
		return itemDetails;
	}
	
	
}
