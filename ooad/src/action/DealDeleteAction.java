package action;
import dao.implementaion.DeleteDealDaoImplementation;
public class DealDeleteAction {

	private int surrogateDealId;

	public String execute(){
		System.out.println("In DeleteDealAction");
		System.out.println(surrogateDealId);
		

		DeleteDealDaoImplementation deleteDealDaoImplementation =new DeleteDealDaoImplementation();
		if(deleteDealDaoImplementation.deleteDeal(surrogateDealId)){
			System.out.println("Out of DeleteDealAction");
			return "success";
		}
		return "error";
	}

	public int getSurrogateDealId() {
		return surrogateDealId;
	}
	public void setSurrogateDealId(int surrogateDealId) {
		this.surrogateDealId = surrogateDealId;
	}

}
