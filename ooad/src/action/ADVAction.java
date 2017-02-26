package action;

import java.sql.PreparedStatement;

import com.opensymphony.xwork2.ActionSupport;

import dao.DBConnection;

public class ADVAction extends ActionSupport {
	
private String adv_cost;



public String getAdv_cost() {
	return adv_cost;
}



public void setAdv_cost(String adv_cost) {
	this.adv_cost = adv_cost;
}



public String execute() {			
    DBConnection cs = new DBConnection();
	try {
		PreparedStatement ps = cs.connect().prepareStatement("UPDATE users set user_name = ? where user_email='admin'");
		ps.setString(1,adv_cost);  
		  
		   //status=rs.next();  
		   if( ps.executeUpdate() != 0 )
		   {
			   cs.disconnect();
				ps.close();
				
		   }
		
		   cs.disconnect();
			ps.close();
			String message = "Advertisement cost updated to "+ getAdv_cost()+" %";
			ps = cs.connect().prepareStatement("INSERT INTO logs(log_message) VALUES(?)");
			ps.setString(1, message);
			ps.execute();
			cs.disconnect();
			ps.close();
			return  SUCCESS;
		
	}
	catch(Exception e) {
		e.printStackTrace();
		System.out.println("VAT exception");
	}
	return ERROR;
	
}

}
