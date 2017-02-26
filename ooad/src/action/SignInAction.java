package action;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.DBConnection;
import dao.SignInDAO;
import dao.implementaion.SignInDAOImplementation;
import model.SignIn;


@SuppressWarnings("serial")
public class SignInAction extends ActionSupport implements ModelDriven<SignIn>, SessionAware {
	
	
	private SignIn signin = new SignIn();
	SessionMap<String,String> sessionmap;
	String result;
	
	private String email;
	private String password;
	
	//for buying process
	private String reviewOrder;
	private String itemId;
	private String quantity;
	
	//for track order 
	private String trackOrder;
	
	
	public String execute() {
		System.out.println("Execute "+email);
		System.out.println("Hello "+sessionmap.put("email",email));
		System.out.println("Hello "+sessionmap.put("password",password));
		System.out.println("Inside sign in action , review order = "+getReviewOrder()+" item id = "+getItemId());
		if(getReviewOrder() != null && getReviewOrder().equals("true"))
		{	sessionmap.put("reviewOrder",reviewOrder);
			sessionmap.put("itemId",itemId);
			sessionmap.put("quantity",quantity);
		}
				
	    DBConnection cs = new DBConnection();
		try {

			System.out.println("--------"+email);
			PreparedStatement ps = cs.connect().prepareStatement("select * from users where user_email=? and user_password=?");
			ps.setString(1,email);  
			   ps.setString(2,password);
			   ResultSet rs=ps.executeQuery();  
			   //status=rs.next();  
			   if(rs.next())
			   {
				   System.out.println("In rs.next");
			       sessionmap.put("login","true");
			       sessionmap.put("surrogate",rs.getString("users_id"));
				   sessionmap.put("username",rs.getString("user_name"));
				   sessionmap.put("userid",rs.getString("user_id"));
				   sessionmap.put("usertype",rs.getString("user_type"));				   
				   
				   System.out.println("SessionAware Interceptor");
			   }
			
			cs.disconnect();
			ps.close();
			
		}
		catch(Exception e) {
			e.printStackTrace();
			System.out.println("SessionAware exception");
		}
		cs.disconnect();
		
		signin.setEmail(email);
		signin.setPassword(password);
		System.out.println(email);
		System.out.println("Track order = "+trackOrder);
		SignInDAO signinDAO = new SignInDAOImplementation();
		result = signinDAO.signIn(signin);
		if(result == "true")
			{	if(getReviewOrder() != null && getReviewOrder().equals("true"))
					{
				   		return "reviewOrder";
					}
				else if(getTrackOrder() != null)
					{
			   			return "trackOrder";
					}
			
				else
					return SUCCESS;
			}
		else if (result == "admin")
			return "admin";
		else if(getReviewOrder() != null && getReviewOrder().equals("true"))
				{
					return "reviewOrderFailed";
					}
		else if(getTrackOrder() != null)
		{
			return "trackOrderFailed";
			}
		return ERROR;
		
	}

public String logout(){  
    if(sessionmap!=null){  
        sessionmap.invalidate(); 
    }  
    return "success";  
}  



	@Override
	public SignIn getModel() {
		// TODO Auto-generated method stub
		return null;
	}



	public SignIn getSignin() {
		return signin;
	}



	public void setSignin(SignIn signin) {
		this.signin = signin;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}
     
	


	@Override
	public void setSession(Map<String, Object> map) {
		
		sessionmap=(SessionMap)map;  
		sessionmap.put("login",null);
	    sessionmap.put("email", email);
	    sessionmap.put("password", password);
		// TODO Auto-generated method stub
		
	}

	public String getReviewOrder() {
		return reviewOrder;
	}

	public void setReviewOrder(String reviewOrder) {
		this.reviewOrder = reviewOrder;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getTrackOrder() {
		return trackOrder;
	}

	public void setTrackOrder(String trackOrder) {
		this.trackOrder = trackOrder;
	}
	

}
