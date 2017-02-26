package action;

import java.sql.PreparedStatement;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.DBConnection;
import model.Seller;

@SuppressWarnings("serial")
public class SellerAccountUpdateAction extends ActionSupport implements ModelDriven<Seller> {

Seller seller = new Seller();


public String execute() {
	
	DBConnection cs = new DBConnection();
	try {
		PreparedStatement ps = cs.connect().prepareStatement("UPDATE users set user_name = ? , user_email = ? , user_password = ? where user_id=?");
		ps.setString(1,seller.getSellerName());
		ps.setString(2, seller.getSellerEmail());
		ps.setString(3, seller.getSellerPassword());
		ps.setString(4, seller.getSellerId());
		Map<String, Object> session = ActionContext.getContext().getSession();
		session.put("username", seller.getSellerName());
		session.put("email",seller.getSellerEmail());
		session.put("password",seller.getSellerPassword());
		  
		   //status=rs.next();  
		   if( ps.executeUpdate() != 0 )
		   {
			   cs.disconnect();
				ps.close();
				
		   }
		   
		   ps = cs.connect().prepareStatement("UPDATE sellers set seller_name = ? , seller_address = ?, seller_contact_no = ?, seller_email = ? where seller_id=?");
			ps.setString(1, seller.getSellerName());
			ps.setString(2, seller.getSellerAddress());
			ps.setString(3, seller.getSellerContactNo());
			ps.setString(4, seller.getSellerEmail());
			ps.setInt(5, seller.getSurrogateSellerId());
			ps.execute();
			cs.disconnect();
			ps.close();
		   
		   String message = "Hello "+seller.getSellerName()+" your account information has been updated successfully.";
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
public Seller getModel() {
	// TODO Auto-generated method stub
	return seller;
}


}
