package action;

import java.sql.PreparedStatement;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.DBConnection;

public class DeleteUserAction extends ActionSupport{
	
	
	public String execute() {
		
		Map<String, Object> session = ActionContext.getContext().getSession();
		String email = (String)(session.get("email"));
		String name =  (String) session.get("username");
		
		DBConnection cs = new DBConnection();
		try {
			
			PreparedStatement ps = cs.connect().prepareStatement("DELETE FROM users where user_email=?");
			ps.setString(1,email);			  
			   //status=rs.next();  
			   if( ps.executeUpdate() != 0 )
			   {
				   cs.disconnect();
					ps.close();
					
			   }
			   session.put("usertype",null);
			   session.put("username",null);
			   session.put("email",null);
			   session.put("password", null);
			   session.put("userid",null);
			   session.put("login","deleted");
			   
			   String message = "Hello "+name+" your account has been deleted successfully.";
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
		return SUCCESS;	
		
		//return ERROR;
	}

}
