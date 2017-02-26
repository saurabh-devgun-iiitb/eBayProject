package action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.PaymentDAO;
import dao.implementaion.PaymentDAOImplementation;

public class PaymentAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	private String sellerId;
	private String itemId;
	private double totalPrice;
	private String address;
	
	public String execute() {
		PaymentDAO paymentDAO = new PaymentDAOImplementation();
		if(paymentDAO.payment(userId, sellerId, itemId, address, totalPrice)) 
			return SUCCESS;
		return ERROR;
	}
	
	public String payment() {
		
		Map<String, Object> session = ActionContext.getContext().getSession();
		
		if(new PaymentDAOImplementation().paymentCart((String) session.get("userid"), Integer.parseInt((String) session.get("surrogate")), (String) session.get("address"), totalPrice))
			return SUCCESS;
		
		return ERROR;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

}
