package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dao.DBConnection;
import dao.SignInDAO;
import model.SignIn;

public class SignInDAOImplementation implements SignInDAO{
	
	
	

	@Override
	public String signIn(SignIn signin) {
		
			DBConnection cs = new DBConnection();
			String status= "false";
		try {

			System.out.println("--------"+signin.getPassword());
			PreparedStatement ps = cs.connect().prepareStatement("select * from users where user_email=? and user_password=?");
			ps.setString(1,signin.getEmail());  
			   ps.setString(2,signin.getPassword());
			   ResultSet rs=ps.executeQuery();  
			   //status=rs.next();  
			   if(rs.next())
			   {
				   System.out.println(rs.getString("user_password"));
				   if(rs.getInt(6)==0)
					   status = "admin";
				   else
				  	   status = "true";
						   
			   }
			
			cs.disconnect();
			ps.close();
			
		}
		catch(Exception e) {
			e.printStackTrace();
			return "false";
		}
		cs.disconnect();
		return status;
		
	}


}
