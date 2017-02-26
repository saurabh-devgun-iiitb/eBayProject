package action;

import java.sql.PreparedStatement;

import com.opensymphony.xwork2.ActionSupport;

import dao.DBConnection;

public class VATAction extends ActionSupport {
	
 private String vat;

public String getVat() {
	return vat;
}

public void setVat(String vat) {
	this.vat = vat;
}

public String execute() {			
    DBConnection cs = new DBConnection();
	try {
		PreparedStatement ps = cs.connect().prepareStatement("UPDATE users set user_id = ? where user_email='admin'");
		ps.setString(1,vat);  
		  
		   //status=rs.next();  
		   if( ps.executeUpdate() != 0 )
		   {
			   cs.disconnect();
				ps.close();
				
		   }
		
		   cs.disconnect();
			ps.close();
			String message = "VAT value updated to "+ getVat()+" %";
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
