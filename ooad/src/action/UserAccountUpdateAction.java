package action;

import java.sql.PreparedStatement;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.DBConnection;
import model.User;

@SuppressWarnings("serial")
public class UserAccountUpdateAction extends ActionSupport implements ModelDriven<User> {

User user = new User();


public String execute() {
	
	DBConnection cs = new DBConnection();
	try {
		PreparedStatement ps = cs.connect().prepareStatement("UPDATE users set user_name = ? , user_email = ? , user_password = ? where user_id=?");
		ps.setString(1,user.getUserName());
		ps.setString(2, user.getUserEmail());
		ps.setString(3, user.getUserPassword());
		ps.setString(4, user.getUserId());
		Map<String, Object> session = ActionContext.getContext().getSession();
		session.put("username", user.getUserName());
		session.put("email",user.getUserEmail());
		session.put("password",user.getUserPassword());
		  
		   //status=rs.next();  
		   if( ps.executeUpdate() != 0 )
		   {
			   cs.disconnect();
				ps.close();
				
		   }
		   
		   String message = "Hello "+user.getUserName()+" your account information has been updated successfully.";
			ps = cs.connect().prepareStatement("INSERT INTO logs(log_message) VALUES(?)");
			ps.setString(1, message);
			ps.execute();
			cs.disconnect();
			ps.close();
		}
		   catch(Exception e) {
				e.printStackTrace();
				System.out.println("User Account Update exception");
			}
	
	
	System.out.println("Returning success");
		return SUCCESS;
		
	
	//return ERROR;
}

@Override
public User getModel() {
	// TODO Auto-generated method stub
	return user;
}


}
