package dao;

import model.Seller;
import model.User;

public interface RegisterDAO {

	public boolean registerSeller(Seller seller);
	
	public boolean registerUser(User user);
}
