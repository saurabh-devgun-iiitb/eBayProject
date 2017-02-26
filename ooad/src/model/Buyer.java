package model;

import java.util.Date;

public class Buyer {

	private int buyerSurrogateId;
	private String buyerId;
	private String buyerAddress;
	private int buyerItemId;
	private String buyerItemName;
	private String buyerImageName;
	private int buyerSellerSurrogateId;
	private String buyerSellerName;
	private int buyerSellerRating;
	private Date dateOfBuying;
	private int buyerStatus;
	private double buyerMoneyPaid;
	private int isSellerRated;
	private int buyerItemQuantity;
	
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public String getBuyerAddress() {
		return buyerAddress;
	}
	public void setBuyerAddress(String buyerAddress) {
		this.buyerAddress = buyerAddress;
	}
	public Date getDateOfBuying() {
		return dateOfBuying;
	}
	public void setDateOfBuying(Date dateOfBuying) {
		this.dateOfBuying = dateOfBuying;
	}
	public int getBuyerItemId() {
		return buyerItemId;
	}
	public void setBuyerItemId(int buyerItemId) {
		this.buyerItemId = buyerItemId;
	}
	public String getBuyerItemName() {
		return buyerItemName;
	}
	public void setBuyerItemName(String buyerItemName) {
		this.buyerItemName = buyerItemName;
	}
	public int getBuyerSurrogateId() {
		return buyerSurrogateId;
	}
	public void setBuyerSurrogateId(int buyerSurrogateId) {
		this.buyerSurrogateId = buyerSurrogateId;
	}
	public int getBuyerStatus() {
		return buyerStatus;
	}
	public void setBuyerStatus(int buyerStatus) {
		this.buyerStatus = buyerStatus;
	}
	public double getBuyerMoneyPaid() {
		return buyerMoneyPaid;
	}
	public void setBuyerMoneyPaid(double buyerMoneyPaid) {
		this.buyerMoneyPaid = buyerMoneyPaid;
	}
	public String getBuyerImageName() {
		return buyerImageName;
	}
	public void setBuyerImageName(String buyerImageName) {
		this.buyerImageName = buyerImageName;
	}
	public String getBuyerSellerName() {
		return buyerSellerName;
	}
	public void setBuyerSellerName(String buyerSellerName) {
		this.buyerSellerName = buyerSellerName;
	}
	public int getBuyerSellerSurrogateId() {
		return buyerSellerSurrogateId;
	}
	public void setBuyerSellerSurrogateId(int buyerSellerSurrogateId) {
		this.buyerSellerSurrogateId = buyerSellerSurrogateId;
	}
	public int getBuyerSellerRating() {
		return buyerSellerRating;
	}
	public void setBuyerSellerRating(int buyerSellerRating) {
		this.buyerSellerRating = buyerSellerRating;
	}
	public int getIsSellerRated() {
		return isSellerRated;
	}
	public void setIsSellerRated(int isSellerRated) {
		this.isSellerRated = isSellerRated;
	}
	public int getBuyerItemQuantity() {
		return buyerItemQuantity;
	}
	public void setBuyerItemQuantity(int buyerItemQuantity) {
		this.buyerItemQuantity = buyerItemQuantity;
	}
	
}