package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.implementaion.DealInsertDaoImplementation;
import model.Item;

@SuppressWarnings("serial")
public class DealInsertAction extends ActionSupport{
	private Item item;
	private int aditya;
	private int aditya2;
	private int rahul;
	
	
	public String execute(){
		System.out.println("in DealInsertAction--execute");
		System.out.println("value from model");
/*		System.out.println(item.getSurrogateItemIdOne());
		System.out.println(item.getSurrogateItemIdTwo());
		System.out.println(item.getSurrogateItemIdThree());
*/		DealInsertDaoImplementation daoImplementation = new DealInsertDaoImplementation(); 
//		if(daoImplementation.insertDeal(item.getSurrogateItemIdOne(),item.getSurrogateItemIdTwo(),item.getSurrogateItemIdThree())){
			if(daoImplementation.insertDeal(getAditya(),getAditya2(),getRahul())){
					 System.out.println("out of  DealInsertAction--execute");
			 return SUCCESS;
			 
		 }
		return ERROR;
		
		
	}
	
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}

	public int getAditya() {
		return aditya;
	}

	public void setAditya(int aditya) {
		this.aditya = aditya;
	}

	public int getAditya2() {
		return aditya2;
	}

	public void setAditya2(int aditya2) {
		this.aditya2 = aditya2;
	}

	public int getRahul() {
		return rahul;
	}

	public void setRahul(int rahul) {
		this.rahul = rahul;
	}

}
