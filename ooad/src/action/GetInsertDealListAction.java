package action;

import java.util.ArrayList;

import com.opensymphony.xwork2.ActionSupport;

import dao.implementaion.GetInsertDealListDaoimplementation;
import model.Item;

@SuppressWarnings("serial")
public class GetInsertDealListAction extends ActionSupport{
	public ArrayList<Item> itemList =new ArrayList<>();
	
	public String execute(){
		GetInsertDealListDaoimplementation daoimplementation = new GetInsertDealListDaoimplementation();
		itemList = daoimplementation.getItemList();
		
		return SUCCESS;
	}

}
