package dao;

public interface PaymentDAO {

	public boolean payment(String userId, String sellerId, String itemId, String address, double totalPrice);
	
	public boolean paymentCart(String userId, int usersId, String address, double totalPrice);
	
	public int getSeller(String sellerId);
	
	public double getBalance(String userId);
}
