package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.ItemDAO;
import dao.implementaion.ItemDAOImplementation;
import model.ItemDetails;

public class ItemDetailsAction extends ActionSupport implements ModelDriven<ItemDetails> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	ItemDetails itemDetails = new ItemDetails();
	
	public String execute() {

		ItemDAO itemDAO = new ItemDAOImplementation();
		if(itemDAO.addItem(itemDetails))
			return SUCCESS;
		return ERROR;
	}
	
	@Override
	public ItemDetails getModel() {
		return itemDetails;
	}

}
