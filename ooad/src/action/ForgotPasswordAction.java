package action;

import com.opensymphony.xwork2.ActionSupport;

import dao.ForgotPasswordDAO;
import dao.implementaion.ForgotPasswordDAOImplementation;

@SuppressWarnings("serial")
public class ForgotPasswordAction extends ActionSupport {
	
	private String email;
	
	
public String execute() {
			ForgotPasswordDAO forgotPasswordDAO = new ForgotPasswordDAOImplementation();
			if(forgotPasswordDAO.sendPassword(email))
				return SUCCESS;
			else
			{
				System.out.println("Returning Error");
				return ERROR;
				
			}
}
	

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	
	

}
