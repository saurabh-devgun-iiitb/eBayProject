package model;

public class finalExam01 {
	
	private String item_id;
	private String deal_id;
	private String free_item_id;
	
	public finalExam01()
	{
		
	}
	
	public finalExam01(String item_id,String deal_id,String free_item_id)
	{
		this.setItem_id(item_id);
		this.setDeal_id(deal_id);
		this.setFree_item_id(free_item_id);
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public String getDeal_id() {
		return deal_id;
	}
	public void setDeal_id(String deal_id) {
		this.deal_id = deal_id;
	}
	public String getFree_item_id() {
		return free_item_id;
	}
	public void setFree_item_id(String free_item_id) {
		this.free_item_id = free_item_id;
	}

}
