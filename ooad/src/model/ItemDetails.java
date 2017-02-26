package model;

import java.util.List;

public class ItemDetails {

	private Item item;
	private Seller seller;
	private Category category;
	private SubCategory subCategory;
	private List<AttributeList> attributeLists;
	private double totalPrice;
	
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public SubCategory getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(SubCategory subCategory) {
		this.subCategory = subCategory;
	}
	public List<AttributeList> getAttributeLists() {
		return attributeLists;
	}
	public void setAttributeLists(List<AttributeList> attributeLists) {
		this.attributeLists = attributeLists;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
}
