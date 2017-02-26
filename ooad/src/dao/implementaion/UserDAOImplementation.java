package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import dao.UserDAO;
import model.User;

public class UserDAOImplementation implements UserDAO {

	@Override
	public User getUser(String userId) {
		User user = new User();
		try {
		
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement("SELECT * FROM users WHERE user_id=?");
			ps.setString(1, userId);
			ResultSet rs = ps.executeQuery();
		    if(rs.next()) {
		    	user.setUserId(userId);
		    	user.setUserName(rs.getString("user_name"));
		    	user.setUserEmail(rs.getString("user_email"));
		    	user.setUserType(rs.getInt("user_type"));
		    }
		    cs.disconnect();
		    ps.close();
		    rs.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	    return user;
	}

}
