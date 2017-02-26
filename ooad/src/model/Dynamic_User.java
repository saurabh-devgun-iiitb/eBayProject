package model;

public class Dynamic_User {
	
	private String id;
	private String name;
	public String getId() {
		return id;
	}
	public Dynamic_User()
	{
		
	}
	public Dynamic_User(String id,String name)
	{
		this.setId(id);
		this.setName(name);
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
