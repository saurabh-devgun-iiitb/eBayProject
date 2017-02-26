package action;

import java.util.ArrayList;

import com.opensymphony.xwork2.ActionSupport;

import dao.implementaion.GetDeleteDealListDaoImplementation;
import model.Deal;

@SuppressWarnings("serial")
public class GetDeleteDealListAction extends ActionSupport{
	public ArrayList<Deal> deleteDealList = new ArrayList<>();
	public String execute(){
		System.out.println("In GetDeleteDealListAction");
		GetDeleteDealListDaoImplementation daoImplementation =new GetDeleteDealListDaoImplementation();
		deleteDealList = daoImplementation.getDealList();
		System.out.println("Out of  GetDeleteDealListAction");
		return SUCCESS;
	}

}
